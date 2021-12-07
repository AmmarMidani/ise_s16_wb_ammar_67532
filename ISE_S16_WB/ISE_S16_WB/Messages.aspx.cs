using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ISE_S16_WB
{
    public partial class Messages : System.Web.UI.Page
    {
        SocialMediaEntities dbe = new SocialMediaEntities();
        User u = new User();
        public void GetLeftSideMessages()
        {
            this.MessageLeftSide.Controls.Clear();
            var qq = dbe.Chats
                    .Where(m => (m.FromUserID == u.ID || m.ToUserID == u.ID))
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
            for (int i = 0; i < IDs.Count; i++)
            {
                UC_MessageTab mt = (UC_MessageTab)LoadControl(ResolveUrl("~/UserControl/UC_MessageTab.ascx"));
                mt.FriendID = IDs[i];
                this.MessageLeftSide.Controls.Add(mt);
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.MaintainScrollPositionOnPostBack = true;
            if (Session["User"] == null)
            {
                Response.Redirect(ResolveUrl("~/Login/Login.aspx"));
            }
            u = (User)Session["User"];
            GetLeftSideMessages();
            if (Request.QueryString["F"] != null)
            {
                string myScriptValue = "window.setInterval(function () {GetAllUnReadMessages(" + this.ChatBody.ClientID + "," +
                    Convert.ToInt64(Request.QueryString["F"]) + "," + this.u.ID + "); }, 1000);";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), DateTime.Now.ToString("MMddYYYYHHmmss"), myScriptValue, true);

                User _friend = dbe.Users.Find(Convert.ToInt64(Request.QueryString["F"]));
                if (_friend != null)
                {
                    List<Chat> all_messages_between = dbe.Chats.Where(m =>
                                                        (m.FromUserID == u.ID && m.ToUserID == _friend.ID)
                                                     || (m.FromUserID == _friend.ID && m.ToUserID == u.ID))
                                                     .OrderBy(m => m.EventDateTime)
                                                     .ToList();
                    for (int i = 0; i < all_messages_between.Count; i++)
                    {
                        try
                        {
                            if (all_messages_between[i].EventDateTime.Day < all_messages_between[i + 1].EventDateTime.Day)
                            {
                                LiteralControl lc = new LiteralControl("<li class=\"text-muted Chat-Time-Middle\"> - "
                                    + all_messages_between[i + 1].EventDateTime.ToString("MMM dd ,yyyy") + " - </li>");
                                this.ChatBody.Controls.Add(lc);
                            }
                        }
                        catch (Exception ex) { }

                        UC_SingleChatMessage scm = (UC_SingleChatMessage)LoadControl(ResolveUrl("~/UserControl/UC_SingleChatMessage.ascx"));
                        scm.MessageID = all_messages_between[i].ID;
                        this.ChatBody.Controls.Add(scm);
                    }
                }
            }
        }
        protected void TimerMessagesRefresh_Tick(object sender, EventArgs e)
        {
            GetLeftSideMessages();
        }
    }
}