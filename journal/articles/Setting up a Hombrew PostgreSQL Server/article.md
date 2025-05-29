# Setting up a Hombrew PostgreSQL Server

<!-- Created 5/11/2025 -->

## Before starting

If you haven't decided how to install PostgreSQL, you might want to see [Choosing a PostgresQL Installer](./Choosing%20a%20PostgresQL%20Installer.md).

## Early Pitfalls

After the initial installation with Homebrew, you will notice some eccentricities. A simple `psql`, fails. This is because the first form of the command takes as a default value a database that is named after a user. In other words, `psql` is short for `psql DATABASE_NAME USER_NAME`, where `DATABASE_NAME` is the same as `USER_NAME`. However, that is not the case in the *Homebrew* distribution, and so it raises an error.

```text
psql: error: connection to server on socket "/tmp/.s.PGSQL.5432" failed: FATAL:  database "herman" does not exist
```

You can know what databases are available by calling `psql -l`. However, this also assumes that there is a server role (i.e. user) that is named after the computer account name that installed it. So if I installed it as computer user `herman`, there will be a server role called `herman`.

If `psql` is not set up to start after a reboot, you might encounter this error:

```text
psql: error: connection to server on socket "/tmp/.s.PGSQL.5432" failed: No such file or directory
	Is the server running locally and accepting connections on that socket?
```

It can be remedied using Homebrew's `services` command.

```sh
brew services start postgresql@16
```

## The set-up

### Part 1: The Principal Admin Role

#### Create admin role

```zsh
# Create a temporary admin role
psql -U $INITIAL_ADMIN_NAME -d postgres -c "CREATE USER temp_admin WITH PASSWORD \'$PASSWORD' SUPERUSER CREATEROLE CREATEDB REPLICATION BYPASSRLS;"
# Rename the initial user to `herman_admin`
psql -U temp_admin -c 'ALTER ROLE $INITIAL_ADMIN_NAME RENAME TO herman_admin;' -d postgres
psql -U herman_admin -c 'DROP USER IF EXISTS temp_admin;' -d postgres
```

#### Create admin database

```zsh
psql -U herman_admin -c 'CREATE DATABASE herman_admin OWNER herman_admin;' -d postgres
```

### Part 2: Secondary Roles

We can create secondary roles using the `setup_pg` script from *Herman's Code*.

```zsh
setup_pg -v -d ./data
```

Use `setup_pg -h` for details on how to use the program.

## Conclusion

That's it.
