using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ISE_S16_WB
{
    public partial class UC_MessageTab : System.Web.UI.UserControl
    {
        private long _FriendID;
        SocialMediaEntities dbe = new SocialMediaEntities();
        User u;
        User _Friend;

        public long FriendID
        {
            get { return _FriendID; }
            set { _FriendID = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            u = (User)Session["User"];
            try
            {
                _Friend = dbe.Users.Find(_FriendID);

                if (_Friend.PersonalImageURL == String.Empty || _Friend.PersonalImageURL == null)
                {
                    if (_Friend.Gender)
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
                    this.FriendImage.ImageUrl = ResolveUrl("~/UserImages/") + _Friend.PersonalImageURL;
                }
                this.FriendImage.AlternateText = this.FriendName.InnerText = _Friend.Firstname + " " + _Friend.Lastname;
                //Last Message
                List<Chat> LastMessage = dbe.Chats.Where(m => (m.FromUserID == u.ID && m.ToUserID == _Friend.ID)
                                            || (m.FromUserID == _Friend.ID && m.ToUserID == u.ID))
                                            .OrderByDescending(m => m.EventDateTime)
                                            .Take(1)
                                            .ToList();
                this.LastMessage.InnerHtml = CLS_Emoji.Replacment(LastMessage[0].MessageContent.ToString());

                if ((DateTime.Now - LastMessage[0].EventDateTime).TotalHours < 24)
                {
                    if ((DateTime.Now - LastMessage[0].EventDateTime).TotalSeconds < 60)
                    {
                        this.LastMessageTime.InnerText += (DateTime.Now - LastMessage[0].EventDateTime).Seconds + " Seconds ago";
                    }
                    else if ((DateTime.Now - LastMessage[0].EventDateTime).TotalMinutes < 60)
                    {
                        this.LastMessageTime.InnerText += (DateTime.Now - LastMessage[0].EventDateTime).Minutes + " Minutes ago";
                    }
                    else
                    {
                        this.LastMessageTime.InnerText += (DateTime.Now - LastMessage[0].EventDateTime).Hours + " Hours ago";
                    }
                }
                else
                {
                    this.LastMessageTime.InnerText = LastMessage[0].EventDateTime.ToString("dd MMM AT HH:mm");
                }
                if (LastMessage[0].IsRead)
                {
                    this.MessageSeen.Visible = true;
                }
                else
                {
                    this.MessageAlert.Visible = true;
                    string MessageAlertCount = dbe.Chats.Where(m => m.IsRead == false && (m.FromUserID == _Friend.ID && m.ToUserID == u.ID))
                                    .ToList().Count.ToString();
                    this.MessageAlert.InnerText = MessageAlertCount;
                }
                this.UserRedirect.NavigateUrl = ResolveUrl("~/Messages.aspx?F=") + _Friend.ID;
            }
            catch (Exception ex)
            {
            }
        }
    }
}