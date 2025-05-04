"""
"""

import re
from pathlib import Path
from pprint import pformat, pprint
from textwrap import indent
from typing import Any, Dict, List, Union

PATTERN_COMMIT_EDITMSG = r"""(?msx:
                             \A
                             (?P<title>^.+?)\n
                             (?P<text>^.+?)\n
                             (?P<list>^- .+)\n
                             (?P<boilerplate>\#\ Please\ enter\ the\ commit\ message\ for\ your\ changes.\ Lines\ starting\n
                             \#\ with\ '\#'\ will\ be\ ignored,\ and\ an\ empty\ message\ aborts\ the\ commit.\n
                             \#\n
                             \#\ On\ branch\ 
                             )
                             (?P<branch>.+)\n
                             \#\ Your\ branch\ is\ up\ to\ date\ with\ '
                             (?P<remote_branch>.+)'\.\n
                             \#\n
                             \#\ Changes\ to\ be\ committed:\n
                             (?P<staged>.+)
                             \#\n
                             \#\ Changes\ not\ staged\ for\ commit:\n
                             (?P<not_staged>.+)
                             \#\n
                             \#\ Untracked\ files:\n
                             (?P<not_tracked>.+)
                             \Z
                             )"""

PATTERN_EDITMSG_TRACKED = r"""(?x:
                              \#\t(?P<status>(?:deleted)|(?:modified)|(?:new\ file)):[ ]+
                              (?P<file>.+)\n
                              )"""

PATTERN_EDITMSG_UNTRACKED = r"""(?x:
                                \#[ ]+(?P<file>.+)\n
                                )"""


def bprint(obj: Any,
           prefix: int):
    """
    Better pprint
    """
    print(indent(pformat(object=obj),
                 prefix=prefix))


def recursive_split(string_: str,
                    lvl: int = 0,
                    verbose: int = 0):
    """
    """
    prefix_1 = lvl * 2 * " "

    if verbose:
        print(f"{prefix_1}lvl {lvl}")

    li_1 = re.split(pattern=fr"\n{prefix_1}(?:-|\.) ",
                    string=string_)

    if verbose:
        li_1_1 = re.split(pattern=fr"\n{prefix_1}(?:-) ",
                        string=string_)
        li_1_2 = re.split(pattern=fr"\n{prefix_1}(?:\.) ",
                        string=string_)

    if verbose:
        header = f"{prefix_1}{">" * 20}"
        footer = f"{prefix_1}{"<" * 20}"
        for li_1_ in [li_1, li_1_1, li_1_2]:
            print(header)
            bprint(obj=li_1_,
                   prefix=prefix_1)
            print(footer)

    # TODO Determine if terminal title or terminal file
    pass

    if len(li_1) == 1:
        # Not split implies a terminal node (leaf) has been reached.
        li_2 = li_1[0]
    elif len(li_1) > 1:
        # A split implies we are still on a non-terminal node (branch).
        li_1 = li_1[:]

        li_2 = []
        header = f"{"  " + prefix_1}{">" * 20}"
        footer = f"{"  " + prefix_1}{"<" * 20}"
        prefix_2 = prefix_1 + (2 * " ")
        for string_el in li_1:
            if verbose:
                print(header)
                bprint(obj=string_el,
                       prefix=prefix_2)
                print(footer)

            li = recursive_split(string_=string_el,
                                lvl=lvl+1)            
            li_2.append(li)
    else:
        raise Exception("An unexpected error occured.")

    return li_2


def li_to_di(nested_list: List,
             parent_name: Any = None,
             lvl: int = 0):
    """
    """
    # NOTE We assume the nested list `nested_list` is created such that all lists are of length at least 2, with the first element being the parent, and the subsequent elements being the children.

    if lvl == 0:
        key_name = "list_parsed"
    elif lvl > 0:
        key_name = parent_name
    else:
        raise ValueError("Parameter `lvl` must be a non-negative integer.")
    di = {key_name: None}
    li_parsed = []
    for el in nested_list:
        if isinstance(el, list):
            di_child = li_to_di(nested_list=el[1:],
                                parent_name=el[0],
                                lvl=lvl+1)
        elif isinstance(el, str):
            # Does not differentiate between text or file
            di_child = {el: None}
        else:
            raise Exception("Nested list elements must be string or list.")
        li_parsed.append(di_child)
    di[key_name] = li_parsed

    return di


