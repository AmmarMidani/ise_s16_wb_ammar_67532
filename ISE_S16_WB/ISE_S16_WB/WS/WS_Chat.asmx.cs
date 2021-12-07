using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;

namespace ISE_S16_WB
{
    /// <summary>
    /// Summary description for WS_Chat
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class WS_Chat : System.Web.Services.WebService
    {
        SocialMediaEntities dbe = new SocialMediaEntities();
        [WebMethod]
        public string AddNewMessage(int FID, int UID, string Content)
        {
            Chat newChat = new Chat()
            {
                EventDateTime = DateTime.Now,
                FromUserID = UID,
                IsRead = false,
                MessageContent = Content.Trim(),
                ToUserID = FID
            };
            dbe.Chats.Add(newChat);
            dbe.SaveChanges();
            User u = dbe.Users.Find(UID);
            if (u == null)
            {
                return "";
            }

            string _returnval = "";
            _returnval += "<li class=\"";
            _returnval += "right";
            _returnval += "\" onclick=\"ShowDateMessage(this)\">";
            _returnval += "<img class=\"profile-photo-sm ";
            _returnval += "pull-right";
            _returnval += "\" src=\"";
            if (u.PersonalImageURL == String.Empty || u.PersonalImageURL == null)
            {
                if (u.Gender)
                {
                    _returnval += "/UserImages/MPlaceHolder.jpg";
                }
                else
                {
                    _returnval += "/UserImages/FPlaceHolder.jpg";
                }
            }
            else
            {
                _returnval += "UserImages/" + u.PersonalImageURL;
            }
            _returnval += "\" alt=\"";
            _returnval += u.Firstname + " " + u.Lastname;
            _returnval += "\">";
            _returnval += "<div class=\"chat-item\"><div class=\"chat-item-header\">";
            _returnval += "<h5>";
            _returnval += u.Firstname + " " + u.Lastname;
            _returnval += "</h5>";
            _returnval += "<small class=\"text-muted\">";
            if ((DateTime.Now - newChat.EventDateTime).TotalHours < 24)
            {
                if ((DateTime.Now - newChat.EventDateTime).TotalSeconds < 60)
                {
                    _returnval += (DateTime.Now - newChat.EventDateTime).Seconds + " Seconds";
                }
                else if ((DateTime.Now - newChat.EventDateTime).TotalMinutes < 60)
                {
                    _returnval += (DateTime.Now - newChat.EventDateTime).Minutes + " Minutes";
                }
                else
                {
                    _returnval += (DateTime.Now - newChat.EventDateTime).Hours + " Hours";
                }
            }
            else
            {
                _returnval = newChat.EventDateTime.ToString("dd MMM AT HH:mm");
            }
            _returnval += "</small></div>";
            _returnval += "<p>";
            _returnval += CLS_Emoji.Replacment(newChat.MessageContent);
            _returnval += "</p></div>";
            _returnval += "<div class=\"timechat ";
            _returnval += "pull-right";
            _returnval += "\">";
            _returnval += newChat.EventDateTime.ToLongDateString() + " " + newChat.EventDateTime.ToLongTimeString();
            _returnval += "</div></li>";
            return _returnval;
        }

        [WebMethod]
        public string AllUnread(int FID, int UID)
        {
            string _returnval = "";
            User u = dbe.Users.Find(UID);
            User _friend = dbe.Users.Find(Convert.ToInt64(FID));
            if (_friend != null)
            {
                List<Chat> all_messages_between = dbe.Chats.Where(m => m.IsRead == false && m.FromUserID == _friend.ID && m.ToUserID == u.ID)
                                                 .OrderBy(m => m.EventDateTime)
                                                 .ToList();
                for (int i = 0; i < all_messages_between.Count; i++)
                {
                    _returnval += "<li class=\"";
                    if (all_messages_between[i].FromUserID == UID)
                    {
                        _returnval += "right";
                    }
                    else
                    {
                        _returnval += "left";
                    }
                    _returnval += "\" onclick=\"ShowDateMessage(this)\">";
                    _returnval += "<img class=\"profile-photo-sm ";
                    if (all_messages_between[i].FromUserID == UID)
                    {
                        _returnval += "pull-right";
                    }
                    else
                    {
                        _returnval += "pull-left";
                    }
                    _returnval += "\" src=\"";
                    if (all_messages_between[i].FromUser.PersonalImageURL == String.Empty || all_messages_between[i].FromUser.PersonalImageURL == null)
                    {
                        if (all_messages_between[i].FromUser.Gender)
                        {
                            _returnval += "/UserImages/MPlaceHolder.jpg";
                        }
                        else
                        {
                            _returnval += "/UserImages/FPlaceHolder.jpg";
                        }
                    }
                    else
                    {
                        _returnval += "UserImages/" + all_messages_between[i].FromUser.PersonalImageURL;
                    }
                    _returnval += "\" alt=\"";
                    _returnval += all_messages_between[i].FromUser.Firstname + " " + all_messages_between[i].FromUser.Lastname;
                    _returnval += "\">";
                    _returnval += "<div class=\"chat-item\"><div class=\"chat-item-header\">";
                    _returnval += "<h5>";
                    _returnval += all_messages_between[i].FromUser.Firstname + " " + all_messages_between[i].FromUser.Lastname;
                    _returnval += "</h5>";
                    _returnval += "<small class=\"text-muted\">";
                    if ((DateTime.Now - all_messages_between[i].EventDateTime).TotalHours < 24)
                    {
                        if ((DateTime.Now - all_messages_between[i].EventDateTime).TotalSeconds < 60)
                        {
                            _returnval += (DateTime.Now - all_messages_between[i].EventDateTime).Seconds + " Seconds";
                        }
                        else if ((DateTime.Now - all_messages_between[i].EventDateTime).TotalMinutes < 60)
                        {
                            _returnval += (DateTime.Now - all_messages_between[i].EventDateTime).Minutes + " Minutes";
                        }
                        else
                        {
                            _returnval += (DateTime.Now - all_messages_between[i].EventDateTime).Hours + " Hours";
                        }
                    }
                    else
                    {
                        _returnval = all_messages_between[i].EventDateTime.ToString("dd MMM AT HH:mm");
                    }
                    _returnval += "</small></div>";
                    _returnval += "<p>";
                    _returnval += CLS_Emoji.Replacment(all_messages_between[i].MessageContent);
                    _returnval += "</p></div>";
                    _returnval += "<div class=\"timechat ";
                    if (all_messages_between[i].FromUserID == UID)
                    {
                        _returnval += "pull-right";
                    }
                    else
                    {
                        _returnval += "pull-left";
                    }
                    _returnval += "\">";
                    _returnval += all_messages_between[i].EventDateTime.ToLongDateString() + " " + all_messages_between[i].EventDateTime.ToLongTimeString();
                    _returnval += "</div></li>";
                    all_messages_between[i].IsRead = true;
                    dbe.SaveChanges();
                }
            }
            return _returnval;
        }
    }
}