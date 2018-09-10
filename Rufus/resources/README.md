This <code>resources</code> contains 'two resources', 
the one is the PNG icon used in the 'mods' project, 
the other is a toolkit to unUPX the exe-file and all its embedded-resources and repacking them all back.

When you come-across a newer version of Rufus from https://rufus.ie/downloads/ you wish to make compatible with your 'Anti-UPX' AntiVirus,
simply drag&amp;drop the exe on-to <code>rcdata_unupx.cmd</code>,

for <code>rufus-2.18p.exe</code>, it will produce this (similar) output:
<pre>

unUPX input file.
                       Ultimate Packer for eXecutables
                          Copyright (C) 1996 - 2017
UPX 3.94w       Markus Oberhumer, Laszlo Molnar & John Reiser   May 12th 2017

        File size         Ratio      Format      Name
   --------------------   ------   -----------   -----------
   2407032 &lt;-    967800   40.21%    win32/pe     RUFUS-~1.EXE

Unpacked 1 file.

extracting embedded UPX-compressed data from RCDATA section to RC file and external binary-file
s.

uncompressing all binary-files, if possible.
                       Ultimate Packer for eXecutables
                          Copyright (C) 1996 - 2017
UPX 3.94w       Markus Oberhumer, Laszlo Molnar & John Reiser   May 12th 2017

        File size         Ratio      Format      Name
   --------------------   ------   -----------   -----------
     92531 &lt;-     66945   72.35%     dos/exe     RCData_1.bin
     58880 &lt;-      6464   10.98%     dos/com     RCData_10.bin
     58880 &lt;-      7059   11.99%     dos/com     RCData_11.bin
     58880 &lt;-      5469    9.29%     dos/com     RCData_12.bin
     58880 &lt;-      4431    7.53%     dos/com     RCData_13.bin
     58880 &lt;-      7217   12.26%     dos/com     RCData_14.bin
     58880 &lt;-      7409   12.58%     dos/com     RCData_15.bin
     58880 &lt;-      5387    9.15%     dos/com     RCData_16.bin
     58880 &lt;-      6973   11.84%     dos/com     RCData_17.bin
     58880 &lt;-      5785    9.83%     dos/com     RCData_18.bin
     58880 &lt;-      5543    9.41%     dos/com     RCData_19.bin
upx: RCData_2.bin: NotPackedException: not packed by UPX
     58880 &lt;-      7228   12.28%     dos/com     RCData_20.bin
     58880 &lt;-      8119   13.79%     dos/com     RCData_21.bin
     58880 &lt;-      6281   10.67%     dos/com     RCData_22.bin
     58880 &lt;-      7758   13.18%     dos/com     RCData_23.bin
     58880 &lt;-      6458   10.97%     dos/com     RCData_24.bin
     58880 &lt;-      7793   13.24%     dos/com     RCData_25.bin
     58880 &lt;-      8929   15.16%     dos/com     RCData_26.bin
     29540 &lt;-      5158   17.46%     dos/com     RCData_27.bin
upx: RCData_28.bin: NotPackedException: not packed by UPX
upx: RCData_29.bin: NotPackedException: not packed by UPX
     62535 &lt;-      3651    5.84%     dos/exe     RCData_3.bin
upx: RCData_30.bin: NotPackedException: not packed by UPX
upx: RCData_31.bin: NotPackedException: not packed by UPX
upx: RCData_32.bin: NotPackedException: not packed by UPX
upx: RCData_33.bin: NotPackedException: not packed by UPX
upx: RCData_34.bin: NotPackedException: not packed by UPX
upx: RCData_35.bin: NotPackedException: not packed by UPX
upx: RCData_36.bin: NotPackedException: not packed by UPX
upx: RCData_37.bin: NotPackedException: not packed by UPX
upx: RCData_38.bin: NotPackedException: not packed by UPX
upx: RCData_39.bin: NotPackedException: not packed by UPX
     28048 &lt;-     11446   40.81%     dos/exe     RCData_4.bin
     30736 &lt;-     16244   52.85%     dos/com     RCData_5.bin
upx: RCData_6.bin: NotPackedException: not packed by UPX
upx: RCData_7.bin: NotPackedException: not packed by UPX
upx: RCData_8.bin: NotPackedException: not packed by UPX
upx: RCData_9.bin: NotPackedException: not packed by UPX
   --------------------   ------   -----------   -----------
   1244350 &lt;-    217747   17.50%                 [ 22 files ]

