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

## The set-up.

We will follow the pattern set out by another project [here](/Users/herman/Documents/LeetCode/setup_postgresql.sh).

We can generalize this and add it to **Shell Package/scripts**. Or not, if it takes too much time.
