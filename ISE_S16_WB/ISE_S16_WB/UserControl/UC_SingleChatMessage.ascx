<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_SingleChatMessage.ascx.cs" Inherits="ISE_S16_WB.UC_SingleChatMessage" ClassName="SingleChatMessage" %>

<li id="LI_Element" runat="server" class="" onclick="ShowDateMessage(this)">
    <asp:Image ID="ChatUserImage" runat="server" CssClass="profile-photo-sm" />
    <div class="chat-item">
        <div class="chat-item-header">
            <h5 id="SenderName" runat="server"></h5>
            <small id="MessageTime" runat="server" class="text-muted"></small>
        </div>
        <p id="MessageContent" runat="server"></p>
    </div>
    <div id="TimeDetails" runat="server" class="">at 7:00</div>
</li>