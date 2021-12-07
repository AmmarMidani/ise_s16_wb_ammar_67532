using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ISE_S16_WB
{
    public partial class Search : System.Web.UI.Page
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
                if (!String.IsNullOrEmpty(Request.Form["SearchValue"].Trim()))
                {
                    string searsh_value = Request.Form["SearchValue"].Trim();
                    List<User> People_results = dbe.Users.Where(m => m.Firstname.Contains(searsh_value)
                                                                || m.Lastname.Contains(searsh_value)
                                                                || m.Mobile.Contains(searsh_value)
                                                                || m.Username.Contains(searsh_value))
                                                         .ToList();
                    if (People_results.Count == 0)
                    {
                        this.search_people.InnerText = "No Result Found";
                        return;
                    }
                    for (int i = 0; i < People_results.Count; i++)
                    {
                        UC_FriendCard p = (UC_FriendCard)LoadControl(ResolveUrl("~/UserControl/UC_FriendCard.ascx"));
                        p.FriendID = People_results[i].ID;
                        this.search_people.Controls.Add(p);
                    }

                }
            }
            catch (Exception ex)
            {
            }
        }
    }
}