def parse_list(string_: str):
    """
    """
    # We define list elements as starting with `\n`, some whitespace, either a `-` or `.`, and then a single space. Therefore we add a single newline to the list string which was removed from dividing the commit message into parts.
    string_ = "\n" + string_

    li: List = recursive_split(string_=string_)

    # Remove empty string from leading `\n`
    li = li[1:]

    # Turn nested list into nested dictionary
    di = li_to_di(nested_list=li)

    return di


def parse_git_commit_editmsg_1(filepath: Path) -> Union[Dict[str, str | Any], None]:
    """
    Parse a commit message that was written in the Herman's Code format into its main parts.
    """

    with open(file=filepath, mode="r") as file_obj:
        text = file_obj.read()
    
    pattern = re.compile(pattern=PATTERN_COMMIT_EDITMSG)

    match_obj = pattern.search(string=text)

    if match_obj:
        result = match_obj.groupdict()
    else:
        result = None

    return result


def parse_git_commit_editmsg(filepath: Path,
                             verbose: int = 0):
    """
    Parse a commit message that was written in the Herman's Code format.
    """

    parts = parse_git_commit_editmsg_1(filepath=filepath)

    # :: 0 :: Define key names
    KEY_TITLE         = "1_title"
    KEY_TEXT          = "2_text"
    KEY_LIST          = "3_list"
    KEY_BOILERPLATE   = "4_boilerplate"
    KEY_BRANCH        = "5_branch"
    KEY_REMOTE_BRANCH = "6_remote_branch"
    KEY_STAGED        = "7_staged"
    KEY_NOT_STAGED    = "8_not_staged"
    KEY_NOT_TRACKED   = "9_not_tracked"

    # :: 1 :: Unpack results
    if parts:
        title         = parts["title"]
        text          = parts["text"]
        list_         = parts["list"]
        boilerplate   = parts["boilerplate"]
        branch        = parts["branch"]
        remote_branch = parts["remote_branch"]
        staged        = parts["staged"]
        not_staged    = parts["not_staged"]
        not_tracked   = parts["not_tracked"]

        results = {KEY_TITLE: title,
                   KEY_TEXT: text,
                   KEY_LIST: None,
                   KEY_BOILERPLATE: boilerplate,
                   KEY_BRANCH: branch,
                   KEY_REMOTE_BRANCH: remote_branch,
                   KEY_STAGED: None,
                   KEY_NOT_STAGED: None,
                   KEY_NOT_TRACKED: None}
    else:
        results = None

    # :: 2 :: Parse list
    if verbose:
        list_parsed_1, list_parsed_2 = parse_list(string_=list_)
    else:
        list_parsed = parse_list(string_=list_)
    results[KEY_LIST] = list_parsed

    # :: 3 :: Parse staged files
    pattern_2 = re.compile(pattern=PATTERN_EDITMSG_TRACKED)
    staged_parsed = pattern_2.findall(string=staged)
    results[KEY_STAGED] = staged_parsed

    # :: 4 :: Parsed files not staged
    pattern_3 = re.compile(pattern=PATTERN_EDITMSG_TRACKED)
    not_staged_parsed = pattern_3.findall(string=not_staged)
    results[KEY_NOT_STAGED] = not_staged_parsed

    # :: 5 :: Parse untracked files
    pattern_3 = re.compile(pattern=PATTERN_EDITMSG_UNTRACKED)
    not_tracked_parsed = pattern_3.findall(string=not_tracked)
    results[KEY_NOT_TRACKED] = not_tracked_parsed

    # TODO :: 3 :: Make sure each staged file was mentioned in the list
    for status, string_ in staged_parsed:
        pass

    # For debugging
    if verbose:
        pprint(list_)

        pprint(list_parsed_1)

        pprint(list_parsed_2)

    # return list_, list_parsed_1, list_parsed_2
    return results
