# README

# To-do

- Consolidate my code
- Clean-up my computer
- Track all coding projects
- Delete old GitHub repositories
- Clean up Dropbox folder: Move everything out. Do not use Dropbox
- "Herman's Code"

##  Consolidate my code

- [ ] Segregate code
  - [ ] "Herman's Code" for non-work projects
  - [ ] DRAPI-Lemur for explicitely work-related projects

## Clean-up my computer

###  Uninstall with Trash click-and-drag
  - [ ] ...

###  Find and remove packages
  - [ ] Mendeley Desktop

Use the following code to search the packages
```bash
pkgutil --pkgs | grep -i $KEYWORD_TO_SEARCH_FOR | sort
```

Then use either `uninstallWithPkgutil.bash` or `uninstallWithPkgutil-Multiple.bash` to uninstall your packages.

### Find traces


###  Remove traces
  - [ ] Batch 2.1: Python. **Do manually**. Read [this](https://docs.python.org/3/using/mac.html)

###  What is in...?
   - [ ] "/Users/herman2"
     - [ ] It's 43 GB big, most of that from the Photos folder, and about 3 GB from "Library". After making sure all the Photos are in the main user account, I can delete this user.

## Track my coding projects

I have code and coding-related files and folders throughout my computer. I should organize them. I can start by searching in these folders:

- Herman's iMac
  - /Users/herman
  - /Users/herman/Documents
  - /Users/herman/Documents/Herman's Code
- Work MBP
  - /Users/herman/Documents/Professional Development
    - AHCA - Code Search
    - HelloWorld
    - Herman's Code
    - Homeless Problem
    - Portfolio - Data Science Narrative
    - Portfolio - Diabetes
    - Portfolio - Indeed Company Rankings
    - Portfolio - Recommender
    - analyzeBloodPressure
    - appleHealthExport
    - applications
    - dbooth
    - hackerrank
    - kaggle Used Cars Dataset
    - portfolio
    - stasia
    - stasia1
    - stasia2
    - studentDebt
    - triton

Maybe  I can try something like

```bash
find / -iname *.py
```

| Folder Name                 | X   | URI                                                               |
| --------------------------- | --- | ----------------------------------------------------------------- |
| Apple Health Blood Pressure | -   | /Users/herman/Documents/Herman's Code/Apple Health Blood Pressure |
| .ssh.copy                   | -   | /Users/herman/Documents/Herman's Code/.ssh.copy                   |
| .vim                        | -   | herman@pyspark:/home/herman/.vim/.vimrc                           |

## Delete old GitHub repositories

To do?

## "Herman's Code"

- [ ] Merge files
  - uninstallFromFileList.bash
  - uninstallFromFileList_Dirs.bash

# Done

## Consolidate my code

- [x] Design code to install features
  - [x] Test installation
- [x] Add uninstallation feature (See "Shell Package/Examples/Remove Text From File.bash")
- [x] Merge the repositories
  - [x] **mlFunctions**
  - [x] **hermanCode**
  - [x] **myAtom**
  - [x] **mySettings**
  - [x] **bashrc**
- [x] Rename **mlFunctions** to **hermanCode**
- Do `git branch -b REPO_NAME REPO_NAME/BRANCH_NAME` for each of the following:
  - [x] hermanCodeNew
  - [x] hermanCodeOriginal
  - [x] myAtom
  - [x] mySettings
- [x] Push the branches to hermanCode
- [x] Merge to hermanCode/main
- [x] Delete all old repositories
- [x] Delete all installations in user folders
- [x] Test code in macOS and Linux. Once that's done move it into the general section.
  - [x] Examples
- [x] Install "Herman's Code"
  - [x] PySpark
  - [x] iMac at home

## `Herman's Code`

- [x] Fix "processTraces.bash". The temporary files are not being kept track of when removing the leading texts.  See "2024-05-27 21-38-53".
- [x] Improve installation/uninstallation. Uninstallation depends on the data created by installation. The data should exist as part of the package in a data directory. So if you remove the repository and clone it, you can immediately run the uninstallation script.

## Remove GUI Apps, packages, and find and remove traces
- Batch 1
  - [x] CloudFlare
  - [x] CrimeFlare
  - [x] R-project
  - [x] anaconda
  - [x] atom
  - [x] brew
  - [x] canopy
  - [x] charles
  - [x] iStats
  - [x] mactex
  - [x] matlab
  - [x] miniconda
  - [x] qgl
  - [x] testgen
  - [x] weka
- Batch 2
  - [x] Akamai
  - [x] BlueStacks  # Android emulator
  - [x] continuum, continuum.io
  - [x] iTools Pro
  - [x] Microsoft Teams classic
  - [x] SignalScope X
  - [x] TestGen
  - [x] texlive
  - [x] texmf
  - [x] TeXShop
  - [x] TextWrangler
- [x] Batch 2.2: VMWare
- [x] Batch 3
    - [x] BetterTouchTool
    - [x] Chromium
    - [x] Chrome Apps
      - [x] Chrome App Launcher
      - [x] Chrome Remote Desktop v1
      - [x] Chrome Remote Desktop v2
      - [x] Gmail
      - [x] Google Drive
      - [x] Google Play Music v1
      - [x] Google Play Music v2
      - [x] Google Search
      - [x] YouTube
    - [x] mySIMBL
    - [x] iTerm
    - [x] Opera
    - [x] VirtualBox
    - [x] JumpDesktop
- [x] Batch 4: hegenberg
- [x] Batch 5
  - [x] vmware (double check there are no traces left)

## Remove Folders
  - [x] "/Users/Shared": The whole folder is about 2GB and there's nothing important there. Try `sudo rm -rf` the subfolders, but not the folder itself.
