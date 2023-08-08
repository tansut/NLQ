using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Security.Principal;
using System.Threading;
using System.Configuration;
using System.Globalization;

namespace JDash.WebForms.Demo
{
    public class Global : System.Web.HttpApplication
    {

        private bool useSessionProvider
        {
            get
            {
                return HttpContext.Current.Request.Url.Host.ToLowerInvariant().EndsWith("jdash.net");
            }
        }

        protected void Application_Start(object sender, EventArgs e)
        {
            RouteConfig.RegisterRoutes(RouteTable.Routes);
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            if (useSessionProvider)
            {
                JDashManager.ChangeProvider("SessionStateProvider");
                var sessionProvider = JDashManager.Providers["SessionStateProvider"];
                sessionProvider.GetType().GetMethod("InitializeSession").Invoke(sessionProvider,
                    new object[] { "SQLDashboardProvider" });
            }
        }

        private void SetUserLocale()
        {
            string Lang;
            HttpRequest Request = HttpContext.Current.Request;
            if (Request.UserLanguages == null)
                Lang = "en-us";
            else Lang = Request.UserLanguages[0];

            // Remove below line for localization.
            Lang = "en-us";

            if (Lang != null)
            {
                try
                {
                    CultureInfo culture = new CultureInfo(Lang);
                    System.Threading.Thread.CurrentThread.CurrentCulture = culture;
                    Thread.CurrentThread.CurrentUICulture = culture;
                }
                catch
                { }
            }
        }
        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            if (!this.Request.Url.Host.StartsWith("www") && !this.Request.Url.IsLoopback)
            {
                var url = new UriBuilder(this.Request.Url);
                url.Host = "www." + this.Request.Url.Host;
                this.Response.RedirectPermanent(url.ToString(), true);
            } else SetUserLocale();
        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AcquireRequestState(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}
