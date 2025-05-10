# 2025-05-10

Here are some useful scripts for developing a more generalized Git commit message file parser. The current version only handles messages with the following format

```text
...

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# On branch <BRANCH_NAME>
# Your branch is up to date with '<REMOTE_NAME>/<REMOTE_BRANCH>'.
#
# Changes to be committed:

...
```

Note the above vignette is an excerpt from a Git *COMMIT_EDITMSG* file where `...` are redacted portions, and `<BRANCH_NAME>`, `<REMOTE_NAME>`, and `<REMOTE_BRANCH>` are placeholders for the values we're interested in extracting. This is handled by the functions in the `herman_code.git_commit` module.

Today we encountered a new format:

```text
...

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# On branch <BRANCH_NAME>
# Your branch is ahead of '<REMOTE_NAME>/<REMOTE_BRANCH>' by <NUM_COMMITS> commit.
#   (use "git push" to publish your local commits)
#
# Changes to be committed:

...
```

Here we have an additional value to extract, `<NUM_COMMITS>`. See [**./scripts/script_1.py**](./scripts/script_1.py) and [**./scripts/script_2.py**](./scripts/script_2.py) for a demonstration on how the parsing was improved using a new regular expression pattern.
