# SSH to your home Mac

<!-- 
Created: March 12, 2025 at 11:19 AM
Last edited: March 18, 2025 at 11:03 AM
First published: ...
Last published: ...
 -->

A tutorial on how to SSH from one mac to another. We describe variations on the theme as follows:
    -  without using passwords on subsequent logins.
    -  On the same WiFi or not, i.e., at home or not.

## Pre-requisites

### Allow remote logins to you Mac

These instructions are copied from the Apple Support guide [here](https://support.apple.com/lt-lt/guide/mac-help/mchlp1066/mac).

<ol>
    <li>
    On your Mac, choose Apple menu <img src="../images/SharedGlobalArt/IL_AppleLogo_11~dark.png"   width="10" title="" alt="IL_AppleLogo_11~dark"/> > System Settings, click General <img src="../images/SharedGlobalArt/AppIconTopic_General.png" width="10" alt="AppIconTopic_General" /> in the sidebar, then click Sharing. (You may need to scroll down.)
    </li>
    <li>
    Click <img src="../images/SharedGlobalArt/IL_InfoCircle.png" width="10" title="" alt="the Info button"/> next to Remote Login.
    </li>
    <li>
    Turn on Remote Login.
    <li>
    If you want remote users to have full access to the disk on your Mac, turn on “Allow full disk access for remote users.”
    </li>
    <li>
    Click the “Allow access for” pop-up menu, then do one of the following:
        <ul>
            <li>
            <i>Let everyone log in to your computer</i>: Click the pop-up menu next to “Allow access for,” then choose “All users.”
            </li>
            <li>
                <p>
<i>Choose who can log in to your computer</i>: Click the pop-up menu next to “Allow access for,” choose “Only these users,” click the <img src="../images/SharedGlobalArt/IL_InfoCircle.png" width="10" title="" alt="Add"/> button at the bottom of the list, select users who can log in remotely, then click Select.
                </p>
                <p>
Users & Groups includes all the users of your Mac. Network Users and Network Groups include people on your network.
                </p>
                <p>
To remove a user from the list, select the user, then click the Remove button.
                </p>
            </li>
        </ul>
    </li>
</ol>

## Instructions: Simple SSH

To remotely log in to a computer simply do 

```shell
ssh REMOTE_USER_ID@HOST
```

where `REMOTE_USER_ID` is the user account on the host that you're trying to log in as, and `HOST` is the host you're trying to log into. For example

```shell
ssh herman@191.168.1.1
# or
ssh herman@hermans_computer
```

This is the simplest way to use `ssh`, but it requires a password authentication with each login. To login without manual authentication, try using SSH keys.

## Instructions: Password-less SSH on a local network

These steps were inspired by this University of Florida IT [article](https://help.rc.ufl.edu/doc/Using_SSH_Keys_To_Access_HPG). You don't need SSH keys to login to a remote computer, but it's convenient because it removes the need to use a password each time.

### Step 1: Create SSH Keys

Here's an example:

```shell
ssh-keygen -a 32 
         \ -t ed25519
         \ -f ~"/.ssh/identity_files/Herman's Computer"
         \ -C "Key created on Herman's Computer 1 to login to Herman's Computer 2."
```

Feel free to edit or omit any of the options (`-a`, `-t`, `-f`, `-C`) as you want.

### Step 2: Add configuration on client computer

Edit your SSH `config` file to include the identity file (key) create in **Step 1**. If the identity file is used for all hosts, you can use

```text
Host *
    IdentityFile PATH_TO_IDENTITY_FILE
```

where PATH_TO_IDENTITY_FILE is the path to the identity file. If you're using an identity file for a specific host, then add it to the specific host

```text
Host host1
    IdentityFile PATH_TO_IDENTITY_FILE
```

Some other useful configurations are 

```text
Host host1
    User herman
    HostName hermans_computer
    Port 22
```

This allows you to easily login by using an alias defined by the `Host` parameter:

```shell
ssh host1
```

### Step 3: Copy Key to Host

Configure your account on the host to accept the key instead of the username and password. If you are already logged in you can manually edit the `~/.ssh/authorized_keys` file and add the new public ssh key. Alternatively you can use `ssh-copy-id`:

```shell
ssh-copy-id -i ~"/.ssh/identity_files/Herman's Computer"
          \ herman@hermans_computer
```

### Step 4: Confirm key works

```shell
ssh host1
```

## Instructions: Password-less SSH on a remote network

1. Enable [port forwarding for SSH](.%2FPort%20Forwarding.md)
2. If using a port besides 22, make sure the host is [listening on your custom port](.%2FSet%20SSH%20to%20listen%20on%20custom%20ports.md).
3. Repeat steps 1 to 4 for [**Password-less SSH on a local network**](#instructions-password-less-ssh-on-a-local-network)

## Notes

### SSH Flowchart

1. Your computer, the client, checks its `known_hosts` file to see if the host has been visited before.
2. The host checks if your computer's public key exists in its `authorized_keys` file.
   1. If it is not, the client is prompted for a password for authentication.
   2. If it is, the client is not prompted for a password, and authentication is scucessfull.
