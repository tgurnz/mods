Project Name:	GRUB for DOS
Definition:	A GRUB build for DOS with extensions for disk drive emulation.
Current Version:	0.4.2
Author:		Tinybit(tinybit@tom.com)

File Format:	DOS EXE executable, Linux kernel

Purpose:	Launch GRUB boot loader from within DOS

Circumstanced Use:	in CONFIG.SYS or AUTOEXEC.BAT

Ability:	Boot any installed operating system on your PC

Limitations:	GRUB.EXE may run in real mode DOS. It cannot run from a DOS
		BOX inside Windows, nor if some TSR programs are running.

		Currently runs on MS-DOS 3.30, 4.0, 5.0, 6.0, 6.20. 6.21, 6.22,
			7.0(Win95), 7.10(Win98), 8.0(WinME/NT/2000/XP), and
			FreeDOS(build 2029 and hopefully more future builds).

		Limited support for returning to DOS from GRUB.EXE, see below.

Copyright(C):	Tinybit(tinybit@tom.com)

License:	GNU GPL(see file COPYING)

		source available as diff patches to the GNU GRUB release.
		See the shell script COMPILE for more info.

WARRANTY:	NO WARRANTY(see file COPYING)
		
TO DO:		Let GRLDR.MBR support more filesystems.

Usage:
		GRUB [--bypass] [--time-out=T] [--hot-key=K] [--config-file=FILE]
		
		The FILE, for example, can be (hd0,0)/menu.lst
		
		In CONFIG.SYS, the line looks like:
		
			install=c:\some\where\grub.exe --config-file=FILE
		
		If no options present, GRUB.EXE simply uses
		
			(hd0,0)/menu.lst
		
		as the configure file, if it exists. (Notice! We finally
		changed the default file from (hd0,0)/boot/grub/menu.lst to
		(hd0,0)/menu.lst)
		
		The partition (hd0,0) can be of a Windows partition or a Linux
		partition, or any other partition type supported by GRUB.

		Only GRUB-style filename is acceptable here for FILE. A DOS
		filename won't work(it is certain we should use GRUB-style
		filenames because DOS-filenames won't access a file in a
		Linux ext2 partition for example).(See Update 2 below)

		Update: FILE can be the contents of a menu. Use semi-colon
		to delimitate the embedded commands here in FILE. The FILE
		can be enclosed with a pair of double-quotes. For example:

			GRUB --config-file="root (hd0,0);chainloader +1"

		This command will boot the system in (hd0,0).

		Another example:

			GRUB --config-file="reboot"

		This command will reboot the machine.

		One more example:

			GRUB --config-file="halt"

		This command will halt the machine.

		if --bypass is specified, GRUB will exit to DOS when
		timeout reached.

		The option `--time-out=T' specifies the timeout value in
		seconds. T defaults to 5 if --bypass is specified and defaults
		to 0 if --bypass is not specified.

		The default hot key value is 0x3920(for space bar). If this
		key is pressed, GRUB will boot normally. If another key is
		pressed, GRUB will terminate immediately and return back to
		DOS. See "int 16 keyboard scan codes" below.

		Each option can be specified only once at most.

		Update 2: DOS filenames have been supported(patched by John
		Cobb). If the beginning two characters of FILE are "#@", then
		the rest of FILE is taken as a DOS filename. Example:

			GRUB --config-file="#@c:\menu.lst"

		Only the beginning 4KB of the DOS file will be used. The file
		should be an uncompressed text file.

		Note: You may also use the `direct DOS file access' with the
		SHELL or INSTALL line in CONFIG.SYS, but should not use it
		with the DEVICE line. The DOS document said that a DOS device
		driver should not call the `open file' DOS call.

Compile:	You should unzip the package under Linux in this way:

		unzip grub_for_dos-*.zip

		then cd into the grub_for_dos-* dir and do a make.

--------------------------------------------------------

Web site:	http://sarovar.org/projects/grub4dos/
Web site:	http://grub4dos.jot.com/
Web site:	http://grub4dos.freespaces.com/

Web site:	http://grub4dos.sourceforge.net/ (WinGRUB by bean123)

Web site:	http://grub.linuxeden.com/ (scratchpad, mainly in Chinese)

Update 1:	Version 0.2.0 also brings out a new thing, GRUB for NTLDR,
		which could be used to boot into GRUB from the boot menu
		of Windows NT/2000/XP. Copy GRLDR to the root directory of
		drive C: of Windows NT/2000/XP and append to C:\BOOT.INI
		this line:

			C:\GRLDR="Start GRUB"

		That will be done. The GRLDR should be in the same directory
		as BOOT.INI and NTLDR. Note that BOOT.INI is usually hidden
		and you must unhide it before you can see it. The filename
		GRLDR shouldn't be changed. If GRLDR is in a NTFS partition,
		it should be copied to the root directory of another non-NTFS
		partition(and likewise should the menu.lst file be). If GRLDR
		is compressed, e.g., in a NTFS partition, it will not work.

		Even if the drive letter of this disk has been changed to
		other than C by the Windows device manager, it seems you still
		have to use the letter C here in BOOT.INI, otherwise, NTLDR
		will fail to locate the GRLDR file.

		And what's more, if you are booting NTLDR from a floppy, you
		will have to write the GRLDR line in A:\BOOT.INI like this:

			C:\GRLDR="Start GRUB"

		and shouldn't use the letter A like this:

			A:\GRLDR="Start GRUB"

		(Note that in the case when BOOT.INI is on floppy A, the
		notation "C:\GRLDR" actually refer to the file A:\GRLDR).

Notice!		In the future, we will remove NTFS support. For Windows users,
		please create an FAT partition and place GRLDR and menu.lst
		there. From now on, please don't report bugs relevant to NTFS.

		Someone reports that Windows XP with newer SPs and Windows
		Vista have intentionally broken the compatiblity with many
		things(including GRLDR). So you will get into trouble with
		these systems.

Update 2:	GRUB for Linux is also introduced along with 0.2.0. You can
		boot grub using a linux loader KEXEC, LILO, SYSLINUX or another
		GRUB. (GRUB4LIN has merged into GRUB.EXE)

		To boot GRUB off Linux, use this pair of commands:

			kexec -l grub.exe
			kexec -e

		To boot GRUB via GRUB, use commands like the following:

			kernel (hd0,0)/grub.exe
			boot

		To boot GRUB via LILO, use these lines in lilo.conf:

			image=/boot/grub.exe
			label=grub.exe

		To boot GRUB via SYSLINUX, use these lines in syslinux.cfg:

			label grub.exe
				kernel grub.exe

		LOADLIN may encounter problems when loading grub.exe, because
		grub.exe requires some unchanged original BIOS interrupt
		vectors, but DOS has destroyed them, and loadlin does not
		recover them before it transfers control to grub.exe.
		
Update 3:	Beginning at version 0.4.0, GRUB for DOS supports memdrives.
		Example:

			# boot into a floppy image
			map --mem (hd0,0)/floppy.img (fd0)
			map --hook
			chainloader (fd0)+1
			rootnoverify (fd0)
			map --floppies=1
			boot

		Because the image will be copied to a memory area, the image
		itself can be non-contiguous and even gzipped.

		Another Example:

			map --mem=-2880 (hd0,0)/floppy.img (fd0)

		This memdrive (fd0) will occupy at least 1440 KB of memory.
		This is useful when the size of a 1.44M-floppy image is less
		than 1440 KB.

		One more example:

			map --mem --read-only (hd0,0)/hd.img (hd1)

		This memdrive is a hard drive, and read-only. That means you
		will not be able to write data to the memdrive (hd1).

		You can use many memdrives and many ordinary virtual emulated
		disk-based drives at the same time.

		If the BIOS does not support int15/EAX=e820h, you will not be
		able to use any memdrives.

Update 4:	For memdrive emulation, a single-partition image can be used
		instead of a whole-harddrive image. Example:

			map --mem (hd0,7)/win98.img (hd0)
			map --hook
			chainloader (hd0)+1
			rootnoverify (hd0)
			map --harddrives=1
			boot

		Here win98.img is a partition image without the leading MBR
		and partition table in it. Surely GRUB for DOS will build an
		MBR and partition table for the memdrive (hd0).

Update 5:	Now GRLDR can be used as a no-emulation-mode bootable CD-ROM
		boot image. Example for Linux users:

			mkdir iso_root
			cp grldr iso_root
			mkisofs -R -b grldr -no-emul-boot -boot-load-seg 0x1000 -o bootable.iso iso_root

		Note: There are quite a lot of buggy BIOSes that cannot boot
		the CD-ROM made with bootable.iso. The boot image of
		bootable.iso is the whole GRLDR file, not solely the first
		2048 bytes of GRLDR. Buggy BIOSes only load the beginning
		2048 bytes of the boot image, and will hang the machine. For
		Those buggy BIOSes, please use stage2_eltorito instead.
		Do a compilation, and the stage2_eltorito will be created in
		the grub-0.97/stage2/ directory. For detailed usage about
		stage2_eltorito, google the Internet, please. Don't use the
		above `mkisofs' line on stage2_eltorito. The line only works
		for GRLDR. The stage2_eltorito has a different `mkisofs' line
		as in the following:

			mkdir iso_root
			cp stage2_eltorito iso_root
			mkisofs -R -b stage2_eltorito -no-emul-boot -boot-load-size 4 -boot-info-table -o stage2.iso iso_root

		The option -boot-info-table should not be used with the GRLDR
		line, while it must be used with stage2_eltorito.

		Update 2006-12-03: Now grldr can be used the same way as
		stage2_eltorito. The -boot-info-table option is allowed but you
		can omit it:

			mkdir iso_root
			cp grldr iso_root
			mkisofs -R -b grldr -no-emul-boot -boot-load-size 4 -o grldr.iso iso_root

		Also note that the bootable.iso above must be created with the
		-boot-load-seg 0xHHHH option where HHHH is greater than or
		equal to 1000(hex). If HHHH < 1000(hex), QEMU will hang. This
		is a bug in QEMU. The grldr.iso can be created with or without
		-boot-load-seg 0xHHHH option.

Update 6:	The Chinese special build is in the "chinese" subdirectory.
		(patched by Gandalf, 2005-06-27)

		The Chinese special build also has scdrom builtin.
		(update: scdrom has been dropped since 2006-07-20)

Update 7:	Added memory drive (md). Like (nd) for network drive and (cd)
		for CD-ROM drive, a new drive (md) is implemented for accessing
		the whole memory as a disk drive. (md) only works for systems
		with BIOS int15/EAX=E820h support.

		The cat command now has a few new options: --hex for hexdump,
		and --locate=STRING for string search in file.

		Typical examples:

			cat --hex (hd0)+1

		It will display the MBR sector in hex form.

			cat --hex (md)+2

		It will display 1KB of your memory(in fact, it is the real-mode
		IDT table), also in hexdump form.
		
			cat --hex (md)0x800+1

		It will display 1 sector of your extended memory.

			cat --hex (hd0,0)+1

		It will display the first sector of partition (hd0,0). Usually
		this sector contains the boot record of an operating system.

Update 8:	Added ram drive (rd). The (md) device accesses the memory
		starting at physical address 0. But (rd) accesses memory
		starting at any base address. The base and length of the ram
		drive can be specified through the map command. "help map" for
		details. You can even specify the BIOS drive number used for
		the (rd) drive, e.g., map --ram-drive=0xf0. The default drive
		number for (rd) is 0x7F which is a floppy. If (rd) is a hard
		drive image, you should change the drive number to a value
		greater than or equal to 0x80(but should avoid using 0xff,
		because 0xff is for the (md) device).

Update 9:	Directly boot NTLDR of WinNT/2K/XP and IO.SYS of Win9x/ME and
		KERNEL.SYS of FreeDOS. Examples:

			chainloader --edx=0xPPYY (hd0,0)/ntldr
			boot

			chainloader --edx=0xYY (hd0,0)/io.sys
			boot

			chainloader --ebx=0xYY (hd0,0)/kernel.sys
			boot

		Hex YY specifies the boot drive number, and hex PP specifies
		the boot partition number of NTLDR. If the boot drive is
		floppy, PP should be the hex value ff, i.e., decimal 255.

		For KERNEL.SYS of FreeDOS, the --edx won't work,
		use --ebx please.

		The option --edx ( --ebx ) can be omitted if the file is in
		its normal place. But in some cases, those options are needed.

		If, e.g., the ntldr file is in an ext2 partition called
		(hd2,8) while you want it to think of the Windows partition
		(hd0,7) as the boot partition, then --edx is required:

			chainloader --edx=0x0780 (hd2,8)/ntldr

		For DOS kernels(i.e., IO.SYS and KERNEL.SYS), the boot
		partition number is meaningless, so you only need to specify
		the correct boot drive number YY(but specifying the boot
		partition number is harmless).

		The above PPYY can also be specified by using a root or
		rootnoverify command after the chainloader command. Examples:

			chainloader (hd2,6)/kernel.sys
			rootnoverify (hd0)	<-------- YY=80
			boot

			chainloader (hd0,0)/ntldr
			rootnoverify (hd0,5)	<-------- YY=80, PP=05
			boot

		Tip: CMLDR (the ComMand LoaDeR, which is used to load the
		Windows Fault Recovery Console) can be chainloaded as well
		as NTLDR.

		Bean has successfully decompressed and booted IO.SYS of WinME.
		Thanks for the great job!

--------------------------------------------------------

	There is no full documentation in English at present. Here are some
	examples showing the usage of disk emulation commands:

1.	Emulates HD partition C: as floppy drive A: and boot win98 from C:

		map --read-only (hd0,0)+1 (fd0)
		chainloader (hd0,0)+1
		rootnoverify (hd0)
		boot

	In the above example, (hd0,0) is drive C: with win98 on it. After win98
	boot complete, you will find that A: contains all files of C:, and if
	you delete files in A:, the files in C: will also disappear.

	At the map command line, the notation (hdm,n)+1 is interpreted to
	represent the whole partition (hdm,n), not just the first sector of the
	partition.

2.	Emulates HD partition C: as floppy drive A: and boot win98 from A:

		map --read-only (hd0,0)+1 (fd0)
		map --hook
		chainloader (fd0)+1
		rootnoverify (fd0)
		map --floppies=1
		boot

	After the "map --hook" command, the emulation takes effect instantly
	even in the GRUB command line.
	
	Note that the (fd0) in "chainloader (fd0)+1" is the emulated virtual
	floppy A:, not the real floppy diskette(because map is hooked now).


3.	Emulates an image file as floppy drive A: and boot win98 from C:

		map --read-only (hd0,0)/floppy.img (fd0)
		chainloader (hd0,0)+1
		rootnoverify (hd0)
		map --floppies=1
		map --harddrives=1
		boot

4.	Emulates an HD partition as the first hard disk and boot DOS from it:

		map --read-only (hd2,6)+1 (hd0)
		map --hook
		chainloader (hd0,0)+1
		rootnoverify (hd0)
		map --harddrives=1
		boot

	In this example, (hd2,6)+1 represents an extended logical DOS partition
	of the third BIOS hard disk (hd2).

	If a DOS partition is used to emulate a hard disk, GRUB for DOS will
	first try to locate the partition table, usually 63 sectors ahead of
	the DOS partition. GRUB for DOS will refuse the emulation if the
	partition table is not there.

5.	Emulates an image file as the first hard disk and boot DOS from it:

		map --read-only (hd0,0)/harddisk.img (hd0)
		chainloader --load-length=512 (hd0,0)/harddisk.img
		rootnoverify (hd0)
		map --harddrives=1
		boot

	If an image file is used to emulate a hard disk, the image file must
	contain an MBR. In other word, the first sector of HARDDISK.IMG must
	contain the partition table of the emulated virtual hard disk.

Note:	Counters for floppies and harddrives in the BIOS Data Area remain
	unchanged during the mapping. You should manually set them to proper
	values with `map --floppies=' and/or `map --harddrives=', especially,
	e.g., when there is no real floppy drive attached to the mother board.
	If not doing so, DOS might fail to start.

	`map --status' can report the values. Note also that `map --floppies='
	and `map --harddrives=' can be used independently without the
	appearance of mappings.

	0.4.2 has introduced a new variable, memdisk_raw, to simulate the
	memdisk-like raw mode. If the BIOS has no int15/87h, or if it has
	buggy int15/87h support, you should set this variable before any
	memdrives are used. Here is an example:

		map --memdisk-raw=1
		map --mem (hd0,0)/floppy.img (fd0)
		map --hook
		chainloader (fd0)+1
		rootnoverify (fd0)
		boot

	If you encountered a memdrive failure without using
	map --memdisk-raw=1, you should have a try with `map --memdisk-raw=1'.

	If you `map --memdisk-raw=0' later, you should afterwards do a
	`map --unhook'(and followed by a `map --hook' if needed).

	Update: memdisk_raw now defaults to 1. You should `map --memdisk-raw=0'
	if you want to use int15/87h to access memdrives.

--------------------------------------------------------
	
	Floppies/harddisks of any size can be emulated with GRUB for DOS 0.2.0.
	
	Image file must be contiguous, or else GRUB for DOS will refuse it.

	The `blocklist' command can list fragments or pieces of a file.

	Type "help map" at the GRUB prompt to get a brief description of the
	command.

	The form 
	
		map ... (fd?)
	
	is a floppy emulation, and the form
	
		map ... (hd?)
	
	is a hard disk emulation.

	When a HARD DISK emulation is used, better not start Windows for
	security reasons. Windows may even destroy all data and all information
	on all your real hard disks!!!!!!!!
	
	Update for --mem: when --mem is used, it seems rather safe even after
	entering Windows. Win98 can operate the memdrive normally.

	Windows NT/2000/XP does not recognize the emulated drives no matter
	whether the --mem option is present.

