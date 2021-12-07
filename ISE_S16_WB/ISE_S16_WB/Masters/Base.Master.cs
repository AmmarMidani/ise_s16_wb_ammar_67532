using System;
using System.Collections.Generic;
using System.Data.Entity.SqlServer;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ISE_S16_WB
{
    public partial class Base : System.Web.UI.MasterPage
    {
        SocialMediaEntities dbe = new SocialMediaEntities();
        User u = new User();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                Response.Redirect(ResolveUrl("~/Login/Login.aspx"));
            }
            u = (User)Session["User"];
            GetOnlineUsers();
            if (u.PersonalImageURL == String.Empty || u.PersonalImageURL == null)
            {
                if (u.Gender)
                {
                    this.BaseUserImage.ImageUrl = this.PublishImage.ImageUrl = ResolveUrl("~/UserImages/MPlaceHolder.jpg");
                }
                else
                {
                    this.BaseUserImage.ImageUrl = this.PublishImage.ImageUrl = ResolveUrl("~/UserImages/FPlaceHolder.jpg");
                }
            }
            else
            {
                this.BaseUserImage.ImageUrl = this.PublishImage.ImageUrl = ResolveUrl("~/UserImages/") + u.PersonalImageURL;
            }
            this.BaseUserImage.AlternateText = this.PublishImage.AlternateText = this.BaseUserNameLink.Text = u.Firstname + " " + u.Lastname;
            this.BaseUserNameLink.NavigateUrl = ResolveUrl("~/About.aspx?u=" + u.ID);
            this.BaseFriendsNumber.Text = GetFriendsCount().ToString();
            if (u.WallImageURL == String.Empty || u.WallImageURL == null)
            {
                this.BaseWallImage.Style["background"] = "url(" + ResolveUrl("~/UserCovers/Placeholder.jpg") + ") no-repeat";
            }
            else
            {
                this.BaseWallImage.Style["background"] = "url(" + ResolveUrl("~/UserCovers/" + u.WallImageURL) + ") no-repeat";
            }
            this.BaseWallImage.Style["background-size"] = "cover";
        }
        public int GetFriendsCount()
        {
            try
            {
                u = dbe.Users.Find(u.ID);
                int fr_u = 0;
                fr_u = dbe.FriendshipRequests.Where(m => m.RelationStatus == 1
                                        && (m.FromUserID == u.ID || m.ToUserID == u.ID))
                                        .ToList().Count;
                return fr_u;
            }
            catch (Exception ex)
            {
                return 0;
            }

        }
        public void GetOnlineUsers()
        {
            try
            {
                this.OnlineChat.InnerHtml = "";
                u = dbe.Users.Find(u.ID);
                List<FriendshipRequest> fr_u = dbe.FriendshipRequests.Where(
                                m => m.RelationStatus == 1
                                && ((m.FromUserID == u.ID && m.ToUser.IsOnline == true)
                                || (m.ToUserID == u.ID && m.FromUser.IsOnline == true))
                             ).OrderByDescending(x => x.FromUser.LastSeen).ThenBy(x => x.ToUser.LastSeen)
                             .ToList();

                for (int i = 0; i < fr_u.Count && i < 15; i++)
                {
                    string CommentIMGPath = "";
                    if (fr_u[i].FromUser.ID == u.ID)
                    {
                        if (fr_u[i].ToUser.PersonalImageURL == String.Empty || fr_u[i].ToUser.PersonalImageURL == null)
                        {
                            if (fr_u[i].ToUser.Gender)
                            {
                                CommentIMGPath = ResolveUrl("~/UserImages/MPlaceHolder.jpg");
                            }
                            else
                            {
                                CommentIMGPath = ResolveUrl("~/UserImages/FPlaceHolder.jpg");
                            }
                        }
                        else
                        {
                            CommentIMGPath = ResolveUrl("~/UserImages/") + fr_u[i].ToUser.PersonalImageURL;
                        }
                        this.OnlineChat.InnerHtml += String.Format("<li><a href=\"{0}\" title=\"{1} {2}\"><img src=\"{3}\" alt=\"{1} {2}\" class=\"img-responsive profile-photo\" /><span class=\"online-dot\"></span></a></li>"
                        , ResolveUrl("~/Messages.aspx?F=" + fr_u[i].ToUser.ID)
                        , fr_u[i].ToUser.Firstname
                        , fr_u[i].ToUser.Lastname
                        , CommentIMGPath
                        );
                    }
                    else
                    { // ToUser
                        if (fr_u[i].FromUser.PersonalImageURL == String.Empty || fr_u[i].FromUser.PersonalImageURL == null)
                        {
                            if (fr_u[i].FromUser.Gender)
                            {
                                CommentIMGPath = ResolveUrl("~/UserImages/MPlaceHolder.jpg");
                            }
                            else
                            {
                                CommentIMGPath = ResolveUrl("~/UserImages/FPlaceHolder.jpg");
                            }
                        }
                        else
                        {
                            CommentIMGPath = ResolveUrl("~/UserImages/") + fr_u[i].FromUser.PersonalImageURL;
                        }
                        this.OnlineChat.InnerHtml += String.Format("<li><a href=\"{0}\" title=\"{1} {2}\"><img src=\"{3}\" alt=\"{1} {2}\" class=\"img-responsive profile-photo\" /><span class=\"online-dot\"></span></a></li>"
                        , ResolveUrl("~/Messages.aspx?F=" + fr_u[i].FromUser.ID)
                        , fr_u[i].FromUser.Firstname
                        , fr_u[i].FromUser.Lastname
                        , CommentIMGPath
                        );
                    }
                }
            }
            catch (Exception ex)
            {
                //this.OnlineChat.InnerHtml = ex.Message;
            }
        }
        protected void Timer1_Tick(object sender, EventArgs e)
        {
            GetOnlineUsers();
        }
        protected void btn_publish_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(this.PublishContent.InnerText.Trim()))
            {
                this.PublishContent.Disabled = true;
                Post p = new Post()
                {
                    IsDeleted = false,
                    PostContent = this.PublishContent.InnerText.Trim(),
                    PostingDateTime = DateTime.Now,
                    UserID = u.ID
                };
                dbe.Posts.Add(p);
                for (int i = 0; i < this.PostImageUpload.PostedFiles.Count; i++)
                {
                    if (this.PostImageUpload.PostedFiles[i].ContentType == "image/jpeg")
                    {
                        string FileName = String.Format("{0}_{1}_{3}.{2}"
                                        , u.ID.ToString()
                                        , MyMD5.GetMd5Hash(DateTime.Now.ToLongDateString() + DateTime.Now.ToLongTimeString())
                                        , Path.GetFileName(this.PostImageUpload.PostedFiles[i].FileName).Split('.').ToList().Last()
                                        , i + 1
                                        );
                        this.PostImageUpload.PostedFiles[i].SaveAs(Server.MapPath("~/PostImages/") + FileName);
                        p.PostsImages.Add(new PostsImage() { ImageURL = FileName });
                    }
                }
                dbe.SaveChanges();
                Response.Redirect(ResolveUrl("~/NewsFeed.aspx"));
            }
        }
    }
}