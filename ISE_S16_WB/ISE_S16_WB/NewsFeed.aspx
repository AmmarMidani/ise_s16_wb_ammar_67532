<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Base.Master" AutoEventWireup="true" CodeBehind="NewsFeed.aspx.cs" Inherits="ISE_S16_WB.NewsFeed" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    SVU Social Network | Home
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MiddleContent" runat="server">
    <asp:Panel runat="server" ID="AllPosts"></asp:Panel>
</asp:Content>