******************************************************************************
***   Explanation of the grldr-bootable floppies or harddisk partitions    ***
******************************************************************************

1. Ext2 Boot Sector/Boot Record Layout (for loading grldr)
------------------------------------------------------------------------------
A sample floppy image is ext2grldr.img within the GRUB for DOS release. Copy
grldr and an optional menu.lst to the root dir of the filesystem inside this
image, and it is then a GRUB-bootable floppy image. Note that the first
sector of ext2grldr.img is exactly the same as the fifth sector of grldr.

Offset	Length	Description
======	======	==============================================================
00h	2	Machine code for short jump over the data.

02h	1	LBA indicator. Valid values are 0x02 for CHS mode, or 0x42 for
		LBA mode.

		If the BIOS int13 supports LBA, this byte can be safely set to
		0x42.

		Some USB BIOSes might have bugs when using CHS mode, so the
		format program should set this byte to 0x42. It seems that
		(generally) all USB BIOSes have LBA support.

		If the format program does not know whether the BIOS has LBA
		support, it may operate this way:

		if (partition_start + total_sectors_in_partition) exceeds the
		CHS addressing ability(especially when it is greater than
		1024*256*63), the caller should set this byte to 0x42,
		otherwise, set to 0x02.

		Note that Windows98 uses the value 0x0e as the LBA indicator.

		Update: this byte of LBA indicator is ignored. The boot
		record can probe the LBA support of BIOS.

03h	10	OEM name string (of OS which formatted the disk).

0Dh	1	Sectors per block. Valid values are 2, 4, 8, 16 and 32.

0Eh	2	Bytes per block. Valid values are 0x400, 0x800, 0x1000, 0x2000
		and 0x4000.

