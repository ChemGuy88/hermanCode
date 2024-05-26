# Journal

# Code snippets

## Mounting drives to the PySpark server

**UF Health shared drive**
```bash
sudo /sbin/mount.cifs //ahcdfs.ahc.ufl.edu/files "/data/herman/Mounted Drives/UF Health Shared Drive" -o user=herman,dom=ad.ufl.edu,uid=herman,gid=herman,password=$HFA_UFADPWD,sec=ntlmssp,vers=2.0
```

**IDR1 drive**
```bash
sudo /sbin/mount.cifs //idr1.ahc.ufl.edu/idr1$ "/data/herman/Mounted Drives/IDR1" -o user=herman,dom=ad.ufl.edu,uid=herman,gid=herman,password=$HFA_UFADPWD,sec=ntlmssp,vers=2.0
```
