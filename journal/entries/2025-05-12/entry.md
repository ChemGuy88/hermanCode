# 2025-05-12

Re-formatting an external hard drive, an old OWC SSD. I've tried all this:

```text
Last login: Mon May 12 18:21:59 on console
Detected interactive mode. Continuing to load shell RC.

CPU usage: 44.96 %
RAM usage: 75.00 %
(herman-base)  6:24PM [1] Herman's Code --> cd /Volumes 
(herman-base)  6:24PM [2] /Volumes --> lss
total 0
0 drwxr-xr-x   3 root  wheel    96B May 12 18:22 .
0 drwxr-xr-x  22 root  wheel   704B Apr 12 01:16 ..
0 lrwxr-xr-x   1 root  wheel     1B May 12 18:21 Macintosh HD -> /
(herman-base)  6:24PM [3] /Volumes --> diskutil 
Disk Utility Tool
Utility to manage local disks and volumes
Most commands require an administrator or root user

WARNING: Most destructive operations are not prompted

Usage:  diskutil [quiet] <verb> <options>, where <verb> is as follows:

     list                 (List the partitions of a disk)
     info[rmation]        (Get information on a specific disk or partition)
     listFilesystems      (List file systems available for formatting)
     listClients          (List all current disk management clients)
     activity             (Continuous log of system-wide disk arbitration)

     u[n]mount            (Unmount a single volume)
     unmountDisk          (Unmount an entire disk (all volumes))
     eject                (Eject a disk)
     mount                (Mount a single volume)
     mountDisk            (Mount an entire disk (all mountable volumes))

     enableJournal        (Enable HFS+ journaling on a mounted HFS+ volume)
     disableJournal       (Disable HFS+ journaling on a mounted HFS+ volume)
     moveJournal          (Move the HFS+ journal onto another volume)
     enableOwnership      (Exact on-disk User/Group IDs on a mounted volume)
     disableOwnership     (Ignore on-disk User/Group IDs on a mounted volume)

     rename[Volume]       (Rename a volume)

     verifyVolume         (Verify the file system data structures of a volume)
     repairVolume         (Repair the file system data structures of a volume)
     verifyDisk           (Verify the components of a partition map of a disk)
     repairDisk           (Repair the components of a partition map of a disk)
     resetFusion          (Reset the components of a machine's Fusion Drive)

     eraseDisk            (Erase an existing disk, removing all volumes)
     eraseVolume          (Erase an existing volume)
     reformat             (Erase an existing volume with same name and type)
     eraseOptical         (Erase optical media (CD/RW, DVD/RW, etc.))
     zeroDisk             (Erase a disk, writing zeros to the media)
     randomDisk           (Erase a disk, writing random data to the media)
     secureErase          (Securely erase a disk or freespace on a volume)

     partitionDisk        ((re)Partition a disk, removing all volumes)
     addPartition         (Create a new partition to occupy free space)
     splitPartition       (Split an existing partition into two or more)
     mergePartitions      (Combine two or more existing partitions into one)
     resizeVolume         (Resize a volume, increasing or decreasing its size)

     appleRAID <verb>     (Perform additional verbs related to AppleRAID)
     coreStorage <verb>   (Perform additional verbs related to CoreStorage)
     apfs <verb>          (Perform additional verbs related to APFS)
     image <verb>         (Perform additional verbs related to DiskImage)

diskutil <verb> with no options will provide help on that verb

(herman-base)  6:24PM [4] /Volumes --> diskutil listClients | less
(herman-base)  6:25PM [5] /Volumes --> sudo diskutil listClients | less
(herman-base)  6:25PM [6] /Volumes --> sudo diskutil list              
/dev/disk0 (internal, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *2.0 TB     disk0
   1:             Apple_APFS_ISC Container disk1         524.3 MB   disk0s1
   2:                 Apple_APFS Container disk3         2.0 TB     disk0s2
   3:        Apple_APFS_Recovery Container disk2         5.4 GB     disk0s3

/dev/disk3 (synthesized):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      APFS Container Scheme -                      +2.0 TB     disk3
                                 Physical Store disk0s2
   1:                APFS Volume Macintosh HD            11.2 GB    disk3s1
   2:              APFS Snapshot com.apple.os.update-... 11.2 GB    disk3s1s1
   3:                APFS Volume Preboot                 7.1 GB     disk3s2
   4:                APFS Volume Recovery                1.0 GB     disk3s3
   5:                APFS Volume Data                    862.4 GB   disk3s5
   6:                APFS Volume VM                      20.5 KB    disk3s6

/dev/disk4 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *500.3 GB   disk4
   1:                        EFI EFI                     209.7 MB   disk4s1
   2:                 Apple_APFS Container disk5         499.9 GB   disk4s2

/dev/disk5 (synthesized):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      APFS Container Scheme -                      +499.9 GB   disk5
                                 Physical Store disk4s2

(herman-base)  6:25PM [7] /Volumes --> diskutil eraseDisk 
Usage:  diskutil eraseDisk [-noEFI] format name
[APM[Format]|MBR[Format]|GPT[Format]] MountPoint|DiskIdentifier|DeviceNode
(Re)-partition a whole disk (create a new partition map). This completely
erases any existing data on the given whole disk; all volumes on this disk
will be destroyed. Format is the specific file system name you want to erase it
as (HFS+, etc.). Name is the (new) volume name (subject to file system naming
restrictions), or can be specified as %noformat% to skip initialization
(newfs). You cannot erase the boot disk.
Ownership of the affected disk is required.
Example: diskutil eraseDisk JHFS+ UntitledUFS disk3
(herman-base)  6:28PM [8] /Volumes --> diskutil listFilesystems
Formattable file systems

These file system personalities can be used for erasing and partitioning.
When specifying a personality as a parameter to a verb, case is not considered.
Certain common aliases (also case-insensitive) are listed below as well.

-------------------------------------------------------------------------------
PERSONALITY                     USER VISIBLE NAME                               
-------------------------------------------------------------------------------
Case-sensitive APFS             APFS (Case-sensitive)                           
  (or) APFSX
APFS                            APFS                                            
  (or) APFSI
ExFAT                           ExFAT                                           
Free Space                      Free Space                                      
  (or) FREE
MS-DOS                          MS-DOS (FAT)                                    
MS-DOS FAT12                    MS-DOS (FAT12)                                  
MS-DOS FAT16                    MS-DOS (FAT16)                                  
MS-DOS FAT32                    MS-DOS (FAT32)                                  
  (or) FAT32
HFS+                            Mac OS Extended                                 
Case-sensitive HFS+             Mac OS Extended (Case-sensitive)                
  (or) HFSX
Case-sensitive Journaled HFS+   Mac OS Extended (Case-sensitive, Journaled)     
  (or) JHFSX
Journaled HFS+                  Mac OS Extended (Journaled)                     
  (or) JHFS+
(herman-base)  6:30PM [9] /Volumes --> sudo diskutil eraseDisk APFS Honeypot GPT disk5
Password:
You cannot manually format an existing APFS Container disk
(herman-base)  6:37PM [10] /Volumes --> sudo diskutil partitionDisk /dev/disk4 1 GPT[Format] APFS Honeypot 100%
zsh: no matches found: GPT[Format]
(herman-base)  6:46PM [11] /Volumes --> sudo diskutil partitionDisk /dev/disk4 1 GPTAPFS APFS Honeypot 100%
Password:
There appear to be too many arguments for the number of partitions you specified, or there is a syntax error in the arguments preceding the partitions
(herman-base)  6:46PM [12] /Volumes --> sudo diskutil partitionDisk /dev/disk4 1 GPT APFS Honeypot 100% 
Started partitioning on disk4
Unmounting disk
Error: -69877: Couldn't open device
(Is a disk in use by a storage system such as AppleRAID, CoreStorage, or APFS?)
(herman-base)  6:46PM [13] /Volumes --> 
```

