using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ISE_S16_WB
{
    public partial class EditAbout : System.Web.UI.Page
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
        public void InitDate()
        {
            for (int i = 1950; i < DateTime.Now.Year - 10; i++)
            {
                this.DDL_Year.Items.Add(i.ToString());
            }
            for (int i = 1; i <= 12; i++)
            {
                this.DDL_Month.Items.Add(i.ToString());
            }
            for (int i = 1; i <= 31; i++)
            {
                this.DDL_Day.Items.Add(i.ToString());
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitDate();
            }
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
            if (!String.IsNullOrEmpty(u.Mobile))
            {
                this.UserMobile.Text = u.Mobile;
            }
            if (u.Birthdate.HasValue)
            {
                this.DDL_Year.SelectedValue = u.Birthdate.Value.Year.ToString();
                this.DDL_Month.SelectedValue = u.Birthdate.Value.Month.ToString();
                this.DDL_Day.SelectedValue = u.Birthdate.Value.Day.ToString();
            }
            //this.UserLocation.InnerText = u.Map_Lat + " , " + u.Map_Lon;
        }
        protected void btn_ChangeImage_Click(object sender, EventArgs e)
        {
            try
            {
                if (this.UploadUserImage.HasFile && this.UploadUserImage.PostedFile.ContentType == "image/jpeg")
                {
                    string FileName = String.Format("{0}_{1}.{2}"
                                , u.ID.ToString()
                                , MyMD5.GetMd5Hash(DateTime.Now.ToLongDateString() + DateTime.Now.ToLongTimeString())
                                , Path.GetFileName(this.UploadUserImage.PostedFile.FileName).Split('.').ToList().Last()
                                );
                    this.UploadUserImage.PostedFile.SaveAs(Server.MapPath("~/UserImages/") + FileName);
                    try
                    {
                        File.Delete(Server.MapPath("~/UserImages/") + u.PersonalImageURL);
                    }
                    catch (Exception ex)
                    {
                    }
                    u.PersonalImageURL = FileName;
                    dbe.SaveChanges();
                    Response.Redirect(Request.Url.AbsoluteUri);
                }
            }
            catch (Exception ex)
            {
                Response.Redirect(Request.Url.AbsoluteUri);
            }
        }
        protected void btn_ChangeWall_Click(object sender, EventArgs e)
        {
            try
            {
                if (this.UploadWallImage.HasFile && this.UploadWallImage.PostedFile.ContentType == "image/jpeg")
                {
                    string FileName = String.Format("{0}_{1}.{2}"
                                , u.ID.ToString()
                                , MyMD5.GetMd5Hash(DateTime.Now.ToLongDateString() + DateTime.Now.ToLongTimeString())
                                , Path.GetFileName(this.UploadWallImage.PostedFile.FileName).Split('.').ToList().Last()
                                );
                    this.UploadWallImage.PostedFile.SaveAs(Server.MapPath("~/UserCovers/") + FileName);
                    try
                    {
                        File.Delete(Server.MapPath("~/UserCovers/") + u.WallImageURL);
                    }
                    catch (Exception ex)
                    {
                    }
                    u.WallImageURL = FileName;
                    dbe.SaveChanges();
                    Response.Redirect(Request.Url.AbsoluteUri);
                }
            }
            catch (Exception ex)
            {
                Response.Redirect(Request.Url.AbsoluteUri);
            }
        }
    }
}