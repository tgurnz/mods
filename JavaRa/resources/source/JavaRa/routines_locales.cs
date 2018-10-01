namespace JavaRa
{
    using JavaRa.My;
    using Microsoft.VisualBasic.CompilerServices;
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.IO;
    using System.Reflection;
    using System.Windows.Forms;

    [StandardModule]
    internal sealed class routines_locales
    {
        private static List<string> current_language_array = new List<string>();
        internal static string language;
        internal static List<string> untranslated_strings = new List<string>();

        public static string get_string(string initial_string)
        {
            if (language != "English")
            {
                if (initial_string == "Remove Java Runtime")
                {
                    initial_string = "Remove JRE";
                }
                foreach (string str3 in current_language_array)
                {
                    if (str3.StartsWith(initial_string + "|"))
                    {
                        return str3.Replace(initial_string + "|", "");
                    }
                }
                if (File.Exists(Path.GetDirectoryName(Assembly.GetEntryAssembly().Location) + @"\localizations\output_strings.true"))
                {
                    untranslated_strings.Add(initial_string);
                }
            }
            return initial_string;
        }

        public static void GetMenues(ToolStripMenuItem Current, ref List<ToolStripMenuItem> menues)
        {
            IEnumerator enumerator;
            menues.Add(Current);
            try
            {
                enumerator = Current.DropDownItems.GetEnumerator();
                while (enumerator.MoveNext())
                {
                    ToolStripMenuItem current = (ToolStripMenuItem) enumerator.Current;
                    GetMenues(current, ref menues);
                }
            }
            finally
            {
                if (enumerator is IDisposable)
                {
                    (enumerator as IDisposable).Dispose();
                }
            }
        }

        public static void translate_strings()
        {
            string path = Path.GetDirectoryName(Assembly.GetEntryAssembly().Location) + @"\localizations\lang." + language + ".locale";
            try
            {
                if (File.Exists(path))
                {
                    current_language_array.Clear();
                    string item = null;
                    StreamReader reader = new StreamReader(path);
                    while (reader.Peek() > -1)
                    {
                        item = reader.ReadLine().ToString();
                        if (!item.StartsWith("//*"))
                        {
                            current_language_array.Add(item);
                        }
                    }
                }
                TranslateControl(MyProject.Forms.UI);
                MyProject.Forms.UI.btnSettings.Text = get_string("Settings");
                MyProject.Forms.UI.btnAbout.Text = get_string("About JavaRa");
                MyProject.Forms.UI.lblVersion.Text = get_string("version") + " " + Application.ProductVersion.Replace(".0.0", "");
                MyProject.Forms.UI.Label5.Text = get_string("The removal routine will delete files, folder and registry entries that are known" + Environment.NewLine + get_string("to be associated with the older versions of the Java Runtime Environment"));
                MyProject.Forms.UI.Label12.Text = get_string("Would you like to download and install the latest version of JRE? ") + Environment.NewLine + get_string("Use this interface.");
                MyProject.Forms.UI.lblStep1.Text = get_string("We recommend that you try running the Java Runtime Environment's built-in") + Environment.NewLine + get_string("uninstaller before you continue.");
            }
            catch (Exception exception1)
            {
                ProjectData.SetProjectError(exception1);
                Exception exception = exception1;
                Functions.write_error(exception);
                ProjectData.ClearProjectError();
            }
        }

        public static void TranslateControl(Control Ctrl)
        {
            IEnumerator enumerator;
            try
            {
                enumerator = Ctrl.Controls.GetEnumerator();
                while (enumerator.MoveNext())
                {
                    Control current = (Control) enumerator.Current;
                    if (current.Text != "")
                    {
                        current.Text = get_string(current.Text.Replace("  ", ""));
                    }
                    TranslateControl(current);
                }
            }
            finally
            {
                if (enumerator is IDisposable)
                {
                    (enumerator as IDisposable).Dispose();
                }
            }
        }
    }
}

