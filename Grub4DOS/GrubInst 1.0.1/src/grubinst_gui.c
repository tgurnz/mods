#include <windows.h>
#include <string.h>

#include "resource.h"

#define MAX_DISKS	10

HINSTANCE hInst;

void GetSysDisks(HWND hWnd)
{
  char dn[24],nn[6];
  int i;

  strcpy(dn,"\\\\.\\PhysicalDrive0");
  strcpy(nn,"(hd0)");
  for (i=0;i<MAX_DISKS;i++)
    {
      HANDLE hd;

      dn[17]='0'+i;
      hd=CreateFile (dn,GENERIC_READ | GENERIC_WRITE,FILE_SHARE_READ | FILE_SHARE_WRITE, NULL,OPEN_EXISTING, 0, NULL);
      if (hd==INVALID_HANDLE_VALUE)
        continue;
      nn[3]='0'+i;
      SendDlgItemMessage(hWnd,IDC_SYSDISKS,CB_ADDSTRING,0,(LPARAM)&nn);
      CloseHandle(hd);
    }
}

void Install(HWND hWnd)
{
  char fn[512];
  char temp[16];
  int len;

  strcpy(fn,"grubinst.exe --pause ");
  len=strlen(fn);
  if (IsDlgButtonChecked(hWnd,IDC_NO_BACKUP_MBR)==BST_CHECKED)
    {
      strcpy(&fn[len],"--no-backup-mbr ");
      len+=strlen(&fn[len]);
    }
  if (IsDlgButtonChecked(hWnd,IDC_DISABLE_FLOPPY)==BST_CHECKED)
    {
      strcpy(&fn[len],"--mbr-disable-floppy ");
      len+=strlen(&fn[len]);
    }
  if (IsDlgButtonChecked(hWnd,IDC_DISABLE_OSBR)==BST_CHECKED)
    {
      strcpy(&fn[len],"--mbr-disable-osbr ");
      len+=strlen(&fn[len]);
    }
  if (IsDlgButtonChecked(hWnd,IDC_DUCE)==BST_CHECKED)
    {
      strcpy(&fn[len],"--duce ");
      len+=strlen(&fn[len]);
    }
  if (IsDlgButtonChecked(hWnd,IDC_PREVMBR_FIRST)==BST_CHECKED)
    {
      strcpy(&fn[len],"--boot-prevmbr-first ");
      len+=strlen(&fn[len]);
    }
  if (GetDlgItemText(hWnd,IDC_PREFERED_DRIVE,temp,sizeof(temp))!=0)
    {
      sprintf(&fn[len],"--prefered-drive=%s ",temp);
      len+=strlen(&fn[len]);
    }
  if (GetDlgItemText(hWnd,IDC_PREFERED_PARTITION,temp,sizeof(temp))!=0)
    {
      sprintf(&fn[len],"--prefered-partition=%s ",temp);
      len+=strlen(&fn[len]);
    }
  if (GetDlgItemText(hWnd,IDC_TIMEOUT,temp,sizeof(temp))!=0)
    {
      sprintf(&fn[len],"--time-out=%s ",temp);
      len+=strlen(&fn[len]);
    }
  if (GetDlgItemText(hWnd,IDC_HOTKEY,temp,sizeof(temp))!=0)
    {
      sprintf(&fn[len],"--hot-key=%s ",temp);
      len+=strlen(&fn[len]);
    }
  if (IsDlgButtonChecked(hWnd,IDC_RESTORE_SAVE)==BST_CHECKED)
    {
      strcpy(&fn[len],"--restore-mbr=");
      len+=strlen(&fn[len]);
      if (GetDlgItemText(hWnd,IDC_SAVEFILE,&fn[len],sizeof(fn)-len)==0)
        {
          MessageBox(hWnd,"No save file specified","Error",MB_OK | MB_ICONERROR);
          return;
        }
      len+=strlen(&fn[len]);
      fn[len++]=' ';
      fn[len]=0;
    }
  else
    {
      int slen;

      strcpy(&fn[len],"--save-mbr=");
      slen=strlen(&fn[len]);
      if (GetDlgItemText(hWnd,IDC_SAVEFILE,&fn[len+slen],sizeof(fn)-len-slen)!=0)
        {
          len+=strlen(&fn[len]);
          fn[len++]=' ';
          fn[len]=0;
        }
      else
        fn[len]=0;
      if (IsDlgButtonChecked(hWnd,IDC_RESTORE_PREVMBR)==BST_CHECKED)
        {
          strcpy(&fn[len],"--restore-prevmbr ");
          len+=strlen(&fn[len]);
        }
    }
  if (IsDlgButtonChecked(hWnd,IDC_ISDISK)==BST_CHECKED)
    {
      if (GetDlgItemText(hWnd,IDC_SYSDISKS,&fn[len],sizeof(fn)-len)==0)
        {
          MessageBox(hWnd,"Disk name is empty","Error",MB_OK | MB_ICONERROR);
          return;
        }
    }
  else if (IsDlgButtonChecked(hWnd,IDC_ISFILE)==BST_CHECKED)
    {
      if (GetDlgItemText(hWnd,IDC_FILENAME,&fn[len],sizeof(fn)-len)==0)
        {
          MessageBox(hWnd,"File name is empty","Error",MB_OK | MB_ICONERROR);
          return;
        }
    }
  else
    {
      MessageBox(hWnd,"Device type not selected","Error",MB_OK | MB_ICONERROR);
      return;
    }
  //MessageBox(hWnd,fn,"Test",MB_OK); return;
  if (WinExec(fn,SW_SHOW)<=31)
    {
      MessageBox(hWnd,"Can\'t run the background program","Error",MB_OK | MB_ICONERROR);
      return;
    }
}

