namespace JavaRa
{
    using Microsoft.VisualBasic.CompilerServices;
    using System;

    public class JREInstallObject
    {
        private bool _installed = true;
        private string app_name;
        private string uninstall_string;
        private string version_number;

        public JREInstallObject(string name, string version, string uninstall)
        {
            this.app_name = name;
            this.version_number = version;
            this.uninstall_string = uninstall;
        }

        public object Installed
        {
            get => 
                this._installed;
            set
            {
                this._installed = Conversions.ToBoolean(value);
            }
        }

        public object Name =>
            this.app_name;

        public object UninstallString =>
            this.uninstall_string;

        public object Version =>
            this.version_number;
    }
}

