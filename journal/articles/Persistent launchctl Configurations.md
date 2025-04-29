# Persistent `launchctl` Configurations

<!-- Created Thu Apr 24 11:36:27 2025 -->

We previously used `launchctl limit` to increase the number of file descriptors that could be used at the same time.

```zsh
launchctl limit maxfiles
# returns:
# 	maxfiles    256            unlimited 
# Which was then successfully changed by doing
launchctl limit maxfiles 4096 unlimited
```

However, after restarting the system these settings are reset to their default value. To make these settings persist, or rather, to automatically set them after rebooting, we must create a *daemon*. A daemon is launched by the system using `launchd` using the instructions stored in its corresponding property list file (e.g., `my_file.plist`). A simple *Hello, World* example is:

```XML
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.hermancode.helloworld</string>
    <key>ProgramArguments</key>
    <array>
        <string>touch</string>
        <string>/Users/herman/Documents/hermancode_helloworld.text</string>
    </array>
</dict>
</plist>
```

You can create a plist without `<key>KeepAlive</key><true/>` and run it with `launchctl start` after loading it with `bootstrap`. For this example we are running a specific kind of daemon, which is a global deamon, not to be confused with a system global daemon, which is more sensitive. The distinction depends on the location of the file. This example is in `/Library/LaunchDaemons`.

We can illustrate the function of a daemon with our example in the command line:

```zsh
sudo vim /Library/LaunchDaemons/com.hermancode.helloworld.plist

# Paste above XML

# Make sure daemon is not running or loaded
sudo launchctl list | grep hermancode

# Check directory before running daemon
lss /Users/herman/Documents/ | grep midas
# No result

# Load global daemon
sudo launchctl bootstrap system /Library/LaunchDaemons/com.hermancode.helloworld.plist

# Run daemon
sudo launchctl start com.hermancode.helloworld

# Check that the daemon was launched
sudo launchctl list | grep hermancode
# Result:
# -	0	com.hermancode.helloworld
# Note the successful exit code of "0"

# And check to see if the file was successfully created
lss /Users/herman/Documents/ | grep hermancode
# Result:
#   0 -rw-r--r--@  1 root    staff     0B Apr 24 15:45 hermancode_helloworld.text

# :: Don't forget to clean up if you want to run the same or other examples ::

# Unload global daemon
sudo launchctl bootout system /Library/LaunchDaemons/com.hermancode.helloworld.plist

# Make sure daemon is not running or loaded
sudo launchctl list | grep hermancode
```

Now for our specific problem regarding file descriptors, we want:

```XML
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <!-- Label -->
    <key>Label</key>
    <string>com.hermancode.maxfiles</string>
    <!-- Program -->
    <key>ProgramArguments</key>
    <array>
        <string>/bin/zsh</string>
        <string>/path/to/maxfiles.zsh</string>
    </array>
    <!-- Program Execution Options -->
    <key>RunAtLoad</key>
    <true/>
    <!-- Debugging -->
    <key>StandardOutPath</key>
    <string>/var/log/hermanCode/job.log</string>
    <key>StandardErrorPath</key>
    <string>/var/log/hermanCode/job.log</string>
    <key>Debug</key>
    <true/>
</dict>
</plist>
```

where `/path/to/maxfiles.zsh` is 

```zsh
launchctl limit maxfiles 4096 unlimited
```

Note that the `<!-- Debugging -->` block in the plist is optional.

Load and start the daemon as illustrated in the example and you will have accomplished your goal!

# References

- [Apple Developer documentation](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html)
- https://www.manpagez.com/man/5/launchd.plist/
- https://www.launchd.info/
