using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ISE_S16_WB
{
    public partial class UC_FriendRequest : System.Web.UI.UserControl
    {
        private long _PersonID;
        private long _RequsetID;
        SocialMediaEntities dbe = new SocialMediaEntities();
        User u;
        User Person;

        public long PersonID
        {
            get { return _PersonID; }
            set { _PersonID = value; }
        }
        public long RequsetID
        {
            get { return _RequsetID; }
            set { _RequsetID = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            u = (User)Session["User"];
            Person = dbe.Users.Find(this._PersonID);
            if (Person != null)
            {
                if (Person.PersonalImageURL == String.Empty || Person.PersonalImageURL == null)
                {
                    if (Person.Gender)
                    {
                        this.PersonImage.ImageUrl = ResolveUrl("~/UserImages/MPlaceHolder.jpg");
                    }
                    else
                    {
                        this.PersonImage.ImageUrl = ResolveUrl("~/UserImages/FPlaceHolder.jpg");
                    }
                }
                else
                {
                    this.PersonImage.ImageUrl = ResolveUrl("~/UserImages/") + Person.PersonalImageURL;
                }
                this.PersonName.InnerText = this.PersonImage.AlternateText = Person.Firstname + " " + Person.Lastname;
                this.PersonName.HRef = ResolveUrl("~/About.aspx?u=" + Person.ID);
            }
        }

        protected void btn_Accept_Click(object sender, EventArgs e)
        {
            try
            {
                FriendshipRequest fr = dbe.FriendshipRequests.Find(_RequsetID);
                if (fr != null)
                {
                    fr.RelationStatus = 1;
                    fr.EventDateTime = DateTime.Now;
                    dbe.SaveChanges();
                }
            }
            catch (Exception ex) { }
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void btn_Reject_Click(object sender, EventArgs e)
        {
            try
            {
                FriendshipRequest fr = dbe.FriendshipRequests.Find(_RequsetID);
                if (fr != null)
                {
                    dbe.FriendshipRequests.Remove(fr);
                    dbe.SaveChanges();
                }
            }
            catch (Exception ex) { }
            Response.Redirect(Request.Url.AbsoluteUri);
        }
    }
}