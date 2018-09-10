<h1><img src="resources/icon.png" />ProcessExplorer</h1>
Older version (12.04) of Windows Sysinternals (Microsoft)'s Process Explorer,
I like it since it has black background to the top CPU graph,
also - in the newer versions the fonts looks weird...

included both binary (program itself) - no installation, better embedded and external manifest for slightly improved rendering.

I like to use the x64 exe directly (notice that if you'll run the x32/x86 bit version your %TEMP% folder will have a x64 exe of process explorer in it..) with the following arguments <code>ProcessExplorer_12_x64.exe /t /e</code> (start in tray and force run as admin) - and creating a shortcut (with those switches) in startup folder to run automatically at startup.

more info:
<a href="https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer">https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer</a>

<a href="http://live.sysinternals.com/">http://live.sysinternals.com/</a>

<hr/>

If you're ok with the look of the new version you might as well download the newer one from the links above and apply the manifest fix using github.com/eladkarako/manifest/ tool.

if you use this older version here is what you'll miss out...
<pre>
16.21
  Fix for an intermittent bug in the Virus Total scanning logic, and is signed with Win7 RTM-compatible certificate.

16.11
- Fixes a bug that caused it to crash when it encountered an image with a path length longer than a few thousand characters.

16.10
- Process Explorer now includes a column in the handle view that reports the text version of handle access masks, as well as several bug fixes including one that would result in the suspension of .NET threads when viewed via the stack dialog.

16.05
- Process Explorer now includes a Protection column that shows process protection status.

16.04
- Fixes a bug in Virus Total file submission that could cause a crash
- Now Shows Windows Store package names on the Image page of the process properties dialog

16.03
- This release of Process Explorer, a process viewing and control utility, fixes several bugs, including one where moving the mouse over the information graphs could cause it to crash and another that could cause a crash when checking Virus Total results.

16.02
- This minor update adds a refresh button to the thread’s stack dialog and ensures that the Virus Total terms of agreement dialog box remains above the main Process Explorer window.

16.01
- This release fixes a bug that could cause a crash when the VirusTotal column is added to the process view, and another that could cause a crash when verifying digital signatures.

16.00
- Introduces integration with VirusTotal.com, an online antivirus analysis service. When enabled, Process Explorer sends the hashes of images and files shown in the process and DLL views to VirusTotal and if they have been previously scanned, reports how many antivirus engines identified them as possibly malicious. Hyperlinked results take you to VirusTotal.com report pages and you can even submit files for scanning.

15.40
- now shows WMI providers hosted in Wmiprvse processes
- includes an option that configures it to automatically run when you logon
- introduces a process view column that shows process DPI awareness support on Windows 8.1 systems.

15.31
- This update fixes a bug with copying text from the process properties dialog and adds an option to disable the heatmap display in the process view.

15.30
- Includes heat-map display for process CPU, private bytes, working set and GPU columns, sortable security groups in the process properties security page, and tooltip reporting of tasks executing in Windows 8 Taskhostex processes. 
- It also creates dump files that match the bitness of the target process and works around a bug introduced in Windows 8 disk counter reporting.

15.23
- Adds the ability to view the process token of protected processes
- Fixes a bug that causes a crash when viewing thread stacks on Windows XP
- Fixes a bug that causes a crash when running on Windows PE.

15.22
- This release addresses a bug that caused Process Explorer to crash when viewing .NET thread stacks of 64-bit Windows XP and 64-bit Windows Server 2003.

15.21
- Fixes a bug related to the autostart functionality introduced in v15.2
- A tooltip display bug
- A bug that prevented display of kernel stacks

15.20
- A Task Manager replacement
- Merges Autoruns functionality by adding a new Autostart Location column and property to the process and DLL views that indicates where an image is configured to automatically start or load. 
- It also adds .NET stack walking support to the thread stack dialog
- Adds a process timeline column that graphically depicts a process’s lifetime relative other processes
- Uses the Windows 8 private ETW logger which enables better coexistence with other ETW-based tools

15.13
- Adds Background priority to the process context menu, which sets the CPU, memory and I/O priorities of a process to low
- Includes a bug fix for restoring user-entered process comments

15.12
- Makes the search dialog asynchronous and reports the types of found items. 
- Showing a small font when run after an older version.
- A bug in the restart-process functionality.
- Working set columns not showing data, and again shows information about service processes when run from an unprivileged user account.
- Fixes several bugs.

15.11
- Fixes several bugs, including the fleeting appearance of garbage characters in the status bar.

15.10
- A Task Manager replacement.
- Adds support for new Windows 8 features by giving the processes hosting immersive applications a distinct highlight color.
- Shows immersive application package names in process tooltips and as a new process view column.
- Lists AppContainer and capability SIDs in the process security properties.
- Updates the GPU support to be compatible with Windows 8. 
- GPU memory counters with more descriptive labels.
- Display of the logon session ID on the security properties.
- Reporting of suspended processes as suspended in the CPU usage column.

15.05
- Fixes a bug in cycle CPU usage calculation on Windows 7.

15.04
- Fixes several minor bugs, including a tooltip display bug and one that could result in a miscalculation of CPU usage on Windows 7 in the refresh immediately following the termination of a CPU-intensive process.

15.03
- Fixes a bug that would result in a crash of Process Explorer when run with standard user rights and the System Information dialog is opened.

15.02
- Includes minor updates to the drawing routines.

15.01
- Adds the ability to select a custom graph background color.
- Adds paged and nonpaged pool quota columns to the process view.
- Fixes incorrect information on the disk and network process properties dialog on 32-bit Windows.
- Fixes a GPU tray icon bug.

15.00
- Adds GPU utilization and memory monitoring on Vista and higher. 
- Adds the ability to restart services.
- A smaller memory footprint.
- Visually cleaner performance graphs.

14.12
- Fixes a bug that prevents removal of tray icons under certain conditions.

14.11
- Includes the ability to configure network and disk activity icons in the tray.

14.10
- Introduces cycle-based CPU usage on Windows 7.
- Shows usage for processes that consume less than 0.01% CPU.
- Shows thread ideal processors on Windows 7.
- Adds the ability to remote control and connect to other logon sessions.

14.01
- Fixes a bug related to the DLL view.
- Adds a tab to the new system information dialog, Summary, that displays all the performance graphs together.

14.00
- Adds a slew of enhancements and new functionality including network and disk monitoring.
- Improved multi-tab system information dialog.
- Additional memory statistics.
- A new column that shows aggregate CPU usage for a tree of processes.
- Improved DLL scanning performance and accuracy, command-lines in process tree tooltips.
- Support for more than 64 CPU systems.

12.04 (this one you have...)
- Adds the ability to generate full and minidump process crash dump files.
- Fixes a bug in the process permission dialog.
</pre>