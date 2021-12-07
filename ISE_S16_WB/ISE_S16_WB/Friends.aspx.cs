using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ISE_S16_WB
{
    public partial class Friends : System.Web.UI.Page
    {
        SocialMediaEntities dbe = new SocialMediaEntities();
        User u = new User();
        public int GetFriendsCount(long UserID)
        {
            try
            {
                ISE_S16_WB.User uu = dbe.Users.Find(UserID);
                int fr_u = 0;
                fr_u = dbe.FriendshipRequests.Where(m => m.RelationStatus == 1
                                        && (m.FromUserID == uu.ID || m.ToUserID == uu.ID))
                                        .ToList().Count;
                return fr_u;
            }
            catch (Exception ex)
            {
                return 0;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                Response.Redirect(ResolveUrl("~/Login/Login.aspx"));
            }
            u = (User)Session["User"];
            u = dbe.Users.Find(u.ID);
            if (u.PersonalImageURL == String.Empty || u.PersonalImageURL == null)
            {
                if (u.Gender)
                {
                    this.PersonImage.ImageUrl = this.PersonImage_small.ImageUrl = ResolveUrl("~/UserImages/MPlaceHolder.jpg");
                }
                else
                {
                    this.PersonImage.ImageUrl = this.PersonImage_small.ImageUrl = ResolveUrl("~/UserImages/FPlaceHolder.jpg");
                }
            }
            else
            {
                this.PersonImage.ImageUrl = this.PersonImage_small.ImageUrl = ResolveUrl("~/UserImages/") + u.PersonalImageURL;
            }
            this.UserName.InnerText = this.UserName_small.InnerText =
                this.PersonImage.AlternateText = this.PersonImage_small.AlternateText =
                this.Title = u.Firstname + " " + u.Lastname;
            if (u.WallImageURL == String.Empty || u.WallImageURL == null)
            {
                this.UserCover.Style["background"] = "url(" + ResolveUrl("~/UserCovers/Placeholder.jpg") + ") no-repeat";
            }
            else
            {
                this.UserCover.Style["background"] = "url(" + ResolveUrl("~/UserCovers/" + u.WallImageURL) + ") no-repeat";
            }
            this.UserCover.Style["background-size"] = "cover";
            this.lbl_FriendNumber.Text = GetFriendsCount(u.ID).ToString();
            try
            {
                var qq = dbe.FriendshipRequests
                   .Where(m => m.RelationStatus == 1 && (m.FromUserID == u.ID || m.ToUserID == u.ID))
                   .OrderByDescending(m => m.EventDateTime)
                   .ToList();
                List<long> IDs = new List<long>();
                for (int i = 0; i < qq.Count; i++)
                {
                    if (qq[i].FromUserID == u.ID)
                    {
                        IDs.Add(qq[i].ToUserID);
                    }
                    else
                    {
                        IDs.Add(qq[i].FromUserID);
                    }
                }
                IDs = IDs.Distinct().ToList();
                var MyFriends = dbe.Users.Where(m => IDs.Contains(m.ID))
                    .ToList();
                
                for (int i = 0; i < MyFriends.Count; i++)
                {
                    UC_FriendCard p = (UC_FriendCard)LoadControl(ResolveUrl("~/UserControl/UC_FriendCard.ascx"));
                    p.FriendID = MyFriends[i].ID;
                    this.AllFriends.Controls.Add(p);
                }
            }
            catch (Exception ex){}
        }
    }
}