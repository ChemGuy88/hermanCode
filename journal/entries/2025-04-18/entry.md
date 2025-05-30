# 2025-04-18

After install *Homebrew* on the iMac, Z Shell's `compinit` complained about a security issue when logging in as a non-administrative user. An exact similar problem has been noted by [others](https://stackoverflow.com/q/58419760/5478086). A Stack Exchange [post](https://stackoverflow.com/a/43544733/5478086) outlined the cause and possible ways to troubleshoot and resolve the problem. Note the following

```zsh
# As non-admin user
compaudit
```

```text
There are insecure directories and files:
/usr/local/share/zsh/site-functions
/usr/local/share/zsh
/usr/local/share/zsh/site-functions/_brew
```

I logged in as an administrator and got

```zsh
compaudit
# No result
```

I called `compaudit` on each of the parent directories for the paths listed above:

```zsh
compaudit /usr/local/share/zsh/site-functions/_brew
# No result
compaudit /usr/local/share/zsh/site-functions
# No result
compaudit /usr/local/share/zsh
# Result:
# There are insecure directories:
# /usr/local/share
```

I then tried changing ownershpi and permissions until `compaudit` gave no warnings:

```zsh
sudo chown -v root /usr/local/share
compaudit /usr/local/share 
# There are insecure directories:
# /usr/local/share

sudo chown -v root:wheel /usr/local/share
compaudit /usr/local/share 
# There are insecure directories:
# /usr/local/share

sudo chmod -vvv g-w /usr/local/share 
compaudit /usr/local/share 
# No result

sudo chown -vvv herman:admin /usr/local/share
compaudit /usr/local/share 
# No result (negative result)
```

So it seems that `compaudit` was giving a positive result because the folder had group write permissions. Unfortunately this did not quell the warnings for `compaudit` on the non-administrative user.

```zsh
compaudit
# There are insecure directories and files:
# /usr/local/share/zsh/site-functions
# /usr/local/share/zsh
# /usr/local/share/zsh/site-functions/_brew
```

Checking the permissions with `ls -l` on each of these paths I noticed that `_brew` is actually a link to `/usr/local/share/Homebrew/completions/zsh/_brew`. It then occurred to me that maybe moving `_brew` would silence the warnings.

```zsh
# As admin user:
mv /usr/local/share/zsh/site-functions/_brew ~/_brew
```

And indeed the warning was absent, but only for that specific link.

```zsh
# As non-admin user:
compaudit
# There are insecure directories and files:
# /usr/local/share/zsh/site-functions
# /usr/local/share/zsh
```

## Aside

I did the following thinking it would stop the `compaudit` warnings, but on second thought I realized it's unnecessary, because `compaudit` without arguments doesn't warn about `/usr/local/Homebrew` and its contents, although if you pass the paths to it as arguments, it will give a warning about them.

```zsh
# As admin-user
sudo chown -vvv root:admin /usr/local/Homebrew/completions/zsh/_brew
# /usr/local/Homebrew/completions/zsh/_brew: 501:80 -> 0:80
sudo chown -vvv root:admin /usr/local/Homebrew/completions/zsh
# /usr/local/Homebrew/completions/zsh: 501:80 -> 0:80
sudo chown -vvv root:admin /usr/local/Homebrew/completions
# /usr/local/Homebrew/completions: 501:80 -> 0:80
sudo chown -vvv root:admin /usr/local/Homebrew
# /usr/local/Homebrew: 501:80 -> 0:80

# As non-admin user
compaudit /usr/local/Homebrew/completions/zsh/_brew
# No warning
compaudit /usr/local/Homebrew/completions/zsh
# No warning
compaudit /usr/local/Homebrew/completions
# No warning
compaudit /usr/local/Homebrew
# No warning
```

Note that once you change the ownership of `/usr/local/Homebrew` to `root`, `brew doctor` will throw a warning

```zsh
brew doctor
```

```text
Warning: The following directories are not writable by your user:
/usr/local/Homebrew

You should change the ownership of these directories to your user.
  sudo chown -R herman /usr/local/Homebrew

And make sure that your user has write permission.
  chmod u+w /usr/local/Homebrew

Warning: Missing https://github.com/Homebrew/brew git origin remote.

Without a correctly configured origin, Homebrew won't update
properly. You can solve this by adding the remote:
  git -C "/usr/local/Homebrew" remote add origin https://github.com/Homebrew/brew
```

I undid the ownership changes and the resulting permission changes

```zsh
# As admin user
sudo chown -vvv herman:admin /usr/local/Homebrew/completions/zsh/_brew
sudo chown -vvv herman:admin /usr/local/Homebrew/completions/zsh
sudo chown -vvv herman:admin /usr/local/Homebrew/completions
sudo chown -vvv herman:admin /usr/local/Homebrew

sudo chmod -vvv 755 /usr/local/Homebrew/completions/zsh/_brew
sudo chmod -vvv 755 /usr/local/Homebrew/completions/zsh
# sudo chmod -vvv 755 /usr/local/Homebrew/completions
sudo chmod -vvv 775 /usr/local/Homebrew
```

Result:

```text
/usr/local/Homebrew/completions/zsh/_brew: 501:80 -> 501:80
/usr/local/Homebrew/completions/zsh: 0:80 -> 501:80
/usr/local/Homebrew/completions: 0:80 -> 501:80
/usr/local/Homebrew: 0:80 -> 501:80
/usr/local/Homebrew/completions/zsh/_brew: 0100644 [-rw-r--r-- ] -> 0100755 [-rwxr-xr-x ]
/usr/local/Homebrew: 040755 [drwxr-xr-x ] -> 040775 [drwxrwxr-x ]
```

## Following Homebrew's recommendations

After reading Jacob Ford's post I realized that these files are for shell completition, and maybe there's a way to disable them. Googling for `what is homebrew shell completion for` led me to some Homebrew documentation on Shell completion, specifically for [Z Shell](https://docs.brew.sh/Shell-Completion):

>  Additionally, if you receive “zsh compinit: insecure directories” warnings when attempting to load these completions, you may need to run this:
>
> ```zsh
> chmod -R go-w "$(brew --prefix)/share"
> ```

However, we know from calling `ls -l` that the contents already are protected from groups and others writing. But we did it anyway:

```zsh
# As admin user
chmod -R go-w "$(brew --prefix)/share"

# As non-admin user
compaudit
# There are insecure directories and files:
# /usr/local/share/zsh/site-functions
# /usr/local/share/zsh
# /usr/local/share/zsh/site-functions/_brew
```

The only solution, it seems, besides ignoring the warning with `compinit -u`, is to fork Z Shell and add an ability for `compaudit` to recognize trusted users.
