<%@ Page Title="About" Language="C#" MasterPageFile="~/Masters/Base.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="ISE_S16_WB.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    About
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
                            <li><a href="#" class="active">About</a></li>
                            <li><a href="Friends.aspx">Friends</a></li>
                        </ul>
                        <ul class="follow-me list-inline">
                            <li>Friend with
                                <asp:Label ID="lbl_FriendNumber" runat="server" Text="0"></asp:Label>
                                people</li>
                            <li>
                                <asp:Button runat="server" Visible="false" ID="btn_AddFriend" CssClass="btn-primary" Text="Add Friend" OnClick="btn_AddFriend_Click" CausesValidation="false"/></li>
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
                        <li><a href="#" class="active">About</a></li>
                        <li><a href="Friends.aspx">Friends</a></li>
                    </ul>
                    <asp:Button runat="server" Visible="false" ID="btn_small_AddFriend" CssClass="btn-primary" Text="Add Friend" OnClick="btn_AddFriend_Click" />
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
                            <h4 class="grey"><i class="ion-at icon-in-title"></i>Email</h4>
                            <p id="UserEmail" runat="server"></p>
                        </div>

                        <div class="about-content-block">
                            <h4 class="grey"><i id="UserGenderIcon" runat="server" class="icon-in-title"></i>Gender</h4>
                            <p id="UserGender" runat="server"></p>
                        </div>

                        <div class="about-content-block">
                            <h4 class="grey"><i class="ion-iphone icon-in-title"></i>Mobile</h4>
                            <p id="UserMobile" runat="server"></p>
                        </div>

                        <div class="about-content-block">
                            <h4 class="grey"><i class="ion-calendar icon-in-title"></i>Birthday</h4>
                            <p id="UserBirthday" runat="server"></p>
                        </div>

                        <div class="about-content-block">
                            <h4 class="grey"><i class="ion-ios-people icon-in-title"></i>On SVU Social Network since</h4>
                            <p id="UserSince" runat="server"></p>
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
                        <div class="about-content-block">
                            <a visible="false" href="<%=ResolveUrl("~/EditAbout.aspx")%>">Edit data about yourself</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
