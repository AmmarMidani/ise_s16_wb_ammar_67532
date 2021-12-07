using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ISE_S16_WB
{
    public partial class Login : System.Web.UI.Page
    {
        SocialMediaEntities dbe = new SocialMediaEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            this.textbox_Username.Focus();
        }
        protected void button_submit_Click(object sender, EventArgs e)
        {
            if (this.textbox_Username.Text.Trim() != String.Empty && this.textbox_Password.Text.Trim() != String.Empty)
            {
                string HashPassword = MyMD5.GetMd5Hash(this.textbox_Password.Text);
                User u = dbe.Users.SingleOrDefault(m => m.Username == this.textbox_Username.Text.Trim()
                                                    && m.Password == HashPassword);
                if(u != null)
                {
                    u.IsOnline = true;
                    u.LastSeen = DateTime.Now;
                    dbe.SaveChanges();
                    Session["User"] = u;
                    Response.Redirect(ResolveUrl("~/NewsFeed.aspx"));
                }
                else
                {
                    this.lbl_status.Visible = true;
                }
            }
        }
    }
}