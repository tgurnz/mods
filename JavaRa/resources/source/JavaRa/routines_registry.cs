namespace JavaRa
{
    using JavaRa.My;
    using Microsoft.VisualBasic.CompilerServices;
    using Microsoft.Win32;
    using System;
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.IO;
    using System.Reflection;

    [StandardModule]
    internal sealed class routines_registry
    {
        public static void delete_jre_startup_entries()
        {
            int num2;
            try
            {
                int num;
                int num3;
            Label_0000:
                num3 = 1;
                List<string> list = new List<string>();
            Label_0009:
                num3 = 2;
                list.Add("jusched-Java Quick Start");
            Label_0017:
                num3 = 3;
                list.Add("SunJavaUpdateSched");
            Label_0025:
                num3 = 4;
                list.Add("Java(tm) Plug-In 2 SSV Helper");
            Label_0033:
                num3 = 5;
                List<string>.Enumerator enumerator = list.GetEnumerator();
                while (enumerator.MoveNext())
                {
                    string current = enumerator.Current;
                Label_004A:
                    ProjectData.ClearProjectError();
                    num = 1;
                Label_0051:
                    num3 = 7;
                    MyProject.Computer.Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Windows\CurrentVersion\Run", true).DeleteValue(current);
                Label_0074:
                    ProjectData.ClearProjectError();
                    num = 1;
                Label_007B:
                    num3 = 9;
                    MyProject.Computer.Registry.CurrentUser.OpenSubKey(@"Software\Microsoft\Windows\CurrentVersion\Run", true).DeleteValue(current);
                Label_009F:
                    ProjectData.ClearProjectError();
                    num = 1;
                Label_00A6:
                    num3 = 11;
                    MyProject.Computer.Registry.LocalMachine.OpenSubKey(@"Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Run", true).DeleteValue(current);
                Label_00CA:
                    ProjectData.ClearProjectError();
                    num = 1;
                Label_00D1:
                    num3 = 13;
                    MyProject.Computer.Registry.CurrentUser.OpenSubKey(@"Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Run", true).DeleteValue(current);
                Label_00F5:
                    num3 = 14;
                }
                enumerator.Dispose();
                goto Label_01A5;
            Label_0117:
                num2 = 0;
                switch ((num2 + 1))
                {
                    case 1:
                        goto Label_0000;

                    case 2:
                        goto Label_0009;

                    case 3:
                        goto Label_0017;

                    case 4:
                        goto Label_0025;

                    case 5:
                        goto Label_0033;

                    case 6:
                        goto Label_004A;

                    case 7:
                        goto Label_0051;

                    case 8:
                        goto Label_0074;

                    case 9:
                        goto Label_007B;

                    case 10:
                        goto Label_009F;

                    case 11:
                        goto Label_00A6;

                    case 12:
                        goto Label_00CA;

                    case 13:
                        goto Label_00D1;

                    case 14:
                        goto Label_00F5;

                    case 15:
                        goto Label_01A5;

                    default:
                        goto Label_019A;
                }
            Label_0165:
                num2 = num3;
                switch (num)
                {
                    case 0:
                        goto Label_019A;

                    case 1:
                        goto Label_0117;
                }
            }
            catch (Exception exception1) when (?)
            {
                ProjectData.SetProjectError(exception1);
                goto Label_0165;
            }
        Label_019A:
            throw ProjectData.CreateProjectError(-2146828237);
        Label_01A5:
            if (num2 != 0)
            {
                ProjectData.ClearProjectError();
            }
        }

        public static void delete_key(string key)
        {
            if (Functions.RegKeyExists(key))
            {
                try
                {
                    string oldValue = key.Remove(0, key.LastIndexOf(@"\")).Trim(new char[] { '\\' });
                    string str2 = "NULL";
                    string name = "NULL";
                    if (key.StartsWith(@"HKLM\"))
                    {
                        str2 = "HKLM";
                        name = key.Replace(@"HKLM\", "").Replace(oldValue, "").Trim(new char[] { '\\' });
                    }
                    if (key.StartsWith(@"HKCR\"))
                    {
                        str2 = "HKCR";
                        name = key.Replace(@"HKCR\", "").Replace(oldValue, "").Trim(new char[] { '\\' });
                    }
                    if (key.StartsWith(@"HKCU\"))
                    {
                        str2 = "HKCU";
                        name = key.Replace(@"HKCU\", "").Replace(oldValue, "").Trim(new char[] { '\\' });
                    }
                    if (key.StartsWith(@"HKUS\"))
                    {
                        str2 = "HKUS";
                        name = key.Replace(@"HKUS\", "").Replace(oldValue, "").Trim(new char[] { '\\' });
                    }
                    RegistryKey key2 = Registry.LocalMachine.OpenSubKey("NULL", true);
                    switch (str2)
                    {
                        case "HKLM":
                            key2 = Registry.LocalMachine.OpenSubKey(name, true);
                            break;

                        case "HKCR":
                            key2 = Registry.ClassesRoot.OpenSubKey(name, true);
                            break;

                        case "HKCU":
                            key2 = Registry.CurrentUser.OpenSubKey(name, true);
                            break;

                        case "HKUS":
                            key2 = Registry.Users.OpenSubKey(name, true);
                            break;
                    }
                    try
                    {
                        key2.DeleteSubKey(oldValue, true);
                        Functions.write_log(routines_locales.get_string("Removed registry subkey:") + " " + oldValue);
                        MyProject.Forms.UI.removal_count++;
                    }
                    catch (InvalidOperationException exception1)
                    {
                        ProjectData.SetProjectError(exception1);
                        InvalidOperationException exception = exception1;
                        key2.DeleteSubKeyTree(oldValue);
                        Functions.write_log(routines_locales.get_string("Removed registry subkey tree:") + " " + oldValue);
                        MyProject.Forms.UI.removal_count++;
                        ProjectData.ClearProjectError();
                    }
                    key2.Close();
                }
                catch (Exception exception3)
                {
                    ProjectData.SetProjectError(exception3);
                    Exception exception2 = exception3;
                    Functions.write_error(exception2);
                    ProjectData.ClearProjectError();
                }
            }
        }

        public static void get_jre_uninstallers()
        {
            MyProject.Forms.UI.JREObjectList.Clear();
            List<RegistryKey> list = new List<RegistryKey> {
                Registry.LocalMachine.OpenSubKey(@"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"),
                Registry.CurrentUser.OpenSubKey(@"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall")
            };
            if (Environment.GetEnvironmentVariable("PROCESSOR_ARCHITECTURE") == "AMD64")
            {
                list.Add(Registry.LocalMachine.OpenSubKey(@"SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"));
            }
            try
            {
                List<RegistryKey>.Enumerator enumerator;
                try
                {
                    enumerator = list.GetEnumerator();
                    while (enumerator.MoveNext())
                    {
                        RegistryKey key3 = enumerator.Current;
                        string[] subKeyNames = key3.GetSubKeyNames();
                        int num3 = subKeyNames.Length - 1;
                        for (int i = 0; i <= num3; i++)
                        {
                            RegistryKey key = key3.OpenSubKey(subKeyNames[i]);
                            if (key.GetValue("DisplayName") != null)
                            {
                                string str2;
                                string str3;
                                string name = Conversions.ToString(key.GetValue("DisplayName"));
                                if (key.GetValue("DisplayVersion") != null)
                                {
                                    str3 = Conversions.ToString(key.GetValue("DisplayVersion"));
                                }
                                else
                                {
                                    str3 = routines_locales.get_string("Data Unavailable");
                                }
                                if (key.GetValue("UninstallString") == null)
                                {
                                    str2 = "";
                                }
                                else
                                {
                                    str2 = Conversions.ToString(key.GetValue("UninstallString"));
                                }
                                if (name.StartsWith("Java(TM) 6") | name.ToString().StartsWith("Java 6 Update"))
                                {
                                    MyProject.Forms.UI.JREObjectList.Add(new JREInstallObject(name, str3, str2));
                                }
                                if (name.StartsWith("Java(TM) 7") | name.ToString().StartsWith("Java 7 Update"))
                                {
                                    MyProject.Forms.UI.JREObjectList.Add(new JREInstallObject(name, str3, str2));
                                }
                                if (name.StartsWith("Java(TM) 8") | name.ToString().StartsWith("Java 8 Update"))
                                {
                                    MyProject.Forms.UI.JREObjectList.Add(new JREInstallObject(name, str3, str2));
                                }
                            }
                        }
                    }
                }
                finally
                {
                    enumerator.Dispose();
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

        public static void output_jre_version()
        {
            string path = Path.GetDirectoryName(Assembly.GetEntryAssembly().Location) + @"\version-output.log";
            Functions.DeleteIfPermitted(path);
            try
            {
                TextWriter writer = File.AppendText(path);
                writer.WriteLine("Installed JRE Versions:" + Environment.NewLine + "========================");
                foreach (JREInstallObject obj2 in MyProject.Forms.UI.JREObjectList)
                {
                    try
                    {
                        if (Conversions.ToBoolean(obj2.Installed))
                        {
                            writer.WriteLine(Operators.ConcatenateObject(Operators.ConcatenateObject(obj2.Name, " version: "), obj2.Version));
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
                writer.Close();
                Process.Start(path);
            }
            catch (Exception exception3)
            {
                ProjectData.SetProjectError(exception3);
                Exception exception2 = exception3;
                Functions.write_error(exception2);
                ProjectData.ClearProjectError();
            }
        }
    }
}

