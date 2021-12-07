using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ISE_S16_WB
{
    public partial class FriendsRequests : System.Web.UI.Page
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
            try
            {
                var qq = dbe.FriendshipRequests
                   .Where(m => m.RelationStatus == 0 && m.ToUserID == u.ID)
                   .OrderByDescending(m => m.EventDateTime)
                   .ToList();
                for (int i = 0; i < qq.Count; i++)
                {
                    UC_FriendRequest p = (UC_FriendRequest)LoadControl(ResolveUrl("~/UserControl/UC_FriendRequest.ascx"));
                    p.PersonID = qq[i].FromUserID;
                    p.RequsetID = qq[i].ID;
                    this.My_Requests.Controls.Add(p);
                }
            }
            catch (Exception ex) { }
        }
    }
}