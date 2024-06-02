# Journal

# Code snippets

## Using visual `diff` tool in `git`

```bash
git difftool tool=emerge
```

This opens the emerge visual editor. Use `n` and `p` to move between the **next** and **previous** differences, respectively. To exit without savings changes use <kbd>Ctrl</kbd>+<kbd>]</kbd>, which in Emacs documentation is represented as `C-]` ([see here](https://www.gnu.org/software/emacs/manual/html_node/emacs/User-Input.html)). To exit with saving use `q`. See the [manual](https://www.gnu.org/software/emacs/manual/html_node/emacs/Merge-Commands.html#Merge-Commands) for more commands.

## Mounting drives to the PySpark server

**UF Health shared drive**
```bash
sudo /sbin/mount.cifs //ahcdfs.ahc.ufl.edu/files "/data/herman/Mounted Drives/UF Health Shared Drive" -o user=herman,dom=ad.ufl.edu,uid=herman,gid=herman,password=$HFA_UFADPWD,sec=ntlmssp,vers=2.0
```

**IDR1 drive**
```bash
sudo /sbin/mount.cifs //idr1.ahc.ufl.edu/idr1$ "/data/herman/Mounted Drives/IDR1" -o user=herman,dom=ad.ufl.edu,uid=herman,gid=herman,password=$HFA_UFADPWD,sec=ntlmssp,vers=2.0
```