Unpacked 22 files.

compiling all binary-files and RC file back to RES file.
Using codepage 1255 as default
Creating mods\Rufus\RESOUR~1\RUFUS-~1.EXE.res

mods\Rufus\RESOUR~1\RUFUS-~1.EXE.rc.
Writing RCDATA:300,     lang:0x409,     size 92531.
Writing RCDATA:301,     lang:0x409,     size 46685.
Writing RCDATA:302,     lang:0x409,     size 62535.
Writing RCDATA:303,     lang:0x409,     size 28048.
Writing RCDATA:304,     lang:0x409,     size 30736.
Writing RCDATA:305,     lang:0x409,     size 40360.
Writing RCDATA:306,     lang:0x409,     size 29750.
Writing RCDATA:307,     lang:0x409,     size 32178.
Writing RCDATA:308,     lang:0x409,     size 13105.
Writing RCDATA:309,     lang:0x409,     size 58880.
Writing RCDATA:310,     lang:0x409,     size 58880.
Writing RCDATA:311,     lang:0x409,     size 58880.
Writing RCDATA:312,     lang:0x409,     size 58880.
Writing RCDATA:313,     lang:0x409,     size 58880.
Writing RCDATA:314,     lang:0x409,     size 58880.
Writing RCDATA:315,     lang:0x409,     size 58880.
Writing RCDATA:316,     lang:0x409,     size 58880.
Writing RCDATA:317,     lang:0x409,     size 58880.
Writing RCDATA:318,     lang:0x409,     size 58880.
Writing RCDATA:319,     lang:0x409,     size 58880.
Writing RCDATA:320,     lang:0x409,     size 58880.
Writing RCDATA:321,     lang:0x409,     size 58880.
Writing RCDATA:322,     lang:0x409,     size 58880.
Writing RCDATA:323,     lang:0x409,     size 58880.
Writing RCDATA:324,     lang:0x409,     size 58880.
Writing RCDATA:325,     lang:0x409,     size 58880.
Writing RCDATA:326,     lang:0x409,     size 29540.
Writing RCDATA:400,     lang:0x409,     size 512.
Writing RCDATA:401,     lang:0x409,     size 36488.
Writing RCDATA:402,     lang:0x409,     size 512.
Writing RCDATA:403,     lang:0x409,     size 68599.
Writing RCDATA:404,     lang:0x409,     size 34140.
Writing RCDATA:450,     lang:0x409,     size 8192.
Writing RCDATA:451,     lang:0x409,     size 31872.
Writing RCDATA:500,     lang:0x409,     size 950890.
Writing RCDATA:501,     lang:0x409,     size 2048.
Writing RCDATA:502,     lang:0x409,     size 262144.
Writing RCDATA:503,     lang:0x409,     size 818.
Writing RCDATA:504,     lang:0x409,     size 843

re-embedding resources into main file.

Original file: mods\Rufus\RESOUR~1\RUFUS-~1.EXE
Modified file: mods\Rufus\RESOUR~1\RUFUS-~1.EXE_unupx.exe

Done.
Press any key to continue . . .
</pre>

<br/>

for <code>rufus-3.0p.exe</code>, it will produce this (similar) output:
<pre>

unUPX input file.
                       Ultimate Packer for eXecutables
                          Copyright (C) 1996 - 2017
UPX 3.94w       Markus Oberhumer, Laszlo Molnar & John Reiser   May 12th 2017

        File size         Ratio      Format      Name
   --------------------   ------   -----------   -----------
   2692152 &lt;-   1017400   37.79%    win32/pe     RUFUS-~2.EXE

Unpacked 1 file.

extracting embedded UPX-compressed data from RCDATA section to RC file and external binary-file
s.

uncompressing all binary-files, if possible.
                       Ultimate Packer for eXecutables
                          Copyright (C) 1996 - 2017
UPX 3.94w       Markus Oberhumer, Laszlo Molnar & John Reiser   May 12th 2017

        File size         Ratio      Format      Name
   --------------------   ------   -----------   -----------
