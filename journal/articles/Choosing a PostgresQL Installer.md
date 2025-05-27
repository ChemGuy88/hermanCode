# Choosing a PostgresQL Installer

<!-- Created 5/11/2025 -->

From the PostgreSQL website we have X options to install the server:

    1. Interactive installer by EDB
    2. Postgres.app
    3. Homebrew
    4. MacPorts
    5. Fink

I don't know what Fink is, and it's the last on their list, so I'm not even considering it. I tried using MacPorts once and it seemed to have little support; it's also second-last on their list.

Now we get to the meat. I tried Homebrew because I've used it a lot before, but the problems start right away. I tried installing it first as a project-specific user, *midas*, but when I did

```zsh
brew install postgresql@16
```

*Homebrew* said:

```text
Error: /usr/local/Cellar is not writable. You should change the
ownership and permissions of /usr/local/Cellar back to your
user account:
  sudo chown -R midas /usr/local/Cellar
==> Downloading https://formulae.brew.sh/api/formula.jws.json
==> Downloading https://formulae.brew.sh/api/formula_tap_migrations.jws.json
==> Downloading https://formulae.brew.sh/api/cask.jws.json
Error: The following directories are not writable by your user:
/usr/local/Cellar
/usr/local/Frameworks
/usr/local/Homebrew
/usr/local/bin
/usr/local/etc
/usr/local/etc/bash_completion.d
/usr/local/include
/usr/local/lib
/usr/local/opt
/usr/local/sbin
/usr/local/share
/usr/local/share/doc
/usr/local/share/man
/usr/local/share/man/man1
/usr/local/share/zsh
/usr/local/share/zsh/site-functions
/usr/local/var/homebrew/linked
/usr/local/var/homebrew/locks

You should change the ownership of these directories to your user.
  sudo chown -R midas /usr/local/Cellar /usr/local/Frameworks /usr/local/Homebrew /usr/local/bin /usr/local/etc /usr/local/etc/bash_completion.d /usr/local/include /usr/local/lib /usr/local/opt /usr/local/sbin /usr/local/share /usr/local/share/doc /usr/local/share/man /usr/local/share/man/man1 /usr/local/share/zsh /usr/local/share/zsh/site-functions /usr/local/var/homebrew/linked /usr/local/var/homebrew/locks

And make sure that your user has write permission.
  chmod u+w /usr/local/Cellar /usr/local/Frameworks /usr/local/Homebrew /usr/local/bin /usr/local/etc /usr/local/etc/bash_completion.d /usr/local/include /usr/local/lib /usr/local/opt /usr/local/sbin /usr/local/share /usr/local/share/doc /usr/local/share/man /usr/local/share/man/man1 /usr/local/share/zsh /usr/local/share/zsh/site-functions /usr/local/var/homebrew/linked /usr/local/var/homebrew/locks
```

So then I go to the admin account on the machine, `herman` and install with *Homebrew*, again. However, I get some caveats after installation:

```text
==> Caveats
==> postgresql@16
This formula has created a default database cluster with:
  initdb --locale=C -E UTF-8 /usr/local/var/postgresql@16

postgresql@16 is keg-only, which means it was not symlinked into /usr/local,
because this is an alternate version of another formula.

If you need to have postgresql@16 first in your PATH, run:
  echo 'export PATH="/usr/local/opt/postgresql@16/bin:$PATH"' >> ~/.zshrc

For compilers to find postgresql@16 you may need to set:
  export LDFLAGS="-L/usr/local/opt/postgresql@16/lib"
  export CPPFLAGS="-I/usr/local/opt/postgresql@16/include"

To start postgresql@16 now and restart at login:
  brew services start postgresql@16
Or, if you don't want/need a background service you can just run:
  LC_ALL="C" /usr/local/opt/postgresql@16/bin/postgres -D /usr/local/var/postgresql@16
```

Here I was concerned about how much this deviated from other installations, and if that would be a problem down the line. And when I ran `brew services start postgresql@16` I got more reasons to be concerned:

```text
Warning: running over SSH without /dev/console ownership, using user/* instead of gui/* domain!
Hide this warning by setting HOMEBREW_SERVICES_NO_DOMAIN_WARNING.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).
==> Successfully started `postgresql@16` (label: homebrew.mxcl.postgresql@16)
```

This, I think, only has to do with the values passed to `sysctl`, which is what `brew services start` does under the hood. To be on the safe side, I ran `sudo brew services start postgresql@16` and I got

```text
Warning: Taking root:admin ownership of some postgresql@16 paths:
  /usr/local/Cellar/postgresql@16/16.9/bin
  /usr/local/Cellar/postgresql@16/16.9/bin/postgres
  /usr/local/opt/postgresql@16
  /usr/local/opt/postgresql@16/bin
This will require manual removal of these paths using `sudo rm` on
brew upgrade/reinstall/uninstall.
Warning: postgresql@16 must be run as non-root to start at user login!
```

After going for a walk I came back and was not as suspicious. None of the warnings themselves seem to guarantee a problem, and I'm actually impressed with the `brew services` feature, which is easier than working with `sysctl` directly.

After restarting the shell I did a simple 

```zsh
brew services start postgresql@16
```

Note that the *Homebrew* distribution of *PostgreSQL* has a quirk where the first command form, a simple `psql`, fails. This is because the first form takes as a default value a database that is named after a user. In other words, `psql DATABASE_NAME USER_NAME`, where `DATABASE_NAME` is the same as `USER_NAME`. However, that is not the case in the *Homebrew* distribution, and so it raises an error.

```text
psql: error: connection to server on socket "/tmp/.s.PGSQL.5432" failed: FATAL:  database "herman" does not exist
```

You can know what databases are available by calling `psql -l`. However, this also assumes that there is a server role (i.e. user) that is named after the computer account name that installed it. So if on a Mac it was installed by a user `herman`, there will be a server role called `herman`.

# References

If I ever need to migrate the PostgreSQL database from the Homebrew version to another, it should be easy, according to this [*StackOverflow* post](https://stackoverflow.com/q/59229256/5478086).
