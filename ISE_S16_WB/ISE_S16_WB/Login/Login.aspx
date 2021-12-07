<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/LoginMasterPage.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ISE_S16_WB.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 class="text-white">Login</h2>
    <div class="line-divider"></div>
    <div class="form-wrapper">
        <p class="signup-text">Login now and meet your friends around the world</p>
        <form runat="server" id="LoginForm">
            <fieldset class="form-group">
                <asp:TextBox runat="server" ID="textbox_Username" placeholder="Username or email" CssClass="form-control" Required></asp:TextBox>
            </fieldset>
            <fieldset class="form-group">
                <asp:TextBox runat="server" ID="textbox_Password" placeholder="Password" CssClass="form-control" TextMode="Password" Required></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="password must be at least 8-16 character"
                                ForeColor="Red" ControlToValidate="textbox_Password" Display="Dynamic" ValidationExpression="(.{8,16})"></asp:RegularExpressionValidator>
            </fieldset>
            <asp:Label runat="server" ID="lbl_status" Visible="False" Font-Bold="True" ForeColor="Red">Username or password is incorrect</asp:Label>
            <asp:Button runat="server" ID="button_submit" CssClass="btn-secondary" Style="position: relative; top: 20px;" Text="Login" OnClick="button_submit_Click" />
        </form>
    </div>
    <a href="<%=ResolveUrl("~/Signup.aspx")%>">Create new account</a>
</asp:Content>