upx: RCData_1.bin: NotPackedException: not packed by UPX
upx: RCData_10.bin: IOException: file is too small -- skipped
upx: RCData_11.bin: NotPackedException: not packed by UPX
upx: RCData_12.bin: NotPackedException: not packed by UPX
upx: RCData_13.bin: NotPackedException: not packed by UPX
upx: RCData_14.bin: NotPackedException: not packed by UPX
upx: RCData_15.bin: NotPackedException: not packed by UPX
upx: RCData_16.bin: IOException: file is too small -- skipped
upx: RCData_17.bin: NotPackedException: not packed by UPX
upx: RCData_18.bin: NotPackedException: not packed by UPX
     92531 &lt;-     66945   72.35%     dos/exe     RCData_19.bin
upx: RCData_2.bin: NotPackedException: not packed by UPX
upx: RCData_20.bin: NotPackedException: not packed by UPX
     62535 &lt;-      3651    5.84%     dos/exe     RCData_21.bin
     28048 &lt;-     11446   40.81%     dos/exe     RCData_22.bin
     30736 &lt;-     16244   52.85%     dos/com     RCData_23.bin
upx: RCData_24.bin: NotPackedException: not packed by UPX
upx: RCData_25.bin: NotPackedException: not packed by UPX
upx: RCData_26.bin: NotPackedException: not packed by UPX
upx: RCData_27.bin: NotPackedException: not packed by UPX
     58880 &lt;-      6464   10.98%     dos/com     RCData_28.bin
     58880 &lt;-      7059   11.99%     dos/com     RCData_29.bin
upx: RCData_3.bin: IOException: file is too small -- skipped
     58880 &lt;-      5469    9.29%     dos/com     RCData_30.bin
     58880 &lt;-      4431    7.53%     dos/com     RCData_31.bin
     58880 &lt;-      7217   12.26%     dos/com     RCData_32.bin
     58880 &lt;-      7409   12.58%     dos/com     RCData_33.bin
     58880 &lt;-      5387    9.15%     dos/com     RCData_34.bin
     58880 &lt;-      6973   11.84%     dos/com     RCData_35.bin
     58880 &lt;-      5785    9.83%     dos/com     RCData_36.bin
     58880 &lt;-      5543    9.41%     dos/com     RCData_37.bin
     58880 &lt;-      7228   12.28%     dos/com     RCData_38.bin
     58880 &lt;-      8119   13.79%     dos/com     RCData_39.bin
upx: RCData_4.bin: IOException: file is too small -- skipped
     58880 &lt;-      6281   10.67%     dos/com     RCData_40.bin
     58880 &lt;-      7758   13.18%     dos/com     RCData_41.bin
     58880 &lt;-      6458   10.97%     dos/com     RCData_42.bin
     58880 &lt;-      7793   13.24%     dos/com     RCData_43.bin
     58880 &lt;-      8929   15.16%     dos/com     RCData_44.bin
     29540 &lt;-      5158   17.46%     dos/com     RCData_45.bin
upx: RCData_46.bin: NotPackedException: not packed by UPX
upx: RCData_47.bin: NotPackedException: not packed by UPX
upx: RCData_48.bin: NotPackedException: not packed by UPX
upx: RCData_49.bin: NotPackedException: not packed by UPX
upx: RCData_5.bin: IOException: file is too small -- skipped
upx: RCData_50.bin: NotPackedException: not packed by UPX
upx: RCData_51.bin: NotPackedException: not packed by UPX
upx: RCData_52.bin: NotPackedException: not packed by UPX
upx: RCData_53.bin: NotPackedException: not packed by UPX
upx: RCData_54.bin: NotPackedException: not packed by UPX
upx: RCData_55.bin: NotPackedException: not packed by UPX
upx: RCData_56.bin: NotPackedException: not packed by UPX
upx: RCData_57.bin: NotPackedException: not packed by UPX
upx: RCData_6.bin: NotPackedException: not packed by UPX
upx: RCData_7.bin: NotPackedException: not packed by UPX
upx: RCData_8.bin: NotPackedException: not packed by UPX
upx: RCData_9.bin: NotPackedException: not packed by UPX
   --------------------   ------   -----------   -----------
   1244350 &lt;-    217747   17.50%                 [ 22 files ]

Unpacked 22 files.

compiling all binary-files and RC file back to RES file.
Using codepage 1255 as default
Creating mods\Rufus\RESOUR~1\RUFUS-~2.EXE.res

