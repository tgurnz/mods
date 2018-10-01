namespace JavaRa
{
    using JavaRa.My;
    using Microsoft.VisualBasic;
    using Microsoft.VisualBasic.CompilerServices;
    using Microsoft.Win32;
    using System;
    using System.IO;
    using System.Reflection;
    using System.Runtime.CompilerServices;
    using System.Runtime.InteropServices;

    [StandardModule]
    internal sealed class Functions
    {
        public static void DeleteIfPermitted(string path)
        {
            try
            {
                if (MyProject.Computer.FileSystem.FileExists(path) && !FileInUse(path))
                {
                    MyProject.Computer.FileSystem.DeleteFile(path);
                }
            }
            catch (Exception exception1)
            {
                ProjectData.SetProjectError(exception1);
                Exception exception = exception1;
                ProjectData.ClearProjectError();
            }
        }

        [MethodImpl(MethodImplOptions.NoOptimization | MethodImplOptions.NoInlining)]
        public static bool FileInUse(string sFile)
        {
            if (File.Exists(sFile))
            {
                try
                {
                    short fileNumber = (short) FileSystem.FreeFile();
                    FileSystem.FileOpen(fileNumber, sFile, OpenMode.Binary, OpenAccess.ReadWrite, OpenShare.LockReadWrite, -1);
                    FileSystem.FileClose(new int[] { fileNumber });
                }
                catch (Exception exception1)
                {
                    ProjectData.SetProjectError(exception1);
                    ProjectData.ClearProjectError();
                    return true;
                }
            }
            return false;
        }

        public static bool RegKeyExists(string key)
        {
            bool flag;
            try
            {
                RegistryKey key2;
                if (key.EndsWith(@"\"))
                {
                    key = key.TrimEnd(new char[] { '\\' });
                }
                string str = key;
                if (key.StartsWith(@"HKLM\"))
                {
                    key = key.Replace(@"HKLM\", "");
                    key2 = Registry.LocalMachine.OpenSubKey(key, true);
                }
                else if (key.StartsWith(@"HKCU\"))
                {
                    key = key.Replace(@"HKCU\", "");
                    key2 = Registry.CurrentUser.OpenSubKey(key, true);
                }
                else if (key.StartsWith(@"HKCR\"))
                {
                    key = key.Replace(@"HKCR\", "");
                    key2 = Registry.ClassesRoot.OpenSubKey(key, true);
                }
                else if (key.StartsWith(@"HKCC\"))
                {
                    key = key.Replace(@"HKCC\", "");
                    key2 = Registry.CurrentConfig.OpenSubKey(key, true);
                }
                else if (key.StartsWith(@"HKUS\"))
                {
                    key = key.Replace(@"HKUS\", "");
                    key2 = Registry.Users.OpenSubKey(key, true);
                }
                else
                {
                    key2 = null;
                }
                if (key2 == null)
                {
                    if (str.StartsWith(@"HKLM\"))
                    {
                        str = str.Replace(@"HKLM\", @"HKEY_LOCAL_MACHINE\");
                    }
                    else if (key.StartsWith(@"HKCU\"))
                    {
                        str = str.Replace(@"HKCU\", @"HKEY_CURRENT_USER\");
                    }
                    else if (str.StartsWith(@"HKCR\"))
                    {
                        str = str.Replace(@"HKCR\", @"HKEY_CLASSES_ROOT\");
                    }
                    else if (str.StartsWith(@"HKUS\"))
                    {
                        str = str.Replace(@"HKUS\", @"HKEY_USERS\");
                    }
                    else if (str.StartsWith(@"HKCC\"))
                    {
                        str = str.Replace(@"HKCC\", @"HKEY_CURRENT_CONFIG\");
                    }
                    string str2 = Conversions.ToString(str.LastIndexOf(@"\"));
                    string valueName = str.Remove(0, (int) Math.Round((double) (Conversions.ToDouble(str2) + 1.0)));
                    if (RuntimeHelpers.GetObjectValue(Registry.GetValue(str.Remove(Conversions.ToInteger(str2)), valueName, null)) == null)
                    {
                        return false;
                    }
                    return true;
                }
                flag = true;
            }
            catch (Exception exception1)
            {
                ProjectData.SetProjectError(exception1);
                Exception exception = exception1;
                flag = false;
                ProjectData.ClearProjectError();
            }
            return flag;
        }

        public static string sanitze_str(string filename, bool allowSpaces = false)
        {
            filename = filename.Replace("[", "");
            filename = filename.Replace("*]", "");
            if (!allowSpaces)
            {
                filename = filename.Replace(" ", "");
            }
            filename = filename.Replace(")", "");
            filename = filename.Replace("(", "");
            filename = filename.Replace("/", "-");
            filename = filename.Replace(@"\", "-");
            filename = filename.Replace(":", "");
            filename = filename.Replace(".", "");
            filename = filename.Replace("'", "");
            return filename;
        }

        public static void write_error(Exception error_object)
        {
            try
            {
                string name = Assembly.GetCallingAssembly().GetName().Name;
                string message = error_object.Message;
                string stackTrace = error_object.StackTrace;
                write_log("Exception encountered in module [" + name + "]" + Environment.NewLine + "Message: " + message + Environment.NewLine + stackTrace + Environment.NewLine);
            }
            catch (Exception exception1)
            {
                ProjectData.SetProjectError(exception1);
                Exception exception = exception1;
                ProjectData.ClearProjectError();
            }
        }

        public static void write_log(string message)
        {
            try
            {
                TextWriter writer = File.AppendText(Path.GetDirectoryName(Assembly.GetEntryAssembly().Location) + @"\JavaRa-" + sanitze_str(Conversions.ToString(DateTime.Today), false) + ".log");
                writer.WriteLine(message);
                writer.Close();
            }
            catch (Exception exception1)
            {
                ProjectData.SetProjectError(exception1);
                Exception exception = exception1;
                ProjectData.ClearProjectError();
            }
        }
    }
}