10h	4	Pointers in pointers-per-block blocks, that is, number of
		blocks covered by a double-indirect block.

		Valid values are 0x10000, 0x40000, 0x100000, 0x400000 and
		0x1000000.

14h	4	Pointers per block, that is, number of blocks covered by an
		indirect block.

		Valid values are 0x100, 0x200, 0x400, 0x800, 0x1000.

18h	2	Sectors per track.

1Ah	2	Number of heads/sides.

1Ch	4	Number of hidden sectors (those preceding the boot sector).

		Also referred to as the starting sector of the partition.

		For floppies, it should be 0.

20h	4	Total number of sectors in the filesystem(or in the partition).

24h	1	BIOS drive number of the boot device.

		Actually this byte is ignored for read. The boot code will
		write DL onto this byte. The BIOS or the caller should set
		drive number in DL.

		We assume all BIOSes pass correct drive number in DL.
		Buggy BIOSes are not supported!!

25h	1	Partition number of this partition on the boot drive.

		0, 1, 2, 3 are primary partitions.
		4, 5, 6, ... are logical partitions in the extended partition.

		0xff is for whole drive. So for floppies, it should be 0xff.

26h	2	reserved.

28h	4	Number of inodes per group.

		Normally a 1.44M floppy has only one group, and the total
		number of inodes is 184. So the value should be	184 or
		greater.

2Ch	4	The block number for group descriptors.

		Valid values are 2 for 1024-byte blocks, and 1 otherwise.

		The value here is equal to (s_first_data_block + 1).

30h	462	Machine code.

1FEh	2	Boot Signature AA55h.


2. FAT12/FAT16 Boot Sector/Boot Record Layout (for loading grldr)
------------------------------------------------------------------------------
A sample floppy image is fat12grldr.img within the GRUB for DOS release. Copy
grldr and an optional menu.lst to the root dir of the filesystem inside the
image, and the image is then a GRUB-bootable floppy image. Note that the first
sector of fat12grldr.img is exactly the same as the fourth sector of grldr.

Offset	Length	Description
======	======	==============================================================
00h	2	Machine code for short jump over the data.

02h	1	LBA indicator. Valid values are 0x90 for CHS mode, or 0x0e for
		LBA mode.

		If the BIOS int13 supports LBA, this byte can be safely set to
		0x0e.

		Some USB BIOSes might have bugs when using CHS mode, so the
		format program should set this byte to 0x0e. It seems that
		(generally) all USB BIOSes have LBA support.

		If the format program does not know whether the BIOS has LBA
		support, it may operate this way:

		if (partition_start + total_sectors_in_partition) exceeds the
		CHS addressing ability(especially when it is greater than
		1024*256*63), the caller should set this byte to 0x0e,
		otherwise, set to 0x90.

		Update: this byte of LBA indicator is ignored. The boot
		record can probe the LBA support of BIOS.

		Update(2006-07-31): Though GRLDR won't use this LBA-indicator
		byte, Windows 98 uses it. Usually this byte should be 0x90 for
		CHS mode(especially for floppies). If this byte is not set
		properly, Windows 98 will not recognize the floppy or
		partition. This problem was reported by neiljoy. Many thanks!

03h	8	OEM name string (of OS which formatted the disk).

0Bh	2	Bytes per sector. Must be 512.

0Dh	1	Sectors per cluster. Valid values are 1, 2, 4, 8, 16, 32, 64
		and 128. But a cluster size larger than 32K should not occur.

0Eh	2	Reserved sectors(number of sectors before the first FAT,
		including the boot sector), usually 1.

10h	1	Number of FATs(nearly always 2).

11h	2	Maximum number of root directory entries.

13h	2	Total number of sectors (for small disks only, if the disk is
		too big this is set to 0 and offset 20h is used instead).

15h	1	Media descriptor byte, pretty meaningless now (see below).

16h	2	Sectors per FAT.

18h	2	Sectors per track.

1Ah	2	Total number of heads/sides.

1Ch	4	Number of hidden sectors (those preceding the boot sector).

		Also referred to as the starting sector of the partition.

		For floppies, it should be 0.

20h	4	Total number of sectors for large disks.

24h	1	BIOS drive number of the boot device.

		Actually this byte is ignored for read. The boot code will
		write DL onto this byte. The BIOS or the caller should set
		drive number in DL.

		We assume all BIOSes pass correct drive number in DL.
		Buggy BIOSes are not supported!!

25h	1	Partition number of this filesystem in the boot drive.

		This byte is ignored for read. The boot code will write
		partition number onto this byte. See offset 41h below.

26h	1	Signature (must be 28h or 29h to be recognised by NT).

27h	4	Volume serial number.

2Bh	11	Volume label.

36h	8	File system ID. "FAT12   ", "FAT16   " or "FAT     ".

3Eh	1	opcode for "cli".

3Fh	1	opcode for "cld".

40h	1	opcode for "mov dh, imm8".

41h	1	Partition number of this partition on the boot drive.

		0, 1, 2, 3 are primary partitions.
		4, 5, 6, ... are logical partitions in the extended partition.

		0xff is for whole drive. So for floppies, it should be 0xff.

42h	442	Machine code.

1FCh	4	Boot Signature AA550000h. (Win9x uses 4 bytes as magic value)


3. FAT32 Boot Sector/Boot Record Layout (for loading grldr)
------------------------------------------------------------------------------
A FAT32 partition can be GRUB-bootable. Copy grldr and an optional menu.lst to
the root dir of the FAT32 partition, and build the boot sector based on the
third sector of grldr(some fields need to be changed as detailed in the
following table). That is ok, the FAT32 partition is then GRUB-bootable.

Offset	Length	Description
======	======	==============================================================
00h	2	Machine code for short jump over the data.

02h	1	LBA indicator. Valid values are 0x90 for CHS mode, or 0x0e for
		LBA mode.

		If the BIOS int13 supports LBA, this byte can be safely set to
		0x0e.

		Some USB BIOSes might have bugs when using CHS mode, so the
		format program should set this byte to 0x0e. It seems that
		(generally) all USB BIOSes have LBA support.

		If the format program does not know whether the BIOS has LBA
		support, it may operate this way:

		if (partition_start + total_sectors_in_partition) exceeds the
		CHS addressing ability(especially when it is greater than
		1024*256*63), the caller should set this byte to 0x0e,
		otherwise, set to 0x90.

		Update: this byte of LBA indicator is ignored. The boot
		record can probe the LBA support of BIOS.

		Update(2006-07-31): Though GRLDR won't use this LBA-indicator
		byte, Windows 98 uses it. Usually this byte should be 0x90 for
		CHS mode(especially for floppies). If this byte is not set
		properly, Windows 98 will not recognize the floppy or
		partition. This problem was reported by neiljoy. Many thanks!

03h	8	OEM name string (of OS which formatted the disk).

0Bh	2	Bytes per sector. Must be 512.

0Dh	1	Sectors per cluster. Valid values are 1, 2, 4, 8, 16, 32, 64
		and 128. But a cluster size larger than 32K should not occur.

0Eh	2	Reserved sectors(number of sectors before the first FAT,
		including the boot sector), usually 1.

10h	1	Number of FATs(nearly always 2).

11h	2	(Maximum number of root directory entries)Must be 0.

13h	2	(Total number of sectors for small disks only)Must be 0.

15h	1	Media descriptor byte, pretty meaningless now (see below).

16h	2	(Sectors per FAT)Must be 0.

18h	2	Sectors per track.

1Ah	2	Total number of heads/sides.

1Ch	4	Number of hidden sectors (those preceding the boot sector).

		Also referred to as the starting sector of the partition.

		For floppies, it should be 0.

20h	4	Total number of sectors for large disks.

24h	4	FAT32 sectors per FAT.

28h	2	If bit 7 is clear then all FATs are updated, otherwise bits
		0-3 give the current active FAT, all other bits are reserved.

2Ah	2	High byte is major revision number, low byte is minor revision
		number, currently both are 0.

2Ch	4	Root directory starting cluster.

30h	2	File system information sector.

32h	2	If non-zero this gives the sector which holds a copy of the
		boot record, usually 6.

34h	12	Reserved, set to 0.

40h	1	BIOS drive number of the boot device.

		80h is first HDD, 00h is first FDD.

		Actually this byte is ignored for read. The boot code will
		write DL onto this byte. The BIOS or the caller should set
		drive number in DL.

		We assume all BIOSes pass correct drive number in DL.
		Buggy BIOSes are not supported!!

41h	1	Partition number of this filesystem in the boot drive.

		This byte is ignored for read. The boot code will write
		partition number onto this byte. See offset 5Dh below.

42h	1	Signature (must be 28h or 29h to be recognised by NT).

43h	4	Volume serial number.

47h	11	Volume label.

52h	8	File system ID. "FAT32   ".

5Ah	1	opcode for "cli".

5Bh	1	opcode for "cld".

5Ch	1	opcode for "mov dh, imm8".

5Dh	1	Partition number of this partition on the boot drive.

		0, 1, 2, 3 are primary partitions.
		4, 5, 6, ... are logical partitions in the extended partition.

		0xff is for whole drive. So for floppies, it should be 0xff.

5Eh	414	Machine code.

1FCh	4	Boot Signature AA550000h. (Win9x uses 4 bytes as magic value)

------------------------------------------------------------------------------

Appendix A: File System Information Sector of FAT32(not used by grldr)

Offset	Length	Description
======	======	==============================================================
0h	4	Leading Signature 41615252h.

4h	480	Reserved, set to 0.

1E4h	4	FSI structure signature 61417272h.

1E8h	4	Contains the last known count of free clusters, if this is
		equal to FFFFFFFFh, then the count is unknown.

1ECh	4	Cluster number at which you should begin a search for a free
		cluster, if this is equal to FFFFFFFFh then the field has not
		been set.

1F0h	12	Reserved, set to 0.

1FCh	4	Trailing Signature AA550000h.

------------------------------------------------------------------------------

