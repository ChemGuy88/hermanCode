# Things to Uninstall

As of 2/25/2024

# GUI Apps

0 drwxr-xr-x   3 root    wheel    96B Dec 17 17:07 Microsoft Teams classic.app
0 drwxr-xr-x@  3 root    wheel    96B Jan  6 08:01 SignalScope X.app
0 drwxr-xr-x   7 root    wheel   224B Mar  3  2021 TestGen
0 drwxr-xr-x   3 root    admin    96B Jul 31  2022 VirtualBox.app
0 drwxr-xr-x@  3 herman  admin    96B Jan 20  2020 iTools Pro.app

# Things to scour for

```
canopy
charles
CloudFlare
CrimeFlare
iStats
testgen
```

and anything from the **GUI Apps** above after you drag-and-drop them.

# macOS Packages

After dragging-and-dropping any applicable GUI Apps above, search for related keywords in macOS's package utility like this:

```bash
pkgutil --pkgs | grep -i $KEYWORD_TO_SEARCH_FOR | sort
```

Then use either `uninstallWithPkgutil.bash` or `uninstallWithPkgutil-Multiple.bash` to uninstall your packages.
