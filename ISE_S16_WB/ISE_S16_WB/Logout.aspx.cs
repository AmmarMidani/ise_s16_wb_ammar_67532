using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ISE_S16_WB
{
    public partial class Logout : System.Web.UI.Page
    {
        SocialMediaEntities dbe = new SocialMediaEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["User"] == null)
                {
                    Response.Redirect(ResolveUrl("~/Login/Login.aspx"));
                    return;
                }
                User u = (User)Session["User"];
                u = dbe.Users.Find(u.ID);
                u.LastSeen = DateTime.Now;
                u.IsOnline = false;
                dbe.SaveChanges();

                Session.Clear();
                Session.Remove("User");
                Session.RemoveAll();
                Session.Abandon();
                Response.Redirect(ResolveUrl("~/Login/Login.aspx"));
            }
            catch (Exception ex)
            {
                Response.Redirect(ResolveUrl("~/Login/Login.aspx"));
            }
            
        }
    }
}