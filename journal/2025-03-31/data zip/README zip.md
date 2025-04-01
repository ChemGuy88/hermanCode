# README

This folder contains a split zip archive to conform to the 100 MB per file size limit imposed by GitHub. It was created using the command

```zsh
cd "2025-03-31/data"
mv data "data 0"  # Rename original directory so it doesn't get overwritten during this test
zip -s 45m -r "data.zip" "data 0"
```

The documentation in `man zip` implies you can unzip it by simply calling `unzip` on the terminal `.zip` file as long as all (in this case, 3) of the related files are in the same directory, however 

```zsh
unzip "data.zip" -d "data 1"
```

produced extracted contents that were significantly less than what was expected. We expect a 1.1 GB directory, but instead got less than 1 MB.

```zsh
du -sh "data 0" "data 1"
# 1.1G	data 0
# 103M	data 1
```


We made two more attempts to extract directly from the partitioned archives:

```zsh
rm -rf "data 1"
unzip "data.z01" "data.z02" "data.z03" "data.z04" "data.z05" "data.zip" -d "data 1"
```

Output:

```text
Archive:  data.z01
  End-of-central-directory signature not found.  Either this file is not
  a zipfile, or it constitutes one disk of a multi-part archive.  In the
  latter case the central directory and zipfile comment will be found on
  the last disk(s) of this archive.
unzip:  cannot find zipfile directory in one of data.z01 or
        data.z01.zip, and cannot find data.z01.ZIP, period.
```

Note that `ls` confirmed all files were where they were expected (not shown here). Second attempt:

```zsh
unzip "data.zip" "data.z01" "data.z02" "data.z03" "data.z04" "data.z05" -d "data 1"
```

Output:

```text
Archive:  data.zip
warning [data.zip]:  zipfile claims to be last disk of a multi-part archive;
  attempting to process anyway, assuming all parts have been concatenated
  together in order.  Expect "errors" and warnings...true multi-part support
  doesn't exist yet (coming soon).
caution: filename not matched:  data.z01
caution: filename not matched:  data.z02
caution: filename not matched:  data.z03
caution: filename not matched:  data.z04
caution: filename not matched:  data.z05
```

It's in this last result that the truth is revealed, that the features outlined in the documentation were not fully implemented. So we resort to the other method described in the documentation for the `-O` and `-s` options in `man zip`, to combine the compressed.

```zsh
rm -rf "data 1"
zip -s 0 "data.zip" --out "data all.zip"
```

We can then uncompress the combined zip archive and compare the disk usage of the original directory and the uncompressed directory.

```zsh
mv "data 0" "data 00"  # Rename original directory so it doesn't get overwritten. Note that the compressed archive, when uncompressed, will also be called "data 0"
unzip "data all.zip"
mv "data 0" "data 1"
mv "data 00" "data 0"
du -s "data 0" "data 1"
# 2323584	data 0
# 2323728	data 1
echo $(( 2354576 - 2323584 ))
# 30992
```

Comparing the `git diff` of `du -s "data 0" > "data 0.text"` and `du -s "data 1" > "data 1.text"`, we see that only one file has a different file size: `log long 2025-03-30 22:15:36.JSON`. This is confirmed by `ls -la`

```zsh
lss "data 0/log long 2025-03-30 22:15:36.JSON" "data 1/log long 2025-03-30 22:15:36.JSON" 
# 862320 -rw-r--r--  1 herman  staff   421M Mar 31 14:24 data 0/log long 2025-03-30 22:15:36.JSON
# 893312 -rw-r--r--  1 herman  staff   421M Mar 31 14:24 data 1/log long 2025-03-30 22:15:36.JSON

echo $(( 893312 - 862320 ))
# 30992
```

**Note**: If for any reason the restored *logarchive* doesn't work, try renaming it to `log long 2025-03-30 22:15:36.logarchive`, incase the files inside are expecting the parent directory to have a specific name, like Chrome HTML web archives.
