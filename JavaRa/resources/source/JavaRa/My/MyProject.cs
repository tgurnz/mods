namespace JavaRa.My
{
    using JavaRa;
    using Microsoft.VisualBasic;
    using Microsoft.VisualBasic.ApplicationServices;
    using Microsoft.VisualBasic.CompilerServices;
    using System;
    using System.CodeDom.Compiler;
    using System.Collections;
    using System.ComponentModel;
    using System.ComponentModel.Design;
    using System.Diagnostics;
    using System.Reflection;
    using System.Runtime.CompilerServices;
    using System.Runtime.InteropServices;

    [HideModuleName, GeneratedCode("MyTemplate", "8.0.0.0"), StandardModule]
    internal sealed class MyProject
    {
        private static readonly ThreadSafeObjectProvider<MyApplication> m_AppObjectProvider = new ThreadSafeObjectProvider<MyApplication>();
        private static readonly ThreadSafeObjectProvider<MyComputer> m_ComputerObjectProvider = new ThreadSafeObjectProvider<MyComputer>();
        private static ThreadSafeObjectProvider<MyForms> m_MyFormsObjectProvider = new ThreadSafeObjectProvider<MyForms>();
        private static readonly ThreadSafeObjectProvider<MyWebServices> m_MyWebServicesObjectProvider = new ThreadSafeObjectProvider<MyWebServices>();
        private static readonly ThreadSafeObjectProvider<Microsoft.VisualBasic.ApplicationServices.User> m_UserObjectProvider = new ThreadSafeObjectProvider<Microsoft.VisualBasic.ApplicationServices.User>();

        [HelpKeyword("My.Application")]
        internal static MyApplication Application =>
            m_AppObjectProvider.GetInstance;

        [HelpKeyword("My.Computer")]
        internal static MyComputer Computer =>
            m_ComputerObjectProvider.GetInstance;

        [HelpKeyword("My.Forms")]
        internal static MyForms Forms =>
            m_MyFormsObjectProvider.GetInstance;

        [HelpKeyword("My.User")]
        internal static Microsoft.VisualBasic.ApplicationServices.User User =>
            m_UserObjectProvider.GetInstance;

        [HelpKeyword("My.WebServices")]
        internal static MyWebServices WebServices =>
            m_MyWebServicesObjectProvider.GetInstance;

        [MyGroupCollection("System.Windows.Forms.Form", "Create__Instance__", "Dispose__Instance__", "My.MyProject.Forms"), EditorBrowsable(EditorBrowsableState.Never)]
        internal sealed class MyForms
        {
            [ThreadStatic]
            private static Hashtable m_FormBeingCreated;
            public JavaRa.UI m_UI;

            [DebuggerHidden]
            private static T Create__Instance__<T>(T Instance) where T: Form, new()
            {
                T local;
                TargetInvocationException exception;
                if ((Instance != null) && !Instance.IsDisposed)
                {
                    return Instance;
                }
                if (m_FormBeingCreated != null)
                {
                    if (m_FormBeingCreated.ContainsKey(typeof(T)))
                    {
                        throw new InvalidOperationException(Utils.GetResourceString("WinForms_RecursiveFormCreate", new string[0]));
                    }
                }
                else
                {
                    m_FormBeingCreated = new Hashtable();
                }
                m_FormBeingCreated.Add(typeof(T), null);
                try
                {
                    local = Activator.CreateInstance<T>();
                }
                catch (TargetInvocationException exception1) when ((exception.InnerException != null))
                {
                    ProjectData.SetProjectError(exception = exception1);
                    throw new InvalidOperationException(Utils.GetResourceString("WinForms_SeeInnerException", new string[] { exception.InnerException.Message }), exception.InnerException);
                }
                finally
                {
                    m_FormBeingCreated.Remove(typeof(T));
                }
                return local;
            }

            [DebuggerHidden]
            private void Dispose__Instance__<T>(ref T instance) where T: Form
            {
                instance.Dispose();
                instance = default(T);
            }

            [EditorBrowsable(EditorBrowsableState.Never)]
            public override bool Equals(object o) => 
                base.Equals(RuntimeHelpers.GetObjectValue(o));

            [EditorBrowsable(EditorBrowsableState.Never)]
            public override int GetHashCode() => 
                base.GetHashCode();

            [EditorBrowsable(EditorBrowsableState.Never)]
            internal Type GetType() => 
                typeof(MyProject.MyForms);

            [EditorBrowsable(EditorBrowsableState.Never)]
            public override string ToString() => 
                base.ToString();

            public JavaRa.UI UI
            {
                get
                {
                    this.m_UI = Create__Instance__<JavaRa.UI>(this.m_UI);
                    return this.m_UI;
                }
                set
                {
                    if (value != this.m_UI)
                    {
                        if (value != null)
                        {
                            throw new ArgumentException("Property can only be set to Nothing");
                        }
                        this.Dispose__Instance__<JavaRa.UI>(ref this.m_UI);
                    }
                }
            }
        }

        [EditorBrowsable(EditorBrowsableState.Never), MyGroupCollection("System.Web.Services.Protocols.SoapHttpClientProtocol", "Create__Instance__", "Dispose__Instance__", "")]
        internal sealed class MyWebServices
        {
            [DebuggerHidden]
            private static T Create__Instance__<T>(T instance) where T: new()
            {
                if (instance == null)
                {
                    return Activator.CreateInstance<T>();
                }
                return instance;
            }

            [DebuggerHidden]
            private void Dispose__Instance__<T>(ref T instance)
            {
                instance = default(T);
            }

            [DebuggerHidden, EditorBrowsable(EditorBrowsableState.Never)]
            public override bool Equals(object o) => 
                base.Equals(RuntimeHelpers.GetObjectValue(o));

            [DebuggerHidden, EditorBrowsable(EditorBrowsableState.Never)]
            public override int GetHashCode() => 
                base.GetHashCode();

            [EditorBrowsable(EditorBrowsableState.Never), DebuggerHidden]
            internal Type GetType() => 
                typeof(MyProject.MyWebServices);

            [EditorBrowsable(EditorBrowsableState.Never), DebuggerHidden]
            public override string ToString() => 
                base.ToString();
        }

        [EditorBrowsable(EditorBrowsableState.Never), ComVisible(false)]
        internal sealed class ThreadSafeObjectProvider<T> where T: new()
        {
            [ThreadStatic, CompilerGenerated]
            private static T m_ThreadStaticValue;

            internal T GetInstance
            {
                [DebuggerHidden]
                get
                {
                    if (MyProject.ThreadSafeObjectProvider<T>.m_ThreadStaticValue == null)
                    {
                        MyProject.ThreadSafeObjectProvider<T>.m_ThreadStaticValue = Activator.CreateInstance<T>();
                    }
                    return MyProject.ThreadSafeObjectProvider<T>.m_ThreadStaticValue;
                }
            }
        }
    }
}

