1. Introdution

This utility is used to install GRUB4DOS to the MBR of hard disk or image file.

grubinst.exe is a console mode program. It mimics the behavior of the DOS/Linux utility
bootlace.com from TinyBit's GRUB4DOS package. But unlike bootlace.com, grubinst is writen
completely in C and can be compiled to run in OSs like Windows NT/2K/XP, Linux and FreeBSD.

grubinst_gui.exe is a GUI frontend to grubinst.exe. It provides a friendly interface to
users who are not familiar whith the command line environment. Currently, grubinst_gui.exe
only runs in Windows OSs.

Please note that these utilities only install MBR, it DOES NOT copy GRLDR to your partition
or configure menu.lst, neither does it modify boot.ini to enable booting from the NT boot
manager. To know more about such things, please refers to README_GRUB4DOS.txt which contains
information about the GRUB4DOS package.

Also note that the current version of grubinst doesn't support modify the MBR of hard disk
in Windows 95/98/ME. For those OSs, bootlace.com should be used instead.

2. Difference between grubinst and bootlace.com

In bootlace.com, hard disk device is represented by numbers, 0x80 is the first hard disk,
0x81 is the second, etc. In grubinst, hard disk device is represented using special
filename, (hd0), (hd1), etc. Floppy device is not supported yet.

grubinst doesn't support install GRUB4DOS to a partition, this would be fixed in furture
releases.

grubinst has a few new options which are used mainly to restore the old MBR.

--save-mbr=FILENAME

This option is used to save the original MBR to FILENAME

--restore-mbr=FILENAME

This option is used to restore MBR from previous saved FILENAME

--restore-prevmbr

This option is used to restore the old MBR saved in the second sector of the hard disk or
image file.

Normally, the original MBR is only one sector long, it's stored in the second sector of the
new GRLDR MBR. You can restore it using --restore-prevmbr option. However, if the original
MBR is longer than one sector, for instance, you have other boot manager installed, then
GRLDR MBR dones't have room to hold it. In this case, you should use --save-mbr=FILENAME
to save the original MBR to an external file, and use --restore-mbr=FILENAME to restore it.

3. Usage

	grubinst  [OPTIONS]  DEVICE_OR_FILE

OPTIONS:

	--help			Show usage information

	--version		Show version information

	--pause			Pause before exiting the application
				(used by the GUI)

	--read-only		do everything except the actual write to the
				specified DEVICE_OR_FILE.

	--no-backup-mbr		do not copy the old MBR to the second sector of
				DEVICE_OR_FILE.

	--force-backup-mbr	force the copy of old MBR to the second sector
				of DEVICE_OR_FILE.(default)

	--mbr-enable-floppy	enable the search for GRLDR on floppy.(default)

	--mbr-disable-floppy	disable the search for GRLDR on floppy.

	--mbr-enable-osbr	enable the boot of PREVIOUS MBR with invalid
				partition table(usually an OS boot sector).
				(default)

	--mbr-disable-osbr	disable the boot of PREVIOUS MBR with invalid
				partition table(usually an OS boot sector).

	--duce			disable the feature of unconditional entrance
				to the command-line.

	--boot-prevmbr-first	try to boot PREVIOUS MBR before the search for
				GRLDR.

	--boot-prevmbr-last	try to boot PREVIOUS MBR after the search for
				GRLDR.(default)

	--preferred-drive=D	preferred boot drive number, 0 <= D < 255.

	--preferred-partition=P	preferred partition number, 0 <= P < 255.

	--time-out=T		wait T seconds before booting PREVIOUS MBR. if
				T is 0xff, wait forever. The default is 5.

	--hot-key=K		if the desired key K is pressed, start GRUB
				before booting PREVIOUS MBR. K is a word
				value, just as the value in AX register
				returned from int16/AH=1. The high byte is the
				scan code and the low byte is ASCII code. The
				default is 0x3920 for space bar.

	--restore-prevmbr	Restore previous MBR saved in the second sector
				of DEVICE_OR_FILE

	--save-mbr=FILENAME	Save the orginal MBR to FILENAME

	--restore-mbr=FILENAME	Restore MBR from previously saved FILENAME

Example 1: Install GRLDR MBR to the first hard disk

	grubinst (hd0)

Example 2: Install GRLDR MBR to the disk image disk.dsk

	grubinst disk.dsk

Example 3: Restore the old one sector MBR of the first hard disk

	grubinst --restore-prevmbr (hd0)

Example 4: Install GRLDR MBR to the first hard disk, and save the old MBR as MBR.sav

	grubinst --save-mbr=MBR.sav (hd0)

Example 5: Restore MBR from previous save file MBR.sav

	grubinst --restore-mbr=MBR.sav (hd0)

Example 6: Load GRUB only if you press space in the first 10 second of booting.
	
	grubinst --boot-prevmbr-first --time-out=10 (hd0)


4. Compilation

To compile the program, you need the GCC toolkit in Linux/FreeBSD, and mingw or Visual C++
6.0 in Windows NT/2K/XP.

Compile using mingw:

	make -f Makefile.mgw

Compile using Visual C++ 6.0:

	nmake -f Makefile.vc6

Compile using GCC toolkit in Linux:

	make -f Makefile.lnx

Compile using GCC toolkit in FreeBSD:

	make -f Makefile.bsd

The binary pacakge is built using mingw.

5. Website

http://grub4dos.sourceforge.net/	grubinst and WINGRUB homepage
http://grub4dos.jot.com/		Latest GRUB4DOS package by TinyBit
http://www.znpc.net/bbs			There is a forum on GRUB4DOS, but it's in chinese
http://grub.linuxeden.com/		Misc information by TinyBit, also in chinese