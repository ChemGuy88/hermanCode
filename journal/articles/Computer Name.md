# Computer name

I've been using `hostname` to know what computer I'm using. However, I get different outputs for the same computer. For example, when logging into the iMac, I get

- `herman-imac.attlocal.net`
- `herman-imac.local`

When logging into the MacBook Air I get

- `Mac.attlocal.net`
- `Hermans-MacBook-Air.local`
- `Hermans-Air.attlocal.net`

I'm pretty sure that the domains (i.e. `.local` vs `.attlocal.net`) have something to do with how I connect to the machine, e.g. the `attlocal.net` domain is associated with an AT&T WiFi.

Note the following results from `hostname` and `scuitl`

```zsh
$ hostname -f
> Hermans-Air.attlocal.net
$ hostname -s   
> Hermans-Air
$ hostname -d
> attlocal.net
$ scutil --get ComputerName
> Herman’s MacBook Air
$ scutil --get HostName    
> HostName: not set
$ scutil --get LocalHostName
> Hermans-MacBook-Air
```

I thought that by setting `HostName` I would fix the output from `hostname`, and it did, in part, but it over-wrote the domain.

```zsh
$ scutil --set HostName "$(scutil --get LocalHostName)"
$ scutil --get HostName                                
> Hermans-MacBook-Air
```

The [`man` page for `hostname`](https://ss64.com/mac/hostname.html) is aware of the inconsistencies in the output.

> When you open a new Terminal window, the prompt will begin with the hostname and this may appear differently if you are connected to a WiFi network compared to opening a new Terminal when disconnected.
> 
> A DHCP server can provide a hostname to a client, along with an IP address, and the client system hostname will be changed to whatever the DHCP server sends.
> 
> If a NetBIOSName has been configured, (it is typically set to = the hostname) the value is stored in a preference file:
> $ defaults read /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName
> 
> You can set the NetBIOS name with defaults or in System Preferences ➞ Network ➞ active network port ➞ Advanced ➞ WINS tab.
> 
> To keep the hostname between reboots, run scutil --set HostName name-of-host.

I experiment with modifying the **com.apple.smb.server.plist** file and decided to change the NetBIOSName to a lowercase version of `HostName`

```zsh
$ defaults read /Library/Preferences/SystemConfiguration/com.apple.smb.server
> {
>     DOSCodePage = 437;
>     NetBIOSName = "Hermans-Air";
>     ServerDescription = "Herman\\U2019s MacBook Air";
> }
$ sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName 'hermans-mba'
$ defaults read /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName
> hermans-mba
```

## Update: 3/18/2025

For some reason when I exited Terminal the logout procedure did not work because the hostname was not recognize as one of the expected values. The logout procedure was expecting `Hermans-MacBook-Air.local` but it got `Hermans-MacBook-Air`. This means that since I wrote this article the hostname was reset. The only thing that has changed is that I'm now on a different WiFI network, although it's still one from AT&T. I will run `defaults write` again and set the value to `hermans-mba`.
