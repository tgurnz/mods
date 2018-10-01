namespace JavaRa
{
    using JavaRa.My;
    using JavaRa.My.Resources;
    using Microsoft.VisualBasic;
    using Microsoft.VisualBasic.CompilerServices;
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.Diagnostics;
    using System.Drawing;
    using System.IO;
    using System.Net;
    using System.Reflection;
    using System.Runtime.CompilerServices;
    using System.Threading;
    using System.Windows.Forms;

    [DesignerGenerated]
    public class UI : Form
    {
        [AccessedThroughProperty("BackgroundWorker1")]
        private BackgroundWorker _BackgroundWorker1;
        [AccessedThroughProperty("boxDownloadJRE")]
        private RadioButton _boxDownloadJRE;
        [AccessedThroughProperty("boxJucheck")]
        private RadioButton _boxJucheck;
        [AccessedThroughProperty("boxLanguage")]
        private ComboBox _boxLanguage;
        [AccessedThroughProperty("boxOnlineCheck")]
        private RadioButton _boxOnlineCheck;
        [AccessedThroughProperty("boxPreserveUISize")]
        private CheckBox _boxPreserveUISize;
        [AccessedThroughProperty("boxUpdateCheck")]
        private CheckBox _boxUpdateCheck;
        [AccessedThroughProperty("btnAbout")]
        private ToolStripButton _btnAbout;
        [AccessedThroughProperty("btnCleanup")]
        private Button _btnCleanup;
        [AccessedThroughProperty("btnCloseApp")]
        private RadioButton _btnCloseApp;
        [AccessedThroughProperty("btnCloseWiz")]
        private RadioButton _btnCloseWiz;
        [AccessedThroughProperty("btnDownload")]
        private Button _btnDownload;
        [AccessedThroughProperty("btnPrev1")]
        private Button _btnPrev1;
        [AccessedThroughProperty("btnRemoveKeys")]
        private Button _btnRemoveKeys;
        [AccessedThroughProperty("btnRun")]
        private Button _btnRun;
        [AccessedThroughProperty("btnRunUninstaller")]
        private Button _btnRunUninstaller;
        [AccessedThroughProperty("btnSave")]
        private Button _btnSave;
        [AccessedThroughProperty("btnSaveLang")]
        private Button _btnSaveLang;
        [AccessedThroughProperty("btnSettings")]
        private ToolStripButton _btnSettings;
        [AccessedThroughProperty("btnStep1")]
        private Button _btnStep1;
        [AccessedThroughProperty("btnStep2")]
        private Button _btnStep2;
        [AccessedThroughProperty("btnUpdateDefs")]
        private Button _btnUpdateDefs;
        [AccessedThroughProperty("btnUpdateJavaPrevious")]
        private Button _btnUpdateJavaPrevious;
        [AccessedThroughProperty("btnUpdateNext")]
        private Button _btnUpdateNext;
        [AccessedThroughProperty("Button1")]
        private Button _Button1;
        [AccessedThroughProperty("Button11")]
        private Button _Button11;
        [AccessedThroughProperty("Button12")]
        private Button _Button12;
        [AccessedThroughProperty("Button2")]
        private Button _Button2;
        [AccessedThroughProperty("Button3")]
        private Button _Button3;
        [AccessedThroughProperty("Button4")]
        private Button _Button4;
        [AccessedThroughProperty("Button5")]
        private Button _Button5;
        [AccessedThroughProperty("Button7")]
        private Button _Button7;
        [AccessedThroughProperty("Button8")]
        private Button _Button8;
        [AccessedThroughProperty("Button9")]
        private Button _Button9;
        [AccessedThroughProperty("cboVersion")]
        private ComboBox _cboVersion;
        [AccessedThroughProperty("ExecutableImages")]
        private ImageList _ExecutableImages;
        [AccessedThroughProperty("Label10")]
        private Label _Label10;
        [AccessedThroughProperty("Label11")]
        private Label _Label11;
        [AccessedThroughProperty("Label12")]
        private Label _Label12;
        [AccessedThroughProperty("Label14")]
        private Label _Label14;
        [AccessedThroughProperty("Label16")]
        private Label _Label16;
        [AccessedThroughProperty("Label19")]
        private Label _Label19;
        [AccessedThroughProperty("Label21")]
        private Label _Label21;
        [AccessedThroughProperty("Label3")]
        private Label _Label3;
        [AccessedThroughProperty("Label4")]
        private Label _Label4;
        [AccessedThroughProperty("Label5")]
        private Label _Label5;
        [AccessedThroughProperty("Label6")]
        private Label _Label6;
        [AccessedThroughProperty("Label7")]
        private Label _Label7;
        [AccessedThroughProperty("Label9")]
        private Label _Label9;
        [AccessedThroughProperty("lblCompleted")]
        private Label _lblCompleted;
        [AccessedThroughProperty("lblDownloadNewVersion")]
        private Label _lblDownloadNewVersion;
        [AccessedThroughProperty("lblStep1")]
        private Label _lblStep1;
        [AccessedThroughProperty("lblStep2")]
        private Label _lblStep2;
        [AccessedThroughProperty("lblStepOne")]
        private Label _lblStepOne;
        [AccessedThroughProperty("lblTitle")]
        private Label _lblTitle;
        [AccessedThroughProperty("lblUpdateDefs")]
        private Label _lblUpdateDefs;
        [AccessedThroughProperty("lblVersion")]
        private Label _lblVersion;
        [AccessedThroughProperty("lbTasks")]
        private CheckedListBox _lbTasks;
        [AccessedThroughProperty("LinkLabel1")]
        private LinkLabel _LinkLabel1;
        [AccessedThroughProperty("lvTools")]
        private ListView _lvTools;
        [AccessedThroughProperty("Panel1")]
        private Panel _Panel1;
        [AccessedThroughProperty("Panel11")]
        private Panel _Panel11;
        [AccessedThroughProperty("Panel12")]
        private Panel _Panel12;
        [AccessedThroughProperty("Panel13")]
        private Panel _Panel13;
        [AccessedThroughProperty("Panel2")]
        private Panel _Panel2;
        [AccessedThroughProperty("Panel3")]
        private Panel _Panel3;
        [AccessedThroughProperty("Panel4")]
        private Panel _Panel4;
        [AccessedThroughProperty("Panel5")]
        private Panel _Panel5;
        [AccessedThroughProperty("Panel6")]
        private Panel _Panel6;
        [AccessedThroughProperty("Panel7")]
        private Panel _Panel7;
        [AccessedThroughProperty("Panel8")]
        private Panel _Panel8;
        [AccessedThroughProperty("Panel9")]
        private Panel _Panel9;
        [AccessedThroughProperty("PanelExtra")]
        private Panel _PanelExtra;
        [AccessedThroughProperty("PanelSettings")]
        private Panel _PanelSettings;
        [AccessedThroughProperty("pnlAbout")]
        private Panel _pnlAbout;
        [AccessedThroughProperty("pnlCleanup")]
        private Panel _pnlCleanup;
        [AccessedThroughProperty("pnlCompleted")]
        private Panel _pnlCompleted;
        [AccessedThroughProperty("pnlDownload")]
        private Panel _pnlDownload;
        [AccessedThroughProperty("pnlRemoval")]
        private Panel _pnlRemoval;
        [AccessedThroughProperty("pnlTopDock")]
        private Panel _pnlTopDock;
        [AccessedThroughProperty("pnlUpdate")]
        private Panel _pnlUpdate;
        [AccessedThroughProperty("pnlUpdateJRE")]
        private Panel _pnlUpdateJRE;
        [AccessedThroughProperty("ProgressBar1")]
        private ProgressBar _ProgressBar1;
        [AccessedThroughProperty("ProgressBar2")]
        private ProgressBar _ProgressBar2;
        [AccessedThroughProperty("ProgressBar3")]
        private ProgressBar _ProgressBar3;
        [AccessedThroughProperty("ProgressBar4")]
        private ProgressBar _ProgressBar4;
        [AccessedThroughProperty("Step1")]
        private Panel _Step1;
        [AccessedThroughProperty("ToolStrip1")]
        private ToolStrip _ToolStrip1;
        [AccessedThroughProperty("ToolTip1")]
        private ToolTip _ToolTip1;
        [AccessedThroughProperty("txtFileName")]
        private TextBox _txtFileName;
        private IContainer components;
        private string config_file;
        public List<JREInstallObject> JREObjectList;
        private bool reboot;
        internal int removal_count;
        internal bool stay_silent;
        private HttpWebRequest theRequest;
        private HttpWebResponse theResponse;
        private bool vendor_integration;
        private string version_number;
        private string whereToSave;

        public UI()
        {
            base.Load += new EventHandler(this.Form1_Load);
            base.FormClosed += new FormClosedEventHandler(this.UI_FormClosed);
            base.FormClosing += new FormClosingEventHandler(this.UI_FormClosing);
            this.version_number = "020500";
            this.stay_silent = false;
            this.reboot = false;
            this.removal_count = 0;
            this.config_file = Path.GetDirectoryName(Assembly.GetEntryAssembly().Location) + @"\config.ini";
            this.JREObjectList = new List<JREInstallObject>();
            this.vendor_integration = false;
            this.InitializeComponent();
        }

        private void BackgroundWorker1_DoWork(object sender, DoWorkEventArgs e)
        {
            HttpWebResponse response;
            HttpWebRequest request = (HttpWebRequest) WebRequest.Create(this.txtFileName.Text);
            try
            {
                response = (HttpWebResponse) request.GetResponse();
            }
            catch (Exception exception1)
            {
                ProjectData.SetProjectError(exception1);
                Exception exception = exception1;
                MessageBox.Show(routines_locales.get_string("An error occurred while downloading file. Possible causes:") + "\r\n" + routines_locales.get_string("1) File doesn't exist") + "\r\n" + routines_locales.get_string("2) Remote server error"), routines_locales.get_string("Error"), MessageBoxButtons.OK, MessageBoxIcon.Hand);
                DownloadCompleteSafe safe3 = new DownloadCompleteSafe(this.DownloadComplete);
                this.Invoke(safe3, new object[] { true });
                ProjectData.ClearProjectError();
                return;
            }
            if (System.IO.File.Exists(this.whereToSave))
            {
                Functions.DeleteIfPermitted(this.whereToSave);
            }
            long contentLength = response.ContentLength;
            if (contentLength < 1L)
            {
                contentLength = 0x86470L;
            }
            ChangeTextsSafe method = new ChangeTextsSafe(this.ChangeTexts);
            this.Invoke(method, new object[] { contentLength, 0, 0, 0 });
            FileStream stream = new FileStream(this.whereToSave, FileMode.Create);
            double num = -1.0;
        Label_0154:
            if (this.BackgroundWorker1.CancellationPending)
            {
                System.IO.File.Delete(this.whereToSave);
                DownloadCompleteSafe safe4 = new DownloadCompleteSafe(this.DownloadComplete);
                this.Invoke(safe4, new object[] { true });
            }
            else
            {
                int num3;
                byte[] buffer = new byte[0x1000];
                int count = response.GetResponseStream().Read(buffer, 0, 0x1000);
                num3 += count;
                short num5 = (short) this.ProgressBar2.Value;
                try
                {
                    num5 = (short) Math.Round((double) (((double) (num3 * 100)) / ((double) contentLength)));
                }
                catch (Exception exception3)
                {
                    ProjectData.SetProjectError(exception3);
                    Exception exception2 = exception3;
                    ProjectData.ClearProjectError();
                }
                this.Invoke(method, new object[] { contentLength, num3, num5, num });
                if (count != 0)
                {
                    stream.Write(buffer, 0, count);
                    goto Label_0154;
                }
                response.GetResponseStream().Close();
                stream.Close();
                DownloadCompleteSafe safe = new DownloadCompleteSafe(this.DownloadComplete);
                this.Invoke(safe, new object[] { false });
            }
        }

        private void boxLanguage_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (this.boxLanguage.Text != routines_locales.language)
            {
                this.btnSaveLang.Enabled = true;
            }
            else
            {
                this.btnSaveLang.Enabled = false;
            }
        }

        private void btnAbout_Click_1(object sender, EventArgs e)
        {
            routines_interface.show_panel(this.pnlAbout, false);
        }

        private void btnCleanup_Click(object sender, EventArgs e)
        {
            routines_interface.cleanup_old_jre();
        }

        private void btnDownload_Click(object sender, EventArgs e)
        {
            this.Cursor = Cursors.WaitCursor;
            try
            {
                this.theRequest = (HttpWebRequest) WebRequest.Create("http://content.thewebatom.net/files/confirm.txt");
                this.theResponse = (HttpWebResponse) this.theRequest.GetResponse();
                if (Directory.Exists(@"C:\Program Files (x86)"))
                {
                    this.txtFileName.Text = "http://singularlabs.com/download/jrex64/latest/";
                }
                else
                {
                    this.txtFileName.Text = "http://singularlabs.com/download/jrex86/latest/";
                }
            }
            catch (Exception exception1)
            {
                ProjectData.SetProjectError(exception1);
                Exception exception = exception1;
                MessageBox.Show(routines_locales.get_string("Could not make a connection to download server. Please see our online help for assistance.") + Environment.NewLine + routines_locales.get_string("This error can be caused by incorrect proxy settings or a security product conflict."), routines_locales.get_string("An error was encountered."), MessageBoxButtons.OK, MessageBoxIcon.Hand);
                this.Cursor = Cursors.Default;
                this.btnDownload.Enabled = false;
                ProjectData.ClearProjectError();
                return;
            }
            this.whereToSave = MyProject.Computer.FileSystem.SpecialDirectories.Temp + @"\java-installer.exe";
            this.txtFileName.Enabled = false;
            this.btnDownload.Enabled = false;
            this.Button1.Enabled = false;
            this.Button4.Enabled = false;
            this.BackgroundWorker1.RunWorkerAsync();
        }

        private void btnPrev1_Click(object sender, EventArgs e)
        {
            routines_interface.show_panel(this.Step1, false);
        }

        private void btnRemoveKeys_Click(object sender, EventArgs e)
        {
            routines_interface.purge_jre();
        }

        private void btnRun_Click(object sender, EventArgs e)
        {
            if (this.lbTasks.CheckedItems.Count == 0)
            {
                this.ToolTip1.Show(routines_locales.get_string("You didn't select any tasks to be performed."), this.lblTitle);
            }
            else
            {
                if (this.lbTasks.CheckedItems.Contains(routines_locales.get_string("Remove startup entry")))
                {
                    routines_registry.delete_jre_startup_entries();
                }
                if (this.lbTasks.CheckedItems.Contains(routines_locales.get_string("Check Java version")))
                {
                    routines_registry.output_jre_version();
                }
                if (this.lbTasks.CheckedItems.Contains(routines_locales.get_string("Remove Outdated JRE Firefox Extensions")))
                {
                    routines_interface.delete_jre_firefox_extensions();
                }
                if (this.lbTasks.CheckedItems.Contains(routines_locales.get_string("Clean JRE Temp Files")))
                {
                    routines_interface.clean_jre_temp_files();
                }
                this.ToolTip1.Show(routines_locales.get_string(routines_locales.get_string("Selected tasks completed successfully.")), this.lblTitle);
            }
        }

        private void btnRunUninstaller_Click(object sender, EventArgs e)
        {
            List<JREInstallObject>.Enumerator enumerator;
            if (this.cboVersion.Text == "")
            {
                MessageBox.Show(routines_locales.get_string("Please select a version of JRE to remove."));
            }
            try
            {
                enumerator = this.JREObjectList.GetEnumerator();
                while (enumerator.MoveNext())
                {
                    JREInstallObject current = enumerator.Current;
                    if (Operators.ConditionalCompareObjectEqual(current.Name, this.cboVersion.Text, false))
                    {
                        try
                        {
                            if (Operators.ConditionalCompareObjectEqual(current.Installed, true, false))
                            {
                                Interaction.Shell(Conversions.ToString(current.UninstallString), AppWinStyle.NormalFocus, true, -1);
                                this.cboVersion.Items.Remove(RuntimeHelpers.GetObjectValue(current.Name));
                                current.Installed = false;
                                if (this.cboVersion.Items.Count == 0)
                                {
                                    this.cboVersion.Enabled = false;
                                    this.btnRunUninstaller.Enabled = false;
                                }
                            }
                            continue;
                        }
                        catch (Exception exception1)
                        {
                            ProjectData.SetProjectError(exception1);
                            Exception exception = exception1;
                            if (!this.stay_silent)
                            {
                                MessageBox.Show(routines_locales.get_string("Could not locatate uninstaller for") + " " + this.cboVersion.Text, routines_locales.get_string("Uninstaller not found"), MessageBoxButtons.OK, MessageBoxIcon.Hand);
                            }
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

        private void btnSaveLang_Click(object sender, EventArgs e)
        {
            string language = routines_locales.language;
            routines_locales.language = this.boxLanguage.Text;
            if (language != routines_locales.language)
            {
                if (language == "English")
                {
                    routines_locales.translate_strings();
                    this.render_ui();
                }
                else
                {
                    MessageBox.Show(routines_locales.get_string("Your changes will take effect when JavaRa is restarted."));
                    this.reboot_app();
                    this.Close();
                }
            }
        }

        private void btnSettings_Click(object sender, EventArgs e)
        {
            routines_interface.show_panel(this.PanelSettings, false);
        }

        private void btnStep1_Click(object sender, EventArgs e)
        {
            routines_interface.show_panel(this.pnlRemoval, false);
        }

        private void btnStep2_Click(object sender, EventArgs e)
        {
            routines_interface.show_panel(this.pnlDownload, false);
        }

        private void btnUpdateDefs_click(object sender, EventArgs e)
        {
            this.download_defs();
        }

        private void btnUpdateNext_Click(object sender, EventArgs e)
        {
            if (this.boxOnlineCheck.Checked)
            {
                if (MessageBox.Show(routines_locales.get_string("Would you like to open the Oracle online JRE version checker?"), routines_locales.get_string("Launch online check"), MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                {
                    if (routines_locales.language == "French")
                    {
                        Process.Start("http://java.com/fr/download/installed.jsp");
                        return;
                    }
                    if (routines_locales.language == "Brazilian")
                    {
                        Process.Start("http://java.com/pt_BR/download/installed.jsp");
                        return;
                    }
                    if (routines_locales.language == "German")
                    {
                        Process.Start("http://java.com/de/download/installed.jsp");
                        return;
                    }
                    if (routines_locales.language == "Polish")
                    {
                        Process.Start("http://www.java.com/pl/download/installed.jsp");
                        return;
                    }
                    if (routines_locales.language == "Russian")
                    {
                        Process.Start("http://www.java.com/ru/download/installed.jsp");
                        return;
                    }
                    if (routines_locales.language == "Spanish")
                    {
                        Process.Start("http://www.java.com/es/download/installed.jsp");
                        return;
                    }
                    Process.Start("http://java.com/en/download/installed.jsp");
                    return;
                }
                routines_interface.show_panel(this.pnlCompleted, false);
                this.lblCompleted.Text = routines_locales.get_string("step 2 - completed.");
            }
            if (this.boxDownloadJRE.Checked)
            {
                routines_interface.show_panel(this.pnlDownload, false);
                this.lblDownloadNewVersion.Text = routines_locales.get_string("step 2 - download new version");
            }
            if (this.boxJucheck.Checked)
            {
                try
                {
                    string pathName = null;
                    if (MyProject.Computer.FileSystem.FileExists(@"C:\Program Files (x86)\Common Files\Java\Java Update\jucheck.exe"))
                    {
                        pathName = @"C:\Program Files (x86)\Common Files\Java\Java Update\jucheck.exe";
                    }
                    if (MyProject.Computer.FileSystem.FileExists(@"C:\Program Files\Common Files\Java\Java Update\jucheck.exe"))
                    {
                        pathName = @"C:\Program Files\Common Files\Java\Java Update\jucheck.exe";
                    }
                    if (pathName == null)
                    {
                        MessageBox.Show(routines_locales.get_string("Java Update Checking Utility (jucheck.exe) could not be found on your system."), routines_locales.get_string("Could not locate jucheck.exe"));
                    }
                    else
                    {
                        Interaction.Shell(pathName, AppWinStyle.NormalFocus, true, -1);
                    }
                    routines_interface.show_panel(this.pnlCleanup, false);
                    this.lblCompleted.Text = routines_locales.get_string("step 3 - completed.");
                }
                catch (Exception exception1)
                {
                    ProjectData.SetProjectError(exception1);
                    Exception exception = exception1;
                    Functions.write_error(exception);
                    ProjectData.ClearProjectError();
                }
            }
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            if (this.lblDownloadNewVersion.Text == routines_locales.get_string("step 3 - download new version"))
            {
                routines_interface.show_panel(this.pnlRemoval, false);
            }
            if (this.lblDownloadNewVersion.Text == routines_locales.get_string("step 2 - download new version"))
            {
                routines_interface.show_panel(this.pnlUpdateJRE, false);
            }
        }

        private void Button3_Click(object sender, EventArgs e)
        {
            routines_interface.show_panel(this.pnlUpdateJRE, false);
        }

        private void Button4_Click(object sender, EventArgs e)
        {
            this.ProgressBar2.Value = 0;
            this.ProgressBar3.Value = 0;
            routines_interface.show_panel(this.pnlCompleted, false);
            if (this.lblDownloadNewVersion.Text == routines_locales.get_string("step 3 - download new version"))
            {
                this.lblCompleted.Text = routines_locales.get_string("step 4 - completed.");
            }
            else if (this.lblDownloadNewVersion.Text == routines_locales.get_string("step 2 - download new version"))
            {
                this.lblCompleted.Text = routines_locales.get_string("step 3 - completed.");
            }
        }

        private void Button5_Click(object sender, EventArgs e)
        {
            routines_interface.show_panel(this.pnlCompleted, false);
        }

        private void Button7_Click(object sender, EventArgs e)
        {
            if (this.btnCloseWiz.Checked)
            {
                routines_interface.return_home();
                routines_registry.get_jre_uninstallers();
                this.lblCompleted.Text = routines_locales.get_string("step 4 - completed.");
            }
            else
            {
                this.Close();
            }
        }

        public void ChangeTexts(long length, int position, int percent, double speed)
        {
            this.ProgressBar2.Value = percent;
            this.ProgressBar3.Value = percent;
        }

        [MethodImpl(MethodImplOptions.NoOptimization | MethodImplOptions.NoInlining)]
        public void check_for_update()
        {
            try
            {
                string requestUriString = "http://content.thewebatom.net/updates/javara/version.tag";
                string path = MyProject.Computer.FileSystem.SpecialDirectories.Temp + @"\javaraversion.tag";
                Stream responseStream = WebRequest.Create(requestUriString).GetResponse().GetResponseStream();
                BinaryWriter writer = new BinaryWriter(new FileStream(path, FileMode.OpenOrCreate));
                byte[] buffer = new byte[0x1001];
                for (int i = responseStream.Read(buffer, 0, 0x1000); i > 0; i = responseStream.Read(buffer, 0, 0x1000))
                {
                    writer.Write(buffer, 0, i);
                }
                responseStream.Close();
                writer.Close();
                if (System.IO.File.Exists(path))
                {
                    StreamReader reader = new StreamReader(path);
                    while (reader.Peek() > -1)
                    {
                        string str3 = reader.ReadLine().ToString();
                        string str4 = this.version_number;
                        if (str3.Length != str4.Length)
                        {
                            ProjectData.EndApp();
                        }
                        if (Conversions.ToInteger(str3) > Conversions.ToInteger(str4))
                        {
                            this.show_threaded_dialog();
                        }
                    }
                }
            }
            catch (Exception exception1)
            {
                ProjectData.SetProjectError(exception1);
                Exception exception = exception1;
                ProjectData.ClearProjectError();
            }
        }

        [DebuggerNonUserCode]
        protected override void Dispose(bool disposing)
        {
            try
            {
                if (disposing && (this.components != null))
                {
                    this.components.Dispose();
                }
            }
            finally
            {
                base.Dispose(disposing);
            }
        }

        private void download_defs()
        {
            this.Cursor = Cursors.WaitCursor;
            try
            {
                this.theRequest = (HttpWebRequest) WebRequest.Create("http://content.thewebatom.net/files/confirm.txt");
                this.theResponse = (HttpWebResponse) this.theRequest.GetResponse();
                this.txtFileName.Text = "http://content.thewebatom.net/updates/javara/JavaRa.def";
            }
            catch (Exception exception1)
            {
                ProjectData.SetProjectError(exception1);
                Exception exception = exception1;
                MessageBox.Show(routines_locales.get_string("Could not make a connection to download server. Please see our online help for assistance.") + Environment.NewLine + routines_locales.get_string("This error can be caused by incorrect proxy settings or a security product conflict."), routines_locales.get_string("An error was encountered."), MessageBoxButtons.OK, MessageBoxIcon.Hand);
                this.Cursor = Cursors.Default;
                this.btnDownload.Enabled = false;
                ProjectData.ClearProjectError();
                return;
            }
            this.whereToSave = Path.GetDirectoryName(Assembly.GetEntryAssembly().Location) + @"\JavaRa.def";
            this.txtFileName.Enabled = false;
            this.btnUpdateDefs.Enabled = false;
            this.btnDownload.Enabled = false;
            if (this.stay_silent)
            {
                MyProject.Computer.Network.DownloadFile(this.txtFileName.Text, this.whereToSave, "", "", false, 100, true);
            }
            else
            {
                this.BackgroundWorker1.RunWorkerAsync();
            }
            this.Cursor = Cursors.Default;
        }

        public void DownloadComplete(bool cancelled)
        {
            this.txtFileName.Enabled = true;
            this.btnDownload.Enabled = true;
            if (cancelled)
            {
                MessageBox.Show(routines_locales.get_string("Download has been cancelled."), routines_locales.get_string("Cancelled."), MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
            }
            this.ProgressBar1.Value = 0;
            this.ProgressBar3.Value = 0;
            this.lblStep1.Text = "";
            if (this.whereToSave == (MyProject.Computer.FileSystem.SpecialDirectories.Temp + @"\java-installer.exe"))
            {
                if (System.IO.File.Exists(MyProject.Computer.FileSystem.SpecialDirectories.Temp + @"\java-installer.exe"))
                {
                    this.ProgressBar2.Value = 0x5f;
                    Interaction.Shell(MyProject.Computer.FileSystem.SpecialDirectories.Temp + @"\java-installer.exe", AppWinStyle.NormalFocus, true, -1);
                    this.ProgressBar2.Value = 100;
                    this.Button1.Enabled = true;
                    this.Button4.Enabled = true;
                }
            }
            else
            {
                this.ToolTip1.Show(routines_locales.get_string("JavaRa definitions updated successfully"), this.ToolStrip1);
            }
            this.Cursor = Cursors.Default;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            if (MyProject.Computer.FileSystem.FileExists(this.config_file))
            {
                try
                {
                    StreamReader reader = new StreamReader(this.config_file);
                    while (reader.Peek() > -1)
                    {
                        string str = reader.ReadLine().ToString();
                        if (str.StartsWith("Language:"))
                        {
                            routines_locales.language = str.Replace("Language:", "");
                        }
                        if (str == "UpdateCheck:False")
                        {
                            this.boxUpdateCheck.Checked = false;
                        }
                        if (str.StartsWith("WindowHeight:"))
                        {
                            this.boxPreserveUISize.Checked = true;
                            this.Height = Conversions.ToInteger(str.Replace("WindowHeight:", ""));
                        }
                        else if (str.StartsWith("WindowWidth:"))
                        {
                            this.boxPreserveUISize.Checked = true;
                            this.Width = Conversions.ToInteger(str.Replace("WindowWidth:", ""));
                        }
                    }
                    reader.Close();
                }
                catch (Exception exception1)
                {
                    ProjectData.SetProjectError(exception1);
                    Exception exception = exception1;
                    Functions.write_error(exception);
                    ProjectData.ClearProjectError();
                }
            }
            try
            {
                IEnumerator<string> enumerator;
                try
                {
                    enumerator = MyProject.Computer.FileSystem.GetFiles(Path.GetDirectoryName(Assembly.GetEntryAssembly().Location) + @"\localizations").GetEnumerator();
                    while (enumerator.MoveNext())
                    {
                        string current = enumerator.Current;
                        if (Path.GetExtension(current) == ".locale")
                        {
                            string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(current);
                            if (fileNameWithoutExtension.StartsWith("lang."))
                            {
                                this.boxLanguage.Items.Add(fileNameWithoutExtension.Replace("lang.", ""));
                            }
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
            catch (Exception exception3)
            {
                ProjectData.SetProjectError(exception3);
                Exception exception2 = exception3;
                Functions.write_error(exception2);
                ProjectData.ClearProjectError();
            }
            if (routines_locales.language == null)
            {
                routines_locales.language = "English";
                this.boxLanguage.Text = "English";
            }
            else
            {
                this.boxLanguage.Text = routines_locales.language;
                routines_locales.translate_strings();
            }
            if (MyProject.Application.CommandLineArgs.Count > 0)
            {
                foreach (string str4 in MyProject.Application.CommandLineArgs)
                {
                    if (str4.ToUpper() == "/SILENT")
                    {
                        this.Visible = false;
                        this.Opacity = 0.0;
                        this.ShowInTaskbar = false;
                        this.stay_silent = true;
                    }
                }
                if (!this.stay_silent)
                {
                    this.render_ui();
                }
                string str5 = MyProject.Application.CommandLineArgs[0].ToString().ToUpper();
                switch (str5)
                {
                    case "/PURGE":
                        if (this.stay_silent)
                        {
                            routines_interface.purge_jre();
                            this.Close();
                        }
                        else
                        {
                            routines_interface.purge_jre();
                        }
                        goto Label_051E;

                    case "/CLEAN":
                        if (this.stay_silent)
                        {
                            routines_interface.cleanup_old_jre();
                            this.Close();
                        }
                        else
                        {
                            routines_interface.cleanup_old_jre();
                        }
                        goto Label_051E;

                    case "/UNINSTALLALL":
                        if (this.stay_silent)
                        {
                            routines_interface.uninstall_all(this.stay_silent);
                            this.Close();
                        }
                        else
                        {
                            routines_interface.uninstall_all(false);
                        }
                        goto Label_051E;

                    case "/UPDATEDEFS":
                        if (this.stay_silent)
                        {
                            this.download_defs();
                            this.Close();
                        }
                        else
                        {
                            this.btnUpdateDefs.PerformClick();
                        }
                        goto Label_051E;

                    case "/SILENT":
                        MessageBox.Show(routines_locales.get_string("Syntax Error. /SILENT is a secondary option to be used in combination with other command line options.") + routines_locales.get_string("It should not be the first option used, nor should it be used alone. Use /? for more information."), routines_locales.get_string("Syntax Error."));
                        this.Close();
                        break;
                }
                if (str5 == "/SILENT")
                {
                    MessageBox.Show(routines_locales.get_string("Syntax Error. /SILENT is a secondary option to be used in combination with other command line options.") + routines_locales.get_string("It should not be the first option used, nor should it be used alone. Use /? for more information."), routines_locales.get_string("Syntax Error."));
                    this.Close();
                }
                else if (str5 == "/?")
                {
                    MessageBox.Show("/PURGE -\t\t" + routines_locales.get_string("Removes all JRE related registry keys, files and directories.") + "\r\n/CLEAN -\t\t" + routines_locales.get_string("Removes only JRE registry keys from previous version.") + "\r\n/UNINSTALLALL -\t" + routines_locales.get_string("Run the built-in uninstaller for all versions of JRE detected.") + "\r\n/UPDATEDEFS -\t" + routines_locales.get_string("Downloads a new copy of the JavaRa definitions.") + "\r\n/SILENT -\t\t" + routines_locales.get_string("Hides the graphical user interface and suppresses all dialog") + "\r\n\t\t" + routines_locales.get_string("messages and error reports.") + "\r\n/? -\t\t" + routines_locales.get_string("Displays this help dialog") + "\r\n\r\n " + routines_locales.get_string("Example: JavaRa /UPDATEDEFS /SILENT") + "\r\n " + routines_locales.get_string("Example: JavaRa /UNINSTALLALL /SILENT") + "\r\n", routines_locales.get_string("Command Line Parameters"));
                    this.Close();
                }
                else
                {
                    MessageBox.Show(routines_locales.get_string("Unsupported argument. Please use /PURGE, /CLEAN, /UNINSTALLALL, or /UPDATEDEFS") + "\r\n" + routines_locales.get_string("with, or without /SILENT."), routines_locales.get_string("Option Not Supported."));
                    this.Close();
                }
            }
            else
            {
                this.render_ui();
            }
        Label_051E:
            routines_registry.get_jre_uninstallers();
            if (this.boxUpdateCheck.Checked)
            {
                new Thread(new ThreadStart(this.check_for_update)) { IsBackground = true }.Start();
            }
        }

        [DebuggerStepThrough]
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            ComponentResourceManager manager = new ComponentResourceManager(typeof(UI));
            this.lvTools = new ListView();
            this.ExecutableImages = new ImageList(this.components);
            this.Panel1 = new Panel();
            this.lblVersion = new Label();
            this.lblTitle = new Label();
            this.Step1 = new Panel();
            this.Panel3 = new Panel();
            this.Button8 = new Button();
            this.btnStep1 = new Button();
            this.cboVersion = new ComboBox();
            this.btnRunUninstaller = new Button();
            this.lblStep1 = new Label();
            this.Label3 = new Label();
            this.pnlRemoval = new Panel();
            this.Panel2 = new Panel();
            this.btnPrev1 = new Button();
            this.btnStep2 = new Button();
            this.ProgressBar1 = new ProgressBar();
            this.btnRemoveKeys = new Button();
            this.Label6 = new Label();
            this.lblStep2 = new Label();
            this.Label5 = new Label();
            this.pnlAbout = new Panel();
            this.Label10 = new Label();
            this.Label4 = new Label();
            this.Panel9 = new Panel();
            this.Button12 = new Button();
            this.Label11 = new Label();
            this.pnlDownload = new Panel();
            this.Panel5 = new Panel();
            this.Button1 = new Button();
            this.Button4 = new Button();
            this.LinkLabel1 = new LinkLabel();
            this.txtFileName = new TextBox();
            this.ProgressBar2 = new ProgressBar();
            this.btnDownload = new Button();
            this.Label12 = new Label();
            this.lblDownloadNewVersion = new Label();
            this.pnlCompleted = new Panel();
            this.Panel6 = new Panel();
            this.Button7 = new Button();
            this.btnCloseApp = new RadioButton();
            this.btnCloseWiz = new RadioButton();
            this.Label14 = new Label();
            this.lblCompleted = new Label();
            this.PanelSettings = new Panel();
            this.boxPreserveUISize = new CheckBox();
            this.boxUpdateCheck = new CheckBox();
            this.btnSaveLang = new Button();
            this.Panel8 = new Panel();
            this.btnSave = new Button();
            this.Button11 = new Button();
            this.Label7 = new Label();
            this.Label16 = new Label();
            this.boxLanguage = new ComboBox();
            this.PanelExtra = new Panel();
            this.lbTasks = new CheckedListBox();
            this.Panel4 = new Panel();
            this.Button9 = new Button();
            this.btnRun = new Button();
            this.BackgroundWorker1 = new BackgroundWorker();
            this.pnlUpdate = new Panel();
            this.Panel11 = new Panel();
            this.Button2 = new Button();
            this.ProgressBar3 = new ProgressBar();
            this.btnUpdateDefs = new Button();
            this.lblUpdateDefs = new Label();
            this.Label19 = new Label();
            this.ToolTip1 = new ToolTip(this.components);
            this.pnlUpdateJRE = new Panel();
            this.boxJucheck = new RadioButton();
            this.Panel12 = new Panel();
            this.btnUpdateJavaPrevious = new Button();
            this.btnUpdateNext = new Button();
            this.boxDownloadJRE = new RadioButton();
            this.boxOnlineCheck = new RadioButton();
            this.lblStepOne = new Label();
            this.Label21 = new Label();
            this.ToolStrip1 = new ToolStrip();
            this.btnSettings = new ToolStripButton();
            this.btnAbout = new ToolStripButton();
            this.Panel7 = new Panel();
            this.pnlTopDock = new Panel();
            this.pnlCleanup = new Panel();
            this.Panel13 = new Panel();
            this.Button3 = new Button();
            this.Button5 = new Button();
            this.ProgressBar4 = new ProgressBar();
            this.btnCleanup = new Button();
            this.Label9 = new Label();
            this.Panel1.SuspendLayout();
            this.Step1.SuspendLayout();
            this.Panel3.SuspendLayout();
            this.pnlRemoval.SuspendLayout();
            this.Panel2.SuspendLayout();
            this.pnlAbout.SuspendLayout();
            this.Panel9.SuspendLayout();
            this.pnlDownload.SuspendLayout();
            this.Panel5.SuspendLayout();
            this.pnlCompleted.SuspendLayout();
            this.Panel6.SuspendLayout();
            this.PanelSettings.SuspendLayout();
            this.Panel8.SuspendLayout();
            this.PanelExtra.SuspendLayout();
            this.Panel4.SuspendLayout();
            this.pnlUpdate.SuspendLayout();
            this.Panel11.SuspendLayout();
            this.pnlUpdateJRE.SuspendLayout();
            this.Panel12.SuspendLayout();
            this.ToolStrip1.SuspendLayout();
            this.pnlTopDock.SuspendLayout();
            this.pnlCleanup.SuspendLayout();
            this.Panel13.SuspendLayout();
            this.SuspendLayout();
            this.lvTools.Activation = ItemActivation.OneClick;
            this.lvTools.Alignment = ListViewAlignment.Default;
            this.lvTools.BackColor = Color.White;
            this.lvTools.BorderStyle = BorderStyle.None;
            this.lvTools.Cursor = Cursors.Hand;
            this.lvTools.Dock = DockStyle.Bottom;
            this.lvTools.Font = new Font("Segoe UI", 9.75f, FontStyle.Regular, GraphicsUnit.Point, 0);
            this.lvTools.HeaderStyle = ColumnHeaderStyle.Nonclickable;
            this.lvTools.LargeImageList = this.ExecutableImages;
            Point point2 = new Point(0, 15);
            this.lvTools.Location = point2;
            Padding padding2 = new Padding(3, 15, 3, 3);
            this.lvTools.Margin = padding2;
            this.lvTools.MultiSelect = false;
            this.lvTools.Name = "lvTools";
            Size size2 = new Size(0x17a, 0xbc);
            this.lvTools.Size = size2;
            this.lvTools.TabIndex = 14;
            size2 = new Size(0x40, 0x40);
            this.lvTools.TileSize = size2;
            this.lvTools.UseCompatibleStateImageBehavior = false;
            this.ExecutableImages.ColorDepth = ColorDepth.Depth32Bit;
            size2 = new Size(0x40, 0x40);
            this.ExecutableImages.ImageSize = size2;
            this.ExecutableImages.TransparentColor = Color.Transparent;
            this.Panel1.BackColor = Color.DeepSkyBlue;
            this.Panel1.Controls.Add(this.lblVersion);
            this.Panel1.Controls.Add(this.lblTitle);
            this.Panel1.Dock = DockStyle.Top;
            point2 = new Point(0, 0);
            this.Panel1.Location = point2;
            padding2 = new Padding(3, 3, 3, 15);
            this.Panel1.Margin = padding2;
            size2 = new Size(0, 40);
            this.Panel1.MaximumSize = size2;
            size2 = new Size(0, 40);
            this.Panel1.MinimumSize = size2;
            this.Panel1.Name = "Panel1";
            padding2 = new Padding(0, 0, 0, 15);
            this.Panel1.Padding = padding2;
            size2 = new Size(0x6b2, 40);
            this.Panel1.Size = size2;
            this.Panel1.TabIndex = 15;
            this.lblVersion.AutoSize = true;
            this.lblVersion.BackColor = Color.Transparent;
            this.lblVersion.Font = new Font("Segoe UI Light", 9.75f, FontStyle.Regular, GraphicsUnit.Point, 0);
            this.lblVersion.ForeColor = Color.White;
            point2 = new Point(0x69, 0x12);
            this.lblVersion.Location = point2;
            this.lblVersion.Name = "lblVersion";
            size2 = new Size(0x44, 0x11);
            this.lblVersion.Size = size2;
            this.lblVersion.TabIndex = 8;
            this.lblVersion.Text = "version 2.6";
            this.lblTitle.AutoSize = true;
            this.lblTitle.BackColor = Color.Transparent;
            this.lblTitle.Font = new Font("Segoe UI Light", 21.75f, FontStyle.Regular, GraphicsUnit.Point, 0);
            this.lblTitle.ForeColor = Color.White;
            point2 = new Point(3, 0);
            this.lblTitle.Location = point2;
            this.lblTitle.Name = "lblTitle";
            size2 = new Size(0x60, 40);
            this.lblTitle.Size = size2;
            this.lblTitle.TabIndex = 0;
            this.lblTitle.Text = "JavaRa";
            this.Step1.BackColor = Color.White;
            this.Step1.Controls.Add(this.Panel3);
            this.Step1.Controls.Add(this.cboVersion);
            this.Step1.Controls.Add(this.btnRunUninstaller);
            this.Step1.Controls.Add(this.lblStep1);
            this.Step1.Controls.Add(this.Label3);
            point2 = new Point(0x18d, 50);
            this.Step1.Location = point2;
            this.Step1.Name = "Step1";
            size2 = new Size(430, 0xcd);
            this.Step1.Size = size2;
            this.Step1.TabIndex = 0x10;
            this.Panel3.BackColor = Color.White;
            this.Panel3.Controls.Add(this.Button8);
            this.Panel3.Controls.Add(this.btnStep1);
            this.Panel3.Dock = DockStyle.Bottom;
            point2 = new Point(0, 0xad);
            this.Panel3.Location = point2;
            size2 = new Size(0, 0x20);
            this.Panel3.MaximumSize = size2;
            size2 = new Size(0, 0x20);
            this.Panel3.MinimumSize = size2;
            this.Panel3.Name = "Panel3";
            padding2 = new Padding(6, 1, 6, 7);
            this.Panel3.Padding = padding2;
            size2 = new Size(430, 0x20);
            this.Panel3.Size = size2;
            this.Panel3.TabIndex = 9;
            this.Button8.Dock = DockStyle.Left;
            this.Button8.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(6, 1);
            this.Button8.Location = point2;
            this.Button8.Name = "Button8";
            size2 = new Size(0x42, 0x18);
            this.Button8.Size = size2;
            this.Button8.TabIndex = 6;
            this.Button8.Text = "Back";
            this.Button8.UseVisualStyleBackColor = true;
            this.btnStep1.Dock = DockStyle.Right;
            this.btnStep1.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(0x166, 1);
            this.btnStep1.Location = point2;
            this.btnStep1.Name = "btnStep1";
            size2 = new Size(0x42, 0x18);
            this.btnStep1.Size = size2;
            this.btnStep1.TabIndex = 4;
            this.btnStep1.Text = "Next";
            this.btnStep1.UseVisualStyleBackColor = true;
            this.cboVersion.DropDownStyle = ComboBoxStyle.DropDownList;
            this.cboVersion.Font = new Font("Segoe UI", 9.75f, FontStyle.Regular, GraphicsUnit.Point, 0);
            this.cboVersion.FormattingEnabled = true;
            point2 = new Point(12, 0x49);
            this.cboVersion.Location = point2;
            this.cboVersion.Name = "cboVersion";
            size2 = new Size(280, 0x19);
            this.cboVersion.Size = size2;
            this.cboVersion.TabIndex = 10;
            this.btnRunUninstaller.Font = new Font("Segoe UI", 9.75f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(0x12a, 0x47);
            this.btnRunUninstaller.Location = point2;
            this.btnRunUninstaller.Name = "btnRunUninstaller";
            size2 = new Size(0x7b, 0x1d);
            this.btnRunUninstaller.Size = size2;
            this.btnRunUninstaller.TabIndex = 7;
            this.btnRunUninstaller.Text = "Run Uninstaller";
            this.btnRunUninstaller.UseVisualStyleBackColor = true;
            this.lblStep1.AutoSize = true;
            this.lblStep1.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(9, 0x25);
            this.lblStep1.Location = point2;
            this.lblStep1.Name = "lblStep1";
            size2 = new Size(0x19f, 30);
            this.lblStep1.Size = size2;
            this.lblStep1.TabIndex = 6;
            this.lblStep1.Text = "We recommend that you try running the Java Runtime Environment's built-in\r\nuninstaller before you continue.";
            this.Label3.AutoSize = true;
            this.Label3.Font = new Font("Segoe UI Light", 18f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(3, 3);
            this.Label3.Location = point2;
            this.Label3.Name = "Label3";
            size2 = new Size(0x116, 0x20);
            this.Label3.Size = size2;
            this.Label3.TabIndex = 5;
            this.Label3.Text = "step 1 - run the uninstaller";
            this.pnlRemoval.BackColor = Color.White;
            this.pnlRemoval.Controls.Add(this.Panel2);
            this.pnlRemoval.Controls.Add(this.ProgressBar1);
            this.pnlRemoval.Controls.Add(this.btnRemoveKeys);
            this.pnlRemoval.Controls.Add(this.Label6);
            this.pnlRemoval.Controls.Add(this.lblStep2);
            point2 = new Point(0x18d, 260);
            this.pnlRemoval.Location = point2;
            this.pnlRemoval.Name = "pnlRemoval";
            size2 = new Size(430, 0xcd);
            this.pnlRemoval.Size = size2;
            this.pnlRemoval.TabIndex = 0x11;
            this.Panel2.BackColor = Color.White;
            this.Panel2.Controls.Add(this.btnPrev1);
            this.Panel2.Controls.Add(this.btnStep2);
            this.Panel2.Dock = DockStyle.Bottom;
            point2 = new Point(0, 0xad);
            this.Panel2.Location = point2;
            size2 = new Size(0, 0x20);
            this.Panel2.MaximumSize = size2;
            size2 = new Size(0, 0x20);
            this.Panel2.MinimumSize = size2;
            this.Panel2.Name = "Panel2";
            padding2 = new Padding(6, 1, 6, 7);
            this.Panel2.Padding = padding2;
            size2 = new Size(430, 0x20);
            this.Panel2.Size = size2;
            this.Panel2.TabIndex = 8;
            this.btnPrev1.Dock = DockStyle.Left;
            this.btnPrev1.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(6, 1);
            this.btnPrev1.Location = point2;
            this.btnPrev1.Name = "btnPrev1";
            size2 = new Size(0x42, 0x18);
            this.btnPrev1.Size = size2;
            this.btnPrev1.TabIndex = 5;
            this.btnPrev1.Text = "Previous";
            this.btnPrev1.UseVisualStyleBackColor = true;
            this.btnStep2.Dock = DockStyle.Right;
            this.btnStep2.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(0x166, 1);
            this.btnStep2.Location = point2;
            this.btnStep2.Name = "btnStep2";
            size2 = new Size(0x42, 0x18);
            this.btnStep2.Size = size2;
            this.btnStep2.TabIndex = 4;
            this.btnStep2.Text = "Next";
            this.btnStep2.UseVisualStyleBackColor = true;
            point2 = new Point(0xba, 0x57);
            this.ProgressBar1.Location = point2;
            this.ProgressBar1.Name = "ProgressBar1";
            size2 = new Size(0xeb, 0x1d);
            this.ProgressBar1.Size = size2;
            this.ProgressBar1.TabIndex = 9;
            this.btnRemoveKeys.Font = new Font("Segoe UI", 9.75f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(12, 0x57);
            this.btnRemoveKeys.Location = point2;
            this.btnRemoveKeys.Name = "btnRemoveKeys";
            size2 = new Size(0xa7, 0x1d);
            this.btnRemoveKeys.Size = size2;
            this.btnRemoveKeys.TabIndex = 7;
            this.btnRemoveKeys.Text = "Perform Removal Routine";
            this.btnRemoveKeys.UseVisualStyleBackColor = true;
            this.Label6.AutoSize = true;
            this.Label6.Font = new Font("Segoe UI Light", 18f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(3, 3);
            this.Label6.Location = point2;
            this.Label6.Name = "Label6";
            size2 = new Size(0x15b, 0x20);
            this.Label6.Size = size2;
            this.Label6.TabIndex = 5;
            this.Label6.Text = "step 2 - perform removal routine";
            this.lblStep2.AutoSize = true;
            this.lblStep2.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(11, 0x25);
            this.lblStep2.Location = point2;
            size2 = new Size(0x1bd, 0);
            this.lblStep2.MaximumSize = size2;
            this.lblStep2.Name = "lblStep2";
            size2 = new Size(0x1ba, 0x2d);
            this.lblStep2.Size = size2;
            this.lblStep2.TabIndex = 6;
            this.lblStep2.Text = manager.GetString("lblStep2.Text");
            this.Label5.AutoSize = true;
            this.Label5.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(11, 0x2e);
            this.Label5.Location = point2;
            size2 = new Size(0x1bd, 0);
            this.Label5.MaximumSize = size2;
            this.Label5.Name = "Label5";
            size2 = new Size(0x1b1, 30);
            this.Label5.Size = size2;
            this.Label5.TabIndex = 6;
            this.Label5.Text = "The removal routine will delete files, folder and registry entries that are known to be associated with the older versions of the Java Runtime Environment\r\n";
            this.pnlAbout.AutoScroll = true;
            this.pnlAbout.BackColor = Color.White;
            this.pnlAbout.Controls.Add(this.Label10);
            this.pnlAbout.Controls.Add(this.Label4);
            this.pnlAbout.Controls.Add(this.Panel9);
            this.pnlAbout.Controls.Add(this.Label11);
            point2 = new Point(12, 260);
            this.pnlAbout.Location = point2;
            this.pnlAbout.Name = "pnlAbout";
            size2 = new Size(0x17b, 0xcd);
            this.pnlAbout.Size = size2;
            this.pnlAbout.TabIndex = 0x12;
            this.Label10.AutoSize = true;
            this.Label10.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(9, 0x25);
            this.Label10.Location = point2;
            size2 = new Size(0x1bd, 0);
            this.Label10.MaximumSize = size2;
            this.Label10.Name = "Label10";
            size2 = new Size(0x1bd, 0x69);
            this.Label10.Size = size2;
            this.Label10.TabIndex = 10;
            this.Label10.Text = manager.GetString("Label10.Text");
            this.Label4.AutoSize = true;
            this.Label4.Font = new Font("Segoe UI Light", 18f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(3, 3);
            this.Label4.Location = point2;
            this.Label4.Name = "Label4";
            size2 = new Size(0x94, 0x20);
            this.Label4.Size = size2;
            this.Label4.TabIndex = 11;
            this.Label4.Text = "about JavaRa";
            this.Panel9.BackColor = Color.White;
            this.Panel9.Controls.Add(this.Button12);
            this.Panel9.Dock = DockStyle.Bottom;
            point2 = new Point(0, 0x9c);
            this.Panel9.Location = point2;
            size2 = new Size(0, 0x20);
            this.Panel9.MaximumSize = size2;
            size2 = new Size(0, 0x20);
            this.Panel9.MinimumSize = size2;
            this.Panel9.Name = "Panel9";
            padding2 = new Padding(6, 1, 6, 7);
            this.Panel9.Padding = padding2;
            size2 = new Size(0x1c6, 0x20);
            this.Panel9.Size = size2;
            this.Panel9.TabIndex = 0x1b;
            this.Button12.Dock = DockStyle.Left;
            this.Button12.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(6, 1);
            this.Button12.Location = point2;
            this.Button12.Name = "Button12";
            size2 = new Size(0x42, 0x18);
            this.Button12.Size = size2;
            this.Button12.TabIndex = 13;
            this.Button12.Text = "Back";
            this.Button12.UseVisualStyleBackColor = true;
            this.Label11.AutoSize = true;
            point2 = new Point(0xf6, 0x38);
            this.Label11.Location = point2;
            this.Label11.Name = "Label11";
            size2 = new Size(0, 13);
            this.Label11.Size = size2;
            this.Label11.TabIndex = 6;
            this.pnlDownload.BackColor = Color.White;
            this.pnlDownload.Controls.Add(this.Panel5);
            this.pnlDownload.Controls.Add(this.LinkLabel1);
            this.pnlDownload.Controls.Add(this.txtFileName);
            this.pnlDownload.Controls.Add(this.ProgressBar2);
            this.pnlDownload.Controls.Add(this.btnDownload);
            this.pnlDownload.Controls.Add(this.Label12);
            this.pnlDownload.Controls.Add(this.lblDownloadNewVersion);
            point2 = new Point(0x341, 0x31);
            this.pnlDownload.Location = point2;
            this.pnlDownload.Name = "pnlDownload";
            size2 = new Size(430, 0xcd);
            this.pnlDownload.Size = size2;
            this.pnlDownload.TabIndex = 0x12;
            this.Panel5.BackColor = Color.White;
            this.Panel5.Controls.Add(this.Button1);
            this.Panel5.Controls.Add(this.Button4);
            this.Panel5.Dock = DockStyle.Bottom;
            point2 = new Point(0, 0xad);
            this.Panel5.Location = point2;
            size2 = new Size(0, 0x20);
            this.Panel5.MaximumSize = size2;
            size2 = new Size(0, 0x20);
            this.Panel5.MinimumSize = size2;
            this.Panel5.Name = "Panel5";
            padding2 = new Padding(6, 1, 6, 7);
            this.Panel5.Padding = padding2;
            size2 = new Size(430, 0x20);
            this.Panel5.Size = size2;
            this.Panel5.TabIndex = 8;
            this.Button1.Dock = DockStyle.Left;
            this.Button1.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(6, 1);
            this.Button1.Location = point2;
            this.Button1.Name = "Button1";
            size2 = new Size(0x42, 0x18);
            this.Button1.Size = size2;
            this.Button1.TabIndex = 5;
            this.Button1.Text = "Previous";
            this.Button1.UseVisualStyleBackColor = true;
            this.Button4.Dock = DockStyle.Right;
            this.Button4.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(0x166, 1);
            this.Button4.Location = point2;
            this.Button4.Name = "Button4";
            size2 = new Size(0x42, 0x18);
            this.Button4.Size = size2;
            this.Button4.TabIndex = 4;
            this.Button4.Text = "Next";
            this.Button4.UseVisualStyleBackColor = true;
            this.LinkLabel1.AutoSize = true;
            this.LinkLabel1.Font = new Font("Segoe UI", 8.25f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(0xde, 0x36);
            this.LinkLabel1.Location = point2;
            this.LinkLabel1.Name = "LinkLabel1";
            size2 = new Size(0x7f, 13);
            this.LinkLabel1.Size = size2;
            this.LinkLabel1.TabIndex = 0x43;
            this.LinkLabel1.TabStop = true;
            this.LinkLabel1.Text = "Java Manual Download";
            point2 = new Point(12, 0x99);
            this.txtFileName.Location = point2;
            this.txtFileName.Name = "txtFileName";
            size2 = new Size(0x199, 20);
            this.txtFileName.Size = size2;
            this.txtFileName.TabIndex = 0x42;
            this.txtFileName.Visible = false;
            point2 = new Point(0x69, 0x55);
            this.ProgressBar2.Location = point2;
            this.ProgressBar2.Name = "ProgressBar2";
            size2 = new Size(0x13c, 0x1d);
            this.ProgressBar2.Size = size2;
            this.ProgressBar2.TabIndex = 9;
            this.btnDownload.Font = new Font("Segoe UI", 9.75f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(12, 0x55);
            this.btnDownload.Location = point2;
            this.btnDownload.Name = "btnDownload";
            size2 = new Size(0x57, 0x1d);
            this.btnDownload.Size = size2;
            this.btnDownload.TabIndex = 7;
            this.btnDownload.Text = "Download";
            this.btnDownload.UseVisualStyleBackColor = true;
            this.Label12.AutoSize = true;
            this.Label12.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(9, 0x25);
            this.Label12.Location = point2;
            this.Label12.Name = "Label12";
            size2 = new Size(0x15b, 30);
            this.Label12.Size = size2;
            this.Label12.TabIndex = 6;
            this.Label12.Text = "Would you like to download and install the latest version of JRE? \r\nUse this interface.\r\n";
            this.lblDownloadNewVersion.AutoSize = true;
            this.lblDownloadNewVersion.Font = new Font("Segoe UI Light", 18f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(3, 3);
            this.lblDownloadNewVersion.Location = point2;
            this.lblDownloadNewVersion.Name = "lblDownloadNewVersion";
            size2 = new Size(0x143, 0x20);
            this.lblDownloadNewVersion.Size = size2;
            this.lblDownloadNewVersion.TabIndex = 5;
            this.lblDownloadNewVersion.Text = "step 3 - download new version";
            this.pnlCompleted.BackColor = Color.White;
            this.pnlCompleted.Controls.Add(this.Panel6);
            this.pnlCompleted.Controls.Add(this.btnCloseApp);
            this.pnlCompleted.Controls.Add(this.btnCloseWiz);
            this.pnlCompleted.Controls.Add(this.Label14);
            this.pnlCompleted.Controls.Add(this.lblCompleted);
            point2 = new Point(0x341, 260);
            this.pnlCompleted.Location = point2;
            this.pnlCompleted.Name = "pnlCompleted";
            size2 = new Size(430, 0xcd);
            this.pnlCompleted.Size = size2;
            this.pnlCompleted.TabIndex = 0x13;
            this.Panel6.BackColor = Color.White;
            this.Panel6.Controls.Add(this.Button7);
            this.Panel6.Dock = DockStyle.Bottom;
            point2 = new Point(0, 0xad);
            this.Panel6.Location = point2;
            size2 = new Size(0, 0x20);
            this.Panel6.MaximumSize = size2;
            size2 = new Size(0, 0x20);
            this.Panel6.MinimumSize = size2;
            this.Panel6.Name = "Panel6";
            padding2 = new Padding(6, 1, 6, 7);
            this.Panel6.Padding = padding2;
            size2 = new Size(430, 0x20);
            this.Panel6.Size = size2;
            this.Panel6.TabIndex = 8;
            this.Button7.Dock = DockStyle.Right;
            this.Button7.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(0x166, 1);
            this.Button7.Location = point2;
            this.Button7.Name = "Button7";
            size2 = new Size(0x42, 0x18);
            this.Button7.Size = size2;
            this.Button7.TabIndex = 4;
            this.Button7.Text = "Finish";
            this.Button7.UseVisualStyleBackColor = true;
            this.btnCloseApp.AutoSize = true;
            this.btnCloseApp.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(12, 0x56);
            this.btnCloseApp.Location = point2;
            this.btnCloseApp.Name = "btnCloseApp";
            size2 = new Size(0x51, 0x13);
            this.btnCloseApp.Size = size2;
            this.btnCloseApp.TabIndex = 10;
            this.btnCloseApp.Text = "Exit JavaRa";
            this.btnCloseApp.UseVisualStyleBackColor = true;
            this.btnCloseWiz.AutoSize = true;
            this.btnCloseWiz.Checked = true;
            this.btnCloseWiz.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(12, 0x3d);
            this.btnCloseWiz.Location = point2;
            this.btnCloseWiz.Name = "btnCloseWiz";
            size2 = new Size(0x71, 0x13);
            this.btnCloseWiz.Size = size2;
            this.btnCloseWiz.TabIndex = 9;
            this.btnCloseWiz.TabStop = true;
            this.btnCloseWiz.Text = "Close this wizard";
            this.btnCloseWiz.UseVisualStyleBackColor = true;
            this.Label14.AutoSize = true;
            this.Label14.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(9, 0x25);
            this.Label14.Location = point2;
            this.Label14.Name = "Label14";
            size2 = new Size(0x124, 15);
            this.Label14.Size = size2;
            this.Label14.TabIndex = 6;
            this.Label14.Text = "The process is complete. Select an option to continue.";
            this.lblCompleted.AutoSize = true;
            this.lblCompleted.Font = new Font("Segoe UI Light", 18f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(3, 3);
            this.lblCompleted.Location = point2;
            this.lblCompleted.Name = "lblCompleted";
            size2 = new Size(0xd3, 0x20);
            this.lblCompleted.Size = size2;
            this.lblCompleted.TabIndex = 5;
            this.lblCompleted.Text = "step 4 - completed.";
            this.PanelSettings.BackColor = Color.White;
            this.PanelSettings.Controls.Add(this.boxPreserveUISize);
            this.PanelSettings.Controls.Add(this.boxUpdateCheck);
            this.PanelSettings.Controls.Add(this.btnSaveLang);
            this.PanelSettings.Controls.Add(this.Panel8);
            this.PanelSettings.Controls.Add(this.Label7);
            this.PanelSettings.Controls.Add(this.Label16);
            this.PanelSettings.Controls.Add(this.boxLanguage);
            point2 = new Point(12, 0x1d7);
            this.PanelSettings.Location = point2;
            this.PanelSettings.Name = "PanelSettings";
            size2 = new Size(0x17b, 0xcd);
            this.PanelSettings.Size = size2;
            this.PanelSettings.TabIndex = 20;
            this.boxPreserveUISize.AutoSize = true;
            this.boxPreserveUISize.Font = new Font("Segoe UI", 9f);
            point2 = new Point(12, 0x39);
            this.boxPreserveUISize.Location = point2;
            this.boxPreserveUISize.Name = "boxPreserveUISize";
            size2 = new Size(0xbd, 0x13);
            this.boxPreserveUISize.Size = size2;
            this.boxPreserveUISize.TabIndex = 0x1f;
            this.boxPreserveUISize.Text = "Preserve Window height/width";
            this.boxPreserveUISize.UseVisualStyleBackColor = true;
            this.boxUpdateCheck.AutoSize = true;
            this.boxUpdateCheck.Checked = true;
            this.boxUpdateCheck.CheckState = CheckState.Checked;
            this.boxUpdateCheck.Font = new Font("Segoe UI", 9f);
            point2 = new Point(12, 0x25);
            this.boxUpdateCheck.Location = point2;
            this.boxUpdateCheck.Name = "boxUpdateCheck";
            size2 = new Size(0xc5, 0x13);
            this.boxUpdateCheck.Size = size2;
            this.boxUpdateCheck.TabIndex = 30;
            this.boxUpdateCheck.Text = "Automatically check for updates";
            this.boxUpdateCheck.UseVisualStyleBackColor = true;
            this.btnSaveLang.Enabled = false;
            this.btnSaveLang.Font = new Font("Segoe UI", 8.25f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(0xee, 0x5f);
            this.btnSaveLang.Location = point2;
            this.btnSaveLang.Name = "btnSaveLang";
            size2 = new Size(0x4b, 0x15);
            this.btnSaveLang.Size = size2;
            this.btnSaveLang.TabIndex = 0x1d;
            this.btnSaveLang.Text = "Save";
            this.btnSaveLang.UseVisualStyleBackColor = true;
            this.Panel8.BackColor = Color.White;
            this.Panel8.Controls.Add(this.btnSave);
            this.Panel8.Controls.Add(this.Button11);
            this.Panel8.Dock = DockStyle.Bottom;
            point2 = new Point(0, 0xad);
            this.Panel8.Location = point2;
            size2 = new Size(0, 0x20);
            this.Panel8.MaximumSize = size2;
            size2 = new Size(0, 0x20);
            this.Panel8.MinimumSize = size2;
            this.Panel8.Name = "Panel8";
            padding2 = new Padding(6, 1, 6, 7);
            this.Panel8.Padding = padding2;
            size2 = new Size(0x17b, 0x20);
            this.Panel8.Size = size2;
            this.Panel8.TabIndex = 0x1b;
            this.btnSave.Anchor = AnchorStyles.Right | AnchorStyles.Top;
            this.btnSave.Font = new Font("Segoe UI", 8.25f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(0x2eb7, 2);
            this.btnSave.Location = point2;
            this.btnSave.Name = "btnSave";
            size2 = new Size(0xa6, 0x18);
            this.btnSave.Size = size2;
            this.btnSave.TabIndex = 0x1d;
            this.btnSave.Text = "Save Settings";
            this.btnSave.UseVisualStyleBackColor = true;
            this.Button11.Dock = DockStyle.Left;
            this.Button11.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(6, 1);
            this.Button11.Location = point2;
            this.Button11.Name = "Button11";
            size2 = new Size(0x42, 0x18);
            this.Button11.Size = size2;
            this.Button11.TabIndex = 13;
            this.Button11.Text = "Back";
            this.Button11.UseVisualStyleBackColor = true;
            this.Label7.AutoSize = true;
            this.Label7.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(9, 0x4d);
            this.Label7.Location = point2;
            this.Label7.Name = "Label7";
            size2 = new Size(0x6c, 15);
            this.Label7.Size = size2;
            this.Label7.TabIndex = 11;
            this.Label7.Text = "Program Language";
            this.Label16.AutoSize = true;
            this.Label16.Font = new Font("Segoe UI Light", 18f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(6, 1);
            this.Label16.Location = point2;
            this.Label16.Name = "Label16";
            size2 = new Size(0xb8, 0x20);
            this.Label16.Size = size2;
            this.Label16.TabIndex = 7;
            this.Label16.Text = "program settings";
            this.boxLanguage.DropDownStyle = ComboBoxStyle.DropDownList;
            this.boxLanguage.Font = new Font("Segoe UI", 8.25f, FontStyle.Regular, GraphicsUnit.Point, 0);
            this.boxLanguage.FormattingEnabled = true;
            this.boxLanguage.Items.AddRange(new object[] { "English" });
            point2 = new Point(12, 0x5f);
            this.boxLanguage.Location = point2;
            this.boxLanguage.Name = "boxLanguage";
            size2 = new Size(220, 0x15);
            this.boxLanguage.Size = size2;
            this.boxLanguage.TabIndex = 4;
            this.PanelExtra.BackColor = Color.White;
            this.PanelExtra.Controls.Add(this.lbTasks);
            this.PanelExtra.Controls.Add(this.Panel4);
            point2 = new Point(0x18d, 0x1d8);
            this.PanelExtra.Location = point2;
            this.PanelExtra.Name = "PanelExtra";
            size2 = new Size(430, 0xcc);
            this.PanelExtra.Size = size2;
            this.PanelExtra.TabIndex = 0x15;
            this.lbTasks.BorderStyle = BorderStyle.None;
            this.lbTasks.CheckOnClick = true;
            this.lbTasks.Dock = DockStyle.Fill;
            this.lbTasks.Font = new Font("Segoe UI", 9.75f, FontStyle.Regular, GraphicsUnit.Point, 0);
            this.lbTasks.FormattingEnabled = true;
            point2 = new Point(0, 0);
            this.lbTasks.Location = point2;
            this.lbTasks.Name = "lbTasks";
            size2 = new Size(430, 0xac);
            this.lbTasks.Size = size2;
            this.lbTasks.TabIndex = 11;
            this.Panel4.BackColor = Color.White;
            this.Panel4.Controls.Add(this.Button9);
            this.Panel4.Controls.Add(this.btnRun);
            this.Panel4.Dock = DockStyle.Bottom;
            point2 = new Point(0, 0xac);
            this.Panel4.Location = point2;
            size2 = new Size(0, 0x20);
            this.Panel4.MaximumSize = size2;
            size2 = new Size(0, 0x20);
            this.Panel4.MinimumSize = size2;
            this.Panel4.Name = "Panel4";
            padding2 = new Padding(6, 1, 6, 7);
            this.Panel4.Padding = padding2;
            size2 = new Size(430, 0x20);
            this.Panel4.Size = size2;
            this.Panel4.TabIndex = 13;
            this.Button9.Dock = DockStyle.Left;
            this.Button9.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(6, 1);
            this.Button9.Location = point2;
            this.Button9.Name = "Button9";
            size2 = new Size(0x42, 0x18);
            this.Button9.Size = size2;
            this.Button9.TabIndex = 13;
            this.Button9.Text = "Back";
            this.Button9.UseVisualStyleBackColor = true;
            this.btnRun.Dock = DockStyle.Right;
            this.btnRun.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(0x143, 1);
            this.btnRun.Location = point2;
            this.btnRun.Name = "btnRun";
            size2 = new Size(0x65, 0x18);
            this.btnRun.Size = size2;
            this.btnRun.TabIndex = 12;
            this.btnRun.Text = "Run";
            this.btnRun.UseVisualStyleBackColor = true;
            this.pnlUpdate.BackColor = Color.White;
            this.pnlUpdate.Controls.Add(this.Panel11);
            this.pnlUpdate.Controls.Add(this.ProgressBar3);
            this.pnlUpdate.Controls.Add(this.btnUpdateDefs);
            this.pnlUpdate.Controls.Add(this.lblUpdateDefs);
            this.pnlUpdate.Controls.Add(this.Label19);
            point2 = new Point(0x4f5, 0x31);
            this.pnlUpdate.Location = point2;
            this.pnlUpdate.Name = "pnlUpdate";
            size2 = new Size(430, 0xcd);
            this.pnlUpdate.Size = size2;
            this.pnlUpdate.TabIndex = 0x1f;
            this.Panel11.BackColor = Color.White;
            this.Panel11.Controls.Add(this.Button2);
            this.Panel11.Dock = DockStyle.Bottom;
            point2 = new Point(0, 0xad);
            this.Panel11.Location = point2;
            size2 = new Size(0, 0x20);
            this.Panel11.MaximumSize = size2;
            size2 = new Size(0, 0x20);
            this.Panel11.MinimumSize = size2;
            this.Panel11.Name = "Panel11";
            padding2 = new Padding(6, 1, 6, 7);
            this.Panel11.Padding = padding2;
            size2 = new Size(430, 0x20);
            this.Panel11.Size = size2;
            this.Panel11.TabIndex = 8;
            this.Button2.Dock = DockStyle.Left;
            this.Button2.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(6, 1);
            this.Button2.Location = point2;
            this.Button2.Name = "Button2";
            size2 = new Size(0x42, 0x18);
            this.Button2.Size = size2;
            this.Button2.TabIndex = 5;
            this.Button2.Text = "Back";
            this.Button2.UseVisualStyleBackColor = true;
            point2 = new Point(0x69, 0x55);
            this.ProgressBar3.Location = point2;
            this.ProgressBar3.Name = "ProgressBar3";
            size2 = new Size(0x13c, 0x1d);
            this.ProgressBar3.Size = size2;
            this.ProgressBar3.TabIndex = 9;
            this.btnUpdateDefs.Font = new Font("Segoe UI", 9.75f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(12, 0x55);
            this.btnUpdateDefs.Location = point2;
            this.btnUpdateDefs.Name = "btnUpdateDefs";
            size2 = new Size(0x57, 0x1d);
            this.btnUpdateDefs.Size = size2;
            this.btnUpdateDefs.TabIndex = 7;
            this.btnUpdateDefs.Text = "Download\r\n";
            this.btnUpdateDefs.UseVisualStyleBackColor = true;
            this.lblUpdateDefs.AutoSize = true;
            this.lblUpdateDefs.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(9, 0x25);
            this.lblUpdateDefs.Location = point2;
            size2 = new Size(0x1bd, 0);
            this.lblUpdateDefs.MaximumSize = size2;
            this.lblUpdateDefs.Name = "lblUpdateDefs";
            size2 = new Size(0x1bc, 30);
            this.lblUpdateDefs.Size = size2;
            this.lblUpdateDefs.TabIndex = 6;
            this.lblUpdateDefs.Text = "Would you like to download and install the latest version of the JavaRa definitions? These are used to find and remove every last trace of JRE.";
            this.Label19.AutoSize = true;
            this.Label19.Font = new Font("Segoe UI Light", 18f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(3, 3);
            this.Label19.Location = point2;
            this.Label19.Name = "Label19";
            size2 = new Size(0x10d, 0x20);
            this.Label19.Size = size2;
            this.Label19.TabIndex = 5;
            this.Label19.Text = "update JavaRa definitions";
            this.pnlUpdateJRE.BackColor = Color.White;
            this.pnlUpdateJRE.Controls.Add(this.boxJucheck);
            this.pnlUpdateJRE.Controls.Add(this.Panel12);
            this.pnlUpdateJRE.Controls.Add(this.boxDownloadJRE);
            this.pnlUpdateJRE.Controls.Add(this.boxOnlineCheck);
            this.pnlUpdateJRE.Controls.Add(this.lblStepOne);
            this.pnlUpdateJRE.Controls.Add(this.Label21);
            point2 = new Point(0x4f5, 260);
            this.pnlUpdateJRE.Location = point2;
            this.pnlUpdateJRE.Name = "pnlUpdateJRE";
            size2 = new Size(430, 0xcd);
            this.pnlUpdateJRE.Size = size2;
            this.pnlUpdateJRE.TabIndex = 0x20;
            this.boxJucheck.AutoSize = true;
            this.boxJucheck.Checked = true;
            this.boxJucheck.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(12, 0x43);
            this.boxJucheck.Location = point2;
            this.boxJucheck.Name = "boxJucheck";
            size2 = new Size(0x85, 0x13);
            this.boxJucheck.Size = size2;
            this.boxJucheck.TabIndex = 13;
            this.boxJucheck.TabStop = true;
            this.boxJucheck.Text = "Use Jucheck.exe tool";
            this.boxJucheck.UseVisualStyleBackColor = true;
            this.Panel12.BackColor = Color.White;
            this.Panel12.Controls.Add(this.btnUpdateJavaPrevious);
            this.Panel12.Controls.Add(this.btnUpdateNext);
            this.Panel12.Dock = DockStyle.Bottom;
            point2 = new Point(0, 0xad);
            this.Panel12.Location = point2;
            size2 = new Size(0, 0x20);
            this.Panel12.MaximumSize = size2;
            size2 = new Size(0, 0x20);
            this.Panel12.MinimumSize = size2;
            this.Panel12.Name = "Panel12";
            padding2 = new Padding(6, 1, 6, 7);
            this.Panel12.Padding = padding2;
            size2 = new Size(430, 0x20);
            this.Panel12.Size = size2;
            this.Panel12.TabIndex = 8;
            this.btnUpdateJavaPrevious.Dock = DockStyle.Left;
            this.btnUpdateJavaPrevious.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(6, 1);
            this.btnUpdateJavaPrevious.Location = point2;
            this.btnUpdateJavaPrevious.Name = "btnUpdateJavaPrevious";
            size2 = new Size(0x42, 0x18);
            this.btnUpdateJavaPrevious.Size = size2;
            this.btnUpdateJavaPrevious.TabIndex = 5;
            this.btnUpdateJavaPrevious.Text = "Previous";
            this.btnUpdateJavaPrevious.UseVisualStyleBackColor = true;
            this.btnUpdateNext.Dock = DockStyle.Right;
            this.btnUpdateNext.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(0x166, 1);
            this.btnUpdateNext.Location = point2;
            this.btnUpdateNext.Name = "btnUpdateNext";
            size2 = new Size(0x42, 0x18);
            this.btnUpdateNext.Size = size2;
            this.btnUpdateNext.TabIndex = 4;
            this.btnUpdateNext.Text = "Next";
            this.btnUpdateNext.UseVisualStyleBackColor = true;
            this.boxDownloadJRE.AutoSize = true;
            this.boxDownloadJRE.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(12, 0x67);
            this.boxDownloadJRE.Location = point2;
            this.boxDownloadJRE.Name = "boxDownloadJRE";
            size2 = new Size(0xd0, 0x13);
            this.boxDownloadJRE.Size = size2;
            this.boxDownloadJRE.TabIndex = 12;
            this.boxDownloadJRE.Text = "Download and install latest version";
            this.boxDownloadJRE.UseVisualStyleBackColor = true;
            this.boxOnlineCheck.AutoSize = true;
            this.boxOnlineCheck.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(12, 0x55);
            this.boxOnlineCheck.Location = point2;
            this.boxOnlineCheck.Name = "boxOnlineCheck";
            size2 = new Size(0xb3, 0x13);
            this.boxOnlineCheck.Size = size2;
            this.boxOnlineCheck.TabIndex = 11;
            this.boxOnlineCheck.Text = "Perform online version check";
            this.boxOnlineCheck.UseVisualStyleBackColor = true;
            this.lblStepOne.AutoSize = true;
            this.lblStepOne.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(9, 0x25);
            this.lblStepOne.Location = point2;
            size2 = new Size(0x1bd, 0);
            this.lblStepOne.MaximumSize = size2;
            this.lblStepOne.Name = "lblStepOne";
            size2 = new Size(0x17f, 30);
            this.lblStepOne.Size = size2;
            this.lblStepOne.TabIndex = 6;
            this.lblStepOne.Text = "JavaRa can update JRE by either performing an online version check, or downloading and re-installing the program - regardless of version.\r\n";
            this.Label21.AutoSize = true;
            this.Label21.Font = new Font("Segoe UI Light", 18f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(3, 3);
            this.Label21.Location = point2;
            this.Label21.Name = "Label21";
            size2 = new Size(0x13a, 0x20);
            this.Label21.Size = size2;
            this.Label21.TabIndex = 5;
            this.Label21.Text = "step 1 - select update method";
            this.ToolStrip1.BackColor = Color.White;
            this.ToolStrip1.Dock = DockStyle.Bottom;
            this.ToolStrip1.GripStyle = ToolStripGripStyle.Hidden;
            this.ToolStrip1.Items.AddRange(new ToolStripItem[] { this.btnSettings, this.btnAbout });
            point2 = new Point(0, 0x2b3);
            this.ToolStrip1.Location = point2;
            this.ToolStrip1.Name = "ToolStrip1";
            size2 = new Size(0x6b2, 0x19);
            this.ToolStrip1.Size = size2;
            this.ToolStrip1.TabIndex = 0x21;
            this.ToolStrip1.Text = "ToolStrip1";
            this.btnSettings.DisplayStyle = ToolStripItemDisplayStyle.Text;
            this.btnSettings.Image = (Image) manager.GetObject("btnSettings.Image");
            this.btnSettings.ImageTransparentColor = Color.Magenta;
            this.btnSettings.Name = "btnSettings";
            size2 = new Size(0x35, 0x16);
            this.btnSettings.Size = size2;
            this.btnSettings.Text = "Settings";
            this.btnSettings.TextImageRelation = TextImageRelation.TextBeforeImage;
            this.btnAbout.DisplayStyle = ToolStripItemDisplayStyle.Text;
            this.btnAbout.Image = (Image) manager.GetObject("btnAbout.Image");
            this.btnAbout.ImageTransparentColor = Color.Magenta;
            this.btnAbout.Name = "btnAbout";
            size2 = new Size(0x52, 0x16);
            this.btnAbout.Size = size2;
            this.btnAbout.Text = "About JavaRa";
            this.Panel7.BackColor = Color.DimGray;
            this.Panel7.Dock = DockStyle.Bottom;
            point2 = new Point(0, 690);
            this.Panel7.Location = point2;
            this.Panel7.Name = "Panel7";
            size2 = new Size(0x6b2, 1);
            this.Panel7.Size = size2;
            this.Panel7.TabIndex = 0x22;
            this.pnlTopDock.BackColor = Color.White;
            this.pnlTopDock.Controls.Add(this.lvTools);
            point2 = new Point(13, 50);
            this.pnlTopDock.Location = point2;
            padding2 = new Padding(3, 15, 3, 3);
            this.pnlTopDock.Margin = padding2;
            size2 = new Size(10, 0);
            this.pnlTopDock.MinimumSize = size2;
            this.pnlTopDock.Name = "pnlTopDock";
            padding2 = new Padding(0, 15, 0, 0);
            this.pnlTopDock.Padding = padding2;
            size2 = new Size(0x17a, 0xcb);
            this.pnlTopDock.Size = size2;
            this.pnlTopDock.TabIndex = 0x23;
            this.pnlCleanup.BackColor = Color.White;
            this.pnlCleanup.Controls.Add(this.Panel13);
            this.pnlCleanup.Controls.Add(this.ProgressBar4);
            this.pnlCleanup.Controls.Add(this.btnCleanup);
            this.pnlCleanup.Controls.Add(this.Label5);
            this.pnlCleanup.Controls.Add(this.Label9);
            point2 = new Point(0x341, 0x1d7);
            this.pnlCleanup.Location = point2;
            this.pnlCleanup.Name = "pnlCleanup";
            size2 = new Size(430, 0xcd);
            this.pnlCleanup.Size = size2;
            this.pnlCleanup.TabIndex = 0x24;
            this.Panel13.BackColor = Color.White;
            this.Panel13.Controls.Add(this.Button3);
            this.Panel13.Controls.Add(this.Button5);
            this.Panel13.Dock = DockStyle.Bottom;
            point2 = new Point(0, 0xad);
            this.Panel13.Location = point2;
            size2 = new Size(0, 0x20);
            this.Panel13.MaximumSize = size2;
            size2 = new Size(0, 0x20);
            this.Panel13.MinimumSize = size2;
            this.Panel13.Name = "Panel13";
            padding2 = new Padding(6, 1, 6, 7);
            this.Panel13.Padding = padding2;
            size2 = new Size(430, 0x20);
            this.Panel13.Size = size2;
            this.Panel13.TabIndex = 8;
            this.Button3.Dock = DockStyle.Left;
            this.Button3.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(6, 1);
            this.Button3.Location = point2;
            this.Button3.Name = "Button3";
            size2 = new Size(0x42, 0x18);
            this.Button3.Size = size2;
            this.Button3.TabIndex = 5;
            this.Button3.Text = "Previous";
            this.Button3.UseVisualStyleBackColor = true;
            this.Button5.Dock = DockStyle.Right;
            this.Button5.Font = new Font("Segoe UI", 9f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(0x166, 1);
            this.Button5.Location = point2;
            this.Button5.Name = "Button5";
            size2 = new Size(0x42, 0x18);
            this.Button5.Size = size2;
            this.Button5.TabIndex = 4;
            this.Button5.Text = "Next";
            this.Button5.UseVisualStyleBackColor = true;
            point2 = new Point(0xba, 0x55);
            this.ProgressBar4.Location = point2;
            this.ProgressBar4.Name = "ProgressBar4";
            size2 = new Size(0xeb, 0x1d);
            this.ProgressBar4.Size = size2;
            this.ProgressBar4.TabIndex = 9;
            this.btnCleanup.Font = new Font("Segoe UI", 9.75f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(12, 0x55);
            this.btnCleanup.Location = point2;
            this.btnCleanup.Name = "btnCleanup";
            size2 = new Size(0xa7, 0x1d);
            this.btnCleanup.Size = size2;
            this.btnCleanup.TabIndex = 7;
            this.btnCleanup.Text = "Perform Cleanup Routine";
            this.btnCleanup.UseVisualStyleBackColor = true;
            this.Label9.AutoSize = true;
            this.Label9.Font = new Font("Segoe UI Light", 18f, FontStyle.Regular, GraphicsUnit.Point, 0);
            point2 = new Point(3, 3);
            this.Label9.Location = point2;
            this.Label9.Name = "Label9";
            size2 = new Size(0x159, 0x20);
            this.Label9.Size = size2;
            this.Label9.TabIndex = 5;
            this.Label9.Text = "step 2 - perform cleanup routine";
            SizeF ef2 = new SizeF(6f, 13f);
            this.AutoScaleDimensions = ef2;
            this.AutoScaleMode = AutoScaleMode.Font;
            size2 = new Size(0x6b2, 0x2cc);
            this.ClientSize = size2;
            this.Controls.Add(this.Panel7);
            this.Controls.Add(this.ToolStrip1);
            this.Controls.Add(this.pnlCleanup);
            this.Controls.Add(this.pnlTopDock);
            this.Controls.Add(this.pnlUpdateJRE);
            this.Controls.Add(this.pnlUpdate);
            this.Controls.Add(this.pnlAbout);
            this.Controls.Add(this.PanelExtra);
            this.Controls.Add(this.PanelSettings);
            this.Controls.Add(this.pnlCompleted);
            this.Controls.Add(this.pnlDownload);
            this.Controls.Add(this.pnlRemoval);
            this.Controls.Add(this.Step1);
            this.Controls.Add(this.Panel1);
            this.Icon = (Icon) manager.GetObject("$this.Icon");
            this.MaximizeBox = false;
            size2 = new Size(150, 150);
            this.MinimumSize = size2;
            this.Name = "UI";
            this.Text = "JavaRa";
            this.Panel1.ResumeLayout(false);
            this.Panel1.PerformLayout();
            this.Step1.ResumeLayout(false);
            this.Step1.PerformLayout();
            this.Panel3.ResumeLayout(false);
            this.pnlRemoval.ResumeLayout(false);
            this.pnlRemoval.PerformLayout();
            this.Panel2.ResumeLayout(false);
            this.pnlAbout.ResumeLayout(false);
            this.pnlAbout.PerformLayout();
            this.Panel9.ResumeLayout(false);
            this.pnlDownload.ResumeLayout(false);
            this.pnlDownload.PerformLayout();
            this.Panel5.ResumeLayout(false);
            this.pnlCompleted.ResumeLayout(false);
            this.pnlCompleted.PerformLayout();
            this.Panel6.ResumeLayout(false);
            this.PanelSettings.ResumeLayout(false);
            this.PanelSettings.PerformLayout();
            this.Panel8.ResumeLayout(false);
            this.PanelExtra.ResumeLayout(false);
            this.Panel4.ResumeLayout(false);
            this.pnlUpdate.ResumeLayout(false);
            this.pnlUpdate.PerformLayout();
            this.Panel11.ResumeLayout(false);
            this.pnlUpdateJRE.ResumeLayout(false);
            this.pnlUpdateJRE.PerformLayout();
            this.Panel12.ResumeLayout(false);
            this.ToolStrip1.ResumeLayout(false);
            this.ToolStrip1.PerformLayout();
            this.pnlTopDock.ResumeLayout(false);
            this.pnlCleanup.ResumeLayout(false);
            this.pnlCleanup.PerformLayout();
            this.Panel13.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();
        }

        private void LinkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            Process.Start("http://www.java.com/en/download/manual.jsp#win");
        }

        private void lvTools_Click(object sender, EventArgs e)
        {
            IEnumerator enumerator;
            try
            {
                enumerator = this.lvTools.Items.GetEnumerator();
                while (enumerator.MoveNext())
                {
                    ListViewItem current = (ListViewItem) enumerator.Current;
                    if (current.Selected)
                    {
                        string text = current.SubItems[0].Text;
                        if (text == routines_locales.get_string("Additional Tasks"))
                        {
                            routines_interface.show_panel(this.PanelExtra, false);
                        }
                        if (text == routines_locales.get_string("Remove Java Runtime"))
                        {
                            this.cboVersion.Items.Clear();
                            foreach (JREInstallObject obj2 in this.JREObjectList)
                            {
                                this.cboVersion.Items.Add(RuntimeHelpers.GetObjectValue(obj2.Name));
                            }
                            routines_interface.show_panel(this.Step1, false);
                            if (this.cboVersion.Items.Count == 0)
                            {
                                this.cboVersion.Enabled = false;
                                this.lblStep1.Text = routines_locales.get_string("No uninstaller found. Please press 'next' to continue");
                                this.btnRunUninstaller.Enabled = false;
                            }
                            else
                            {
                                this.btnRunUninstaller.Enabled = true;
                                this.cboVersion.Enabled = true;
                                this.lblStep1.Text = routines_locales.get_string("We recommend that you try running the Java Runtime Environment's built-in") + Environment.NewLine + routines_locales.get_string("uninstaller before you continue.");
                            }
                        }
                        if (text == routines_locales.get_string("Update JavaRa Definitions"))
                        {
                            routines_interface.show_panel(this.pnlUpdate, false);
                        }
                        if (text == routines_locales.get_string("Update Java Runtime"))
                        {
                            routines_interface.show_panel(this.pnlUpdateJRE, false);
                        }
                    }
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

        public void reboot_app()
        {
            this.reboot = true;
            this.Close();
        }

        private void render_ui()
        {
            try
            {
                this.lvTools.Items.Clear();
                this.lbTasks.Items.Clear();
                Bitmap update = JavaRa.My.Resources.Resources.update;
                this.ExecutableImages.Images.Add(routines_locales.get_string("Update Java Runtime"), update);
                string imageKey = routines_locales.get_string("Update Java Runtime");
                this.lvTools.Items.Add(routines_locales.get_string("Update Java Runtime"), imageKey);
                update = JavaRa.My.Resources.Resources.clear;
                this.ExecutableImages.Images.Add(routines_locales.get_string("Remove Java Runtime"), update);
                imageKey = routines_locales.get_string("Remove Java Runtime");
                this.lvTools.Items.Add(routines_locales.get_string("Remove Java Runtime"), imageKey);
                update = JavaRa.My.Resources.Resources.download;
                this.ExecutableImages.Images.Add(routines_locales.get_string("Update JavaRa Definitions"), update);
                imageKey = routines_locales.get_string("Update JavaRa Definitions");
                this.lvTools.Items.Add(routines_locales.get_string("Update JavaRa Definitions"), imageKey);
                update = JavaRa.My.Resources.Resources.tools;
                this.ExecutableImages.Images.Add(routines_locales.get_string("Additional Tasks"), update);
                imageKey = routines_locales.get_string("Additional Tasks");
                this.lvTools.Items.Add(routines_locales.get_string("Additional Tasks"), imageKey);
                if (this.vendor_integration)
                {
                    update = JavaRa.My.Resources.Resources.security;
                    this.ExecutableImages.Images.Add(routines_locales.get_string("Upgrade your Anti-Virus"), update);
                    imageKey = routines_locales.get_string("Upgrade your Anti-Virus");
                    this.lvTools.Items.Add(routines_locales.get_string("Upgrade your Anti-Virus"), imageKey);
                }
                this.lbTasks.Items.Add(routines_locales.get_string("Remove startup entry"));
                this.lbTasks.Items.Add(routines_locales.get_string("Check Java version"));
                this.lbTasks.Items.Add(routines_locales.get_string("Remove Outdated JRE Firefox Extensions"));
                this.lbTasks.Items.Add(routines_locales.get_string("Clean JRE Temp Files"));
            }
            catch (Exception exception1)
            {
                ProjectData.SetProjectError(exception1);
                Exception exception = exception1;
                Functions.write_error(exception);
                ProjectData.ClearProjectError();
            }
            if (!this.boxPreserveUISize.Checked)
            {
                this.Width = 460;
                this.Height = 260;
            }
            routines_interface.return_home();
        }

        private void Return_Button_Click(object sender, EventArgs e)
        {
            routines_interface.return_home();
        }

        public void show_threaded_dialog()
        {
            this.lblTitle.BeginInvoke(new ShowNotification(this.UI_Thread_Show_Notification), new object[] { false });
        }

        private void UI_FormClosed(object sender, FormClosedEventArgs e)
        {
            if (this.reboot)
            {
                Process.Start(Assembly.GetExecutingAssembly().GetModules()[0].FullyQualifiedName);
            }
            if (System.IO.File.Exists(Path.GetDirectoryName(Assembly.GetEntryAssembly().Location) + @"\localizations\output_strings.true") & (routines_locales.language != "English"))
            {
                foreach (string str in routines_locales.untranslated_strings)
                {
                    try
                    {
                        TextWriter writer = System.IO.File.AppendText(Path.GetDirectoryName(Assembly.GetEntryAssembly().Location) + @"\debug-errors." + routines_locales.language.ToUpper() + ".log");
                        writer.WriteLine(str);
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

        private void UI_FormClosing(object sender, FormClosingEventArgs e)
        {
            try
            {
                if (MyProject.Computer.FileSystem.FileExists(this.config_file))
                {
                    MyProject.Computer.FileSystem.DeleteFile(this.config_file);
                }
                TextWriter writer = System.IO.File.AppendText(this.config_file);
                if (routines_locales.language != "English")
                {
                    writer.WriteLine("Language:" + routines_locales.language);
                }
                if (!this.boxUpdateCheck.Checked)
                {
                    writer.WriteLine("UpdateCheck:False");
                }
                if (this.boxPreserveUISize.Checked)
                {
                    writer.WriteLine("WindowHeight:" + Conversions.ToString(this.Height));
                    writer.WriteLine("WindowWidth:" + Conversions.ToString(this.Width));
                }
                writer.Close();
                if (System.IO.File.Exists(this.config_file) && (MyProject.Computer.FileSystem.GetFileInfo(this.config_file).Length == 0L))
                {
                    MyProject.Computer.FileSystem.DeleteFile(this.config_file);
                }
            }
            catch (Exception exception1)
            {
                ProjectData.SetProjectError(exception1);
                Exception exception = exception1;
                ProjectData.ClearProjectError();
            }
        }

        public void UI_Thread_Show_Notification(bool data)
        {
            if (MessageBox.Show(routines_locales.get_string("A new version of JavaRa is available! Visit download page?"), routines_locales.get_string("Update Available"), MessageBoxButtons.YesNo) == DialogResult.Yes)
            {
                Process.Start("http://singularlabs.com/software/javara/javara-download/");
            }
        }

        internal virtual BackgroundWorker BackgroundWorker1
        {
            get => 
                this._BackgroundWorker1;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                DoWorkEventHandler handler = new DoWorkEventHandler(this.BackgroundWorker1_DoWork);
                if (this._BackgroundWorker1 != null)
                {
                    this._BackgroundWorker1.DoWork -= handler;
                }
                this._BackgroundWorker1 = value;
                if (this._BackgroundWorker1 != null)
                {
                    this._BackgroundWorker1.DoWork += handler;
                }
            }
        }

        internal virtual RadioButton boxDownloadJRE
        {
            get => 
                this._boxDownloadJRE;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._boxDownloadJRE = value;
            }
        }

        internal virtual RadioButton boxJucheck
        {
            get => 
                this._boxJucheck;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._boxJucheck = value;
            }
        }

        internal virtual ComboBox boxLanguage
        {
            get => 
                this._boxLanguage;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.boxLanguage_SelectedIndexChanged);
                if (this._boxLanguage != null)
                {
                    this._boxLanguage.SelectedIndexChanged -= handler;
                }
                this._boxLanguage = value;
                if (this._boxLanguage != null)
                {
                    this._boxLanguage.SelectedIndexChanged += handler;
                }
            }
        }

        internal virtual RadioButton boxOnlineCheck
        {
            get => 
                this._boxOnlineCheck;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._boxOnlineCheck = value;
            }
        }

        internal virtual CheckBox boxPreserveUISize
        {
            get => 
                this._boxPreserveUISize;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._boxPreserveUISize = value;
            }
        }

        internal virtual CheckBox boxUpdateCheck
        {
            get => 
                this._boxUpdateCheck;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._boxUpdateCheck = value;
            }
        }

        internal virtual ToolStripButton btnAbout
        {
            get => 
                this._btnAbout;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.btnAbout_Click_1);
                if (this._btnAbout != null)
                {
                    this._btnAbout.Click -= handler;
                }
                this._btnAbout = value;
                if (this._btnAbout != null)
                {
                    this._btnAbout.Click += handler;
                }
            }
        }

        internal virtual Button btnCleanup
        {
            get => 
                this._btnCleanup;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.btnCleanup_Click);
                if (this._btnCleanup != null)
                {
                    this._btnCleanup.Click -= handler;
                }
                this._btnCleanup = value;
                if (this._btnCleanup != null)
                {
                    this._btnCleanup.Click += handler;
                }
            }
        }

        internal virtual RadioButton btnCloseApp
        {
            get => 
                this._btnCloseApp;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._btnCloseApp = value;
            }
        }

        internal virtual RadioButton btnCloseWiz
        {
            get => 
                this._btnCloseWiz;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._btnCloseWiz = value;
            }
        }

        internal virtual Button btnDownload
        {
            get => 
                this._btnDownload;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.btnDownload_Click);
                if (this._btnDownload != null)
                {
                    this._btnDownload.Click -= handler;
                }
                this._btnDownload = value;
                if (this._btnDownload != null)
                {
                    this._btnDownload.Click += handler;
                }
            }
        }

        internal virtual Button btnPrev1
        {
            get => 
                this._btnPrev1;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.btnPrev1_Click);
                if (this._btnPrev1 != null)
                {
                    this._btnPrev1.Click -= handler;
                }
                this._btnPrev1 = value;
                if (this._btnPrev1 != null)
                {
                    this._btnPrev1.Click += handler;
                }
            }
        }

        internal virtual Button btnRemoveKeys
        {
            get => 
                this._btnRemoveKeys;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.btnRemoveKeys_Click);
                if (this._btnRemoveKeys != null)
                {
                    this._btnRemoveKeys.Click -= handler;
                }
                this._btnRemoveKeys = value;
                if (this._btnRemoveKeys != null)
                {
                    this._btnRemoveKeys.Click += handler;
                }
            }
        }

        internal virtual Button btnRun
        {
            get => 
                this._btnRun;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.btnRun_Click);
                if (this._btnRun != null)
                {
                    this._btnRun.Click -= handler;
                }
                this._btnRun = value;
                if (this._btnRun != null)
                {
                    this._btnRun.Click += handler;
                }
            }
        }

        internal virtual Button btnRunUninstaller
        {
            get => 
                this._btnRunUninstaller;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.btnRunUninstaller_Click);
                if (this._btnRunUninstaller != null)
                {
                    this._btnRunUninstaller.Click -= handler;
                }
                this._btnRunUninstaller = value;
                if (this._btnRunUninstaller != null)
                {
                    this._btnRunUninstaller.Click += handler;
                }
            }
        }

        internal virtual Button btnSave
        {
            get => 
                this._btnSave;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._btnSave = value;
            }
        }

        internal virtual Button btnSaveLang
        {
            get => 
                this._btnSaveLang;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.btnSaveLang_Click);
                if (this._btnSaveLang != null)
                {
                    this._btnSaveLang.Click -= handler;
                }
                this._btnSaveLang = value;
                if (this._btnSaveLang != null)
                {
                    this._btnSaveLang.Click += handler;
                }
            }
        }

        internal virtual ToolStripButton btnSettings
        {
            get => 
                this._btnSettings;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.btnSettings_Click);
                if (this._btnSettings != null)
                {
                    this._btnSettings.Click -= handler;
                }
                this._btnSettings = value;
                if (this._btnSettings != null)
                {
                    this._btnSettings.Click += handler;
                }
            }
        }

        internal virtual Button btnStep1
        {
            get => 
                this._btnStep1;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.btnStep1_Click);
                if (this._btnStep1 != null)
                {
                    this._btnStep1.Click -= handler;
                }
                this._btnStep1 = value;
                if (this._btnStep1 != null)
                {
                    this._btnStep1.Click += handler;
                }
            }
        }

        internal virtual Button btnStep2
        {
            get => 
                this._btnStep2;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.btnStep2_Click);
                if (this._btnStep2 != null)
                {
                    this._btnStep2.Click -= handler;
                }
                this._btnStep2 = value;
                if (this._btnStep2 != null)
                {
                    this._btnStep2.Click += handler;
                }
            }
        }

        internal virtual Button btnUpdateDefs
        {
            get => 
                this._btnUpdateDefs;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.btnUpdateDefs_click);
                if (this._btnUpdateDefs != null)
                {
                    this._btnUpdateDefs.Click -= handler;
                }
                this._btnUpdateDefs = value;
                if (this._btnUpdateDefs != null)
                {
                    this._btnUpdateDefs.Click += handler;
                }
            }
        }

        internal virtual Button btnUpdateJavaPrevious
        {
            get => 
                this._btnUpdateJavaPrevious;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.Return_Button_Click);
                if (this._btnUpdateJavaPrevious != null)
                {
                    this._btnUpdateJavaPrevious.Click -= handler;
                }
                this._btnUpdateJavaPrevious = value;
                if (this._btnUpdateJavaPrevious != null)
                {
                    this._btnUpdateJavaPrevious.Click += handler;
                }
            }
        }

        internal virtual Button btnUpdateNext
        {
            get => 
                this._btnUpdateNext;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.btnUpdateNext_Click);
                if (this._btnUpdateNext != null)
                {
                    this._btnUpdateNext.Click -= handler;
                }
                this._btnUpdateNext = value;
                if (this._btnUpdateNext != null)
                {
                    this._btnUpdateNext.Click += handler;
                }
            }
        }

        internal virtual Button Button1
        {
            get => 
                this._Button1;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.Button1_Click);
                if (this._Button1 != null)
                {
                    this._Button1.Click -= handler;
                }
                this._Button1 = value;
                if (this._Button1 != null)
                {
                    this._Button1.Click += handler;
                }
            }
        }

        internal virtual Button Button11
        {
            get => 
                this._Button11;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.Return_Button_Click);
                if (this._Button11 != null)
                {
                    this._Button11.Click -= handler;
                }
                this._Button11 = value;
                if (this._Button11 != null)
                {
                    this._Button11.Click += handler;
                }
            }
        }

        internal virtual Button Button12
        {
            get => 
                this._Button12;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.Return_Button_Click);
                if (this._Button12 != null)
                {
                    this._Button12.Click -= handler;
                }
                this._Button12 = value;
                if (this._Button12 != null)
                {
                    this._Button12.Click += handler;
                }
            }
        }

        internal virtual Button Button2
        {
            get => 
                this._Button2;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.Return_Button_Click);
                if (this._Button2 != null)
                {
                    this._Button2.Click -= handler;
                }
                this._Button2 = value;
                if (this._Button2 != null)
                {
                    this._Button2.Click += handler;
                }
            }
        }

        internal virtual Button Button3
        {
            get => 
                this._Button3;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.Button3_Click);
                if (this._Button3 != null)
                {
                    this._Button3.Click -= handler;
                }
                this._Button3 = value;
                if (this._Button3 != null)
                {
                    this._Button3.Click += handler;
                }
            }
        }

        internal virtual Button Button4
        {
            get => 
                this._Button4;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.Button4_Click);
                if (this._Button4 != null)
                {
                    this._Button4.Click -= handler;
                }
                this._Button4 = value;
                if (this._Button4 != null)
                {
                    this._Button4.Click += handler;
                }
            }
        }

        internal virtual Button Button5
        {
            get => 
                this._Button5;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.Button5_Click);
                if (this._Button5 != null)
                {
                    this._Button5.Click -= handler;
                }
                this._Button5 = value;
                if (this._Button5 != null)
                {
                    this._Button5.Click += handler;
                }
            }
        }

        internal virtual Button Button7
        {
            get => 
                this._Button7;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.Button7_Click);
                if (this._Button7 != null)
                {
                    this._Button7.Click -= handler;
                }
                this._Button7 = value;
                if (this._Button7 != null)
                {
                    this._Button7.Click += handler;
                }
            }
        }

        internal virtual Button Button8
        {
            get => 
                this._Button8;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.Return_Button_Click);
                if (this._Button8 != null)
                {
                    this._Button8.Click -= handler;
                }
                this._Button8 = value;
                if (this._Button8 != null)
                {
                    this._Button8.Click += handler;
                }
            }
        }

        internal virtual Button Button9
        {
            get => 
                this._Button9;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.Return_Button_Click);
                if (this._Button9 != null)
                {
                    this._Button9.Click -= handler;
                }
                this._Button9 = value;
                if (this._Button9 != null)
                {
                    this._Button9.Click += handler;
                }
            }
        }

        internal virtual ComboBox cboVersion
        {
            get => 
                this._cboVersion;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._cboVersion = value;
            }
        }

        internal virtual ImageList ExecutableImages
        {
            get => 
                this._ExecutableImages;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._ExecutableImages = value;
            }
        }

        internal virtual Label Label10
        {
            get => 
                this._Label10;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Label10 = value;
            }
        }

        internal virtual Label Label11
        {
            get => 
                this._Label11;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Label11 = value;
            }
        }

        internal virtual Label Label12
        {
            get => 
                this._Label12;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Label12 = value;
            }
        }

        internal virtual Label Label14
        {
            get => 
                this._Label14;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Label14 = value;
            }
        }

        internal virtual Label Label16
        {
            get => 
                this._Label16;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Label16 = value;
            }
        }

        internal virtual Label Label19
        {
            get => 
                this._Label19;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Label19 = value;
            }
        }

        internal virtual Label Label21
        {
            get => 
                this._Label21;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Label21 = value;
            }
        }

        internal virtual Label Label3
        {
            get => 
                this._Label3;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Label3 = value;
            }
        }

        internal virtual Label Label4
        {
            get => 
                this._Label4;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Label4 = value;
            }
        }

        internal virtual Label Label5
        {
            get => 
                this._Label5;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Label5 = value;
            }
        }

        internal virtual Label Label6
        {
            get => 
                this._Label6;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Label6 = value;
            }
        }

        internal virtual Label Label7
        {
            get => 
                this._Label7;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Label7 = value;
            }
        }

        internal virtual Label Label9
        {
            get => 
                this._Label9;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Label9 = value;
            }
        }

        internal virtual Label lblCompleted
        {
            get => 
                this._lblCompleted;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._lblCompleted = value;
            }
        }

        internal virtual Label lblDownloadNewVersion
        {
            get => 
                this._lblDownloadNewVersion;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._lblDownloadNewVersion = value;
            }
        }

        internal virtual Label lblStep1
        {
            get => 
                this._lblStep1;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._lblStep1 = value;
            }
        }

        internal virtual Label lblStep2
        {
            get => 
                this._lblStep2;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._lblStep2 = value;
            }
        }

        internal virtual Label lblStepOne
        {
            get => 
                this._lblStepOne;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._lblStepOne = value;
            }
        }

        internal virtual Label lblTitle
        {
            get => 
                this._lblTitle;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._lblTitle = value;
            }
        }

        internal virtual Label lblUpdateDefs
        {
            get => 
                this._lblUpdateDefs;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._lblUpdateDefs = value;
            }
        }

        internal virtual Label lblVersion
        {
            get => 
                this._lblVersion;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._lblVersion = value;
            }
        }

        internal virtual CheckedListBox lbTasks
        {
            get => 
                this._lbTasks;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._lbTasks = value;
            }
        }

        internal virtual LinkLabel LinkLabel1
        {
            get => 
                this._LinkLabel1;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                LinkLabelLinkClickedEventHandler handler = new LinkLabelLinkClickedEventHandler(this.LinkLabel1_LinkClicked);
                if (this._LinkLabel1 != null)
                {
                    this._LinkLabel1.LinkClicked -= handler;
                }
                this._LinkLabel1 = value;
                if (this._LinkLabel1 != null)
                {
                    this._LinkLabel1.LinkClicked += handler;
                }
            }
        }

        internal virtual ListView lvTools
        {
            get => 
                this._lvTools;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                EventHandler handler = new EventHandler(this.lvTools_Click);
                if (this._lvTools != null)
                {
                    this._lvTools.Click -= handler;
                }
                this._lvTools = value;
                if (this._lvTools != null)
                {
                    this._lvTools.Click += handler;
                }
            }
        }

        internal virtual Panel Panel1
        {
            get => 
                this._Panel1;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Panel1 = value;
            }
        }

        internal virtual Panel Panel11
        {
            get => 
                this._Panel11;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Panel11 = value;
            }
        }

        internal virtual Panel Panel12
        {
            get => 
                this._Panel12;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Panel12 = value;
            }
        }

        internal virtual Panel Panel13
        {
            get => 
                this._Panel13;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Panel13 = value;
            }
        }

        internal virtual Panel Panel2
        {
            get => 
                this._Panel2;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Panel2 = value;
            }
        }

        internal virtual Panel Panel3
        {
            get => 
                this._Panel3;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Panel3 = value;
            }
        }

        internal virtual Panel Panel4
        {
            get => 
                this._Panel4;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Panel4 = value;
            }
        }

        internal virtual Panel Panel5
        {
            get => 
                this._Panel5;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Panel5 = value;
            }
        }

        internal virtual Panel Panel6
        {
            get => 
                this._Panel6;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Panel6 = value;
            }
        }

        internal virtual Panel Panel7
        {
            get => 
                this._Panel7;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Panel7 = value;
            }
        }

        internal virtual Panel Panel8
        {
            get => 
                this._Panel8;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Panel8 = value;
            }
        }

        internal virtual Panel Panel9
        {
            get => 
                this._Panel9;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Panel9 = value;
            }
        }

        internal virtual Panel PanelExtra
        {
            get => 
                this._PanelExtra;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._PanelExtra = value;
            }
        }

        internal virtual Panel PanelSettings
        {
            get => 
                this._PanelSettings;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._PanelSettings = value;
            }
        }

        internal virtual Panel pnlAbout
        {
            get => 
                this._pnlAbout;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._pnlAbout = value;
            }
        }

        internal virtual Panel pnlCleanup
        {
            get => 
                this._pnlCleanup;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._pnlCleanup = value;
            }
        }

        internal virtual Panel pnlCompleted
        {
            get => 
                this._pnlCompleted;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._pnlCompleted = value;
            }
        }

        internal virtual Panel pnlDownload
        {
            get => 
                this._pnlDownload;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._pnlDownload = value;
            }
        }

        internal virtual Panel pnlRemoval
        {
            get => 
                this._pnlRemoval;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._pnlRemoval = value;
            }
        }

        internal virtual Panel pnlTopDock
        {
            get => 
                this._pnlTopDock;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._pnlTopDock = value;
            }
        }

        internal virtual Panel pnlUpdate
        {
            get => 
                this._pnlUpdate;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._pnlUpdate = value;
            }
        }

        internal virtual Panel pnlUpdateJRE
        {
            get => 
                this._pnlUpdateJRE;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._pnlUpdateJRE = value;
            }
        }

        internal virtual ProgressBar ProgressBar1
        {
            get => 
                this._ProgressBar1;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._ProgressBar1 = value;
            }
        }

        internal virtual ProgressBar ProgressBar2
        {
            get => 
                this._ProgressBar2;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._ProgressBar2 = value;
            }
        }

        internal virtual ProgressBar ProgressBar3
        {
            get => 
                this._ProgressBar3;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._ProgressBar3 = value;
            }
        }

        internal virtual ProgressBar ProgressBar4
        {
            get => 
                this._ProgressBar4;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._ProgressBar4 = value;
            }
        }

        internal virtual Panel Step1
        {
            get => 
                this._Step1;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._Step1 = value;
            }
        }

        internal virtual ToolStrip ToolStrip1
        {
            get => 
                this._ToolStrip1;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._ToolStrip1 = value;
            }
        }

        internal virtual ToolTip ToolTip1
        {
            get => 
                this._ToolTip1;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._ToolTip1 = value;
            }
        }

        internal virtual TextBox txtFileName
        {
            get => 
                this._txtFileName;
            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                this._txtFileName = value;
            }
        }

        public delegate void ChangeTextsSafe(long length, int position, int percent, double speed);

        public delegate void DownloadCompleteSafe(bool cancelled);

        public delegate void ShowNotification(bool data);
    }
}

