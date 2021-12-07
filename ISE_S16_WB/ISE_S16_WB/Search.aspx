<%@ Page Title="Search" Language="C#" MasterPageFile="~/Masters/Base.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="ISE_S16_WB.Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Search
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MiddleContent" runat="server">
    <div class="friend-list">
        <div class="row" id="search_people" runat="server">
        </div>
    </div>
</asp:Content>
