# README

# To-do

- [ ] Consolidate my code
- [ ] Clean up Dropbox folder: Move everything out. Do not use Dropbox
- [ ] Shell Package
  - [ ] Improve installation: add `pypi.username` and `pypi.password` to `$HOME/.pypirc` according to [PyPI](https://pypi.org/help/#apitoken). See [.pypirc]("Shell Package/install/templates/.pypirc")



##  Consolidate my code

- [ ] Segregate code
  - [x] "Herman's Code" for non-work projects
  - [x] DRAPI-Lemur for explicitely work-related projects

## Shell Package

  - [x] Dichotomize shell package into zsh and BASH. For example, rc.sh can check if it's being executed by zsh or bash, and then calls rc.zsh or rc.bash, as appropriate.

# Done

## Track all coding projects

- [x] Herman's iMac
- [x] Work MBP
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
- [x] Merge files
  - uninstallFromFileList.bash
  - uninstallFromFileList_Dirs.bash

## Clean-up my computer

### Uninstall software

#### Procedure

For each of the following **batches** below, perform the following:

  - Uninstall with Trash click-and-drag
  - Find and remove packages
  - Find traces
  - Remove traces

#### Batches

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
- [x] Batch 2.1: Python
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

### Remove Folders
  - [x] "/Users/Shared": The whole folder is about 2GB and there's nothing important there. Try `sudo rm -rf` the subfolders, but not the folder itself.
  - [x] "/Users/herman2"
