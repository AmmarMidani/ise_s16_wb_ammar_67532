<%@ Page Title="Edit About" Language="C#" MasterPageFile="~/Masters/Base.Master" AutoEventWireup="true" CodeBehind="EditAbout.aspx.cs" Inherits="ISE_S16_WB.EditAbout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Edit About
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MiddleContent" runat="server">


    <!-- Timeline
      ================================================= -->
    <div class="timeline">
        <div class="timeline-cover" id="UserCover" runat="server">

            <!--Timeline Menu for Large Screens-->
            <div class="timeline-nav-bar hidden-sm hidden-xs">
                <div class="row">
                    <div class="col-md-3">
                        <div class="profile-info">
                            <asp:Image ID="PersonImage" runat="server" ImageUrl="" AlternateText="" CssClass="img-responsive profile-photo" />
                            <h4 id="UserName" runat="server"></h4>
                            <%--<p class="text-muted">Creative Director</p>--%>
                        </div>
                    </div>
                    <div class="col-md-9">
                        <ul class="list-inline profile-menu">
                            <li><a href="About.aspx" class="active">About</a></li>
                            <li><a href="Friends.aspx">Friends</a></li>
                        </ul>
                        <ul class="follow-me list-inline">
                            <li>Friend with
                                <asp:Label ID="lbl_FriendNumber" runat="server" Text="0"></asp:Label>
                                people</li>
                        </ul>
                    </div>
                </div>
            </div>
            <!--Timeline Menu for Large Screens End-->

            <!--Timeline Menu for Small Screens-->
            <div class="navbar-mobile hidden-lg hidden-md">
                <div class="profile-info">
                    <asp:Image ID="PersonImage_small" runat="server" ImageUrl="" AlternateText="" CssClass="img-responsive profile-photo" />
                    <h4 id="UserName_small" runat="server"></h4>
                </div>
                <div class="mobile-menu">
                    <ul class="list-inline">
                        <li><a href="About.aspx" class="active">About</a></li>
                        <li><a href="Friends.aspx">Friends</a></li>
                    </ul>
                </div>
            </div>
            <!--Timeline Menu for Small Screens End-->

        </div>
        <div id="page-contents">
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-9">

                    <!-- About
              ================================================= -->
                    <div class="about-profile">

                        <div class="about-content-block">
                            <h4 class="grey"><i class="ion-locked icon-in-title"></i>Change Password</h4>
                            <asp:TextBox runat="server" ID="tbox_OldPassword" CssClass="form-control" placeholder="Old Password" TextMode="Password" /><br />
                            <asp:TextBox runat="server" ID="tbox_NewPassword" CssClass="form-control" placeholder="New Password" TextMode="Password" /><br />
                            <asp:TextBox runat="server" ID="tbox_ConfirmNewPassword" CssClass="form-control" placeholder="Confirm New Password" TextMode="Password" />
                            <asp:CompareValidator ID="CompareValidator1" ControlToCompare="tbox_NewPassword" ControlToValidate="tbox_ConfirmNewPassword" runat="server" ErrorMessage="New Password doesn't match" ForeColor="Red" Display="Dynamic"></asp:CompareValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="password must be at least 8-16 character"
                                ForeColor="Red" ControlToValidate="tbox_NewPassword" Display="Dynamic"
                                ValidationExpression="(.{8,16})"></asp:RegularExpressionValidator>
                            <br />
                            <button id="btn_EditPassword" class="btn btn-success" onclick="FN_EditPassword(<%=((ISE_S16_WB.User)Session["User"]).ID %> , <%=this.tbox_OldPassword.ClientID %> , <%=this.tbox_NewPassword.ClientID %>)">Change Password</button>
                        </div>


                        <div class="about-content-block">
                            <h4 class="grey"><i class="ion-social-instagram icon-in-title"></i>Personal Image</h4>
                            <asp:FileUpload ID="UploadUserImage" runat="server" AllowMultiple="false" accept=".jpg"/>
                            <br />
                            <asp:Button Text="Change Personal Image" runat="server" ID="btn_ChangeImage" OnClick="btn_ChangeImage_Click" CausesValidation="false" CssClass="btn btn-success" />
                        </div>

                        <div class="about-content-block">
                            <h4 class="grey"><i class="ion-images icon-in-title"></i>Wall Image</h4>
                            <asp:FileUpload ID="UploadWallImage" runat="server" AllowMultiple="false" accept=".jpg"/>
                            <br />
                            <asp:Button Text="Change Wall Image" runat="server" ID="btn_ChangeWall" OnClick="btn_ChangeWall_Click" CausesValidation="false" CssClass="btn btn-success" />
                        </div>

                        <div class="about-content-block">
                            <h4 class="grey"><i class="ion-iphone icon-in-title"></i>Mobile</h4>
                            <asp:TextBox runat="server" ID="UserMobile" CssClass="form-control" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Insert valid mobile number (example : 0912345678)"
                                ControlToValidate="UserMobile" Display="Dynamic" ForeColor="Red" ValidationExpression="[0-9]{10}"></asp:RegularExpressionValidator>
                            <br />
                            <button id="EditNumber" class="btn btn-success" onclick="EditMobile(<%=((ISE_S16_WB.User)Session["User"]).ID %> , <%=this.UserMobile.ClientID %>)">Save Number</button>
                        </div>

                        <div class="about-content-block">
                            <h4 class="grey"><i class="ion-calendar icon-in-title"></i>Birthday</h4>
                            <div class="row">
                                <div class="col-md-4">
                                    <asp:DropDownList ID="DDL_Day" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                                <div class="col-md-4">
                                    <asp:DropDownList ID="DDL_Month" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                                <div class="col-md-4">
                                    <asp:DropDownList ID="DDL_Year" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>
                            <br />
                            <button id="EditBirthday" class="btn btn-success" onclick="FN_EditBirthday(<%=((ISE_S16_WB.User)Session["User"]).ID %> , <%=this.DDL_Day.ClientID %> ,
                                <%=this.DDL_Month.ClientID %> , <%=this.DDL_Year.ClientID %> )">
                                Save Date</button>
                        </div>
                        <%--
                         <div class="about-content-block">
                            <h4 class="grey"><i class="ion-map icon-in-title"></i>Location</h4>
                            <p id="UserLocation" runat="server"></p>
                            <div class="google-maps">
                                <div id="map" class="map"></div>
                            </div>
                        </div>
                        --%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>