Appendix B: Media Descriptor Byte(not used by grldr)

The Media descriptor byte is meaningless because of the duplications, F0h for
example.

Byte	Type of disk	Sectors	Heads	Tracks	Capacity
----	------------	-------	-----	------	--------
FFh	5 1/4"		8	2	40	320KB
FEh	5 1/4"		8	1	40	160KB
FDh	5 1/4"		9	2	40	360KB
FCh	5 1/4"		9	1	40	180KB
FBh	both		9	2	80	640KB
FAh	both		9	1	80	320KB
F9h	5 1/4"		15	2	80	1200KB
F9h	3 1/2"		9	2	80	720KB
F0h	3 1/2"		18 	2	80	1440KB
F0h	3 1/2"		36 	2	80	2880KB
F8h	hard disk	NA	NA	NA	NA

******************************************************************************
***   grldr.mbr - How to write it to Master Boot Track of the hard disk    ***
******************************************************************************

grldr.mbr contains code that can be used as Master Boot Record. The code is
responsible for searching all partitions for grldr and when found, loading it.
Currently supported partition types are: FAT12/FAT16/FAT32, NTFS, EXT2/EXT3.
Logical partitions in the extended partition are supported, provided that the
extended partition type is Microsoft-compatible. In fact, the Linux extended
partition type(0x85) is not fully tested for the search mechanism.

Notice!		In the future, we will remove NTFS support. For Windows users,
		please create an FAT partition and place GRLDR and menu.lst
		there. From now on, please don't report bugs relevant to NTFS.

		Someone reports that Windows XP with newer SPs and Windows
		Vista have intentionally broken the compatiblity with many
		things(including GRLDR). So you will get into trouble with
		these systems.

How to write GRLDR.MBR to the Master Boot Track of a hard disk?

First, read the Windows disk signature and partition information bytes
(72 bytes in total, from offset 0x01b8 to 0x01ff of the MBR sector), and put
them on the same range from offset 0x01b8 to 0x01ff of the beginning sector of
GRLDR.MBR.

Optionally, if the MBR in the hard disk is a single sector MBR created by
Microsoft FDISK, it may be copied onto the second sector of GRLDR.MBR.

The second sector of GRLDR.MBR is called "previous MBR". When GRLDR not found,
"previous MBR" will be started.

No other steps needed, after all necessary changes stated above have been made,
now simply write GRLDR.MBR on to the Master Boot Track. That's all.

Note: The Master Boot Track means the first track of the hard drive.

Note: The bootstrap code of GRLDR.MBR only finds GRLDR file in the root dir of
a partition. You'd better place menu.lst file accompanying with GRLDR(i.e., in
the same root dir of the same partition as GRLDR).

The filename "grldr" in an ext2 partition must be in lower case letters, and
the file type of grldr must be plain regular. Other types, e.g., a symbolic
link, won't work.

Update:	bootlace.com is a DOS/Linux utility for installing grldr.mbr to MBR.
The whole grldr.mbr is embedded in the body of the bootlace.com utility, so
bootlace.com can be used independently. See below.

******************************************************************************
***               grldr.mbr - Details about the control bytes              ***
******************************************************************************

Six bytes can be used to control the boot process of GRLDR.MBR.

