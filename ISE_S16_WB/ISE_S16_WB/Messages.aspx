<%@ Page Title="Messages" Language="C#" MasterPageFile="~/Masters/Base.Master" AutoEventWireup="true" CodeBehind="Messages.aspx.cs" Inherits="ISE_S16_WB.Messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Messages
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MiddleContent" runat="server">

    <div class="chat-room">
        <div class="row">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="col-md-4">

                        <!-- Contact List in Left-->
                        <ul id="MessageLeftSide" runat="server" class="nav nav-tabs contact-list scrollbar-wrapper scrollbar-outer">
                        </ul>
                        <!--Contact List in Left End-->

                    </div>
                    <asp:Timer runat="server" ID="TimerMessagesRefresh" OnTick="TimerMessagesRefresh_Tick" Interval="10000"></asp:Timer>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="TimerMessagesRefresh" EventName="Tick" />
                </Triggers>
            </asp:UpdatePanel>

            <div class="col-md-8">

                <!--Chat Messages in Right-->
                <div class="tab-content scrollbar-wrapper wrapper scrollbar-outer">
                    <div class="tab-pane active" id="contact-1">
                        <div class="chat-body">
                            <ul class="chat-message" id="ChatBody" runat="server">
                            </ul>
                        </div>
                    </div>
                </div>
                <!--Chat Messages in Right End-->

                <div class="send-message">
                    <div class="input-group">
                        <asp:TextBox runat="server" ID="Textbox_Message" CssClass="form-control" placeholder="Type your message"></asp:TextBox>
                        <span class="input-group-btn">
                            <button type="button" id="button_SendMessage" class="btn btn-default" onclick="callMe(<%=this.Textbox_Message.ClientID%> , <%
                                if (Request.QueryString["F"] != String.Empty && Request.QueryString["F"] != null)
                                {
                                    Response.Write(Request.QueryString["F"]);
                                }
                                else
                                {
                                    Response.Write("null");
                                }
                                 %> , <%=((ISE_S16_WB.User)Session["User"]).ID %>  , <%=this.ChatBody.ClientID %>)">
                                send</button>
                        </span>
                    </div>
                </div>
            </div>


            <div class="clearfix"></div>
        </div>
    </div>
</asp:Content>