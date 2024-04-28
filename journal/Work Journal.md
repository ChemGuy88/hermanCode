# Journal

# Code snippets

## Mounting the shared drive to the PySpark server

```bash
sudo /sbin/mount.cifs //ahcdfs.ahc.ufl.edu/files "/data/herman/Mounted Drives/UF Health Shared Drive" -o user=herman,dom=ad.ufl.edu,uid=herman,gid=herman,password=$HFA_UFADPWD,sec=ntlmssp,vers=2.0
```
