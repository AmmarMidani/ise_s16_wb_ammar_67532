using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ISE_S16_WB
{
    public partial class UC_FriendCard : System.Web.UI.UserControl
    {
        private long _FriendID;
        SocialMediaEntities dbe = new SocialMediaEntities();
        User u;
        User Friend;
        public long FriendID
        {
            get { return _FriendID; }
            set { _FriendID = value; }
        }
        public bool IsFriend()
        {
            int FriendNumber = dbe.FriendshipRequests.Where(m =>
                                                    (m.FromUser.ID == u.ID && m.ToUser.ID == Friend.ID)
                                                 || (m.ToUser.ID == u.ID && m.FromUser.ID == Friend.ID)
                                            ).ToList().Count;
            if (FriendNumber > 0)
            {
                return true;
            }
            return false;
        }
        public int RequestType()
        {
            try
            {
                return dbe.FriendshipRequests.Where(m =>
                               (m.FromUser.ID == u.ID && m.ToUser.ID == Friend.ID)
                            || (m.ToUser.ID == u.ID && m.FromUser.ID == Friend.ID)).ToList().Last().RelationStatus;
            }
            catch (Exception ex)
            {
                return 0;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            u = (User)Session["User"];
            Friend = dbe.Users.Find(this._FriendID);
            if (Friend != null)
            {
                if (Friend.PersonalImageURL == String.Empty || Friend.PersonalImageURL == null)
                {
                    if (Friend.Gender)
                    {
                        this.FriendImage.ImageUrl = ResolveUrl("~/UserImages/MPlaceHolder.jpg");
                    }
                    else
                    {
                        this.FriendImage.ImageUrl = ResolveUrl("~/UserImages/FPlaceHolder.jpg");
                    }
                }
                else
                {
                    this.FriendImage.ImageUrl = ResolveUrl("~/UserImages/") + Friend.PersonalImageURL;
                }
                this.FriendName.InnerText = this.CoverImage.AlternateText = this.FriendImage.AlternateText = Friend.Firstname + " " + Friend.Lastname;
                if (Friend.WallImageURL == String.Empty || Friend.WallImageURL == null)
                {
                    this.CoverImage.ImageUrl = ResolveUrl("~/UserCovers/Placeholder.jpg");
                }
                else
                {
                    this.CoverImage.ImageUrl = ResolveUrl("~/UserCovers/") + Friend.WallImageURL;
                }
                this.FriendName.HRef = ResolveUrl("~/About.aspx?u=" + Friend.ID);
                if (IsFriend())
                {
                    switch (RequestType())
                    {
                        case 0:
                            //this.btn_AddFriend.Visible = false;
                            this.Label_Friend.Visible = true;
                            this.Label_Friend.InnerText = "Sent";
                            break;
                        case 1:
                            //this.btn_AddFriend.Visible = false;
                            this.Label_Friend.Visible = true;
                            this.Label_Friend.InnerText = "Friend";
                            break;
                        default:
                            //this.btn_AddFriend.Visible = false;
                            break;
                    }
                }
                else
                {
                    //this.btn_AddFriend.Visible = true;
                }
            }
        }
    }
}