#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <errno.h>

#ifdef WIN32

#include <io.h>

#else

#define O_BINARY		0

#endif

#include "grub_mbr.h"

#define VER_MAJOR		1
#define VER_MINOR		0
#define VER_BUILD		1

// Application flags, used by this program

#define AFG_PAUSE		1
#define AFG_READ_ONLY		2
#define AFG_NO_BACKUP_MBR	4
#define AFG_RESTORE_PREVMBR	8

// Grldr flags, this flag is used by grldr.mbr

#define GFG_DISABLE_FLOPPY	1
#define GFG_DISABLE_OSBR	2
#define GFG_DUCE		4
#define GFG_PREVMBR_LAST	128

#define MAX_DISKS		10

#define APP_NAME		"grubinst: "

#ifdef WIN32

#define print_pause		if (afg & AFG_PAUSE) {fputs("Press any key to continue ...\n",stderr); getch();}

#else

#define print_pause

#endif

#define print_apperr(a)		{ fprintf(stderr,APP_NAME "%s\n",a); print_pause; }
#define print_syserr(a)		{ perror(APP_NAME a); print_pause; }

#define valueat(buf,ofs,type)	*((type*)(((char*)&buf)+ofs))

void help(void)
{
  puts("Usage:");
  puts("\tgrubinst  [OPTIONS]  DEVICE_OR_FILE\n");
  puts("OPTIONS:\n");
  puts("\t--help\t\t\tShow usage information\n");
  puts("\t--version\t\tShow version information\n");
#ifdef WIN32
  puts("\t--pause\t\t\tPause before exiting the application\n"
       "\t\t\t\t(used by the GUI)\n");
#endif
  puts("\t--read-only\t\tdo everything except the actual write to the\n"
       "\t\t\t\tspecified DEVICE_OR_FILE.\n");
  puts("\t--no-backup-mbr\t\tdo not copy the old MBR to the second sector of\n"
       "\t\t\t\tDEVICE_OR_FILE.\n");
  puts("\t--force-backup-mbr\tforce the copy of old MBR to the second sector\n"
       "\t\t\t\tof DEVICE_OR_FILE.(default)\n");
  puts("\t--mbr-enable-floppy\tenable the search for GRLDR on floppy.(default)\n");
  puts("\t--mbr-disable-floppy\tdisable the search for GRLDR on floppy.\n");
  puts("\t--mbr-enable-osbr\tenable the boot of PREVIOUS MBR with invalid\n"
       "\t\t\t\tpartition table (usually an OS boot sector).\n"
       "\t\t\t\t(default)\n");
  puts("\t--mbr-disable-osbr\tdisable the boot of PREVIOUS MBR with invalid\n"
       "\t\t\t\tpartition table (usually an OS boot sector).\n");
  puts("\t--duce\t\t\tdisable the feature of unconditional entrance\n"
       "\t\t\t\tto the command-line.\n");
  puts("\t--boot-prevmbr-first\ttry to boot PREVIOUS MBR before the search for\n"
       "\t\t\t\tGRLDR.\n");
  puts("\t--boot-prevmbr-last\ttry to boot PREVIOUS MBR after the search for\n"
       "\t\t\t\tGRLDR.(default)\n");
  puts("\t--preferred-drive=D\tpreferred boot drive number, 0 <= D < 255.\n");
  puts("\t--preferred-partition=P\tpreferred partition number, 0 <= P < 255.\n");
  puts("\t--time-out=T\t\twait T seconds before booting PREVIOUS MBR. if\n"
       "\t\t\t\tT is 0xff, wait forever. The default is 5.\n");
  puts("\t--hot-key=K\t\tif the desired key K is pressed, start GRUB\n"
       "\t\t\t\tbefore booting PREVIOUS MBR. K is a word\n"
       "\t\t\t\tvalue, just as the value in AX register\n"
       "\t\t\t\treturned from int16/AH=1. The high byte is the\n"
       "\t\t\t\tscan code and the low byte is ASCII code. The\n"
       "\t\t\t\tdefault is 0x3920 for space bar.\n");
  puts("\t--restore-prevmbr\tRestore previous MBR saved in the second sector\n"
       "\t\t\t\tof DEVICE_OR_FILE\n");
  puts("\t--save-mbr=FILENAME\tSave the orginal MBR to FILENAME\n");
  puts("\t--restore-mbr=FILENAME\tRestore MBR from previously saved FILENAME");
}

