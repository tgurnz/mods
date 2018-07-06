<h1><img src="resources/icon.png"/> Dependency Walker <sub>(<em>a.k.a <code>Depends.Exe</code></em>)</sub></h1>

Normally you'll find it in your Visual-Studio folder,<br/>
this one (<code>Dependency Walker 2.1.3790</code>) is from an older Microsoft Visual Studio 8 (2008), from within the sub-directory <code>\Common7\Tools\Bin\</code>,<br/>
slightly modified with an added manifest (embedded and external).

you can find the help-files in the <code>Resources/</code> folder above.
<br/>
<hr/>

<pre>
Command Line Options and Return Values

DEPENDS.EXE	[/?] [/c] [/a:#] [/f:#] [/u:#] [/ps:#] [/pp:#] [/po:#] [/ph:#] [/pl:#] [/pg:#] [/pt:#] [/pn:#] [/pe:#] [/pm:#] [/pf:#] [/pi:#] [/pc:#] [/pa:#] [/pd:dir] [/pb] [/sm:#] [/si:#] [/se:#] [/sf:#] [/od:path] [/ot:path] [/of:path] [/oc:path] [/d:path] [path [args...]]

/?	Help - Displays this page.
/c	Console mode - Dependency Walker will process the other command line options and exit without displaying its graphical interface.  You must specify a module or Dependency Walker Image (DWI) file to open when using this option.
/a:#	Auto Expand - Use /a:0 to start Dependency Walker with the Auto Expand setting initially turned off, or /a:1 to start with it turned on.  If this option is not specified, then the setting from the last time you ran Dependency Walker will be used.

/f:#	View full paths - Use /f:0 to start Dependency Walker with the View Full Paths setting initially turned off, or /f:1 to start with it turned on.  If this option is not specified, then the setting from the last time you ran Dependency Walker will be used.
/u:#	Undecorate C++ functions - Use /u:0 to start Dependency Walker with the Undecorate C++ Functions setting initially turned off, or /u:1 to start with it turned on.  If this option is not specified, then the setting from the last time you ran Dependency Walker will be used.

/ps:#	Profiling option: Simulate ShellExecute by inserting any App Paths directories into the PATH environment variable - Use /ps:0 to start Dependency Walker with this setting initially turned off, or /ps:1 to start with it turned on.  If this option is not specified, then the setting from the last time you ran Dependency Walker will be used.
/pp:#	Profiling option: Log DllMain calls for process attach and process detach messages - Use /pp:0 to start Dependency Walker with this setting initially turned off, or /pp:1 to start with it turned on.  If this option is not specified, then the setting from the last time you ran Dependency Walker will be used.

/po:#	Profiling option: Log DllMain calls for all other messages, including thread attach and thread detach - Use /po:0 to start Dependency Walker with this setting initially turned off, or /po:1 to start with it turned on.  If this option is not specified, then the setting from the last time you ran Dependency Walker will be used.
/ph:#	Profiling option: Hook the process to gather more detailed dependency information - Use /ph:0 to start Dependency Walker with this setting initially turned off, or /ph:1 to start with it turned on.  If this option is not specified, then the setting from the last time you ran Dependency Walker will be used.

/pl:#	Profiling option: Log LoadLibrary function calls - Use /pl:0 to start Dependency Walker with this setting initially turned off, or /pl:1 to start with it turned on.  If this option is not specified, then the setting from the last time you ran Dependency Walker will be used.  If this option is turned on, then the "Hook the process to gather more detailed dependency information" option will also be turned on.
/pg:#	Profiling option: Log GetProcAddress function calls - Use /pg:0 to start Dependency Walker with this setting initially turned off, or /pg:1 to start with it turned on.  If this option is not specified, then the setting from the last time you ran Dependency Walker will be used.  If this option is turned on, then the "Hook the process to gather more detailed dependency information" option will also be turned on.

/pt:#	Profiling option: Log thread information - Use /pt:0 to start Dependency Walker with this setting initially turned off, or /pt:1 to start with it turned on.  If this option is not specified, then the setting from the last time you ran Dependency Walker will be used.
/pn:#	Profiling option: Use simple thread numbers instead of actual thread IDs - Use /pn:0 to start Dependency Walker with this setting initially turned off, or /pn:1 to start with it turned on.  If this option is not specified, then the setting from the last time you ran Dependency Walker will be used.  If this option is turned on, then the "Log thread information" option will also be turned on.

/pe:#	Profiling option: Log first chance exceptions - Use /pe:0 to start Dependency Walker with this setting initially turned off, or /pe:1 to start with it turned on.  If this option is not specified, then the setting from the last time you ran Dependency Walker will be used.
/pm:#	Profiling option: Log debug output messages - Use /pm:0 to start Dependency Walker with this setting initially turned off, or /pm:1 to start with it turned on.  If this option is not specified, then the setting from the last time you ran Dependency Walker will be used.

/pf:#	Profiling option: Use full paths when logging file names - Use /pf:0 to start Dependency Walker with this setting initially turned off, or /pf:1 to start with it turned on.  If this option is not specified, then the setting from the last time you ran Dependency Walker will be used.
/pi:#	Profiling option: Log a time stamp with each line of log - Use /pi:0 to start Dependency Walker with this setting initially turned off, or /pi:1 to start with it turned on.  If this option is not specified, then the setting from the last time you ran Dependency Walker will be used.

/pc:#	Profiling option: Automatically open and profile child processes - Use /pc:0 to start Dependency Walker with this setting initially turned off, or /pc:1 to start with it turned on.  If this option is not specified, then the setting from the last time you ran Dependency Walker will be used.  This option is ignored when running in console mode.
/pa:#	Profiling option: Turn all profiling options on or off - Use /pa:0 to initially turn all profiling options off, or /pa:1 to initially turn them all on.  This option can be used before other profiling options.  For example, /pa:1 /pf:0 will turn on all options except for the "Use full paths when logging file names" option.

/pd:dir	Profiling option: Starting directory - Specifies the starting directory to use when profiling the module.  This option requires that you specify a module to open.
/pb	Profiling option: Automatically begin profiling after the module has been loaded - This option requires that you specify a module to open.  If an output option (/od, /ot, /of, or /oc) is specified, Dependency Walker will wait until the profiling fully completes before saving the results.

/sm:#	Sort column for module list view - This option controls the initial sort column that Dependency Walker will use when sorting the items in the Module List View.  If this option is not specified, then the value from the last time you ran Dependency Walker will be used.  The values allowed are:

1.	Icon

2.	Module Name or Path

3.	File Time Stamp

4.	Link Time Stamp

5.	File Size

6.	File Attributes

7.	Link Checksum

8.	Real Checksum

9.	CPU Type

10.	Subsystem Type

11.	Symbol Types

12.	Preferred Base Address

13.	Actual Base Address

14.	Virtual Size

15.	Load Order

16.	File Version

17.	Product Version

18.	Image Version

19.	Linker Version

20.	OS Version

21.	Subsystem Version

/si:#	Sort column for parent import function list view - This option controls the initial sort column that Dependency Walker will use when sorting the items in the Parent Import Function List View.  If neither this option or the /sf option is specified, then the value from the last time you ran Dependency Walker will be used.  The values allowed are:

1.	Icon

2.	Ordinal Value

3.	Hint Value

4.	Function Name

5.	Entry Point Address

/se:#	Sort column for export function list views - This option controls the initial sort column that Dependency Walker will use when sorting the items in the Export Function List View.  If neither this option or the /sf option is specified, then the value from the last time you ran Dependency Walker will be used.  The values allowed are:

1.	Icon

2.	Ordinal Value

3.	Hint Value

4.	Function Name

5.	Entry Point Address

/sf:#	Sort column for both function list views - This option controls the initial sort column that Dependency Walker will use when sorting the items in both the Parent Import Function List View and the Export Function List View.  If no sort column option is specified for a particular column, then the value(s) from the last time you ran Dependency Walker will be used.  The values allowed are:

1.	Icon

2.	Ordinal Value

3.	Hint Value

4.	Function Name

5.	Entry Point Address

/od:path	Output file in Dependency Walker Image (DWI) format - This option requires that you specify a module or Dependency Walker Image (DWI) file to open.  Once the module has been processed, the results will be written to the specified file in the Dependency Walker Image (DWI) format.
/ot:path	Output file in text format - This option requires that you specify a module or Dependency Walker Image (DWI) file to open.  Once the module has been processed, the results will be written to the specified file in text format.

/of:path	Output file in text format with import / export function lists - This option requires that you specify a module or Dependency Walker Image (DWI) file to open.  Once the module has been processed, the results will be written to the specified file in text format, including the import and export function lists.
/oc:path	Output file in Comma Separated Value (CSV) format - This option requires that you specify a module or Dependency Walker Image (DWI) file to open.  Once the module has been processed, the results will be written to the specified file in a Comma Separated Value (CSV) format.

/d:path	Dependency Walker Path (DWP) file to load - This options allows you to specify a Dependency Walker Path (DWP) File to load and use as the initial search path when searching for modules.  DWP files can be created using the Configure Search Order command in Dependency Walker.
path	Path to a module or Dependency Walker Image (DWI) file to load - For this option, you can specify a file name, a relative path, or a full path to a file to load.  The file must be a 32-bit or 64-bit Windows module or a Dependency Walker Image (DWI) file.  This path must come after any options intended for Dependency Walker since all options that follow this path are assumed to be program arguments for use when profiling the module.

args...	Program arguments - Specifies the command line arguments to use when profiling the module specified by the path option.  Dependency Walker considers any text following the path option as being program arguments.  For this reason, any options intended for Dependency Walker must be specified before the path option.  If the file specified by the path option is really a Dependency Walker Image (DWI) file, then the args are ignored.





General Rules about Command Line Options



	Options are case insensitive.  For example, "/c" and "/C" are equivalent.
	Options may start with a slash or a dash.  For example, "/c" and "-c" are equivalent.
	The colons (:) shown in the options above are optional.  They may be removed or replaced with spaces.  For example, "/f:0", "/f 0", and "/f0" are equivalent.
	All profiling options are cumulative from left to right.  For example, /pa:1 /pm:0 will turn on all the profiling options, then turn off the "Log debug output messages" option, but /pm:0 /pa:1 will simply turn on all profiling options. 

	Program options intended for Dependency Walker must come before the module path.  All options after the module path will be passed to the module as its command line when profiled.
	If you wish to specify text that has spaces, that text should be placed in quotes.  For example:

depends /pb /oc "c:\output files\foo bar.csv" "c:\input files\foo bar.exe" 1 2 3 "this is a test"

	Multiple options can be grouped together.  You may even append options to other options that require numerical values.  The only options that cannot be appended to are options that require a path or text values (/pd, /od, /ot, /of, /oc, and /d).  For example:

depends /c /f:0 /u:1 /pa:1 /pf:0 /pe:0 /pb /sm:12 /sf:4 /d:search.dwp /oc:result.csv /od:result.dwi foo.exe

Could be shortened to:

depends /cf0u1pa1pf0pe0pbsm12sf4dsearch.dwp /ocresult.csv /odresult.dwi foo.exe bar

	All options can be specified with or without the "Console Mode" option (/c).

	More than one output file type option can be specified.





Return Values



When Dependency Walker exits, it returns a set of bit flags that are OR'ed together.  There are three groups of error flags - module warnings, module errors, and processing errors.  The error flags have been arranged in a way that makes it easy to detect the severity of a problem.



If the return value is greater than or equal to 0x00010000, then there was a processing error with Dependency Walker and no work was done.  Otherwise, if the return value is greater than or equal to 0x00000100, then the operating system will not be able to load the module due to some module or dependency error.  Otherwise, if the return value is greater than or equal to 0x00000001, then the module has no load-time dependency problems and will most likely have no problems loading, but may have runtime problems.



Module Warnings - Application should load, but might fail during runtime.



0x00000001	At least one dynamic dependency module was not found.
0x00000002	At least one delay-load dependency module was not found.
0x00000004	At least one module could not dynamically locate a function in another module using the GetProcAddress function call.
0x00000008	At least one module has an unresolved import due to a missing export function in a delay-load dependent module.
0x00000010	At least one module was corrupted or unrecognizable to Dependency Walker, but still appeared to be a Windows module.

0x00000020	At least one module failed to load during profiling.  This usually occurs when a module returns 0 from its DllMain function or generates an unhandled exception while processing the DLL_PROCESS_ATTACH message.



Module Errors - Application will fail to load by the operating system.



0x00000100	At least one file was not a 32-bit or 64-bit Windows module.
0x00000200	At least one required implicit or forwarded dependency was not found.
0x00000400	At least one module has an unresolved import due to a missing export function in a dependent module.
0x00000800	Modules with different CPU types were found.
0x00001000	A circular dependency was detected.
0x00002000	There was an error in a Side-by-Side configuration file.



Processing Errors - All or some modules could not be processed.



0x00010000	There was an error with at least one command line option.
0x00020000	The file you specified to load could not be found.
0x00040000	At least one file could not be opened for reading.
0x00080000	The format of the Dependency Walker Image (DWI) file was unrecognized.
0x00100000	There was an error while trying to profile the application.
0x00200000	There was an error writing the results to an output file.
0x00400000	Dependency Walker ran out of memory.

0x00800000	Dependency Walker encountered an internal program error.
</pre>