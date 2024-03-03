#!/bin/bash
# Deleting VMWare Fusion
# Follow the steps here: https://kb.vmware.com/s/article/1017838
# Comment abbreviations:
# rs : requires sudo
# nf : not found
# d  : not in kb article, but found in the directory, and deleted just in case.

cd /
rm -r /Library/Application\ Support/VMware                                      # rs
rm -r /Library/Application\ Support/VMware\ Fusion                              # nf
rm -r /Library/Preferences/VMware\ Fusion                                       # rs
rm -r ~/Library/Application\ Support/VMware\ Fusion
rm -r ~/Library/Application\ Support/VMware\ Fusion\ Applications\ Menu
rm ~/Library/Caches/com.vmware.fusion                                           # nf
rm -r ~/Library/Preferences/VMware\ Fusion
rm ~/Library/Preferences/com.vmware.fusion.plist                                # nf
rm ~/Library/Preferences/com.vmware.fusion.plist.lockfile                       # nf
rm ~/Library/Preferences/com.vmware.fusionDaemon.plist                          # nf
rm ~/Library/Preferences/com.vmware.fusionDaemon.plist.lockfile                 # nf
rm ~/Library/Preferences/com.vmware.fusionApplicationsMenu.helper.plist         # d
rm ~/Library/Preferences/com.vmware.fusionApplicationsMenu.plist                # d
rm ~/Library/Preferences/com.vmware.fusionStartMenu.plist
rm ~/Library/Preferences/com.vmware.fusionStartMenu.plist.lockfile              # nf

echo Uninstall complete.