char* get_disk_name(int n)
{
  static char buf[24];

#if defined(WIN32)
  sprintf(buf,"\\\\.\\PhysicalDrive%d",n);
#elif defined(LINUX)
  sprintf(buf,"/dev/hd%c",'a'+n);
#elif defined(FREEBSD)
  sprintf(buf,"/dev/ad%d",n);
#else
#error Please define OS type (WIN32, LINUX or FREEBSD)
#endif
  return buf;
}

int afg,gfg,prefered_drive,prefered_partition,time_out,hot_key;
char *save_fn,*restore_fn;

int install(char* fn)
{
  int hd,nn;
  char prev_mbr[sizeof(grub_mbr)];

  hd=open(fn,O_RDWR | O_BINARY,S_IREAD | S_IWRITE);
  if (hd==-1)
    {
      print_syserr("open");
      return errno;
    }
  nn=read(hd,prev_mbr,sizeof(prev_mbr));
  if (nn==-1)
    {
      print_syserr("read");
      return errno;
    }
  if (nn<sizeof(prev_mbr))
    {
      print_apperr("The input file is too short");
      return 1;
    }
  if (save_fn)
    {
      int h2;

      h2=open(save_fn,O_CREAT | O_TRUNC | O_RDWR | O_BINARY,S_IREAD | S_IWRITE);
      if (h2==-1)
        {
          print_syserr("open save file");
          return errno;
        }
      nn=write(h2,prev_mbr,sizeof(prev_mbr));
      if (nn==-1)
        {
          print_syserr("write save file");
          return errno;
        }
      if (nn<sizeof(prev_mbr))
        {
          print_apperr("Can\'t write the whole MBR to the save file");
          return 1;
        }
      close(h2);
    }
  if (restore_fn)
    {
      int h2;

      h2=open(restore_fn,O_RDONLY | O_BINARY,S_IREAD);
      if (h2==-1)
        {
          print_syserr("open restore file");
          return errno;
        }
      nn=read(h2,grub_mbr,sizeof(grub_mbr));
      if (nn==-1)
        {
          print_syserr("read restore file");
          return errno;
        }
      if ((nn<512) || (nn & 0x1FF!=0) ||
          (valueat(grub_mbr,510,unsigned short)!=0xAA55))
        {
          print_apperr("Invalid restore file");
          return 1;
        }
      close(h2);
      if (nn<sizeof(grub_mbr))
        memset(&grub_mbr[nn],0,sizeof(grub_mbr)-nn);
      memcpy(&grub_mbr[0x1b8],&prev_mbr[0x1b8],72);
    }
  else if (afg & AFG_RESTORE_PREVMBR)
    {
      if (strncmp(&prev_mbr[1024+3],"GRLDR",5))
        {
          print_apperr("GRLDR is not installed");
          return 1;
        }
      if (valueat(prev_mbr,512+510,unsigned short)!=0xAA55)
        {
          print_apperr("No previous saved MBR");
          return 1;
        }
      memset(&grub_mbr,0,sizeof(grub_mbr));
      memcpy(&grub_mbr,&prev_mbr[512],512);
      memcpy(&grub_mbr[0x1b8],&prev_mbr[0x1b8],72);
    }
  else
    {
      if (! (afg & AFG_NO_BACKUP_MBR))
        {
          // If we already install grldr, then the orginal mbr is stored at the
          // second sector
          if (! strncmp(&prev_mbr[1024+3],"GRLDR",5))
            memcpy(&grub_mbr[512],&prev_mbr[512],512);
          else
            memcpy(&grub_mbr[512],prev_mbr,512);
        }
      memcpy(&grub_mbr[0x1b8],&prev_mbr[0x1b8],72);
      valueat(grub_mbr,2,unsigned char)=gfg;
      valueat(grub_mbr,3,unsigned char)=time_out;
      valueat(grub_mbr,4,unsigned short)=hot_key;
      valueat(grub_mbr,6,unsigned char)=prefered_drive;
      valueat(grub_mbr,7,unsigned char)=prefered_partition;
    }
  if (! (afg & AFG_READ_ONLY))
    {
      lseek(hd,0,SEEK_SET);
      nn=write(hd,grub_mbr,sizeof(grub_mbr));
      if (nn==-1)
        {
          print_syserr("write");
          close(hd);
          return errno;
        }
      if (nn<sizeof(grub_mbr))
        {
          print_apperr("Can\'t write the whole mbr");
          close(hd);
          return 1;
        }
    }
  close(hd);
  if (afg & AFG_PAUSE)
    {
      fputs("The MBR has been successfully installed\n",stderr);
      print_pause;
    }
  return 0;
}

