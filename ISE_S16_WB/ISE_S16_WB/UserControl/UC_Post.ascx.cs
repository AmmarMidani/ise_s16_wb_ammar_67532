using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ISE_S16_WB
{
    public partial class UC_Post : System.Web.UI.UserControl
    {
        private long _PostID;
        Post p;
        SocialMediaEntities dbe = new SocialMediaEntities();
        User u;
        public long PostID
        {
            get { return _PostID; }
            set { _PostID = value; }
        }
        private void GetComments()
        {
            this.PostComments.InnerHtml = "";
            List<PostComment> pc = p.PostComments.ToList();
            for (int i = 0; i < pc.Count; i++)
            {
                string CommentIMGPath = "";
                string CommentDate = "";
                if (pc[i].User.PersonalImageURL == String.Empty || pc[i].User.PersonalImageURL == null)
                {
                    if (pc[i].User.Gender)
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
                    CommentIMGPath = ResolveUrl("~/UserImages/") + pc[i].User.PersonalImageURL;
                }
                if ((DateTime.Now - pc[i].EventDateTime).TotalHours < 24)
                {
                    if ((DateTime.Now - pc[i].EventDateTime).TotalSeconds < 60)
                    {
                        CommentDate = (DateTime.Now - pc[i].EventDateTime).Seconds + " Seconds";
                    }
                    else if ((DateTime.Now - pc[i].EventDateTime).TotalMinutes < 60)
                    {
                        CommentDate = (DateTime.Now - pc[i].EventDateTime).Minutes + " Minutes";
                    }
                    else
                    {
                        CommentDate = (DateTime.Now - pc[i].EventDateTime).Hours + " Hours";
                    }
                }
                else
                {
                    CommentDate = pc[i].EventDateTime.ToLongDateString() + " " + pc[i].EventDateTime.ToLongTimeString();
                }
                this.PostComments.InnerHtml += String.Format(
                    "<div class=\"post-comment\"><img src=\"{0}\" alt=\"{1} {2}\" class=\"profile-photo-sm\"/><p><a href=\"{7}\" class=\"profile-link\">{3} {4}</a> {5}</p><span class=\"following\">{6}</span></div>"
                    , CommentIMGPath
                    , pc[i].User.Firstname
                    , pc[i].User.Lastname
                    , pc[i].User.Firstname
                    , pc[i].User.Lastname
                    , CLS_Emoji.Replacment(pc[i].CommentContent)
                    , CommentDate
                    , ResolveUrl("~/About.aspx?u=" + pc[i].User.ID)
                    );
            }
        }
        private void GetSlider()
        {
            this.CarouselImagesContent.InnerHtml = "";
            List<PostsImage> poImg = p.PostsImages.ToList();
            if (poImg.Count == 0)
            {
                this.myCarousel.Visible = false;
                return;
            }
            this.CarouselImagesContent.InnerHtml +=
                String.Format("<div class=\"item active\"><img src=\"{0}\" alt=\"{1} {2} ~ {3} ~\" class=\"img-responsive post-image\" /></div>"
                , ResolveUrl("~/PostImages/") + poImg[0].ImageURL
                , this.u.Firstname
                , this.u.Lastname
                , this.p.PostContent.Take(20).ToString()
                );
            for (int i = 1; i < poImg.Count; i++)
            {
                this.CarouselImagesContent.InnerHtml +=
                    String.Format("<div class=\"item\"><img src=\"{0}\" alt=\"{1} {2} ~ {3} ~\" class=\"img-responsive post-image\" /></div>"
                    , ResolveUrl("~/PostImages/") + poImg[i].ImageURL
                    , this.u.Firstname
                    , this.u.Lastname
                    , this.p.PostContent.Take(20).ToString()
                );
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            u = (User)Session["User"];
            p = dbe.Posts.SingleOrDefault(m => m.ID == this._PostID);
            if (p != null)
            {
                GetSlider();
                this.PostContent.InnerHtml = CLS_Emoji.Replacment(p.PostContent);
                if (p.User.PersonalImageURL == String.Empty || p.User.PersonalImageURL == null)
                {
                    if (p.User.Gender)
                    {
                        this.UserImage.ImageUrl = this.CommentUserImage.ImageUrl = ResolveUrl("~/UserImages/MPlaceHolder.jpg");
                    }
                    else
                    {
                        this.UserImage.ImageUrl = this.CommentUserImage.ImageUrl = ResolveUrl("~/UserImages/FPlaceHolder.jpg");
                    }
                }
                else
                {
                    this.UserImage.ImageUrl = this.CommentUserImage.ImageUrl = ResolveUrl("~/UserImages/") + p.User.PersonalImageURL;
                }
                this.UserName.Text = this.UserImage.AlternateText = this.CommentUserImage.AlternateText = p.User.Firstname + " " + p.User.Lastname;
                this.UserName.NavigateUrl = ResolveUrl("~/About.aspx?u=" + this.p.User.ID);
                if ((DateTime.Now - p.PostingDateTime).TotalHours < 24)
                {
                    if ((DateTime.Now - p.PostingDateTime).TotalSeconds < 60)
                    {
                        this.PostDateTime.InnerText += (DateTime.Now - p.PostingDateTime).Seconds + " Seconds";
                    }
                    else if ((DateTime.Now - p.PostingDateTime).TotalMinutes < 60)
                    {
                        this.PostDateTime.InnerText += (DateTime.Now - p.PostingDateTime).Minutes + " Minutes";
                    }
                    else
                    {
                        this.PostDateTime.InnerText += (DateTime.Now - p.PostingDateTime).Hours + " Hours";
                    }
                }
                else
                {
                    this.PostDateTime.InnerText = p.PostingDateTime.ToLongDateString() + " " + p.PostingDateTime.ToLongTimeString();
                }
                this.PostDateTime.Attributes["title"] = p.PostingDateTime.ToLongDateString() + " " + p.PostingDateTime.ToLongTimeString();
                this.LikeNumbers.InnerText = dbe.PostLikes.Where(m => m.PostID == p.ID).Count().ToString();
                if (p.PostLikes.Where(m => m.UserID == u.ID).ToList().Count > 0)
                {
                    this.ButtonLike.CssClass = this.ButtonLike.CssClass + " text-green";
                }
                GetComments();
            }
        }
        protected void ButtonLike_Click(object sender, EventArgs e)
        {
            if (this.ButtonLike.CssClass.Contains(" text-green"))
            {
                //remove like
                this.ButtonLike.CssClass = "btn text-black";
                PostLike pl = dbe.PostLikes.SingleOrDefault(m => m.PostID == p.ID && m.UserID == u.ID);
                dbe.PostLikes.Remove(pl);
                dbe.SaveChanges();
                int cccc = dbe.PostLikes.Where(m => m.PostID == p.ID).Count();
                this.LikeNumbers.InnerText = cccc.ToString();
            }
            else
            {
                //add like
                this.ButtonLike.CssClass = this.ButtonLike.CssClass + " text-green";
                dbe.PostLikes.Add(new PostLike()
                {
                    EventDateTime = DateTime.Now,
                    PostID = p.ID,
                    UserID = u.ID
                });
                dbe.SaveChanges();
                this.LikeNumbers.InnerText = dbe.PostLikes.Where(m => m.PostID == p.ID).Count().ToString();
            }
        }
        protected void SendComment_Click(object sender, EventArgs e)
        {
            try
            {
                if (!String.IsNullOrEmpty(this.PostCommentText.InnerText.Trim()))
                {
                    this.p.PostComments.Add(new PostComment()
                    {
                        CommentContent = this.PostCommentText.InnerText.Trim(),
                        EventDateTime = DateTime.Now,
                        UserID = u.ID,
                        PostID = p.ID,
                        IsDeleted = false
                    });
                    dbe.SaveChanges();
                    this.PostCommentText.InnerText = String.Empty;
                    GetComments();
                }
            }
            catch (Exception ex) { }
        }
    }
}