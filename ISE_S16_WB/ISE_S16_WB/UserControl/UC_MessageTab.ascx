<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_MessageTab.ascx.cs" Inherits="ISE_S16_WB.UC_MessageTab" ClassName="MessageTab" %>

<li runat="server" id="MessageCard">
    <asp:HyperLink runat="server" ID="UserRedirect" >
        <div class="contact">
            <asp:Image ID="FriendImage" runat="server" ImageUrl="" AlternateText="" CssClass="profile-photo-sm pull-left" />
            <div class="msg-preview">
                <h6 id="FriendName" runat="server"></h6>
                <p id="LastMessage" runat="server" class="text-muted"></p>
                <small id="LastMessageTime" runat="server" class="text-muted"></small>
                <div id="MessageSeen" runat="server" visible="False" class="seen"><i class="icon ion-checkmark-round"></i></div>
                <div id="MessageAlert" runat="server" visible="False" class="chat-alert"></div>
            </div>
        </div>
    </asp:HyperLink>
</li>
