# README

## To-do

- Clean-up my computer
- Consolidate my code
- Track all coding projects
- Clean up Dropbox folder: Move everything out. Do not use Dropbox

## Clean-up my computer

###  Uninstall with Trash click-and-drag
  - [ ] ...

###  Find and remove packages
  - [ ] ...

Use the following code to search the packages
```bash
pkgutil --pkgs | grep -i $KEYWORD_TO_SEARCH_FOR | sort
```

Then use either `uninstallWithPkgutil.bash` or `uninstallWithPkgutil-Multiple.bash` to uninstall your packages.

### Find traces
- Batch 3
    - [ ] BetterTouchTool
    - [ ] Chromium
    - [ ] Chrome Apps
      - [ ] Chrome App Launcher
      - [ ] Chrome Remote Desktop v1
      - [ ] Chrome Remote Desktop v2
      - [ ] Gmail
      - [ ] Google Drive
      - [ ] Google Play Music v1
      - [ ] Google Play Music v2
      - [ ] Google Search
      - [ ] YouTube
    - [ ] mySIMBL
    - [ ] iTerm
    - [ ] Opera
    - [ ] VirtualBox
    - [ ] JumpDesktop
- [ ] Batch 4
    - [ ] hegenberg


###  Remove traces
  - [ ] Python: **Do manually**. Read [this](https://docs.python.org/3/using/mac.html)
  - [ ] VMWare. See https://kb.vmware.com/s/article/1017838
    - /Library/Application Support/VMware
    - /Library/Application Support/VMware Fusion
    - /Library/Preferences/VMware Fusion
    - ~/Library/Application\ Support/VMware Fusion
    - ~/Library/Application\ Support/VMware Fusion\ Applications\ Menu
    - ~/Library/Caches/com.vmware.fusion
    - ~/Library/Preferences/VMware Fusion
    - ~/Library/Preferences/com.vmware.fusion.plist
    - ~/Library/Preferences/com.vmware.fusion.plist.lockfile
    - ~/Library/Preferences/com.vmware.fusionDaemon.plist
    - ~/Library/Preferences/com.vmware.fusionDaemon.plist.lockfile
    - ~/Library/Preferences/com.vmware.fusionApplicationsMenu.helper.plist
    - ~/Library/Preferences/com.vmware.fusionApplicationsMenu.plist
    - ~/Library/Preferences/com.vmware.fusionStartMenu.plist
    - ~/Library/Preferences/com.vmware.fusionStartMenu.plist.lockfile


###  What is in...?
   - [ ] "/Users/herman2"
     - [ ] It's 43 GB big, most of that from the Photos folder, and about 3 GB from "Library". After making sure all the Photos are in the main user account, I can delete this user.

##  Consolidate my code

Push the code from the iMac to a remote, one of 

| Repository Name | Date Created | URI                                                        | Archived in GitHub | Merge Destination |
| --------------- | ------------ | ---------------------------------------------------------- | ------------------ | ----------------- |
| hermanCode      | 2024-02-11   | https://github.com/ChemGuy88/hermanCode                    |                    |                   |
| mySettings      | 2020-10-20   | https://github.com/ChemGuy88/mySettings                    |                    |                   |
| bashrc          | 2020-10-20   | https://github.com/ChemGuy88/bashrc                        | True               |                   |
| myAtom          | 2020-03-06   | https://github.com/ChemGuy88/myatom                        |                    |                   |
| mlFunctions     | 2018-09-17   | https://github.com/ChemGuy88/mlFunctions                   |                    | True              |
| mlFunctions     | 2024-XX-XX   | herman@remote-imac:/Users/herman/.hermanCode               |                    | True              |
| hermanCode      | 2024-XX-XX   | herman@pyspark:/home/herman/.hermanCode                    |                    |                   |
| hermanCode      | 2024-XX-XX   | herman@pyspark:/data/herman/Documents/GitHub/Herman's Code |                    |                   |


See https://www.google.com/search?q=can+you+merge+multiple+repositories+and+keep+their+history
or
https://www.linkedin.com/pulse/merge-multiple-git-repositories-without-breaking-file-akshay-kaushik-qto1f/

I left off in the `fetch` step from the LinkedIn article above.

## Track my coding projects

I have code and coding-related files and folders throughout my computer. I should organize them. I can start by searching in these folders:

- /Users/herman
- /Users/herman/Documents
- /Users/herman/Documents/Herman's Code

Maybe  I can try something like

```bash
find / -iname *.py
```

| Folder Name                 | X   | URI                                                               |
| --------------------------- | --- | ----------------------------------------------------------------- |
| Apple Health Blood Pressure | -   | /Users/herman/Documents/Herman's Code/Apple Health Blood Pressure |
| .ssh.copy                   | -   | /Users/herman/Documents/Herman's Code/.ssh.copy                   |
| .vim                        | -   | herman@pyspark:/home/herman/.vim/.vimrc                           |

# Done

### Remove GUI Apps, packages, and find and remove traces
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

### Remove Folders
  - [x] "/Users/Shared": The whole folder is about 2GB and there's nothing important there. Try `sudo rm -rf` the subfolders, but not the folder itself.
