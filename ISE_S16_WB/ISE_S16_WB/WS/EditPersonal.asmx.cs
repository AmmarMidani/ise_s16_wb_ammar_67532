using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace ISE_S16_WB
{
    /// <summary>
    /// Summary description for EditPersonal
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class EditPersonal : System.Web.Services.WebService
    {
        SocialMediaEntities dbe = new SocialMediaEntities();
        User u = new User();
        [WebMethod]
        public void EditMobile(int Uid, string Mobile)
        {
            try
            {
                u = dbe.Users.Find(Uid);
                u.Mobile = Mobile;
                dbe.SaveChanges();
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        [WebMethod]
        public void EditBirthday(int Uid, int Day, int Month, int Year)
        {
            try
            {
                u = dbe.Users.Find(Uid);
                u.Birthdate = new DateTime(Year, Month, Day);
                dbe.SaveChanges();
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        [WebMethod]
        public string EditPassword(int Uid, string OldPass, string NewPass)
        {
            try
            {
                u = dbe.Users.Find(Uid);
                if (u.Password == MyMD5.GetMd5Hash(OldPass))
                {
                    u.Password = MyMD5.GetMd5Hash(NewPass);
                    dbe.SaveChanges();
                    return "Done";
                }
                else
                {
                    return "Old password is incorrect";
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
                return "Error Happend";
            }
        }
    }
}