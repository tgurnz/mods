<h1><img src="resources/icon.png"/> AAPT (version 1 and 2)</h1>

<h2>Android Asset Packaging Tool</h2>

Windows files (x32 bit):
<h3>AAPT  (version 1) <code>v0.2.20170824.132118</h3>
<h3>AAPT2 (version 2) <code>v2.19.20170824.132118</code>.</h3>

<hr/>

after build, slightly modified it with a proper windows 10 manifest, 
icon and VERSIONINFO resources.

<hr/>

<h3>What are those file?</h3>

<strong>AAPT</strong> from https://android.googlesource.com/platform/frameworks/base/+/master/tools/aapt2/ <br/>
and <strong>AAPT2</strong> from https://android.googlesource.com/platform/frameworks/base/+/master/tools/aapt2/ <br/>

are parsers of the <code>manifest.xml</code> (and other files) which you may find in a generic APK file, 
https://en.wikipedia.org/wiki/Android_application_package .

the <code>manifest.xml</code> file (for example) is binary-packed, 
there are amounts that being read that describing the next section size and type, 
done in-order, it constructes (with some heuristics..) a plain-text XML file.

<hr/>

In PHP, you may use https://github.com/eladkarako/APK-Information , which unpack the <code>manifest.xml</code> <br/>
file without the need of external executables. <br/>

There are some other tools around github that tries to do the same, <br/>
some use PhpJS unpack (not production ready, undocumented), but it is all very messy. <br/>

