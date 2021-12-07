using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ISE_S16_WB
{
    public partial class Signup : System.Web.UI.Page
    {
        SocialMediaEntities dbe = new SocialMediaEntities();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void button_submit_Click(object sender, EventArgs e)
        {
            if (this.textbox_Username.Text.Trim() != String.Empty
                && this.textbox_Password.Text != String.Empty
                && this.textbox_ConfirmPassword.Text != String.Empty
                && this.textbox_Email.Text.Trim() != String.Empty
                && this.textbox_FirstName.Text.Trim() != String.Empty
                && this.textbox_LastName.Text.Trim() != String.Empty
                )
            {
                int a = 0;
                a = dbe.Users.Where(m => m.Username == this.textbox_Username.Text.Trim()).ToArray().Count();
                if (a > 0)
                {
                    this.lbl_status.Text = "Username ( " + this.textbox_Username.Text.Trim() + " ) Is exist";
                    this.lbl_status.Visible = true;
                    return;
                }
                a = dbe.Users.Where(m => m.Email == this.textbox_Email.Text.Trim()).ToArray().Count();
                if (a > 0)
                {
                    this.lbl_status.Text = "( " + this.textbox_Email.Text.Trim() + " ) Is exist";
                    this.lbl_status.Visible = true;
                    return;
                }

                User u = dbe.Users.Add(new User()
                {
                    Email = this.textbox_Email.Text.Trim(),
                    Firstname = this.textbox_FirstName.Text.Trim(),
                    Lastname = this.textbox_LastName.Text.Trim(),
                    IsOnline = true,
                    LastSeen = DateTime.Now,
                    Map_Lat = "0",
                    Map_Lon = "0",
                    Password = MyMD5.GetMd5Hash(this.textbox_Password.Text.Trim()),
                    Username = this.textbox_Username.Text.Trim(),
                    Gender = this.radio_gender_male.Checked,
                    RegisterationDate = DateTime.Now
                });
                dbe.SaveChanges();
                Session["User"] = u;
                Response.Redirect(ResolveUrl("~/NewsFeed.aspx"));
            }
            else
            {
                this.lbl_status.Text = "Please Fill all textboxes";
                this.lbl_status.Visible = true;
            }
        }
    }
}