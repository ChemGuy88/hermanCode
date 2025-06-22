"""
Batch edit Google GMail filters.
"""

from pathlib import Path

from bs4 import BeautifulSoup
import pandas as pd

filters_path = Path("data/input/gmail_filters/mailFilters.xml")
with open(file=filters_path, mode="r") as file_:
    filters_markup = file_.read()

# XML Editing
soup = BeautifulSoup(markup=filters_markup, features="xml")
entry_li = soup.find_all(name="entry")

entry_li_2 = []
for entry in entry_li:
    result = entry.find_all(name="category")  # type: ignore
    num_entry_category = len(result)
    if num_entry_category == 1:
        pass
    else:
        raise Exception(f"Encountered an unexpected number of entry categories: {num_entry_category}.")

    entry_category = result[0]
    del result
    entry_category_attrs = entry_category.attrs  # type: ignore
    TERM_ATTRIBUTE_NAME  = "term"  # noqa
    TERM_ATTRIBUTE_VALUE = "filter"
    if entry_category.has_attr(TERM_ATTRIBUTE_NAME):  # type: ignore
        term_value = entry_category_attrs[TERM_ATTRIBUTE_NAME]
        if term_value == TERM_ATTRIBUTE_VALUE:
            pass
        else:
            raise Exception(f"We expected the value '{TERM_ATTRIBUTE_VALUE}' for the entry category attribute '{TERM_ATTRIBUTE_NAME}', but instead got '{term_value}'.")
    else:
        raise Exception(f"Entry category missing attribute '{TERM_ATTRIBUTE_NAME}', we instead have: {entry_category_attrs}")

    LABEL_JOB_ALERTS_1 = "Pathrise — Job Alerts"
    LABEL_JOB_ALERTS_2 = "Pathrise — Job Alerts/Tier 2"
    result = entry.find_all(name="apps:property", attrs={"name": "label", "value": LABEL_JOB_ALERTS_1})  # type: ignore
    len_result = len(result)
    if len_result == 0:
        entry_li_2.append(entry)
    elif len_result == 1:
        entry_label = result[0]
        entry_li_2.append(entry)
        # Add keywords TODO
        pass
        # Add entry for tier 2 TODO
        pass
        # Temporary: Break
        break
    else:
        raise Exception(f"We expected 0 or 1 label attributes, but instead got: {len_result}.")

# XML to table
if False:
    table = pd.read_xml(path_or_buffer=filters_path, namespaces={"apps": "http://schemas.google.com/apps/2006"})
    # Works but is not informative, since it doesn't include the "app:property" elements.
    # Tried to make it work with the `xapth` parameter, but couldn't find an argument that worked.
elif False:
    table = pd.read_xml(path_or_buffer=filters_path,
                        xpath="//entry",
                        namespaces={"apps": "http://schemas.google.com/apps/2006"})
elif False:
    table = pd.read_xml(path_or_buffer=filters_path,
                        xpath="//entry/apps",
                        namespaces={"apps": "http://schemas.google.com/apps/2006"})
elif False:
    table = pd.read_xml(path_or_buffer=filters_path,
                        xpath="//entry/apps:property",
                        namespaces={"apps": "http://schemas.google.com/apps/2006"})
elif False:
    table = pd.read_xml(path_or_buffer=filters_path,
                        xpath="//*/apps:property",
                        namespaces={"apps": "http://schemas.google.com/apps/2006"})
    # Works, but it doesn't group it by entries.
elif True:
    table = pd.DataFrame(entry_li_2)

print(table)
