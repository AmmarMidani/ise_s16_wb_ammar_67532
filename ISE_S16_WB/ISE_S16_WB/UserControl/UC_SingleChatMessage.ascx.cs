using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ISE_S16_WB
{
    public partial class UC_SingleChatMessage : System.Web.UI.UserControl
    {

        private long _MessageID;
        SocialMediaEntities dbe = new SocialMediaEntities();
        User u;
        public long MessageID
        {
            get { return _MessageID; }
            set { _MessageID = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            u = (User)Session["User"];
            Chat c = dbe.Chats.Find(this._MessageID);
            if (c.IsRead == false)
            {
                c.IsRead = true;
                dbe.SaveChanges();
            }
            if (c.FromUserID == this.u.ID)
            {
                this.LI_Element.Attributes.Add("class", "right");
                this.ChatUserImage.CssClass = this.ChatUserImage.CssClass + " pull-right";
                this.TimeDetails.Attributes.Add("class", "timechat pull-right");
            }
            else
            {
                this.LI_Element.Attributes.Add("class", "left");
                this.ChatUserImage.CssClass = this.ChatUserImage.CssClass + " pull-left";
                this.TimeDetails.Attributes.Add("class", "timechat pull-left");
            }
            if (c.FromUser.PersonalImageURL == String.Empty || c.FromUser.PersonalImageURL == null)
            {
                if (c.FromUser.Gender)
                {
                    this.ChatUserImage.ImageUrl = ResolveUrl("~/UserImages/MPlaceHolder.jpg");
                }
                else
                {
                    this.ChatUserImage.ImageUrl = ResolveUrl("~/UserImages/FPlaceHolder.jpg");
                }
            }
            else
            {
                this.ChatUserImage.ImageUrl = ResolveUrl("~/UserImages/") + c.FromUser.PersonalImageURL;
            }
            this.ChatUserImage.AlternateText = this.SenderName.InnerText = c.FromUser.Firstname + " " + c.FromUser.Lastname;
            this.MessageTime.InnerText = "";
            if ((DateTime.Now - c.EventDateTime).TotalHours < 24)
            {
                if ((DateTime.Now - c.EventDateTime).TotalSeconds < 60)
                {
                    this.MessageTime.InnerText += (DateTime.Now - c.EventDateTime).Seconds + " Seconds";
                }
                else if ((DateTime.Now - c.EventDateTime).TotalMinutes < 60)
                {
                    this.MessageTime.InnerText += (DateTime.Now - c.EventDateTime).Minutes + " Minutes";
                }
                else
                {
                    this.MessageTime.InnerText += (DateTime.Now - c.EventDateTime).Hours + " Hours";
                }
            }
            else
            {
                this.MessageTime.InnerText = c.EventDateTime.ToString("dd MMM AT HH:mm");
            }
            this.TimeDetails.InnerText = c.EventDateTime.ToLongDateString() + " " + c.EventDateTime.ToLongTimeString();
            this.MessageContent.InnerHtml = CLS_Emoji.Replacment(c.MessageContent);
        }
    }
}