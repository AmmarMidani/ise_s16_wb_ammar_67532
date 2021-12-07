using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ISE_S16_WB
{
    public partial class NewsFeed : System.Web.UI.Page
    {
        SocialMediaEntities dbe = new SocialMediaEntities();
        User u = new User();

        public void GetPosts()
        {
            try
            {
                var qq = dbe.FriendshipRequests
                    .Where(m => m.RelationStatus == 1 && (m.FromUserID == u.ID || m.ToUserID == u.ID))
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
                IDs.Add(u.ID);
                IDs = IDs.Distinct().ToList();
                var AllPosts = dbe.Posts.Where(m => IDs.Contains(m.UserID))
                    .OrderByDescending(m => m.PostingDateTime)
                    .ToList();
                for (int i = 0; i < AllPosts.Count; i++)
                {
                    UC_Post p = (UC_Post)LoadControl(ResolveUrl("~/UserControl/UC_Post.ascx"));
                    p.PostID = AllPosts[i].ID;
                    this.AllPosts.Controls.Add(p);
                }
            }
            catch (Exception ex)
            {
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            u = (User)Session["User"];
            GetPosts();
        }
    }
}