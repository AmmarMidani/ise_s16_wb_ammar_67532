<%@ Page Title="Friends Requests" Language="C#" MasterPageFile="~/Masters/Base.Master" AutoEventWireup="true" CodeBehind="FriendsRequests.aspx.cs" Inherits="ISE_S16_WB.FriendsRequests" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Friends Requests
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MiddleContent" runat="server">
    <div class="people-nearby" id="My_Requests" runat="server">
    </div>
</asp:Content>
