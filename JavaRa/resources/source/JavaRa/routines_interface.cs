namespace JavaRa
{
    using JavaRa.My;
    using Microsoft.VisualBasic;
    using Microsoft.VisualBasic.CompilerServices;
    using Microsoft.VisualBasic.FileIO;
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Reflection;
    using System.Runtime.InteropServices;
    using System.Windows.Forms;

    [StandardModule]
    internal sealed class routines_interface
    {
        public static void clean_jre_temp_files()
        {
            Functions.write_log(routines_locales.get_string("== Cleaning JRE temporary files =="));
            try
            {
                foreach (string str2 in Directory.GetFiles((Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData) + @"\Sun\Java\Deployment\").Replace(@"\Local\", @"\LocalLow\"), "*.*", System.IO.SearchOption.AllDirectories))
                {
                    if (str2.Contains(@"\cache\"))
                    {
                        File.Delete(str2);
                        Functions.write_log(routines_locales.get_string("Deleted file: " + str2));
                    }
                    if (str2.Contains(@"\SystemCache\"))
                    {
                        Functions.write_log(routines_locales.get_string("Deleted file: " + str2));
                    }
                }
            }
            catch (Exception exception1)
            {
                ProjectData.SetProjectError(exception1);
                Exception exception = exception1;
                Functions.write_error(exception);
                ProjectData.ClearProjectError();
            }
            Functions.write_log(" ");
        }

        public static void cleanup_old_jre()
        {
            try
            {
                string str;
                if (!MyProject.Forms.UI.stay_silent && !MyProject.Computer.FileSystem.FileExists(Path.GetDirectoryName(Assembly.GetEntryAssembly().Location) + @"\JavaRa.def"))
                {
                    MessageBox.Show(routines_locales.get_string("The JavaRa definitions have been removed.") + Environment.NewLine + routines_locales.get_string("You need to download them before continuing."), routines_locales.get_string("Definitions Not Available"));
                    show_panel(MyProject.Forms.UI.pnlUpdate, false);
                    return;
                }
                Functions.write_log(routines_locales.get_string("User initialised redundant data purge.") + Environment.NewLine + "......................" + Environment.NewLine);
                StreamReader reader = new StreamReader(Path.GetDirectoryName(Assembly.GetEntryAssembly().Location) + @"\JavaRa.def");
                int num2 = 1;
                while (reader.Peek() > -1)
                {
                    str = reader.ReadLine().ToString();
                    if (str.StartsWith("linecount="))
                    {
                        num2 = Conversions.ToInteger(str.Replace("linecount=", ""));
                        break;
                    }
                }
                int num = 0;
                StreamReader reader2 = new StreamReader(Path.GetDirectoryName(Assembly.GetEntryAssembly().Location) + @"\JavaRa.def");
                while (reader2.Peek() > -1)
                {
                    str = reader2.ReadLine().ToString();
                    if (str.StartsWith("[key]"))
                    {
                        routines_registry.delete_key(str.Replace("[key]", ""));
                    }
                    num++;
                    if (!MyProject.Forms.UI.stay_silent)
                    {
                        if (num < num2)
                        {
                            MyProject.Forms.UI.ProgressBar1.Value = (int) Math.Round((double) ((((double) num) / ((double) num2)) * 100.0));
                        }
                        Application.DoEvents();
                    }
                }
                Functions.write_log(routines_locales.get_string("Cleanup routine completed successfully.") + " " + Conversions.ToString(MyProject.Forms.UI.removal_count) + " " + routines_locales.get_string("items have been deleted."));
                if (!MyProject.Forms.UI.stay_silent)
                {
                    MessageBox.Show(routines_locales.get_string("Cleanup routine completed successfully.") + " " + Conversions.ToString(MyProject.Forms.UI.removal_count) + " " + routines_locales.get_string("items have been deleted."), routines_locales.get_string("Removal Routine Complete"));
                }
            }
            catch (Exception exception1)
            {
                ProjectData.SetProjectError(exception1);
                Exception exception = exception1;
                Functions.write_error(exception);
                ProjectData.ClearProjectError();
            }
            if (MyProject.Forms.UI.stay_silent)
            {
                MyProject.Forms.UI.Close();
            }
        }

        private static void delete_dir(string file)
        {
            if (file.Contains("%ProgramFiles%"))
            {
                file = file.Replace("%ProgramFiles%", @"C:\Program Files");
                LoopDelete(file);
                if (Directory.Exists(@"C:\Program Files (x86)"))
                {
                    LoopDelete(file.Replace(@"C:\Program Files\", @"C:\Program Files (x86)\"));
                }
            }
            else if (file.Contains("%Windows%"))
            {
                file = file.Replace("%Windows%", @"C:\Windows");
                LoopDelete(file);
            }
            else if (file.Contains("%AppData%"))
            {
                file = file.Replace("%AppData%", Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData));
                LoopDelete(file);
            }
            else if (file.Contains("%CommonAppData%"))
            {
                file = file.Replace("%CommonAppData%", Environment.GetFolderPath(Environment.SpecialFolder.CommonApplicationData));
                LoopDelete(file);
            }
            else if (file.Contains("%LocalAppData%"))
            {
                file = file.Replace("%LocalAppData%", Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData));
                LoopDelete(file);
            }
        }

        private static void delete_file(string file)
        {
            file = file.Replace("%ProgramFiles%", @"C:\Program Files");
            file = file.Replace("%CommonAppData%", Environment.GetFolderPath(Environment.SpecialFolder.CommonApplicationData));
            file = file.Replace("%Windows%", @"C:\Windows");
            file = file.Replace("%AppData%", Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData));
            file = file.Replace("%LocalAppData%", Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData));
            if (File.Exists(file))
            {
                File.Delete(file);
            }
            else if (file.Contains(@"C:\Program Files"))
            {
                try
                {
                    File.Delete(file.Replace(@"C:\Program Files", @"C:\Program Files (x86)"));
                }
                catch (Exception exception1)
                {
                    ProjectData.SetProjectError(exception1);
                    Exception exception = exception1;
                    ProjectData.ClearProjectError();
                }
            }
        }

        public static void delete_jre_firefox_extensions()
        {
            try
            {
                IEnumerator<string> enumerator;
                string directory = null;
                if (MyProject.Computer.FileSystem.DirectoryExists(@"C:\Program Files (x86)\Mozilla Firefox\extensions\"))
                {
                    directory = @"C:\Program Files (x86)\Mozilla Firefox\extensions\";
                }
                else if (MyProject.Computer.FileSystem.DirectoryExists(@"C:\Program Files\Mozilla Firefox\extensions\"))
                {
                    directory = @"C:\Program Files\Mozilla Firefox\extensions\";
                }
                else
                {
                    return;
                }
                string right = Conversions.ToString(0);
                foreach (string str4 in MyProject.Computer.FileSystem.GetDirectories(directory))
                {
                    if (str4.Contains("{CAFEEFAC-0016-0000-") & str4.Contains("-ABCDEFFEDCBA}"))
                    {
                        str4 = str4.Remove(0, str4.LastIndexOf(@"\") + 1).Replace("-ABCDEFFEDCBA}", "").Replace("{CAFEEFAC-0016-0000-", "");
                        if (Operators.CompareString(str4, right, false) > 0)
                        {
                            right = str4;
                        }
                    }
                }
                string str2 = directory + "{CAFEEFAC-0016-0000-" + right + "-ABCDEFFEDCBA}";
                try
                {
                    enumerator = MyProject.Computer.FileSystem.GetDirectories(directory).GetEnumerator();
                    while (enumerator.MoveNext())
                    {
                        string current = enumerator.Current;
                        if ((current.Contains("{CAFEEFAC-0016-0000-") & current.Contains("-ABCDEFFEDCBA}")) && (current != str2))
                        {
                            MyProject.Computer.FileSystem.DeleteDirectory(current, DeleteDirectoryOption.DeleteAllContents);
                        }
                    }
                }
                finally
                {
                    if (enumerator != null)
                    {
                        enumerator.Dispose();
                    }
                }
            }
            catch (Exception exception1)
            {
                ProjectData.SetProjectError(exception1);
                Exception exception = exception1;
                Functions.write_error(exception);
                ProjectData.ClearProjectError();
            }
        }

        private static void LoopDelete(string dir)
        {
            IEnumerator<string> enumerator;
            try
            {
                enumerator = MyProject.Computer.FileSystem.GetFiles(dir).GetEnumerator();
                while (enumerator.MoveNext())
                {
                    string current = enumerator.Current;
                    try
                    {
                        if (File.Exists(current))
                        {
                            File.Delete(current);
                        }
                        continue;
                    }
                    catch (Exception exception1)
                    {
                        ProjectData.SetProjectError(exception1);
                        Exception exception = exception1;
                        Functions.write_error(exception);
                        ProjectData.ClearProjectError();
                        continue;
                    }
                }
            }
            finally
            {
                if (enumerator != null)
                {
                    enumerator.Dispose();
                }
            }
        }

        public static void purge_jre()
        {
            try
            {
                string str;
                if (!MyProject.Forms.UI.stay_silent && !MyProject.Computer.FileSystem.FileExists(Path.GetDirectoryName(Assembly.GetEntryAssembly().Location) + @"\JavaRa.def"))
                {
                    MessageBox.Show(routines_locales.get_string("The JavaRa definitions have been removed.") + Environment.NewLine + routines_locales.get_string("You need to download them before continuing."), routines_locales.get_string("Definitions Not Available"));
                    show_panel(MyProject.Forms.UI.pnlUpdate, false);
                    return;
                }
                Functions.write_log(routines_locales.get_string("User initialised redundant data purge.") + Environment.NewLine + "......................" + Environment.NewLine);
                StreamReader reader = new StreamReader(Path.GetDirectoryName(Assembly.GetEntryAssembly().Location) + @"\JavaRa.def");
                int num2 = 1;
                while (reader.Peek() > -1)
                {
                    str = reader.ReadLine().ToString();
                    if (str.StartsWith("linecount="))
                    {
                        num2 = Conversions.ToInteger(str.Replace("linecount=", ""));
                        break;
                    }
                }
                int num = 0;
                StreamReader reader2 = new StreamReader(Path.GetDirectoryName(Assembly.GetEntryAssembly().Location) + @"\JavaRa.def");
                while (reader2.Peek() > -1)
                {
                    str = reader2.ReadLine().ToString();
                    if (str.StartsWith("[key]"))
                    {
                        routines_registry.delete_key(str.Replace("[key]", ""));
                    }
                    if (str.StartsWith("[dir]"))
                    {
                        delete_dir(str.Replace("[dir]", ""));
                    }
                    if (str.StartsWith("[file]"))
                    {
                        delete_file(str.Replace("[file]", ""));
                    }
                    num++;
                    if (!MyProject.Forms.UI.stay_silent)
                    {
                        if (num < num2)
                        {
                            MyProject.Forms.UI.ProgressBar1.Value = (int) Math.Round((double) ((((double) num) / ((double) num2)) * 100.0));
                        }
                        Application.DoEvents();
                    }
                }
                try
                {
                    if (Directory.Exists(@"C:\Program Files\Java\"))
                    {
                        Directory.Delete(@"C:\Program Files\Java\", true);
                    }
                    if (Directory.Exists(@"C:\Program Files (x86)\Java\"))
                    {
                        Directory.Delete(@"C:\Program Files (x86)\Java\", true);
                    }
                    if (Directory.Exists(@"C:\Users\" + Environment.UserName + @"\AppData\LocalLow\Sun\Java"))
                    {
                        Directory.Delete(@"C:\Users\" + Environment.UserName + @"\AppData\LocalLow\Sun\Java", true);
                    }
                }
                catch (Exception exception1)
                {
                    ProjectData.SetProjectError(exception1);
                    Exception exception = exception1;
                    ProjectData.ClearProjectError();
                }
                Functions.write_log(routines_locales.get_string("Removal routine completed successfully.") + " " + Conversions.ToString(MyProject.Forms.UI.removal_count) + " " + routines_locales.get_string("items have been deleted."));
                if (!MyProject.Forms.UI.stay_silent)
                {
                    MessageBox.Show(routines_locales.get_string("Removal routine completed successfully.") + " " + Conversions.ToString(MyProject.Forms.UI.removal_count) + " " + routines_locales.get_string("items have been deleted."), routines_locales.get_string("Removal Routine Complete"));
                }
            }
            catch (Exception exception3)
            {
                ProjectData.SetProjectError(exception3);
                Exception exception2 = exception3;
                Functions.write_error(exception2);
                ProjectData.ClearProjectError();
            }
            if (MyProject.Forms.UI.stay_silent)
            {
                MyProject.Forms.UI.Close();
            }
        }

        public static void return_home()
        {
            MyProject.Forms.UI.pnlTopDock.BringToFront();
            MyProject.Forms.UI.pnlTopDock.Dock = DockStyle.Fill;
            MyProject.Forms.UI.lvTools.Dock = DockStyle.Fill;
            MyProject.Forms.UI.Panel7.BringToFront();
        }

        public static void show_panel(Panel pnl, bool scrollbar = false)
        {
            pnl.BringToFront();
            pnl.Dock = DockStyle.Fill;
            MyProject.Forms.UI.Panel7.BringToFront();
        }

        public static void uninstall_all(bool silent = false)
        {
            List<JREInstallObject>.Enumerator enumerator;
            try
            {
                enumerator = MyProject.Forms.UI.JREObjectList.GetEnumerator();
                while (enumerator.MoveNext())
                {
                    JREInstallObject current = enumerator.Current;
                    if (Operators.ConditionalCompareObjectEqual(current.Installed, true, false))
                    {
                        try
                        {
                            if (!silent)
                            {
                                Interaction.Shell(Conversions.ToString(current.UninstallString), AppWinStyle.NormalFocus, true, -1);
                            }
                            else
                            {
                                Interaction.Shell(Conversions.ToString(Operators.ConcatenateObject(current.UninstallString, " /qn /Norestart")), AppWinStyle.Hide, true, -1);
                            }
                            continue;
                        }
                        catch (Exception exception1)
                        {
                            ProjectData.SetProjectError(exception1);
                            Exception exception = exception1;
                            Functions.write_error(exception);
                            ProjectData.ClearProjectError();
                            continue;
                        }
                    }
                }
            }
            finally
            {
                enumerator.Dispose();
            }
        }
    }
}

