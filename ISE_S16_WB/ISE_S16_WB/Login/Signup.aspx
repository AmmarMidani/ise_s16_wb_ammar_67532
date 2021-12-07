<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/LoginMasterPage.Master" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="ISE_S16_WB.Signup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 class="text-white">Signup</h2>
    <div class="line-divider"></div>
    <div class="form-wrapper">
        <p class="signup-text">Signup now and meet awesome people around the world</p>
        <form runat="server" id="SingupForm">
            <fieldset class="form-group">
                <asp:TextBox runat="server" ID="textbox_Username" placeholder="Username" CssClass="form-control" Required></asp:TextBox>
            </fieldset>
            <fieldset class="form-group">
                <asp:TextBox runat="server" ID="textbox_Email" placeholder="Email" CssClass="form-control" Required></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="&lt;br&gt;Enter Regular Email" ControlToValidate="textbox_Email" Display="Dynamic" Font-Bold="True" ForeColor="Red" ValidationExpression='^(([^<>()[\]\\.,;:\s@\""]+(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$' SetFocusOnError="True"></asp:RegularExpressionValidator>
            </fieldset>
            <fieldset class="form-group">
                <asp:TextBox runat="server" ID="textbox_Password" placeholder="Password" CssClass="form-control" Required TextMode="Password"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="password must be at least 8-16 character"
                                ForeColor="Red" ControlToValidate="textbox_Password" Display="Dynamic"
                                ValidationExpression="(.{8,16})"></asp:RegularExpressionValidator>
            </fieldset>
            <fieldset class="form-group">
                <asp:TextBox runat="server" ID="textbox_ConfirmPassword" placeholder="Confirm Passowrd" CssClass="form-control" Required TextMode="Password"></asp:TextBox>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="textbox_Password" ControlToValidate="textbox_ConfirmPassword" ErrorMessage="&lt;br&gt;Doesn't match" Font-Bold="True" ForeColor="Red" Display="Dynamic"></asp:CompareValidator>
            </fieldset>
            <fieldset class="form-group">
                <asp:TextBox runat="server" ID="textbox_FirstName" placeholder="First Name" CssClass="form-control" Required></asp:TextBox>
            </fieldset>
            <fieldset class="form-group">
                <asp:TextBox runat="server" ID="textbox_LastName" placeholder="Last Name" CssClass="form-control" Required></asp:TextBox>
            </fieldset>
            <fieldset class="form-group">
                <asp:RadioButton ID="radio_gender_male" Text="Male" runat="server" CssClass="" Checked="true" GroupName="Gender"/>
                <asp:RadioButton ID="radio_gender_female" Text="Female" runat="server" CssClass="" GroupName="Gender"/>
            </fieldset>
            <asp:Label runat="server" ID="lbl_status" Visible="False" Font-Bold="True" ForeColor="Red" Text=""></asp:Label>
            <asp:Button runat="server" ID="button_submit" CssClass="btn-secondary" style="position: relative;top: 20px;" Text="Signup" OnClick="button_submit_Click"/>
        </form>
    </div>
    <a href="<%=ResolveUrl("~/Login.aspx")%>">Already have an account?</a>
</asp:Content>