For batch files (or for APKTool's <codE>-a</code>/<code>--aapt</code>) you'll need this one.

<hr/>

It is not distributed anymore in the newer versions of the SDK-platform tools, 
and it carries the same license agreement of Google <a href="https://gist.github.com/eladkarako/b121a24ddaf4cf5ed2e8f4cfe9ddfc00">(SDK-)platform-tools</a>.
so redistribute/commercial usage === your own risk.

<hr/>

<h1>AAPT</h1>

<pre>
Android Asset Packaging Tool

Usage:
 aapt l[ist] [-v] [-a] file.{zip,jar,apk}
   List contents of Zip-compatible archive.

 aapt d[ump] [--values] [--include-meta-data] WHAT file.{apk} [asset [asset ...]]
   strings          Print the contents of the resource table string pool in the APK.
   badging          Print the label and icon for the app declared in APK.
   permissions      Print the permissions from the APK.
   resources        Print the resource table from the APK.
   configurations   Print the configurations in the APK.
   xmltree          Print the compiled xmls in the given assets.
   xmlstrings       Print the strings of the given compiled xml assets.

 aapt p[ackage] [-d][-f][-m][-u][-v][-x][-z][-M AndroidManifest.xml] \
        [-0 extension [-0 extension ...]] [-g tolerance] [-j jarfile] \
        [--debug-mode] [--min-sdk-version VAL] [--target-sdk-version VAL] \
        [--app-version VAL] [--app-version-name TEXT] [--custom-package VAL] \
        [--rename-manifest-package PACKAGE] \
        [--rename-instrumentation-target-package PACKAGE] \
        [--utf16] [--auto-add-overlay] \
        [--max-res-version VAL] \
        [-I base-package [-I base-package ...]] \
        [-A asset-source-dir]  [-G class-list-file] [-P public-definitions-file] \
        [-D main-dex-class-list-file] \
        [-S resource-sources [-S resource-sources ...]] \
        [-F apk-file] [-J R-file-dir] \
        [--product product1,product2,...] \
        [-c CONFIGS] [--preferred-density DENSITY] \
        [--split CONFIGS [--split CONFIGS]] \
        [--feature-of package [--feature-after package]] \
        [raw-files-dir [raw-files-dir] ...] \
        [--output-text-symbols DIR]

   Package the android resources.  It will read assets and resources that are
   supplied with the -M -A -S or raw-files-dir arguments.  The -J -P -F and -R
   options control which files are output.

 aapt r[emove] [-v] file.{zip,jar,apk} file1 [file2 ...]
   Delete specified files from Zip-compatible archive.

 aapt a[dd] [-v] file.{zip,jar,apk} file1 [file2 ...]
   Add specified files to Zip-compatible archive.

 aapt c[runch] [-v] -S resource-sources ... -C output-folder ...
   Do PNG preprocessing on one or several resource folders
   and store the results in the output folder.

 aapt s[ingleCrunch] [-v] -i input-file -o outputfile
   Do PNG preprocessing on a single file.

 aapt v[ersion]
   Print program version.

 Modifiers:
   -a  print Android-specific data (resources, manifest) when listing
   -c  specify which configurations to include.  The default is all
       configurations.  The value of the parameter should be a comma
       separated list of configuration values.  Locales should be specified
       as either a language or language-region pair.  Some examples:
            en
            port,en
            port,land,en_US
   -d  one or more device assets to include, separated by commas
   -f  force overwrite of existing files
   -g  specify a pixel tolerance to force images to grayscale, default 0
   -j  specify a jar or zip file containing classes to include
   -k  junk path of file(s) added
   -m  make package directories under location specified by -J
   -u  update existing packages (add new, replace older, remove deleted files)
   -v  verbose output
   -x  create extending (non-application) resource IDs
   -z  require localization of resource attributes marked with
       localization="suggested"
   -A  additional directory in which to find raw asset files
   -G  A file to output proguard options into.
   -D  A file to output proguard options for the main dex into.
   -F  specify the apk file to output
   -I  add an existing package to base include set
   -J  specify where to output R.java resource constant definitions
   -M  specify full path to AndroidManifest.xml to include in zip
   -P  specify where to output public resource definitions
   -S  directory in which to find resources.  Multiple directories will be scanned
       and the first match found (left to right) will take precedence.
   -0  specifies an additional extension for which such files will not
       be stored compressed in the .apk.  An empty string means to not
       compress any files at all.
   --debug-mode
       inserts android:debuggable="true" in to the application node of the
       manifest, making the application debuggable even on production devices.
   --include-meta-data
       when used with "dump badging" also includes meta-data tags.
   --pseudo-localize
       generate resources for pseudo-locales (en-XA and ar-XB).
   --min-sdk-version
       inserts android:minSdkVersion in to manifest.  If the version is 7 or
       higher, the default encoding for resources will be in UTF-8.
   --target-sdk-version
       inserts android:targetSdkVersion in to manifest.
   --max-res-version
       ignores versioned resource directories above the given value.
   --values
       when used with "dump resources" also includes resource values.
   --version-code
       inserts android:versionCode in to manifest.
   --version-name
       inserts android:versionName in to manifest.
   --replace-version
       If --version-code and/or --version-name are specified, these
       values will replace any value already in the manifest. By
       default, nothing is changed if the manifest already defines
       these attributes.
   --custom-package
       generates R.java into a different package.
   --extra-packages
       generate R.java for libraries. Separate libraries with ':'.
   --generate-dependencies
       generate dependency files in the same directories for R.java and resource package
   --auto-add-overlay
       Automatically add resources that are only in overlays.
   --preferred-density
       Specifies a preference for a particular density. Resources that do not
       match this density and have variants that are a closer match are removed.
   --split
       Builds a separate split APK for the configurations listed. This can
       be loaded alongside the base APK at runtime.
   --feature-of
       Builds a split APK that is a feature of the apk specified here. Resources
       in the base APK can be referenced from the the feature APK.
   --feature-after
       An app can have multiple Feature Split APKs which must be totally ordered.
       If --feature-of is specified, this flag specifies which Feature Split APK
       comes before this one. The first Feature Split APK should not define
       anything here.
   --rename-manifest-package
       Rewrite the manifest so that its package name is the package name
       given here.  Relative class names (for example .Foo) will be
       changed to absolute names with the old package so that the code
       does not need to change.
   --rename-instrumentation-target-package
       Rewrite the manifest so that all of its instrumentation
       components target the given package.  Useful when used in
       conjunction with --rename-manifest-package to fix tests against
       a package that has been renamed.
   --product
       Specifies which variant to choose for strings that have
       product variants
   --utf16
       changes default encoding for resources to UTF-16.  Only useful when API
       level is set to 7 or higher where the default encoding is UTF-8.
   --non-constant-id
       Make the resources ID non constant. This is required to make an R java class
       that does not contain the final value but is used to make reusable compiled
       libraries that need to access resources.
   --shared-lib
       Make a shared library resource package that can be loaded by an application
       at runtime to access the libraries resources. Implies --non-constant-id.
   --app-as-shared-lib
       Make an app resource package that also can be loaded as shared library at runtime.
       Implies --non-constant-id.
   --error-on-failed-insert
       Forces aapt to return an error if it fails to insert values into the manifest
       with --debug-mode, --min-sdk-version, --target-sdk-version --version-code
       and --version-name.
       Insertion typically fails if the manifest already defines the attribute.
   --error-on-missing-config-entry
       Forces aapt to return an error if it fails to find an entry for a configuration.
   --output-text-symbols
       Generates a text file containing the resource symbols of the R class in the
       specified folder.
   --ignore-assets
       Assets to be ignored. Default pattern is:
       !.svn:!.git:!.ds_store:!*.scc:.*:<dir>_*:!CVS:!thumbs.db:!picasa.ini:!*~
   --skip-symbols-without-default-localization
       Prevents symbols from being generated for strings that do not have a default
       localization
   --no-version-vectors
       Do not automatically generate versioned copies of vector XML resources.
   --no-version-transitions
       Do not automatically generate versioned copies of transition XML resources.
   --private-symbols
       Java package name to use when generating R.java for private resources.
</pre>

<hr/>

<h1>AAPT2</h1>

<pre>
no command specified

usage: aapt2 [compile|link|dump|diff|optimize|version] ...
                                                         
-------------------------------------------------------  
aapt2 compile                                            
                                                         
missing required flag -o

aapt2 compile [options] -o arg files...

Options:
 -o arg                                            Output path
 --dir arg                                         Directory to scan for resources
 --pseudo-localize                                 Generate resources for pseudo-locales (en-XA and ar-XB)
 --no-crunch                                       Disables PNG processing
 --legacy                                          Treat errors that used to be valid in AAPT as warnings
 -v                                                Enables verbose logging
 -h                                                Displays this help menu
-------------------------------------------------------  
aapt2 link                                               
                                                         
missing required flag -o

aapt2 link [options] -o arg --manifest arg files...

Options:
 -o arg                                            Output path.
 --manifest arg                                    Path to the Android manifest to build.
 -I arg                                            Adds an Android APK to link against.
 -A arg                                            An assets directory to include in the APK. These are unprocessed.
 -R arg                                            Compilation unit to link, using `overlay` semantics.
                                                   The last conflicting resource given takes precedence.
 --package-id arg                                  Specify the package ID to use for this app. Must be greater or equal to
                                                   0x7f and can't be used with --static-lib or --shared-lib.
 --java arg                                        Directory in which to generate R.java.
 --proguard arg                                    Output file for generated Proguard rules.
 --proguard-main-dex arg                           Output file for generated Proguard rules for the main dex.
 --no-auto-version                                 Disables automatic style and layout SDK versioning.
 --no-version-vectors                              Disables automatic versioning of vector drawables. Use this only
                                                   when building with vector drawable support library.
 --no-version-transitions                          Disables automatic versioning of transition resources. Use this only
                                                   when building with transition support library.
 --no-resource-deduping                            Disables automatic deduping of resources with
                                                   identical values across compatible configurations.
 --enable-sparse-encoding                          Enables encoding sparse entries using a binary search tree.
                                                   This decreases APK size at the cost of resource retrieval performance.
 -x                                                Legacy flag that specifies to use the package identifier 0x01.
 -z                                                Require localization of strings marked 'suggested'.
 -c arg                                            Comma separated list of configurations to include. The default
                                                   is all configurations.
 --preferred-density arg                           Selects the closest matching density and strips out all others.
 --product arg                                     Comma separated list of product names to keep
 --output-to-dir                                   Outputs the APK contents to a directory specified by -o.
 --no-xml-namespaces                               Removes XML namespace prefix and URI information from
                                                   AndroidManifest.xml and XML binaries in res/*.
 --min-sdk-version arg                             Default minimum SDK version to use for AndroidManifest.xml.
 --target-sdk-version arg                          Default target SDK version to use for AndroidManifest.xml.
 --version-code arg                                Version code (integer) to inject into the AndroidManifest.xml if none is
                                                   present.
 --version-name arg                                Version name to inject into the AndroidManifest.xml if none is present.
 --shared-lib                                      Generates a shared Android runtime library.
 --static-lib                                      Generate a static Android library.
 --no-static-lib-packages                          Merge all library resources under the app's package.
 --non-final-ids                                   Generates R.java without the final modifier. This is implied when
                                                   --static-lib is specified.
 --stable-ids arg                                  File containing a list of name to ID mapping.
 --emit-ids arg                                    Emit a file at the given path with a list of name to ID mappings,
                                                   suitable for use with --stable-ids.
 --private-symbols arg                             Package name to use when generating R.java for private symbols.
                                                   If not specified, public and private symbols will use the application's
                                                   package name.
 --custom-package arg                              Custom Java package under which to generate R.java.
 --extra-packages arg                              Generate the same R.java but with different package names.
 --add-javadoc-annotation arg                      Adds a JavaDoc annotation to all generated Java classes.
 --output-text-symbols arg                         Generates a text file containing the resource symbols of the R class in
                                                   the specified folder.
 --auto-add-overlay                                Allows the addition of new resources in overlays without
                                                   <add-resource> tags.
 --rename-manifest-package arg                     Renames the package in AndroidManifest.xml.
 --rename-instrumentation-target-package arg       Changes the name of the target package for instrumentation. Most useful
                                                   when used in conjunction with --rename-manifest-package.
 -0 arg                                            File extensions not to compress.
 --split arg                                       Split resources matching a set of configs out to a Split APK.
                                                   Syntax: path/to/output.apk:<config>[,<config>[...]].
                                                   On Windows, use a semicolon ';' separator instead.
 -v                                                Enables verbose logging.
 -h                                                Displays this help menu
-------------------------------------------------------  
aapt2 diff                                               
                                                         
must have two apks as arguments.

aapt2 diff [options] files...

Options:
 -h                                                Displays this help menu
-------------------------------------------------------  
aapt2 optimize                                           
                                                         
must have one APK as argument.

aapt2 optimize [options] files...

Options:
 -o arg                                            Path to the output APK.
 -d arg                                            Path to the output directory (for splits).
 -x arg                                            Path to XML configuration file.
 --target-densities arg                            Comma separated list of the screen densities that the APK will be optimized for.
                                                   All the resources that would be unused on devices of the given densities will be 
                                                   removed from the APK.
 -c arg                                            Comma separated list of configurations to include. The default
                                                   is all configurations.
 --split arg                                       Split resources matching a set of configs out to a Split APK.
                                                   Syntax: path/to/output.apk;<config>[,<config>[...]].
                                                   On Windows, use a semicolon ';' separator instead.
 --enable-sparse-encoding                          Enables encoding sparse entries using a binary search tree.
                                                   This decreases APK size at the cost of resource retrieval performance.
 -v                                                Enables verbose logging
 -h                                                Displays this help menu

</pre>


<br/>

<hr/>

In the <code>resource</code> folder, there are also <br/>
32bit versions for linux and mac, which include just aapt, <br/>
and 64bit versions for linux and mac that includes aapt and aapt2.

linux 32bit:  <code>ELF 32-bit LSB shared object, Intel 80386, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux.so.2, for GNU/Linux 2.6.24, BuildID[sha1]=0325feccd8ae1f6d77c4a992b1e5ebeb35bdede7, stripped, with debug_info</code>
Linux 64-bit: <code>ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 2.6.24, stripped, with debug_info</code>
mac 32bit:    <code>Mach-O i386 executable, flags:NOUNDEFS|DYLDLINK|TWOLEVEL|WEAK_DEFINES|BINDS_TO_WEAK|PIE|NO_HEAP_EXECUTION</code>
mac 64bit:    <code>Mach-O 64-bit x86_64 executable, flags:NOUNDEFS|DYLDLINK|TWOLEVEL|WEAK_DEFINES|BINDS_TO_WEAK|PIE</code>