BOOL CALLBACK DialogProc(HWND hWnd,UINT wMsg,WPARAM wParam,LPARAM lParam)
{

  switch (wMsg) {
  case WM_CLOSE:
    EndDialog(hWnd,0);
    break;
  case WM_INITDIALOG:
    {
      HICON hIcon;

      hIcon=LoadIcon(hInst,MAKEINTRESOURCE(ICO_MAIN));
      SendMessage(hWnd,WM_SETICON,ICON_BIG,(LPARAM)hIcon);
      GetSysDisks(hWnd);
      break;
    }
  case WM_COMMAND:
    {
      switch (wParam & 0xFFFF) {
      case IDOK:
        Install(hWnd);
        break;
      case IDCANCEL:
        EndDialog(hWnd,0);
        break;
      case IDC_BROWSE:
        {
          OPENFILENAME ofn;
          char fn[512];

          memset(&ofn,0,sizeof(ofn));
          GetDlgItemText(hWnd,IDC_FILENAME,fn,sizeof(fn));
          ofn.lStructSize=sizeof(ofn);
          ofn.hwndOwner=hWnd;
          ofn.hInstance=hInst;
          ofn.lpstrFile=fn;
          ofn.nMaxFile=sizeof(fn);
          ofn.Flags=OFN_PATHMUSTEXIST | OFN_FILEMUSTEXIST;
          if (GetOpenFileName(&ofn))
            SetDlgItemText(hWnd,IDC_FILENAME,fn);
          break;
        }
      case IDC_SYSDISKS:
        {
          if (wParam>>16==CBN_SELENDOK)
            CheckRadioButton(hWnd,IDC_ISDISK,IDC_ISFILE,IDC_ISDISK);
          break;
        }
      case IDC_FILENAME:
        {
          if (wParam>>16==EN_CHANGE)
            CheckRadioButton(hWnd,IDC_ISDISK,IDC_ISFILE,IDC_ISFILE);
          break;
        }
      case IDC_BROWSE_SAVE:
        {
          OPENFILENAME ofn;
          char fn[512];

          memset(&ofn,0,sizeof(ofn));
          GetDlgItemText(hWnd,IDC_SAVEFILE,fn,sizeof(fn));
          ofn.lStructSize=sizeof(ofn);
          ofn.hwndOwner=hWnd;
          ofn.hInstance=hInst;
          ofn.lpstrFile=fn;
          ofn.nMaxFile=sizeof(fn);
          if (GetOpenFileName(&ofn))
            SetDlgItemText(hWnd,IDC_SAVEFILE,fn);
          break;
        }
      }
      break;
    }
  default:
    return FALSE;
  }
  return TRUE;

}

int WINAPI WinMain(HINSTANCE hInstance,HINSTANCE hPrevInstance,LPSTR lpCmdLine,int nCmdShow)
{
  hInst=hInstance;
  DialogBoxParam(hInst,MAKEINTRESOURCE(DLG_MAIN),NULL,DialogProc,0);
  return 0;
}
