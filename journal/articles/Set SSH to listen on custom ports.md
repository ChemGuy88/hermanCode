# Set SSH to listen on custom ports

- Copy or edit `/etc/ssh/sshd_config`
  - If copying:
    - `sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config_custom`
    - `sudo vim /etc/ssh/sshd_config_custom`
  - If editing
    - `sudo vim /etc/ssh/sshd_config`

Add however many additional lines you want in the form `Port X`, where `X` is the port number. The default is 22. Here is an excerpt of the part of the file we will be editing, based on the OpenBSD version of the file (v 1.104 2021/07/02 05:11:21)

```text
# explicitly set.  Options that appear multiple times keep the first value set,
# unless they are a multivalue option such as HostKey.
Include /etc/ssh/sshd_config.d/*

#Port 22
#AddressFamily any
#ListenAddress 0.0.0.0
```

The default values are commented out for reference. If we want to launch the SSH server to use ports 22, 1024, and 1025, we would edit the file like this:

```text
# explicitly set.  Options that appear multiple times keep the first value set,
# unless they are a multivalue option such as HostKey.
Include /etc/ssh/sshd_config.d/*

Port 22
Port 1024
Port 1025
#AddressFamily any
#ListenAddress 0.0.0.0
```

Save the results on vim with `:wq`. If you get any permission or read/write errors make sure you were using vim with `sudo`.

Next, use `sshd`'s parsing to test the new configuration. If you try to run `sshd` without the full path, it will ask you to do so. You can use `which sshd` to find the full path. Also, it might not be able to load the keys if you don't run it with sudo. Therefore the recommended command is, if you edited the config file:

```shell
sudo "$(which sshd)" -t -f /etc/ssh/sshd_config
```

or, if you copied the file:

```shell
sudo "$(which sshd)" -t -f /etc/ssh/sshd_config_custom
```

If you get an error, you can troubleshoot using the `-T` and `-d` options. If nothing is returned, the configuration file is valid and you only need to run it again without the test mode.

```shell
sudo "$(which sshd)" -f /etc/ssh/sshd_config  # or "/etc/ssh/sshd_config_custom"
```

To confirm that SSH is listening on the ports that you added, run the following command and make sure you see the ports listed in the result.

```shell
sudo lsof -i -P | grep LISTEN | grep :1024
```

where `1024` is the port number from our example. If you added multiple ports and want to check each one, you will need to run the above command with each different port number.
