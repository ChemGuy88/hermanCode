# README

## To-do

- Clean-up my computer
- Consolidate my code
- Track all coding projects

## Clean-up my computer

###  Uninstall with Trash click-and-drag
  - [ ] ...

###  Find and remove packages
  - [ ] ...
  - [ ] JumpDesktop

Use the following code to search the packages
```bash
pkgutil --pkgs | grep -i $KEYWORD_TO_SEARCH_FOR | sort
```

Then use either `uninstallWithPkgutil.bash` or `uninstallWithPkgutil-Multiple.bash` to uninstall your packages.

### Find traces
- Batch 1
    - [ ] Akamai
    - [ ] BlueStacks  # Android emulator
    - [ ] continuum, continuum.io
    - [ ] iTools Pro
    - [ ] Microsoft Teams classic
    - [ ] SignalScope X
    - [ ] TestGen
    - [ ] texlive
    - [ ] texmf
    - [ ] TeXShop
    - [ ] TextWrangler
- Batch 2
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
   - [ ] "/Users/Shared"
   - [ ] "/Users/herman2"

##  Consolidate my code

Push the code from the iMac to a remote, one of 

| Repository Name | Date Created | URI                                          |
| --------------- | ------------ | -------------------------------------------- |
| hermanCode      | 2024-02-11   | https://github.com/ChemGuy88/hermanCode      |
| mySettings      | 2020-10-20   | https://github.com/ChemGuy88/mySettings      |
| bashrc          | 2020-10-20   | https://github.com/ChemGuy88/bashrc          |
| myAtom          | 2020-03-06   | https://github.com/ChemGuy88/myatom          |
| mlFunctions     | 2018-09-17   | https://github.com/ChemGuy88/mlFunctions     |
| N/A             | 2024-XX-XX   | herman@remote-imac:/Users/herman/.hermanCode |
| N/A             | 2024-XX-XX   | herman@pyspark:/.../.hermanCode              |

## Track my coding projects

I have code and coding-related files and folders throughout my computer. I should organize them. I can start my searching in these folders:

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
