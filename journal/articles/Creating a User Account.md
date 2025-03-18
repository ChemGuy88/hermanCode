# Introduction

These are notes on creating a user on the macOS command line. This particular example is for a hypothetical user *Alfred Gator* and group *The Club*.

# Preparation

We need to get some information before creating the account

## Get the list of users and their ID numbers

```bash
dscl . -list /Users UniqueID | sort -nk2
```

## Get list of groups and their ID numbers

```bash
dscl . list /Groups PrimaryGroupID | sort -nk2
```

# Instructions

## Create group^[1](https://superuser.com/a/74365/522206)

```bash
sudo dscl . -create /Groups/the_club
sudo dscl . -create /Groups/the_club name "the_club"
sudo dscl . -create /Groups/the_club passwd "$password_group"
sudo dscl . -create /Groups/the_club gid "$group_id"  # For valid `gid` values see https://unix.stackexchange.com/a/701144/399435
```

## Create user^[2](https://apple.stackexchange.com/a/84039/322902)

```bash
sudo dscl . create /Users/algator
sudo dscl . create /Users/algator RealName "Alfred Gator"
sudo dscl . create /Users/algator hint 'This is your password hint: Ask Herman!'
sudo dscl . passwd /Users/algator "$password_user"
sudo dscl . create /Users/algator UniqueID "$user_id"
# The proper way to add a user to a group is unclear, but we followed the advice from https://apple.stackexchange.com/a/97080/322902
sudo dscl . -append /Groups/the_club GroupMembership algator
sudo dscl . create /Users/algator PrimaryGroupID "$group_id"
```

## Verification

```bash
dscl /Local/Default -authonly algator  # If the password you enter is correct, you will receive no feedback. Otherwise it will raise an error.
```

and

```bash
sudo -i -u algator bashc -c 'whoami'  # It should say `algator`
```
