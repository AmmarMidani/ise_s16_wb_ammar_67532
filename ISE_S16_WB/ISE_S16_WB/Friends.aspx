<%@ Page Title="Friend List" Language="C#" MasterPageFile="~/Masters/Base.Master" AutoEventWireup="true" CodeBehind="Friends.aspx.cs" Inherits="ISE_S16_WB.Friends" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Friend List 
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
                            <li><a href="About.aspx">About</a></li>
                            <li><a href="#" class="active">Friends</a></li>
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
                        <li><a href="#" class="active">Friends</a></li>
                    </ul>
                </div>
            </div>
            <!--Timeline Menu for Small Screens End-->

        </div>
        <div id="page-contents">
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-9">

                    <!-- Friends 
              ================================================= -->
                    <div class="friend-list">
                        <div class="row" id="AllFriends" runat="server">
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
