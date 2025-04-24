# README

This folder contains a split zip archive to conform to the 100 MB per file size limit imposed by GitHub. It was created using the command

```zsh
cd "2025-04-24"
mkdir "data"
mv -nv "last.log" "data/last.log"
mv -nv "log "* "data"/
mkdir "data zip"
cd "data"
zip -v -s 45m -r "../data zip/data.zip" ./*
```

Combine split archive:

```zsh
cd ..
zip -s 0 "data zip/data.zip" --out "data all.zip"
```

We can then uncompress the combined zip archive and compare the disk usage of the original directory and the uncompressed directory.

```zsh
mv "data" "data 0"
unzip "data all.zip" -d "data 1"
du -s "data 0" "data 1"
# 849928	data 0
# 832976	data 1
echo $(( 849928 - 832976 ))
# 16952
```

Comparing the `git diff` of `du -s "data 0"/**.* > "data 0.text"` and `du -s "data 1"/**/*.* > "data 1.text"`, we see that only two files have different file sizes:

- log long 2025-04-23 23:46:23.JSON
- log long 2025-04-23 23:46:23.log

This is confirmed by `ls -l`

```zsh
lss "data 0/log long 2025-04-23 23:46:23.JSON" "data 1/log long 2025-04-23 23:46:23.JSON" "data 0/log long 2025-04-23 23:46:23.log" "data 1/log long 2025-04-23 23:46:23.log"
# 230320 -rw-r--r--  1 root    staff   104M Apr 24 08:27 data 0/log long 2025-04-23 23:46:23.JSON
#  45816 -rw-r--r--  1 root    staff    22M Apr 24 08:27 data 0/log long 2025-04-23 23:46:23.log
# 213392 -rw-r--r--  1 herman  staff   104M Apr 24 08:27 data 1/log long 2025-04-23 23:46:23.JSON
#  45792 -rw-r--r--  1 herman  staff    22M Apr 24 08:27 data 1/log long 2025-04-23 23:46:23.log

echo $(( 230320 + 45816 - 213392 - 45792 ))
# 16952
```
