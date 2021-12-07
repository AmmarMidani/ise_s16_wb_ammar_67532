using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace ISE_S16_WB
{
    public class Global : System.Web.HttpApplication
    {
        SocialMediaEntities dbe = new SocialMediaEntities();
        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {
            try
            {
                User u = (User)Session["User"];
                u = dbe.Users.SingleOrDefault(m => m.ID == u.ID);
                u.IsOnline = false;
                u.LastSeen = DateTime.Now;
                dbe.SaveChanges();
            }
            catch (Exception ex)
            {
            }
        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}