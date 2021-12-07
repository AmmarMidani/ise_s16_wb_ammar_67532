using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ISE_S16_WB
{
    public partial class About : System.Web.UI.Page
    {
        SocialMediaEntities dbe = new SocialMediaEntities();
        User u = new User();
        User other_user = new User();

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
        public bool IsFriend()
        {
            int FriendNumber = dbe.FriendshipRequests.Where(m =>
                                                    (m.FromUser.ID == u.ID && m.ToUser.ID == other_user.ID)
                                                 || (m.ToUser.ID == u.ID && m.FromUser.ID == other_user.ID)
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
                               (m.FromUser.ID == u.ID && m.ToUser.ID == other_user.ID)
                            || (m.ToUser.ID == u.ID && m.FromUser.ID == other_user.ID)).ToList().Last().RelationStatus;
            }
            catch (Exception ex)
            {
                return 0;
            }
        }
        public int GetAge(DateTime birthdate)
        {
            DateTime x = DateTime.Now.AddTicks(-1 * birthdate.Ticks);
            return x.Year;
        }
        private string GetElapsedTime(DateTime from_date)
        {
            DateTime to_date = DateTime.Now;
            int years, months, days, hours, minutes, seconds = 0;
            years = to_date.Year - from_date.Year;
            DateTime test_date = from_date.AddMonths(12 * years);
            if (test_date > to_date)
            {
                years--;
                test_date = from_date.AddMonths(12 * years);
            }
            months = 0;
            while (test_date <= to_date)
            {
                months++;
                test_date = from_date.AddMonths(12 * years + months);
            }
            months--;
            from_date = from_date.AddMonths(12 * years + months);
            TimeSpan remainder = to_date - from_date;
            days = remainder.Days;
            hours = remainder.Hours;
            minutes = remainder.Minutes;
            seconds = remainder.Seconds;
            string LastTime = "About ";
            if (years != 0) LastTime += years + " Years ";
            if (months != 0) LastTime += months + " Months ";
            if (days != 0) LastTime += days + " Days ";
            if (hours != 0) LastTime += hours + " Hours ";
            if (minutes != 0) LastTime += minutes + " Minutes ";
            if (seconds != 0) LastTime += seconds + " Seconds ";
            return LastTime;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                Response.Redirect(ResolveUrl("~/Login/Login.aspx"));
            }
            u = (User)Session["User"];
            try
            {
                other_user = dbe.Users.Find(Convert.ToInt64(Request.QueryString["u"]));
            }
            catch (Exception ex) { }
            if (other_user == null || other_user.ID == 0)
            {
                Response.Redirect(ResolveUrl("~/About.aspx?u=" + u.ID));
            }
            if (Request.QueryString["u"] != null && Request.QueryString["u"] != "" && Request.QueryString["u"] != String.Empty)
            {
                if (other_user.PersonalImageURL == String.Empty || other_user.PersonalImageURL == null)
                {
                    if (other_user.Gender)
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
                    this.PersonImage.ImageUrl = this.PersonImage_small.ImageUrl = ResolveUrl("~/UserImages/") + other_user.PersonalImageURL;
                }
                this.UserName.InnerText = this.UserName_small.InnerText =
                    this.PersonImage.AlternateText = this.PersonImage_small.AlternateText =
                    this.Title = other_user.Firstname + " " + other_user.Lastname;
                if (other_user.WallImageURL == String.Empty || other_user.WallImageURL == null)
                {
                    this.UserCover.Style["background"] = "url(" + ResolveUrl("~/UserCovers/Placeholder.jpg") + ") no-repeat";
                }
                else
                {
                    this.UserCover.Style["background"] = "url(" + ResolveUrl("~/UserCovers/" + other_user.WallImageURL) + ") no-repeat";
                }
                this.UserCover.Style["background-size"] = "cover";
                this.lbl_FriendNumber.Text = GetFriendsCount(other_user.ID).ToString();
                if (this.other_user.ID != this.u.ID)
                {
                    if (IsFriend())
                    {
                        switch (RequestType())
                        {
                            case 0:
                                this.btn_AddFriend.Visible = true;
                                this.btn_AddFriend.Enabled = false;
                                this.btn_AddFriend.Text = "Sent";
                                break;
                            case 1:
                                this.btn_AddFriend.Visible = true;
                                this.btn_AddFriend.Text = "Unfriend";
                                break;
                            default:
                                this.btn_AddFriend.Visible = false;
                                break;
                        }
                    }
                    else
                    {
                        this.btn_AddFriend.Visible = true;
                    }
                }
                this.UserEmail.InnerText = other_user.Email;
                if (other_user.Gender)
                {
                    this.UserGenderIcon.Attributes["class"] += " ion-male";
                    this.UserGender.InnerText = "Male";
                }
                else
                {
                    this.UserGenderIcon.Attributes["class"] += " ion-female";
                    this.UserGender.InnerText = "Female";
                }
                if (!String.IsNullOrEmpty(other_user.Mobile))
                {
                    this.UserMobile.InnerText = other_user.Mobile;
                }
                else
                {
                    this.UserMobile.InnerText = "Not Entered Yet!!!";
                }
                if (other_user.Birthdate.HasValue)
                {
                    this.UserBirthday.InnerText = String.Format("{0} ~ About {1} Year."
                        , other_user.Birthdate.Value.ToString("dddd, dd MMMM yyyy")
                        , GetAge(other_user.Birthdate.Value));
                }
                else
                {
                    this.UserBirthday.InnerText = "Not Entered Yet!!!";
                }
                this.UserSince.InnerText = GetElapsedTime(other_user.RegisterationDate);
                //this.UserLocation.InnerText = other_user.Map_Lat + " , " + other_user.Map_Lon;
            }
            else
            {
                Response.Redirect(ResolveUrl("~/About.aspx?u=" + u.ID));
            }
        }
        protected void btn_AddFriend_Click(object sender, EventArgs e)
        {
            try
            {
                switch (btn_AddFriend.Text)
                {
                    case "Add Friend":
                        dbe.FriendshipRequests.Add(new FriendshipRequest()
                        {
                            EventDateTime = DateTime.Now,
                            FromUserID = u.ID,
                            ToUserID = this.other_user.ID,
                            RelationStatus = 0
                        });
                        dbe.SaveChanges();
                        break;
                    case "Unfriend":
                        FriendshipRequest fr_req = dbe.FriendshipRequests.Where(m =>
                                                        (m.FromUser.ID == u.ID && m.ToUser.ID == other_user.ID)
                                                     || (m.ToUser.ID == u.ID && m.FromUser.ID == other_user.ID)).First();
                        dbe.FriendshipRequests.Remove(fr_req);
                        dbe.SaveChanges();
                        break;
                    default:
                        break;
                }
                Response.Redirect(ResolveUrl(Request.RawUrl));
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }

        }
    }
}