mods\Rufus\RESOUR~1\RUFUS-~2.EXE.rc.
Writing RCDATA:121,     lang:0x409,     size 947.
Writing RCDATA:122,     lang:0x409,     size 707.
Writing RCDATA:123,     lang:0x409,     size 312.
Writing RCDATA:124,     lang:0x409,     size 277.
Writing RCDATA:125,     lang:0x409,     size 453.
Writing RCDATA:126,     lang:0x409,     size 824.
Writing RCDATA:131,     lang:0x409,     size 1636.
Writing RCDATA:132,     lang:0x409,     size 1200.
Writing RCDATA:133,     lang:0x409,     size 789.
Writing RCDATA:134,     lang:0x409,     size 478.
Writing RCDATA:135,     lang:0x409,     size 712.
Writing RCDATA:136,     lang:0x409,     size 1375.
Writing RCDATA:141,     lang:0x409,     size 2407.
Writing RCDATA:142,     lang:0x409,     size 1576.
Writing RCDATA:143,     lang:0x409,     size 627.
Writing RCDATA:144,     lang:0x409,     size 339.
Writing RCDATA:145,     lang:0x409,     size 645.
Writing RCDATA:146,     lang:0x409,     size 2006.
Writing RCDATA:300,     lang:0x409,     size 92531.
Writing RCDATA:301,     lang:0x409,     size 46685.
Writing RCDATA:302,     lang:0x409,     size 62535.
Writing RCDATA:303,     lang:0x409,     size 28048.
Writing RCDATA:304,     lang:0x409,     size 30736.
Writing RCDATA:305,     lang:0x409,     size 40360.
Writing RCDATA:306,     lang:0x409,     size 29750.
Writing RCDATA:307,     lang:0x409,     size 32178.
Writing RCDATA:308,     lang:0x409,     size 13105.
Writing RCDATA:309,     lang:0x409,     size 58880.
Writing RCDATA:310,     lang:0x409,     size 58880.
Writing RCDATA:311,     lang:0x409,     size 58880.
Writing RCDATA:312,     lang:0x409,     size 58880.
Writing RCDATA:313,     lang:0x409,     size 58880.
Writing RCDATA:314,     lang:0x409,     size 58880.
Writing RCDATA:315,     lang:0x409,     size 58880.
Writing RCDATA:316,     lang:0x409,     size 58880.
Writing RCDATA:317,     lang:0x409,     size 58880.
Writing RCDATA:318,     lang:0x409,     size 58880.
Writing RCDATA:319,     lang:0x409,     size 58880.
Writing RCDATA:320,     lang:0x409,     size 58880.
Writing RCDATA:321,     lang:0x409,     size 58880.
Writing RCDATA:322,     lang:0x409,     size 58880.
Writing RCDATA:323,     lang:0x409,     size 58880.
Writing RCDATA:324,     lang:0x409,     size 58880.
Writing RCDATA:325,     lang:0x409,     size 58880.
Writing RCDATA:326,     lang:0x409,     size 29540.
Writing RCDATA:400,     lang:0x409,     size 512.
Writing RCDATA:401,     lang:0x409,     size 36488.
Writing RCDATA:402,     lang:0x409,     size 512.
Writing RCDATA:403,     lang:0x409,     size 68599.
Writing RCDATA:404,     lang:0x409,     size 34140.
Writing RCDATA:450,     lang:0x409,     size 8192.
Writing RCDATA:451,     lang:0x409,     size 31872.
Writing RCDATA:500,     lang:0x409,     size 949163.
Writing RCDATA:501,     lang:0x409,     size 2048.
Writing RCDATA:502,     lang:0x409,     size 524288.
Writing RCDATA:503,     lang:0x409,     size 818.
Writing RCDATA:504,     lang:0x409,     size 843

re-embedding resources into main file.

Original file: mods\Rufus\RESOUR~1\RUFUS-~2.EXE
Modified file: mods\Rufus\RESOUR~1\RUFUS-~2.EXE_unupx.exe

Done.
Press any key to continue . . .
</pre>

<h4>it will then open Windows-explorer to show you the new file.</h4>

Use the newly-generated file (the one with the <code>_unupx</code> suffix) as same you were using the original one, hopefully it will not trigger you antivirus or malware detector since its 'exe header' signature will report a simple C++ GCC MINGW-64w compiler exe file without any app-layer compression.

if you wish you can drag&amp;drop it over <code>add_manifest.cmd</code> from https://github.com/eladkarako/manifest to give it a Windows-10 compatible manifest and high-DPI-screen support.
