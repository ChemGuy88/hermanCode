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
> ...
> 
> To keep the hostname between reboots, run scutil --set HostName name-of-host.

I permanently changed the `hostname` values according to ["Shell Package/constants.sh"](../../Shell%20Package/constants.sh).

For more information try `defaults read <domain> <key>`:

```zsh
$ defaults read /Library/Preferences/SystemConfiguration/preferences System
> {
>     Network =     {
>         HostNames =         {
>             LocalHostName = "Hermans-MacBook-Air";
>         };
>     };
>     System =     {
>         ComputerName = "Herman\\U2019s MacBook Air";
>         ComputerNameEncoding = 0;
>         HostName = "herman-mba";
>     };
> }
```

And you can probably restore the domain information using `scutil`:

```zsh
$ scutil --dns
> DNS configuration
> 
> resolver #1
>   search domain[0] : attlocal.net
>   nameserver[0] : 2600:1700:3870:d770::1
>   nameserver[1] : 192.168.1.254
>   if_index : 11 (en0)
>   flags    : Request A records, Request AAAA records
>   reach    : 0x00020002 (Reachable,Directly Reachable Address)
```