Currently now the plan is to

  1. Wait a given amount of time for it to fix itself, according to the first comment on this [*AskDifferent* StackExchange post](https://apple.stackexchange.com/q/338300/322902).
  2. If that doesn't work, add a 100 GB partition to my MBA drive, copy the HDD to it, and then reformat that HDD.

So far I've gotten two errors from *Disk Utility*:

- 69626
- 69877

# Part 2

After restarting my computer with the intent to "let it fix itself", I noticed that the synthesized disk was not present in *diskutil*, so I went ahead and tried erasing it. But now I get a different error.

```text
Erasing “OWC Envoy Media” (disk4) and creating “Honeypot”

Unmounting disk
Creating the partition map
Waiting for partitions to activate
Formatting disk4s2 as Mac OS Extended (Journaled) with name Honeypot
newfs_hfs: WriteBuffer:  pwrite(3, 0x5fc400000, 1048576, 2101248): Device not configured
newfs_hfs: write (sector 4104): Device not configured

Mounting disk
Could not mount disk4s2 after erase
File system formatter failed. : (-69832)

Operation failed…
```

Then, based on this [post](https://apple.stackexchange.com/a/387218/322902), I tried:

```text
(herman-base)  7:52PM [2] Herman's Code --> diskutil eraseDisk JHFS+ dummy GPT disk4 
Started erase on disk4
Unmounting disk
Creating the partition map
Waiting for partitions to activate
Formatting disk4s2 as Mac OS Extended (Journaled) with name dummy
newfs_hfs: WriteBuffer:  pwrite(3, 0x632400000, 1048576, 10489856): Device not configured
newfs_hfs: write (sector 20488): Device not configured
Mounting disk
Could not mount disk4s2 after erase
Error: -69832: File system formatter failed

(herman-base)  7:59PM [3] Herman's Code --> sudo diskutil eraseDisk JHFS+ dummy GPT disk4
Password:
Started erase on disk4
Unmounting disk
Creating the partition map
Waiting for partitions to activate
Formatting disk4s2 as Mac OS Extended (Journaled) with name dummy
Error: -69825: Wiping volume data to prevent future accidental probing failed
```

# Part 3

I restarted again and this happens

```text
(herman-base)  8:08PM [2] Herman's Code --> sudo diskutil list
Password:
/dev/disk0 (internal, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *2.0 TB     disk0
   1:             Apple_APFS_ISC Container disk1         524.3 MB   disk0s1
   2:                 Apple_APFS Container disk3         2.0 TB     disk0s2
   3:        Apple_APFS_Recovery Container disk2         5.4 GB     disk0s3

/dev/disk3 (synthesized):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      APFS Container Scheme -                      +2.0 TB     disk3
                                 Physical Store disk0s2
   1:                APFS Volume Macintosh HD            11.2 GB    disk3s1
   2:              APFS Snapshot com.apple.os.update-... 11.2 GB    disk3s1s1
   3:                APFS Volume Preboot                 7.1 GB     disk3s2
   4:                APFS Volume Recovery                1.0 GB     disk3s3
   5:                APFS Volume Data                    862.4 GB   disk3s5
   6:                APFS Volume VM                      20.5 KB    disk3s6

/dev/disk4 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:                                                   *500.3 GB   disk4

(herman-base)  8:08PM [3] Herman's Code --> sudo diskutil eraseDisk JHFS+ dummy GPT disk4
Started erase on disk4
Unmounting disk
Creating the partition map
Waiting for partitions to activate
Formatting disk4s2 as Mac OS Extended (Journaled) with name dummy
newfs_hfs: WriteBuffer:  pwrite(3, 0x688400000, 1048576, 0): Device not configured
newfs_hfs: write (sector 0): Device not configured
Mounting disk
Could not mount disk4s2 after erase
Error: -69832: File system formatter failed
(herman-base)  8:08PM [4] Herman's Code --> sudo diskutil list                      
/dev/disk0 (internal, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *2.0 TB     disk0
   1:             Apple_APFS_ISC Container disk1         524.3 MB   disk0s1
   2:                 Apple_APFS Container disk3         2.0 TB     disk0s2
   3:        Apple_APFS_Recovery Container disk2         5.4 GB     disk0s3

/dev/disk3 (synthesized):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      APFS Container Scheme -                      +2.0 TB     disk3
                                 Physical Store disk0s2
   1:                APFS Volume Macintosh HD            11.2 GB    disk3s1
   2:              APFS Snapshot com.apple.os.update-... 11.2 GB    disk3s1s1
   3:                APFS Volume Preboot                 7.1 GB     disk3s2
   4:                APFS Volume Recovery                1.0 GB     disk3s3
   5:                APFS Volume Data                    862.4 GB   disk3s5
   6:                APFS Volume VM                      20.5 KB    disk3s6

/dev/disk4 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *500.3 GB   disk4
   1:                        EFI EFI                     209.7 MB   disk4s1
   2:                  Apple_HFS                         499.9 GB   disk4s2

```

The disk became "uninitialized", but when I tried erasing it, it became initialized.

Then I try this:

```
(herman-base)  8:11PM [6] Herman's Code --> sudo diskutil eraseDisk HFS+ dummy GPT disk4 
Started erase on disk4
Unmounting disk
Creating the partition map
Waiting for partitions to activate
Formatting disk4s2 as Mac OS Extended with name dummy
newfs_hfs: WriteBuffer:  pwrite(3, 0xc16400000, 1048576, 0): Device not configured
newfs_hfs: write (sector 0): Device not configured
Mounting disk
Could not mount disk4s2 after erase
Error: -69832: File system formatter failed

(herman-base)  8:12PM [7] Herman's Code --> sudo diskutil eraseDisk "MS-DOS FAT32" dummy GPT disk4
Started erase on disk4
Unmounting disk
Creating the partition map
Waiting for partitions to activate
Formatting disk4s2 as MS-DOS (FAT32) with name dummy
Error: -69825: Wiping volume data to prevent future accidental probing failed

(herman-base)  8:16PM [8] Herman's Code --> sudo diskutil eraseDisk FREE dummy GPT disk4
Started erase on disk4
Unmounting disk
Creating the partition map
Waiting for partitions to activate
Finished erase on disk4
```

Then I tried in *Disk Utility* to format it to APFS but I get the same error as before: *Device not configured*.

```text
(herman-base)  8:17PM [9] Herman's Code --> sudo diskutil eraseDisk FREE dummy GPT disk4  # To re-initialize
Started erase on disk4
Unmounting disk
Creating the partition map
Waiting for partitions to activate
Finished erase on disk4

(herman-base)  8:20PM [10] Herman's Code --> sudo diskutil eraseDisk ExFAT dummy GPT disk4
Started erase on disk4
Unmounting disk
Creating the partition map
Error: 6: Device not configured

# Device becomes un-initialized again.

(herman-base)  8:20PM [11] Herman's Code --> sudo diskutil eraseDisk FREE dummy GPT disk4  # To re-initialize.
Started erase on disk4
Unmounting disk
Creating the partition map
Waiting for partitions to activate
Finished erase on disk4
```

# Trying `fsck`

```text
(herman-base)  8:24PM [14] Herman's Code --> sudo fsck_hfs -fy /dev/disk4
** /dev/rdisk4
   Executing fsck_hfs (version hfs-683.100.9).
volumeType is 0
/dev/rdisk4 0000:  0000 0000 0000 0000 0000 0000 0000 0000       |................|
. . .
/dev/rdisk4 01b0:  0000 0000 0000 0000 0000 0000 0000 00fe       |................|
/dev/rdisk4 01c0:  ffff eefe ffff 0100 0000 a370 3d3a 0000       |...........p....|
/dev/rdisk4 01d0:  0000 0000 0000 0000 0000 0000 0000 0000       |................|
. . .
/dev/rdisk4 01f0:  0000 0000 0000 0000 0000 0000 0000 55aa       |..............U.|
```

```zsh
sudo diskutil eraseDisk APFS dummy GPT disk4
```

```text
Started erase on disk4
Unmounting disk
Creating the partition map
Waiting for partitions to activate
Formatting disk4s2 as APFS with name dummy
tx_checkpoint_desc_zero:394: rdisk4s2 failed to zero checkpoint descriptor block 130 @ 131: 6
nx_format:377: tx checkpoint descriptor area initialization failed: 6 - Device not configured
tx_mgr_free_tx:189: rdisk4s2 Trash unfinished tx xid=0x1
newfs_apfs: unable to format /dev/disk4s2: Device not configured
Mounting disk
Could not mount disk4s2 after erase
Error: -69832: File system formatter failed
```

```text
sudo fsck_apfs -fy /dev/disk4            
warning: option -f is not implemented, ignoring
0000:  0000 0000 0000 0000 0000 0000 0000 0000       |................|
. . .
01b0:  0000 0000 0000 0000 0000 0000 0000 00fe       |................|
01c0:  ffff eefe ffff 0100 0000 a370 3d3a 0000       |...........p....|
01d0:  0000 0000 0000 0000 0000 0000 0000 0000       |................|
. . .
01f0:  0000 0000 0000 0000 0000 0000 0000 55aa       |..............U.|
0200:  4546 4920 5041 5254 0000 0100 5c00 0000       |EFI.PART........|
0210:  7d8f 6900 0000 0000 0100 0000 0000 0000       |..i.............|
0220:  a370 3d3a 0000 0000 2200 0000 0000 0000       |.p..............|
0230:  8270 3d3a 0000 0000 4ac9 fe48 db6e 2b49       |.p......J..H.n.I|
0240:  b2e6 4534 af50 b0a2 0200 0000 0000 0000       |..E4.P..........|
0250:  8000 0000 8000 0000 6a7c 6d41 0000 0000       |........j.mA....|
0260:  0000 0000 0000 0000 0000 0000 0000 0000       |................|
. . .
0400:  2873 2ac1 1ff8 d211 ba4b 00a0 c93e c93b       |.s.......K......|
0410:  a014 24b0 8c44 1042 b50c a35d 28c6 db98       |.....D.B........|
0420:  2800 0000 0000 0000 2740 0600 0000 0000       |................|
0430:  0000 0000 0000 0000 4500 4600 4900 2000       |........E.F.I...|
0440:  5300 7900 7300 7400 6500 6d00 2000 5000       |S.y.s.t.e.m...P.|
0450:  6100 7200 7400 6900 7400 6900 6f00 6e00       |a.r.t.i.t.i.o.n.|
0460:  0000 0000 0000 0000 0000 0000 0000 0000       |................|
. . .
0480:  ef57 347c 0000 aa11 aa11 0030 6543 ecac       |.W4........0eC..|
0490:  eb29 8fa7 3308 884c 8b8b f1e4 02d2 e2d5       |....3..L........|
04a0:  2840 0600 0000 0000 7f70 3d3a 0000 0000       |.........p......|
04b0:  0000 0000 0000 0000 0000 0000 0000 0000       |................|
. . .
0ff0:  0000 0000 0000 0000 0000 0000 0000 0000       |................|

error: Device does not contain a valid APFS container.
   Container superblock is invalid.
** The container /dev/disk4 could not be verified completely.
(herman-base)  8:27PM [20] Herman's Code --> man fsck_apfs                
(herman-base)  8:27PM [21] Herman's Code --> sudo fsck_apfs -y /dev/disk4s2
0000:  0000 0000 0000 0000 0000 0000 0000 0000       |................|
. . .
0ff0:  0000 0000 0000 0000 0000 0000 0000 0000       |................|

error: Device does not contain a valid APFS container.
   Container superblock is invalid.
** The container /dev/disk4s2 could not be verified completely.
(herman-base)  8:28PM [22] Herman's Code --> sudo fsck_apfs -y /dev/disk4s1
0000:  eb58 9042 5344 2020 342e 3400 0201 2000       |.X.BSD..4.4.....|
0010:  0200 0000 00f0 0000 2000 1000 0000 0000       |................|
0020:  0040 0600 4f0c 0000 0000 0000 0200 0000       |....O...........|
0030:  0100 0600 0000 0000 0000 0000 0000 0000       |................|
0040:  0000 29ed 17e3 6745 4649 2020 2020 2020       |......gEFI......|
0050:  2020 4641 5433 3220 2020 fa31 c08e d0bc       |..FAT32....1....|
0060:  007c fb8e d8e8 0000 5e83 c619 bb07 00fc       |................|
0070:  ac84 c074 06b4 0ecd 10eb f530 e4cd 16cd       |...t.......0....|
0080:  190d 0a4e 6f6e 2d73 7973 7465 6d20 6469       |...Non.system.di|
0090:  736b 0d0a 5072 6573 7320 616e 7920 6b65       |sk..Press.any.ke|
00a0:  7920 746f 2072 6562 6f6f 740d 0a00 0000       |y.to.reboot.....|
00b0:  0000 0000 0000 0000 0000 0000 0000 0000       |................|
. . .
01f0:  0000 0000 0000 0000 0000 0000 0000 55aa       |..............U.|
0200:  5252 6141 0000 0000 0000 0000 0000 0000       |RRaA............|
0210:  0000 0000 0000 0000 0000 0000 0000 0000       |................|
. . .
03e0:  0000 0000 7272 4161 4127 0600 0300 0000       |....rrAaA.......|
03f0:  0000 0000 0000 0000 0000 0000 0000 55aa       |..............U.|
0400:  0000 0000 0000 0000 0000 0000 0000 0000       |................|
. . .
0c00:  eb58 9042 5344 2020 342e 3400 0201 2000       |.X.BSD..4.4.....|
0c10:  0200 0000 00f0 0000 2000 1000 0000 0000       |................|
0c20:  0040 0600 4f0c 0000 0000 0000 0200 0000       |....O...........|
0c30:  0100 0600 0000 0000 0000 0000 0000 0000       |................|
0c40:  0000 29ed 17e3 6745 4649 2020 2020 2020       |......gEFI......|
0c50:  2020 4641 5433 3220 2020 fa31 c08e d0bc       |..FAT32....1....|
0c60:  007c fb8e d8e8 0000 5e83 c619 bb07 00fc       |................|
0c70:  ac84 c074 06b4 0ecd 10eb f530 e4cd 16cd       |...t.......0....|
0c80:  190d 0a4e 6f6e 2d73 7973 7465 6d20 6469       |...Non.system.di|
0c90:  736b 0d0a 5072 6573 7320 616e 7920 6b65       |sk..Press.any.ke|
0ca0:  7920 746f 2072 6562 6f6f 740d 0a00 0000       |y.to.reboot.....|
0cb0:  0000 0000 0000 0000 0000 0000 0000 0000       |................|
. . .
0df0:  0000 0000 0000 0000 0000 0000 0000 55aa       |..............U.|
0e00:  5252 6141 0000 0000 0000 0000 0000 0000       |RRaA............|
0e10:  0000 0000 0000 0000 0000 0000 0000 0000       |................|
. . .
0fe0:  0000 0000 7272 4161 4127 0600 0300 0000       |....rrAaA.......|
0ff0:  0000 0000 0000 0000 0000 0000 0000 55aa       |..............U.|

error: Device does not contain a valid APFS container.
   Container superblock is invalid.
** The container /dev/disk4s1 could not be verified completely.
```

So apparently the SSD has some old formatting. It seems the contents/data/formatting is corrupt.

# Trying out `dd`

I googled ```|.X.BSD..4.4.....|` and [one of the results](https://discussions.apple.com/thread/251607590?sortBy=rank) mentioned erasing part of a disk to force a certain behavior. But I thought, why not [erase the whole thing](https://askubuntu.com/a/142862/956843)?

```zsh
sudo dd if=/dev/zero of=/dev/disk4 status=progress bs=16M && sync
```

Wish me luck!

...

lol

```text
dd: /dev/disk4: Device not configured) transferred 66.003s, 7544 MB/s

29819+0 records in
29818+0 records out
500263026688 bytes transferred in 66.302319 secs (7545181439 bytes/sec)
```

# Comparing to Toshiba HDD

```text
(herman-base) 10:37PM [1] Herman's Code --> diskutil list                                                    
/dev/disk0 (internal, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *2.0 TB     disk0
   1:             Apple_APFS_ISC Container disk1         524.3 MB   disk0s1
   2:                 Apple_APFS Container disk3         2.0 TB     disk0s2
   3:        Apple_APFS_Recovery Container disk2         5.4 GB     disk0s3

/dev/disk3 (synthesized):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      APFS Container Scheme -                      +2.0 TB     disk3
                                 Physical Store disk0s2
   1:                APFS Volume Macintosh HD            11.2 GB    disk3s1
   2:              APFS Snapshot com.apple.os.update-... 11.2 GB    disk3s1s1
   3:                APFS Volume Preboot                 7.1 GB     disk3s2
   4:                APFS Volume Recovery                1.0 GB     disk3s3
   5:                APFS Volume Data                    863.0 GB   disk3s5
   6:                APFS Volume VM                      20.5 KB    disk3s6

/dev/disk4 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *320.1 GB   disk4
   1:                        EFI EFI                     209.7 MB   disk4s1
   2:       Microsoft Basic Data TOSHIBA EXT             319.7 GB   disk4s2
                    (free space)                         134.5 MB   -

(herman-base) 10:37PM [2] Herman's Code --> sudo fsck_msdos /dev/disk4 | less                             
(herman-base) 10:38PM [3] Herman's Code --> sudo fsck_msdos /dev/disk4       
** /dev/rdisk4Warning: (NO WRITE)
Invalid BS_jmpBoot in boot block: 000000
(herman-base) 10:38PM [4] Herman's Code --> sudo fsck_msdos /dev/disks1
** /dev/rdisks1
Can't open
 (No such file or directory)
(herman-base) 10:38PM [5] Herman's Code --> sudo fsck_msdos /dev/disk4s1
** /dev/rdisk4s1
** Phase 1 - Preparing FAT
** Phase 2 - Checking Directories
** Phase 3 - Checking for Orphan Clusters
Warning: 0 files, 201632 KiB free (403265 clusters)
(herman-base) 10:38PM [6] Herman's Code --> sudo fsck_msdos /dev/disk4s2
** /dev/rdisk4s2Warning: (NO WRITE)
** Phase 1 - Preparing FAT
** Phase 2 - Checking Directories
** Phase 3 - Checking for Orphan Clusters
Warning: 69105 files, 266484576 KiB free (8327643 clusters)
```

```text
(herman-base) 10:38PM [1] Herman's Code --> sudo fsck_exfat /dev/disk4
Password:
fsck_exfat: Opened /dev/rdisk4 read-only
** Checking volume.
** Checking main boot region.
   Main boot region is invalid. Trying alternate boot region.
** Checking alternate boot region.
   Alternate boot region is invalid.
** The volume  could not be verified completely.
(herman-base) 10:39PM [2] Herman's Code --> sudo fsck_exfat /dev/disk4s1
** Checking volume.
** Checking main boot region.
   Main boot region is invalid. Trying alternate boot region.
** Checking alternate boot region.
   Alternate boot region is invalid.
** The volume  could not be verified completely.
(herman-base) 10:39PM [3] Herman's Code --> sudo fsck_exfat /dev/disk4s2
fsck_exfat: Opened /dev/rdisk4s2 read-only
** Checking volume.
** Checking main boot region.
   Main boot region is invalid. Trying alternate boot region.
** Checking alternate boot region.
   Alternate boot region is invalid.
** The volume  could not be verified completely.
```

And finally:

```text
Erasing “Toshiba External USB HDD Media” (disk4) and creating “Honeypot”

Unmounting disk
Creating the partition map
Waiting for partitions to activate
Formatting disk4s2 as Mac OS Extended (Journaled) with name Honeypot
Initialized /dev/rdisk4s2 as a 298 GB case-insensitive HFS Plus volume with a 24576k journal

Mounting disk
Creating a new empty APFS Container
Unmounting Volumes
Switching disk4s2 to APFS
Creating APFS Container
Created new APFS Container disk5
Preparing to add APFS Volume to APFS Container disk5
Creating APFS Volume
Created new APFS Volume disk5s1
Mounting APFS Volume
Setting volume permissions

Operation successful.
```

# References

- https://apple.stackexchange.com/a/313858/322902
