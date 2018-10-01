Project Name:	GRUB for DOS
Definition:	A GRUB build for DOS with extensions for disk drive emulation.
Current Version:	0.2.0
Author:		Tinybit(tinybit@163.net)

File Format:	DOS EXE executable

Purpose:	Launch GRUB boot loader from within DOS

Circumstanced Use:	in CONFIG.SYS or AUTOEXEC.BAT

Ability:	Boot any installed operating system on your PC

Limitations:	GRUB.EXE only runs in real mode DOS. It cannot run from a DOS
		BOX inside Windows. Besides, GRUB cannot run if EMM386.EXE in
		CONFIG.SYS line is loaded. Similarly it does not run if some
		TSR programs is running.

		Currently runs on MS-DOS 3.30, 4.0, 5.0, 6.0, 6.20. 6.21, 6.22,
			7.0(Win95), 7.10(Win98), 8.0(WinME/NT/2000/XP), and
			FreeDOS(build 2029 and hopefully more future builds).

		Currently could not return to DOS after GRUB.EXE was started.

Copyright(C):	Tinybit(tinybit@163.net)

License:	GNU GPL(see file COPYING)

		source available as diff patches to the GNU GRUB release.
		See the shell script COMPILE for more info.

WARRANTY:	NO WARRANTY(see file COPYING)
		
TO DO:		Build for running on other DOS versions.

Usage:
			GRUB [ --config-file=FILE ]
		
		The FILE, for example, can be (hd0,0)/boot/grub/menu.lst
		
		In CONFIG.SYS, the line looks like:
		
			install=c:\some\where\grub.exe --config-file=FILE
		
		If no options present, GRUB for DOS simply uses
		
			(hd0,0)/boot/grub/menu.lst
		
		as the configure file, if it exists.
		
		The partition (hd0,0) can be a Windows partition or a Linux
		partition, or any other partition type supported by GRUB.

--------------------------------------------------------

FTP site:	(temporarily) ftp://ftp.linuxeden.com/tinybit/
FTP site:	(temporarily) ftp://ftp2.linuxeden.com/tools/

Web site:	http://newdos.yginfo.net/grubdos.htm (Thanks to Wengier)

Web site:	http://sourceforge.net/projects/grub4dos/ (WinGRUB by bean)

Web site:	http://grub.linuxeden.com/ (scratchpad, mainly in Chinese)

Update:		Version 0.2.0 also brings out a new thing, GRUB for NTLDR,
		which could be used to boot into GRUB from the boot menu
		of Windows NT/2000/XP. Copy GRLDR to the root directory of
		drive C: of Windows NT/2000/XP and append to C:\BOOT.INI
		this line:

			C:\GRLDR="Start GRUB"

		That will be done.
		
--------------------------------------------------------

	There is no full documentation in English for version 0.2.0 at present.
Here are only some examples showing the usage of the disk emulation commands:

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
		boot

	After the "map --hook" command, the emulation takes effect instantly
	even in the GRUB command line.
	
	Note that the (fd0) in "chainloader (fd0)+1" is the emulated virtual
	floppy A:, not the real floppy diskette(because map is hooked now).


3.	Emulates an image file as floppy drive A: and boot win98 from C:

		map --read-only (hd0,0)/floppy.img (fd0)
		chainloader (hd0,0)+1
		rootnoverify (hd0)
		boot

4.	Emulates an HD partition as the first hard disk and boot DOS from it:

		map --read-only (hd2,6)+1 (hd0)
		map --hook
		chainloader (hd0,0)+1
		rootnoverify (hd0)
		boot

	In this example, (hd2,6)+1 represents an extended logical DOS partition
	of the third BIOS hard disk (hd2).

	If a DOS partition is used to emulate a hard disk, GRUB for DOS will
	first try to locate the partition table, usually 63 sectors ahead of
	the DOS partition. GRUB for DOS will refuse the emulation if the
	partition table is not there.

5.	Emulates an image file as the first hard disk and boot DOS from it:

		map --read-only (hd0,0)/harddisk.img (hd0)
		chainloader (hd0,0)/harddisk.img
		rootnoverify (hd0)
		boot

	If an image file is used to emulate a hard disk, the image file must
	contain an MBR. In other word, the first sector of HARDDISK.IMG must
	contain the partition table of the emulated virtual hard disk.

--------------------------------------------------------
	
	Floppies/harddisks of any size can be emulated with GRUB for DOS 0.2.0.
	
	Image file must be contiguous, or else GRUB for DOS will refuse it.

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
	

