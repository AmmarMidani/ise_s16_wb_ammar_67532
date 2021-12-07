<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_FriendCard.ascx.cs" Inherits="ISE_S16_WB.UC_FriendCard" %>
<div class="col-md-6 col-sm-6">
    <div class="friend-card">
        <asp:Image ID="CoverImage" ImageUrl="" runat="server" AlternateText="" CssClass="img-responsive cover"/>
        <div class="card-info">
            <asp:Image ID="FriendImage" ImageUrl="" runat="server" AlternateText="" CssClass="profile-photo-lg"/>
            <div class="friend-info">
                <%--<asp:Button CausesValidation="false" Text="Add Friend" runat="server" Visible="true" ID="btn_AddFriend" CssClass="pull-right btn btn-success" OnClick="btn_AddFriend_Click" />--%>
                <a href="#" class="pull-right text-green" runat="server" id="Label_Friend" visible="false">Friends</a>
                <h5><a id="FriendName" runat="server" href="" class="profile-link"></a></h5>
            </div>
        </div>
    </div>
</div>