Offset	Length	Description
======	======	==============================================================
02h	1	bit0=1: disable the search for GRLDR on floppy
		bit0=0: enable the search for GRLDR on floppy

		bit1=1: disable the boot of PREVIOUS MBR with invalid
			partition table(usually an OS boot sector)
		bit1=0: enable the boot of PREVIOUS MBR with invalid
			partition table(usually an OS boot sector)

		bit2=1: disable the feature of unconditional entrance to
			the command-line(See below `--duce')
		bit2=0: enable the feature of unconditional entrance to
			the command-line(See below `--duce')

		bit3 - bit6: reserved

		bit7=1: try to boot PREVIOUS MBR after the search for GRLDR
		bit7=0: try to boot PREVIOUS MBR before the search for GRLDR

03h	1	timeout in seconds to wait for a key press. 0xff stands for
		waiting all the time(endless).

04h	2	hot-key code. high byte is scan code, low byte is ASCII code.
		the default value is 0x3920, which stands for the space bar.
		if this key is pressed, GRUB will be started prior to the boot
		of previous MBR. See "int 16 keyboard scan codes" below.

06h	1	preferred boot drive number, 0xff for no-drive
07h	1	preferred partition number, 0xff for whole drive

		if the preferred boot drive number is 0xff, the order of the
		search for GRLDR will be:

			(hd0,0), (hd0,1), ..., (hd0,L),(L=max partition number) 
			(hd1,0), (hd1,1), ..., (hd1,M),(M=max partition number)
			... ... ... ... ... ... ... ... 
			(hdX,0), (hdX,1), ..., (hdX,N),(N=max partition number)
						       (X=max harddrive number)
			(fd0)

		otherwise, if the preferred boot drive number is Y(not equal to
		0xff) and the preferred partition number is K, then the order of
		the search for GRLDR will be:

			(Y) if K=0xff; or (Y,K) otherwise
			(hd0,0), (hd0,1), ..., (hd0,L),(L=max partition number) 
			(hd1,0), (hd1,1), ..., (hd1,M),(M=max partition number)
			... ... ... ... ... ... ... ... 
			(hdX,0), (hdX,1), ..., (hdX,N),(N=max partition number)
						       (X=max harddrive number)
			(fd0)

		Note: if Y < 0x80, then (Y) is floppy, else (Y) is harddrive,
		      and (Y,K) is partition number K on harddrive (Y).


******************************************************************************
***        bootlace.com - Install GRLDR.MBR bootstrap code to MBR          ***
******************************************************************************

BOOTLACE.COM installs GRLDR.MBR boot record to the MBR of a harddrive or of a
harddrive image file, or to the boot sector of a floppy or a floppy image.

Usage:

	bootlace.com  [OPTIONS]  DEVICE_OR_FILE

OPTIONS:

	--read-only		do everything except the actual write to the
				specified DEVICE_OR_FILE.

	--no-backup-mbr		do not copy the old MBR to the second sector of
				DEVICE_OR_FILE.

	--force-backup-mbr	force the copy of old MBR to the second sector
				of DEVICE_OR_FILE.

	--mbr-enable-floppy	enable the search for GRLDR on floppy.

	--mbr-disable-floppy	disable the search for GRLDR on floppy.

	--mbr-enable-osbr	enable the boot of PREVIOUS MBR with invalid
				partition table(usually an OS boot sector).

	--mbr-disable-osbr	disable the boot of PREVIOUS MBR with invalid
				partition table(usually an OS boot sector).

	--duce			disable the feature of unconditional entrance
	                        to the command-line.

				Normally one can unconditionally get the
				command-line console by a keypress of `C',
				bypassing all config-files(including the
				preset-menu). This is a security hole. So we
				need this option to disable the feature.

				DUCE is for Disable Unconditional Command-line
				Entrance.

	--boot-prevmbr-first	try to boot PREVIOUS MBR before the search for
				GRLDR.

	--boot-prevmbr-last	try to boot PREVIOUS MBR after the search for
				GRLDR.

	--preferred-drive=D	preferred boot drive number, 0 <= D < 255.

	--preferred-partition=P	preferred partition number, 0 <= P < 255.

	--time-out=T		wait T seconds before booting PREVIOUS MBR. if
				T is 0xff, wait forever. The default is 5.
	
	--hot-key=K		if the desired key K is pressed, start GRUB
				before booting PREVIOUS MBR. K is a word
				value, just as the value in AX register
				returned from int16/AH=1. The high byte is the
				scan code and the low byte is ASCII code. The
				default is 0x3920 for space bar. See "int 16
				keyboard scan codes" below.

	--floppy		if DEVICE_OR_FILE is floppy, use this option.

	--floppy=N		if DEVICE_OR_FILE is a partition on a hard
				drive, use this option. N is used to specify
				the partition number: 0,1,2 and 3 for the
				primary partitions, and 4,5,6,... for the
				logical partitions.

	--sectors-per-track=S	specifies sectors per track for --floppy.
				1 <= S <= 63, default is 63.

	--heads=H		specifies number of heads for --floppy.
				1 <= H <= 256, default is 255.

	--start-sector=B	specifies hidden sectors for --floppy=N.

	--total-sectors=C	specifies total sectors for --floppy.
				default is 0.

	--lba			use lba mode for --floppy. If the floppy BIOS
				has LBA support, you can specify --lba here.
				It is assumed that all floppy BIOSes have CHS
				support. So you would rather specify --chs.
				If neither --chs nor --lba is specified, then
				the LBA indicator(i.e., the third byte of the
				boot sector) will not be touched.

	--chs			use chs mode for --floppy. You should specify
				--chs if the floppy BIOS does not support LBA.
				We assume all floppy BIOSes have CHS support.
				So it is likely you want to specify --chs.
				If neither --chs nor --lba is specified, then
				the LBA indicator(i.e., the third byte of the
				boot sector) will not be touched.

	--fat12			FAT12 is allowed to be installed for --floppy.

	--fat16			FAT16 is allowed to be installed for --floppy.

	--fat32			FAT32 is allowed to be installed for --floppy.

	--vfat			FAT12/16/32 are allowed to be installed for
				--floppy.

	--ntfs			NTFS is allowed to be installed for --floppy.

	--ext2			EXT2 is allowed to be installed for --floppy.

	--install-partition=I	Install the boot record onto the boot area of
				partition number I of the specified hard drive
				or harddrive image DEVICE_OR_FILE.

DEVICE_OR_FILE:	Filename of the device or the image file. For DOS, a BIOS drive
number(hex 0xHH or decimal DDD) can be used to access the drive. BIOS drive
number 0 is for the first floppy, 1 is for the second floppy; 0x80 is for the
first hard drive, 0x81 is for the second hard drive, etc.

Note: BOOTLACE.COM writes only the boot code to MBR. The boot code needs to
load GRLDR as the second(and last) stage of the GRUB boot process. Therefore
GRLDR should be copied to the root directory of one of the supported
partitions, either before or after a successful execution of BOOTLACE.COM.
Currently only partitions with filesystem type of FAT12, FAT16, FAT32, NTFS,
EXT2 or EXT3 are supported.

Note 2: If DEVICE_OR_FILE is a harddisk device or a harddisk image file, it
must contain a valid partition table, otherwise, BOOTLACE.COM will fail. If
DEVICE_OR_FILE is a floppy device or a floppy image file, then it must contain
a supported filesystem(i.e., either of FAT12/FAT16/FAT32/NTFS/EXT2/EXT3).

Note 3: If DEVICE_OR_FILE is a floppy device or a floppy image file, and it
was formated EXT2/EXT3, then you should specify --sectors-per-track and
--heads explicitly.


Notice!		In the future, we will remove NTFS support. For Windows users,
		please create an FAT partition and place GRLDR and menu.lst
		there. From now on, please don't report bugs relevant to NTFS.

Important!! If you install GRLDR Boot Record to a floppy or a partition, the
floppy or partition will boot solely grldr, and your original
IO.SYS(DOS/Win9x/Me) and NTLDR(WinNT/2K/XP) will become unbootable. This is
because the original boot record of the floppy or partition was overwritten.
There is no such problem when installing GRLDR Boot Record onto the MBR.
Update: Some NTLDR/IO.SYS/KERNEL.SYS files can be directly chainloaded in the
latest GRUB4DOS.

Tip: If the filename begins in a dash(-) or a digit, you may prefix a dirname
(./) or (.\) to it.

Examples:

	Installing GRLDR boot code to MBR under Linux:

		bootlace.com  /dev/hda

	Installing GRLDR boot code to MBR under DOS:

		bootlace.com  0x80

	Installing GRLDR boot code to a harddisk image under DOS or Linux:

		bootlace.com  hd.img

	Installing GRLDR boot code to floppy under Linux:

		bootlace.com  --floppy --chs /dev/fd0

	Installing GRLDR boot code to floppy under DOS:

		bootlace.com  --floppy --chs 0x00

	Installing GRLDR boot code to a floppy image under DOS or Linux:

		bootlace.com  --floppy --chs floppy.img

BOOTLACE.COM cannot function well under Windows NT/2000/XP/2003. It is expected
(and designed) to run under DOS/Win9x and Linux. Update: For image FILES,
bootlace.com function well under Windows NT/2000/XP/2003. For devices,
bootlace.com will not work under Windows NT/2000/XP/2003 because bootlace.com
is a DOS utility and Windows NT/2000/XP/2003 does not allow bootlace.com to
access devices.

******************************************************************************
***        kexec-tools should be patched for the 1.101 release             ***
******************************************************************************

The file kexec-tools-1.101-patch is a patch to the kexec-tools-1.101 release.
Kexec might fail to load grub.exe without this patch.

The home page of kexec-tools is:

	http://www.xmission.com/~ebiederm/files/kexec/

Note: The Linux kernel should be KEXEC enabled before kexec can be run.

			!! Important Update !!

The patch `kexec-tools-1.101-patch' is not needed now and has been deleted.
Even worse, it fails in `kexec -l grub.exe --initrd=imgfile'. So please
do not use it any more.

******************************************************************************
***           Direct transition to DOS/Win9x from within Linux             ***
******************************************************************************

By using kexec, we can easily boot into DOS/Win9x from a running Linux system.

If WIN98.IMG is a bootable hard-disk image, do as follows:

kexec -l grub.exe --initrd=WIN98.IMG --command-line="--config-file=map (rd) (hd0); map --hook; chainloader (hd0)+1; rootnoverify (hd0)"

kexec -e

If DOS.IMG is a bootable floppy image, do this way:

kexec -l grub.exe --initrd=DOS.IMG --command-line="--config-file=map (rd) (fd0); map --hook; chainloader (fd0)+1; rootnoverify (fd0)"

kexec -e

Note that in this manner, we can boot DOS/Win9x without using a real DOS/Win9x
disk. We need no FAT partition but an image file.

We have noticed that Linux itself can act as a big boot manager by using kexec
and grub.exe. This may be convenient to developers who write installation or
bootstrap or initialization programs.

Certainly, grub.exe and the bootable disk image can also be loaded by a running
GRUB or LILO or syslinux. Examples:

1. Loaded by GRUB:

	kernel (hd0,0)/grub.exe --config-file="map (rd) (fd0); map --hook; chainloader (fd0)+1; rootnoverify (fd0)"
	initrd (hd0,0)/DOS.IMG
	boot

2. Loaded by LILO:

	image=/boot/grub.exe
		label=grub.exe
		initrd=/boot/DOS.IMG
		append="--config-file=map (rd) (fd0); map --hook; chainloader (fd0)+1; rootnoverify (fd0)"

3. Loaded by SYSLINUX:

	label grub.exe
		kernel grub.exe
		append initrd=DOS.IMG --config-file="map (rd) (fd0); map --hook; chainloader (fd0)+1; rootnoverify (fd0)"

Note: If the above `map (rd) (...)' failed, you may use `map (rd)+1 (...)'
instead and try again.

******************************************************************************
***               Keyboard BIOS Scan Code/ASCII code tables                ***
******************************************************************************

Keyboard bios scan code and ascii character code tables can be obtained from
the web by, for example, googling for "3920 372A 4A2D 4E2B 352F". Here are 2
main results:

1. From "http://heim.ifi.uio.no/~stanisls/helppc/scan_codes.html":

INT 16 - Keyboard Scan Codes

       Key	 Normal    Shifted   w/Ctrl    w/Alt

	A	  1E61	    1E41      1E01	1E00
	B	  3062	    3042      3002	3000
	C	  2E63	    2E43      2E03	2E00
	D	  2064	    2044      2004	2000
	E	  1265	    1245      1205	1200
	F	  2166	    2146      2106	2100
	G	  2267	    2247      2207	2200
	H	  2368	    2348      2308	2300
	I	  1769	    1749      1709	1700
	J	  246A	    244A      240A	2400
	K	  256B	    254B      250B	2500
	L	  266C	    264C      260C	2600
	M	  326D	    324D      320D	3200
	N	  316E	    314E      310E	3100
	O	  186F	    184F      180F	1800
	P	  1970	    1950      1910	1900
	Q	  1071	    1051      1011	1000
	R	  1372	    1352      1312	1300
	S	  1F73	    1F53      1F13	1F00
	T	  1474	    1454      1414	1400
	U	  1675	    1655      1615	1600
	V	  2F76	    2F56      2F16	2F00
	W	  1177	    1157      1117	1100
	X	  2D78	    2D58      2D18	2D00
	Y	  1579	    1559      1519	1500
	Z	  2C7A	    2C5A      2C1A	2C00

       Key	 Normal    Shifted   w/Ctrl    w/Alt

	1	  0231	    0221		7800
	2	  0332	    0340      0300	7900
	3	  0433	    0423		7A00
	4	  0534	    0524		7B00
	5	  0635	    0625		7C00
	6	  0736	    075E      071E	7D00
	7	  0837	    0826		7E00
	8	  0938	    092A		7F00
	9	  0A39	    0A28		8000
	0	  0B30	    0B29		8100

       Key	 Normal    Shifted   w/Ctrl    w/Alt

	-	  0C2D	    0C5F      0C1F	8200
	=	  0D3D	    0D2B		8300
	[	  1A5B	    1A7B      1A1B	1A00
	]	  1B5D	    1B7D      1B1D	1B00
	;	  273B	    273A		2700
	'	  2827	    2822
	`	  2960	    297E
	\	  2B5C	    2B7C      2B1C	2600 (same as Alt L)
	,	  332C	    333C
	.	  342E	    343E
	/	  352F	    353F

	Key	 Normal    Shifted   w/Ctrl    w/Alt

	F1	  3B00	    5400      5E00	6800
	F2	  3C00	    5500      5F00	6900
	F3	  3D00	    5600      6000	6A00
	F4	  3E00	    5700      6100	6B00
	F5	  3F00	    5800      6200	6C00
	F6	  4000	    5900      6300	6D00
	F7	  4100	    5A00      6400	6E00
	F8	  4200	    5B00      6500	6F00
	F9	  4300	    5C00      6600	7000
	F10	  4400	    5D00      6700	7100
	F11	  8500	    8700      8900	8B00
	F12	  8600	    8800      8A00	8C00

	Key	    Normal    Shifted	w/Ctrl	  w/Alt

	BackSpace    0E08      0E08	 0E7F	  0E00
	Del	     5300      532E	 9300	  A300
	Down Arrow   5000      5032	 9100	  A000
	End	     4F00      4F31	 7500	  9F00
	Enter	     1C0D      1C0D	 1C0A	  A600
	Esc	     011B      011B	 011B	  0100
	Home	     4700      4737	 7700	  9700
	Ins	     5200      5230	 9200	  A200
	Keypad 5		4C35	 8F00
	Keypad *     372A		 9600	  3700
	Keypad -     4A2D      4A2D	 8E00	  4A00
	Keypad +     4E2B      4E2B		  4E00
	Keypad /     352F      352F	 9500	  A400
	Left Arrow   4B00      4B34	 7300	  9B00
	PgDn	     5100      5133	 7600	  A100
	PgUp	     4900      4939	 8400	  9900
	PrtSc				 7200
	Right Arrow  4D00      4D36	 7400	  9D00
	SpaceBar     3920      3920	 3920	  3920
	Tab	     0F09      0F00	 9400	  A500
	Up Arrow     4800      4838	 8D00	  9800


- Some key combinations are not available on all systems.  The PS/2
  includes many that aren't available on the PC, XT and AT.
- To retrieve the character from a scan code logical AND the word
  with 0x00FF.
- see  INT 16  MAKE CODES



2. From "http://www.hoppie.nl/ivan/keycodes.txt":



     Keystroke                  Keypress code
--------------------------------------------------
     Esc                        011B
     1                          0231
     2                          0332
     3                          0433
     4                          0534
     5                          0635
     6                          0736
     7                          0837
     8                          0938
     9                          0A39
     0                          0B30
     -                          0C2D
     =                          0D3D
     Backspace                  0E08
     Tab                        0F09
     q                          1071
     w                          1177
     e                          1265
     r                          1372
     t                          1474
     y                          1579
     u                          1675
     i                          1769
     o                          186F
     p                          1970
     [                          1A5B
     ]                          1B5D
     Enter                      1C0D
     Ctrl                         **
     a                          1E61
     s                          1F73
     d                          2064
     f                          2166
     g                          2267
     h                          2368
     j                          246A
     k                          256B
     l                          266C
     ;                          273B
     '                          2827
     `                          2960
     Shift                        **
     \                          2B5C
     z                          2C7A
     x                          2D78
     c                          2E63
     v                          2F76
     b                          3062
     n                          316E
     m                          326D
     ,                          332C
     .                          342E
     /                          352F
     Gray *                     372A
     Alt                          **
     Space                      3920
     Caps Lock                    **
     F1                         3B00
     F2                         3C00
     F3                         3D00
     F4                         3E00
     F5                         3F00
     F6                         4000
     F7                         4100
     F8                         4200
     F9                         4300
     F10                        4400
     F11                        8500
     F12                        8600
     Num Lock                     **
     Scroll Lock                  **
     White Home                 4700
     White Up Arrow             4800
     White PgUp                 4900
     Gray -                     4A2D
     White Left Arrow           4B00
     Center Key                 4C00
     White Right Arrow          4D00
     Gray +                     4E2B
     White End                  4F00
     White Down Arrow           5000
     White PgDn                 5100
     White Ins                  5200
     White Del                  5300
     SysReq                       **
     Key 45 [1]                 565C
     Enter (number keypad)      1C0D
     Gray /                     352F
     PrtSc                        **
     Pause                        **
     Gray Home                  4700
     Gray Up Arrow              4800
     Gray Page Up               4900
     Gray Left Arrow            4B00
     Gray Right Arrow           4D00
     Gray End                   4F00
     Gray Down Arrow            5000
     Gray Page Down             5100
     Gray Insert                5200
     Gray Delete                5300

     Shift Esc                  011B
     !                          0221
     @                          0340
     #                          0423
     $                          0524
     %                          0625
     ^                          075E
     &                          0826
     * (white)                  092A
     (                          0A28
     )                          0B29
     _                          0C5F
     + (white)                  0D2B
     Shift Backspace            0E08
     Shift Tab (Backtab)        0F00
     Q                          1051
     W                          1157
     E                          1245
     R                          1352
     T                          1454
     Y                          1559
     U                          1655
     I                          1749
     O                          184F
     P                          1950
     {                          1A7B
     }                          1B7D
     Shift Enter                1C0D
     Shift Ctrl                   **
     A                          1E41
     S                          1F53
     D                          2044
     F                          2146
     G                          2247
     H                          2348
     J                          244A
     K                          254B
     L                          264C
     :                          273A
     "                          2822
     ~                          297E
     |                          2B7C
     Z                          2C5A
     X                          2D58
     C                          2E43
     V                          2F56
     B                          3042
     N                          314E
     M                          324D
     <                          333C
     >                          343E
     ?                          353F
     Shift Gray *               372A
     Shift Alt                    **
     Shift Space                3920
     Shift Caps Lock              **
     Shift F1                   5400
     Shift F2                   5500
     Shift F3                   5600
     Shift F4                   5700
     Shift F5                   5800
     Shift F6                   5900
     Shift F7                   5A00
     Shift F8                   5B00
     Shift F9                   5C00
     Shift F10                  5D00
     Shift F11                  8700
     Shift F12                  8800
     Shift Num Lock               **
     Shift Scroll Lock            **
     Shift 7 (number pad)       4737
     Shift 8 (number pad)       4838
     Shift 9 (number pad)       4939
     Shift Gray -               4A2D
     Shift 4 (number pad)       4B34
     Shift 5 (number pad)       4C35
     Shift 6 (number pad)       4D36
     Shift Gray +               4E2B
     Shift 1 (number pad)       4F31
     Shift 2 (number pad)       5032
     Shift 3 (number pad)       5133
     Shift 0 (number pad)       5230
     Shift . (number pad)       532E
     Shift SysReq                 **
     Shift Key 45 [1]           567C
     Shift Enter (number pad)   1C0D
     Shift Gray /               352F
     Shift PrtSc                  **
     Shift Pause                  **
     Shift Gray Home            4700
     Shift Gray Up Arrow        4800
     Shift Gray Page Up         4900
     Shift Gray Left Arrow      4B00
     Shift Gray Right Arrow     4D00
     Shift Gray End             4F00
     Shift Gray Down Arrow      5000
     Shift Gray Page Down       5100
     Shift Gray Insert          5200
     Shift Gray Delete          5300

     Ctrl Esc                   011B
     Ctrl 1                       --
     Ctrl 2 (NUL)               0300
     Ctrl 3                       --
     Ctrl 4                       --
     Ctrl 5                       --
     Ctrl 6 (RS)                071E
     Ctrl 7                       --
     Ctrl 8                       --
     Ctrl 9                       --
     Ctrl 0                       --
     Ctrl -                     0C1F
     Ctrl =                       --
     Ctrl Backspace (DEL)       0E7F
     Ctrl Tab                   9400
     Ctrl q (DC1)               1011
     Ctrl w (ETB)               1117
     Ctrl e (ENQ)               1205
     Ctrl r (DC2)               1312
     Ctrl t (DC4)               1414
     Ctrl y (EM)                1519
     Ctrl u (NAK)               1615
     Ctrl i (HT)                1709
     Ctrl o (SI)                180F
     Ctrl p (DEL)               1910
     Ctrl [ (ESC)               1A1B
     Ctrl ] (GS)                1B1D
     Ctrl Enter (LF)            1C0A
     Ctrl a (SOH)               1E01
     Ctrl s (DC3)               1F13
     Ctrl d (EOT)               2004
     Ctrl f (ACK)               2106
     Ctrl g (BEL)               2207
     Ctrl h (Backspace)         2308
     Ctrl j (LF)                240A
     Ctrl k (VT)                250B
     Ctrl l (FF)                260C
     Ctrl ;                       --
     Ctrl '                       --
     Ctrl `                       --
     Ctrl Shift                   **
     Ctrl \ (FS)                2B1C
     Ctrl z (SUB)               2C1A
     Ctrl x (CAN)               2D18
     Ctrl c (ETX)               2E03
     Ctrl v (SYN)               2F16
     Ctrl b (STX)               3002
     Ctrl n (SO)                310E
     Ctrl m (CR)                320D
     Ctrl ,                       --
     Ctrl .                       --
     Ctrl /                       --
     Ctrl Gray *                9600
     Ctrl Alt                     **
     Ctrl Space                 3920
     Ctrl Caps Lock               --
     Ctrl F1                    5E00
     Ctrl F2                    5F00
     Ctrl F3                    6000
     Ctrl F4                    6100
     Ctrl F5                    6200
     Ctrl F6                    6300
     Ctrl F7                    6400
     Ctrl F8                    6500
     Ctrl F9                    6600
     Ctrl F10                   6700
     Ctrl F11                   8900
     Ctrl F12                   8A00
     Ctrl Num Lock                --
     Ctrl Scroll Lock             --
     Ctrl White Home            7700
     Ctrl White Up Arrow        8D00
     Ctrl White PgUp            8400
     Ctrl Gray -                8E00
     Ctrl White Left Arrow      7300
     Ctrl 5 (number pad)        8F00
     Ctrl White Right Arrow     7400
     Ctrl Gray +                9000
     Ctrl White End             7500
     Ctrl White Down Arrow      9100
     Ctrl White PgDn            7600
     Ctrl White Ins             9200
     Ctrl White Del             9300
     Ctrl SysReq                  **
     Ctrl Key 45 [1]            --  
     Ctrl Enter (number pad)    1C0A
     Ctrl / (number pad)        9500
     Ctrl PrtSc                 7200
     Ctrl Break                 0000
     Ctrl Gray Home             7700
     Ctrl Gray Up Arrow         8DE0
     Ctrl Gray Page Up          8400
     Ctrl Gray Left Arrow       7300
     Ctrl Gray Right Arrow      7400
     Ctrl Gray End              7500
     Ctrl Gray Down Arrow       91E0
     Ctrl Gray Page Down        7600
     Ctrl Gray Insert           92E0
     Ctrl Gray Delete           93E0

     Alt Esc                    0100
     Alt 1                      7800
     Alt 2                      7900
     Alt 3                      7A00
     Alt 4                      7B00
     Alt 5                      7C00
     Alt 6                      7D00
     Alt 7                      7E00
     Alt 8                      7F00
     Alt 9                      8000
     Alt 0                      8100
     Alt -                      8200
     Alt =                      8300
     Alt Backspace              0E00
     Alt Tab                    A500
     Alt q                      1000
     Alt w                      1100
     Alt e                      1200
     Alt r                      1300
     Alt t                      1400
     Alt y                      1500
     Alt u                      1600
     Alt i                      1700
     Alt o                      1800
     Alt p                      1900
     Alt [                      1A00
     Alt ]                      1B00
     Alt Enter                  1C00
     Alt Ctrl                     **
     Alt a                      1E00
     Alt s                      1F00
     Alt d                      2000
     Alt f                      2100
     Alt g                      2200
     Alt h                      2300
     Alt j                      2400
     Alt k                      2500
     Alt l                      2600
     Alt ;                      2700
     Alt '                      2800
     Alt `                      2900
     Alt Shift                    **
     Alt \                      2B00
     Alt z                      2C00
     Alt x                      2D00
     Alt c                      2E00
     Alt v                      2F00
     Alt b                      3000
     Alt n                      3100
     Alt m                      3200
     Alt ,                      3300
     Alt .                      3400
     Alt /                      3500
     Alt Gray *                 3700
     Alt Space                  3920
     Alt Caps Lock                **
     Alt F1                     6800
     Alt F2                     6900
     Alt F3                     6A00
     Alt F4                     6B00
     Alt F5                     6C00
     Alt F6                     6D00
     Alt F7                     6E00
     Alt F8                     6F00
     Alt F9                     7000
     Alt F10                    7100
     Alt F11                    8B00
     Alt F12                    8C00
     Alt Num Lock                 **
     Alt Scroll Lock              **
     Alt Gray -                 4A00
     Alt Gray +                 4E00
     Alt 7 (number pad)           # 
     Alt 8 (number pad)           # 
     Alt 9 (number pad)           # 
     Alt 4 (number pad)           # 
     Alt 5 (number pad)           # 
     Alt 6 (number pad)           # 
     Alt 1 (number pad)           # 
     Alt 2 (number pad)           # 
     Alt 3 (number pad)           # 
     Alt Del                      --
     Alt SysReq                   **
     Alt Key 45 [1]               --
     Alt Enter (number pad)     A600
     Alt / (number pad)         A400
     Alt PrtSc                    **
     Alt Pause                    **
     Alt Gray Home              9700
     Alt Gray Up Arrow          9800
     Alt Gray Page Up           9900
     Alt Gray Left Arrow        9B00
     Alt Gray Right Arrow       9D00
     Alt Gray End               9F00
     Alt Gray Down Arrow        A000
     Alt Gray Page Down         A100
     Alt Gray Insert            A200
     Alt Gray Delete            A300

  -------------------------------------------------------------------------

Footnotes

        [1]   In the United States, the 101/102-key keyboard is shipped
              with 101 keys. Overseas versions have an additional key
              sandwiched between the left Shift key and the Z key. This
              additional key is identified by IBM (and in this table) as
              "Key 45."

        [**]  Keys and key combinations marked ** are used by the ROM BIOS
              but do not put values into the keyboard buffer.

        [--]  Keys and key combinations marked -- are ignored by the ROM
              BIOS.

Note by Tinybit:

	Someone reported F11 key and F12 key do not work. I suspect there
	is something wrong with that BIOS.

******************************************************************************
***           !!!!!!!! NTFS Will No Longer Be Supported !!!!!!!!           ***
******************************************************************************

Notice!		In the future, we will remove NTFS support. For Windows users,
		please create an FAT partition and place GRLDR and menu.lst
		there. From now on, please don't report bugs relevant to NTFS.

		Someone reports that Windows XP with newer SPs and Windows
		Vista have intentionally broken the compatiblity with many
		things(including GRLDR). So you will get into trouble with
		these systems.

Note 1:		Although bug reports on NTFS will be ignored, patches on NTFS
		and/or Windows are welcome.

Note 2:		Microsoft will continue to block GRLDR on its newer OSes. If
		so, don't report it. But (again) patches are acceptable.

Note 3:		NTFS support will be dropped at the time when most people
		wouldn't like to use it.

******************************************************************************
***                         GRLDR  Error messages                          ***
******************************************************************************

1. Missing MBR-helper.

	The helper function in the sectors that immediately follow the MBR is
	not present, or it has been erased by a virus or by Windows XP/Vista.

	Run the bootlace.com utility to fix the problem.

2. Buggy BIOS!

	Your BIOS is too buggy. It even has no support for INT13/AH=8.

	No solution except flashing your BIOS. Buggy BIOSes will encounter
	more and more problems with grub4dos in the future.

3. This partition is NTFS but with unknown boot record. Please install
Microsoft NTFS boot sectors to this partition correctly, or create an
FAT12/16/32 partition and place the same copy of GRLDR and MENU.LST there.

	The boot record was changed or erased by Microsoft Windows XP Service
	Pack 2.

	You may install the old boot record introduced with the	original clean
	Windows 2K/XP. As another solution, you may create an FAT partition
	for your system, and copy GRLDR and your MENU.LST to its root dir.

	While the startup code of grldr might fail to load GRLDR in NTFS
	partitions, it always successfully loads GRLDR in FAT partitions(and
	even in ext2/ext3 partitions).

	Note that NTLDR only loads the startup code of grldr(i.e., the leading
	16 sectors of grldr), not the whole grldr file.

	Thus, C:\GRLDR must exist(here C: can be NTFS), since it is used for
	BOOT.INI and NTLDR. If C: is NTFS, X:\GRLDR should exist as well,
	where X: stands for a certain FAT partition.


******************************************************************************
***                             Known BIOS bugs                            ***
******************************************************************************

1. Some newer Dell machines have no int13/AH=43h support. You may encounter
	failure when trying to write-access an emulated disk.

	Note: This bug is serious! The old "root+setup" installation method
	(in real mode grub environment) uses INT13 to write the first sector
	of stage2. It will fail for the buggy DELL machine when stage2 is
	accessed with LBA mode.

2. Some newer machines have no int15/AH=87h support. You may encounter failure
	when accessing a memdrive.

3. Some buggy BIOSes won't boot bootable.iso(See above).(qemu can boot it fine)

4. Some BIOSes have no int15/AH=24h(gate A20 control) support. It will
	encounter problems with GRUB4DOS in the future.



******************************************************************************
***                             Known Problems                             ***
******************************************************************************

1.	Running GRUB.EXE from a DOS box of Windows 9x/Me could hang the
	machine, especially for some systems with USB support. You may
	encounter the same problem when running GRUB.EXE through KEXEC under
	Linux.

Note:	You don't have to run GRUB.EXE from protected mode of Win9x, which
	could hang the machine; Instead, you usually want to run GRUB.EXE
	after you have done a "Restart the computer in MS-DOS mode", which
	is safe enough.

2.	The default chainloader action will keep A20 on. Some buggy DOS XMS
	memory managers could hang the machine. You may use the --disable-a20
	option in the chainloader line and try again. Anyway, you should avoid
	using those buggy memory managers.

3.	THTF BIOS L4S5M Ver 1.1a(dated 2002-1-10) has a buggy int15 which
	causes hang at the boot of a multi boot kernel(memdisk for example).

******************************************************************************
***        List of binary files and their corresponding source files       ***
******************************************************************************

binary file	main source file	other included source or binary files
-------------   ----------------	-------------------------------------

bootlace.com	bootlacestart.S		bootlace.inc, grldrstart.S

grldr		grldrstart.S		pre_stage2(binary, See note below)

grldr.mbr	mbrstart.S		grldrstart.S

grub.exe	dosstart.S		pre_stage2(binary, See note below)

-----------------------------------------------------------------------------

Note: pre_stage2 is the main body of GNU GRUB and it is simply appended to
grldrstart/dosstart in binary format to form our grldr/grub.exe.

Note: The GRUB file(WITHOUT .EXE suffix) is a static-linked ELF executable
program for Linux, normally called the GRUB Shell. The GRUB Shell is a boot-
manager, but not a boot-loader(the "boot" command won't work in GRUB Shell). 
GRUB.EXE(with KEXEC) can be used as a bootloader running directly under Linux.

******************************************************************************
***             Memory Layout for Quiting to DOS from GRUB.EXE             ***
******************************************************************************

The quit command is implemented to return to DOS in the instance that GRUB.EXE
is started off DOS.

1. Before GRUB.EXE transfers control to pre_stage2, it will copy 640KB of
conventional memory to physical address 0x200000(i.e., 2MB), and write 4 long
integers immediately follows the backup copy of the conventional memory:
	At 0x2A0000:	0x50554B42, it is the "BKUP" signature.

	At 0x2A0004:	Gate A20 status under DOS: non-zero means A20 on;
			zero means A20 off. Update: A20 always on, see below.

	At 0x2A0008:	high word is boot-CS, low word is boot-IP. The quit
			command uses this entry point to return to DOS.

	At 0x2A000C:	CheckSum: the sum of all long integers in the memory
			range from 0x200000 to 0x2A000F is 0.

2. If the above memory structure is corrupted by a grub command, the quit
command will issue an error message and refuse to exit from grub.

3. Because GRUB may corrupt extended memory, you should better avoid using
extended memory under DOS before running GRUB.EXE.

4. Gate A20 will be enabled by GRUB.EXE. Hopefully this would hurt nothing.


******************************************************************************
***                Command-line Length about GRUB.EXE                      ***
******************************************************************************

GRUB.EXE now can be started in CONFIG.SYS with the **DEVICE** command:

	DEVICE=grub.exe [--config-file="FILENAME_OR_COMMANDS"]

1. If GRUB.EXE is invoked with DEVICE command and FILENAME_OR_COMMANDS is a
collection of some GRUB commands separated by semi-colon, then the length of
FILENAME_OR_COMMANDS can be nearly 4KB ----Supprise? But true!  MS-DOS 7+
even allows a much longer line, but 4KB seems enough for our use of GRUB.EXE.
This is very useful when we want to embed a big menu into the command line.
Note that GRLDR hasn't yet supported any command-line arguments.

2. If GRUB.EXE is invoked with INSTALL command, the option length has a limit
of 80 characters(including the leading "--config-file=" part). An overflow may
hang up MS-DOS immediately.

3. If GRUB.EXE is invoked with SHELL command, the option length has a limit of
126 characters(including the leading "--config-file=" part). Overflow won't
hang up MS-DOS, but the line will be cut short. This limit is the same as that
in the console-DOS-prompt or in a BAT file.

4. The DOS editor EDIT does not allow to create a line of 4KB long. So use
another editor, for example, vi for Linux, please.

5. The DEVICE=GRUB.EXE line can be used together with other DEVICE commands
such as DEVICE=HIMEM.SYS and DEVICE=EMM386.EXE. The GRUB.EXE line should
occur before the EMM386.EXE line in order to avoid the rejection by EMM386.
Update: Since 0.4.2, GRUB.EXE works well even after EMM386.EXE is loaded.

6. In any case mentioned above, you can return back to DOS by quit command.

7. Memory usage about command-line menu: The 4KB command-line menu starts at
physical address 0x0800 and ends at 0x17FF.

******************************************************************************
***          New Syntax for the DEFAULT/SAVEDEFAULT Commands               ***
******************************************************************************

In addition to the original usage of "default NUM" and "default saved", now
there is a new usage of "default FILE", like this:

		default (hd0,0)/default

Note that FILE must have a valid DEFAULT file format. A sample DEFAULT file
is included in the release. You may copy it to wherever you like, but you
should avoid modifying its content manually. The DEFAULT file may be used
in this way:

(1) First, you should copy a default file with valid format to somewhere in
your operating system.

(2) Secondly, you should use the "default FILE" command of GRUB to announce
the use of FILE as our new default file for being written by "savedefault".

(3) Then, you may use "savedefault" command to save the desired entry number
into this new default file.

(4) OK, at next boot, you may read the saved entry number by using the same
"default FILE" command as mentioned in above (2).

And the SAVEDEFAULT command now accept an options `--wait=T', like this:

		savedefault --wait=5

If `--wait=T' is specified and T is non-zero, savedefault will prompt
the user with a message just before it writes to disk. The write operation
will be cancelled in T seconds if the `Y' key was not pressed.

Here is a sample menu.lst file:

#--------------------begin menu.lst---------------------------------------
color black/cyan yellow/cyan
timeout 30
default /default

title find and load NTLDR of Windows NT/2K/XP
find --set-root /ntldr
chainloader /ntldr
savedefault --wait=2

title find and load CMLDR of Windows NT/2K/XP
find --set-root /cmldr
chainloader /cmldr
savedefault --wait=2

title find and load IO.SYS of Windows 9x/Me
find --set-root /io.sys
chainloader /io.sys
savedefault --wait=2

title floppy (fd0)
chainloader (fd0)+1
rootnoverify (fd0)
savedefault --wait=2

title find and boot Linux with menu.lst already installed
find --set-root /sbin/init
savedefault --wait=2
configfile /boot/grub/menu.lst

title find and boot Mandriva with menu.lst already installed
find --set-root /etc/mandriva-release
savedefault --wait=2
configfile /boot/grub/menu.lst

title back to dos
savedefault --wait=2
quit

title commandline
savedefault --wait=2
commandline

title reboot
savedefault --wait=2
reboot

title halt
savedefault --wait=2
halt
#--------------------end menu.lst---------------------------------------

Note 1:	The file DEFAULT must exist and have a proper format as stated above.
	Or else, the default/savedefault commands won't function well.

Note 2:	The file DEFAULT which is in the same dir as a certain MENU.LST file
	is called associated with the MENU.LST file.

Note 3:	The associated DEFAULT file will take effect automatically if there
	are no `default' commands present.

Note 4:	Just before a menu file gains control(e.g., it is the associated
	MENU.LST of a GRLDR file, or it was specified via
	`grub.exe --config-file=(DEVICE)/PATH/YOUR_MENU_FILE', or it was
	specified by the `configfile' command of grub), its associated
	DEFAULT file will be used if present, until an explicit `default'
	command is encountered.

******************************************************************************
***                   The New `cdrom' Command Syntax                       ***
******************************************************************************

1. Initialize the ATAPI CDROM devices:

	grub> cdrom --init

   This will display the number of atapi cdroms found: atapi_dev_count

2. Stop the ATAPI CDROM devices:

	grub> cdrom --stop

   This will set atapi_dev_count to 0.

3. Add IO ports for searching the atapi cdrom devices. For example:

	grub> cdrom --add-io-ports=0x03F601F0

After running `cdrom --init' and `map --hook', the cdroms can be accessed
through devices (cd0), (cd1), ...

Note 1: If the system does not fully support the ATAPI CD-ROM specifications,
	you will encounter failure when trying to access the (cdX) devices.

Note 2: After doing a `cdrom --stop', you should do a `map --unhook'. Of
	course you may `map --hook' again if there are mapped drives.

Note 3: After adding IO ports, you should do a `map --unhook' followed by a
	`cdrom --init' and then followed by a `map --hook'.

	By default, these ports are used for searching cdroms(so they needn't
	be added):

		0x03F601F0, 0x03760170, 0x02F600F0,
		0x03860180, 0x6F006B00, 0x77007300.

Note 4: The BIOS might have offered a cdrom interface. It would be (cd). After
	`cdrom --init' and `map --hook', we might have our (cd0), (cd1), ...
	available. It is likely that one of them could access the same media
	as the BIOS-offered (cd).

Note 5: You may access the (cd) and (cdX)'es in the blocklist way. Example:

		cat --hex (cd0)16+2

	The cdrom sectors are big sectors with a size of 2048 bytes.

Note 6:	The iso9660 filesystem driver has Rock-Ridge extension support, but
	has no Joliet extension support. So you may encounter failure when
	you attempt to read files on a Joliet CD.

Note 7: The (cd) or (cdX)'es can be booted now. Examples:

		chainloader (cd)
		boot

		chainloader (cd0)
		boot

		chainloader (cd1)
		boot

	You should already have access to the CD sectors before you can
	chainload it.

******************************************************************************
***                   About the New `setvbe' Command                       ***
******************************************************************************

Gerardo Richarte contributed the `setvbe' code and the following comment:

	New command is `setvbe', and can be used to change the video mode
	before executing the kernel.

	For example, you can do

		setvbe 1024x768x32

	this will scan the list of available modes and set it, and
	automatically append a `video=' option to each subsequent kernel
	command-line. The appended `video=' option is like this:

		video=1024x768x32@0xf0000000,4096

	where 0xf0000000 is the video framebuffer address as reported by vbe,
	and 4096 is the size of a scanline in bytes (also as reported by vbe).

	This is really useful if you want to give some graphics support to your
	OS, but you don't want to implement any video functionality other than
	writing a pixel to video memory.


******************************************************************************
***                   About the DOS utility `hmload'                       ***
******************************************************************************

This program was written by John Cobb (Queen Mary, University of London).

John Cobb's note:

	To make use of the ram drive feature I wrote a program `hmload' to load
	an arbitrary file to an arbitrary address in high memory. The program
	is not very sophisticated and relies on XMS to turn on the A20 line.
	(Also one must be very careful to steer clear of any areas of memory
	already in use).

	Under Linux we generated a disk image `dskimg' (with the kernel and
	Initrd and a partition table).

	Using this our boot procedure looked something like this:

	hmload -fdskimg -a128
	fixrb
	<unload network drivers>
	grub

		map --ram-drive=0x81
		map --rd-base=0x8000000
		map --rd-size=0x400000
		root (rd,0)
		kernel /kernel root=/dev/ram0 rw ip=bootp ramdisk_size=32768 ...
		initrd /initrd
		boot

See http://sysdocs.stu.qmul.ac.uk/sysdocs/Comment/GrubForDOS.html for details.


******************************************************************************
***                      Notes on the use of stack                         ***
******************************************************************************

The protected-mode and real-mode stack are merged at physical address 0x2000.

All functions should use at most 2K stack space(0x1800-0x2000). So each
subfunction should use as little stack as possible to avoid stack-overflow.

Don't use recursive functions because they could expend too much stack space.

The original protected mode stack at 0x68000(expand-down) is free now and can
be reused for any purposes.


******************************************************************************
***                  A bug was found in the CDROM driver                   ***
******************************************************************************

It seems the cdrom must be connected as the master device of an IDE controller.

If cdrom is slave, the driver will fail to read the cdrom sectors. Hope someone

could fix this problem.


******************************************************************************
***                        BIOS and the (cd) drive                         ***
******************************************************************************

When BIOS boots a no-emulation-mode bootable CD-ROM, it allocates a BIOS drive
number to the CD. If the boot image of the CD-ROM is grldr or stage2_eltorito,
then GRUB can access the CD-ROM media through the drive number allocated by
BIOS. The device name of the CD-ROM is (cd).

BIOS can allocate a BIOS drive number to a no-emulation-mode CDROM even when
the CDROM is not bootable. QEMU has done so. At boot time, GRUB4DOS will
search drives 0x80-0xFE for a possible no-emulation-mode CDROM drive allocated
by BIOS. So if BIOS offered a CDROM interface of int13 EBIOS functions 41h-4Eh,
then the (cd) device will be automatically available in GRUB4DOS.


******************************************************************************
***              The way of disk emulation changed greatly                ***
******************************************************************************

The way of disk emulation has changed greatly since 0.4.2pre10. Please don't
mix newer versions with older versions when disk emulation features are used.

The newer versions won't automatically unhook emulations established in a
previous grub4dos environment. The GRUB.EXE of an older version will
automatically dismiss emulations established previously, before transferring
control to the main grub program(i.e., pre_stage2).


******************************************************************************
***            FreeDOS EMM386 v2.26 (2006-08-27) VCPI problem              ***
******************************************************************************

The VCPI function "AX=DE0Ch - Switch From Protected Mode to V86 Mode" of
FreeDOS EMM386 v2.26 was not implemented properly(it always hangs). As an
alternative, you can use Microsoft's EMM386 instead.

Even while emm386 is running, grub.exe can be started. But if you try to quit
to DOS from grub4dos by using the `quit' command, the VCPI function DE0C will
be called. If EMM386 is of Microsoft, everything goes ok. If EMM386 is of
FreeDOS, the machine will hang.