int main(int argc,char** argv)
{
  int idx;
  char *fn;

  afg=gfg=0;
  prefered_drive=prefered_partition=-1;
  afg=0;
  gfg=GFG_PREVMBR_LAST;
  time_out=5;
  hot_key=0x3920;
  save_fn=NULL;
  restore_fn=NULL;
  for (idx=1;idx<argc;idx++)
    {
      if (argv[idx][0]!='-')
        break;
      if ((! strcmp(argv[idx],"--help")) || (! strcmp(argv[idx],"-h")))
        {
          help();
          print_pause;
          return 1;
        }
      else if (! strcmp(argv[idx],"--version"))
        {
          printf("grubinst version : %d.%d.%d\n",VER_MAJOR,VER_MINOR,VER_BUILD);
          print_pause;
          return 1;
        }
#ifdef WIN32
      else if (! strcmp(argv[idx],"--pause"))
        afg|=AFG_PAUSE;
#endif
      else if (! strcmp(argv[idx],"--read-only"))
        afg|=AFG_READ_ONLY;
      else if (! strcmp(argv[idx],"--no-backup-mbr"))
        afg|=AFG_NO_BACKUP_MBR;
      else if (! strcmp(argv[idx],"--force-backup-mbr"))
        afg&=~AFG_NO_BACKUP_MBR;
      else if (! strcmp(argv[idx],"--mbr-enable-floppy"))
        gfg&=~GFG_DISABLE_FLOPPY;
      else if (! strcmp(argv[idx],"--mbr-disable-floppy"))
        gfg|=GFG_DISABLE_FLOPPY;
      else if (! strcmp(argv[idx],"--mbr-enable-osbr"))
        gfg&=~GFG_DISABLE_OSBR;
      else if (! strcmp(argv[idx],"--mbr-disable-osbr"))
        gfg|=GFG_DISABLE_OSBR;
      else if (! strcmp(argv[idx],"--duce"))
        gfg|=GFG_DUCE;
      else if (! strcmp(argv[idx],"--boot-prevmbr-first"))
        gfg&=~GFG_PREVMBR_LAST;
      else if (! strcmp(argv[idx],"--boot-prevmbr-last"))
        gfg|=GFG_PREVMBR_LAST;
      else if (! strncmp(argv[idx],"--preferred-drive=",18))
        {
          prefered_drive=strtol(&argv[idx][18],NULL,0);
          if ((prefered_drive<0) || (prefered_drive>=255))
            {
              print_apperr("Invalid preferred drive number");
              return 1;
            }
        }
      else if (! strncmp(argv[idx],"--preferred-partition=",22))
        {
          prefered_partition=strtol(&argv[idx][22],NULL,0);
          if ((prefered_partition<0) || (prefered_partition>=255))
            {
              print_apperr("Invalid preferred partition number");
              return 1;
            }
        }
      else if (! strncmp(argv[idx],"--time-out=",10))
        {
          time_out=strtol(&argv[idx][10],NULL,0);
          if ((time_out<0) || (time_out>255))
            {
              print_apperr("Invalid timeout value");
              return 1;
            }
        }
      else if (! strncmp(argv[idx],"--hot-key=",10))
        {
          hot_key=strtol(&argv[idx][10],NULL,0);
        }
      else if (! strcmp(argv[idx],"--restore-prevmbr"))
        afg|=AFG_RESTORE_PREVMBR;
      else if (! strncmp(argv[idx],"--save-mbr=",11))
        {
          save_fn=&argv[idx][11];
          if (*save_fn==0)
            {
              print_apperr("Empty filename");
              return 1;
            }
        }
      else if (! strncmp(argv[idx],"--restore-mbr=",14))
        {
          restore_fn=&argv[idx][14];
          if (*restore_fn==0)
            {
              print_apperr("Empty filename");
              return 1;
            }
        }
      else
        {
          print_apperr("Invalid option, please use --help to see all valid options");
          return 1;
        }
    }
  if (idx>=argc)
    {
      print_apperr("No filename specified");
      return 1;
    }
  if (idx<argc-1)
    {
      print_apperr("Extra parameters");
      return 1;
    }
  fn=argv[idx];
  if (! strncmp(fn,"(hd",3))
    {
      int n;
      char* p;

      n=strtol(&fn[3],&p,0);
      if ((*p!=')') || (*(p+1)!=0))
        {
          print_apperr("Invalid device name");
          return 1;
        }
      if ((n<0) || (n>=MAX_DISKS))
        {
          print_apperr("Invalid device number");
          return 1;
        }
      fn=get_disk_name(n);
    }
  return install(fn);
}
