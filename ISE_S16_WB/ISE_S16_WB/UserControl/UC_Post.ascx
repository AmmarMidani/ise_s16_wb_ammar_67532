<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_Post.ascx.cs" Inherits="ISE_S16_WB.UC_Post" ClassName="Post" %>

<div class="post-content">
    <div id="myCarousel" runat="server" visible="true" class="carousel slide" data-ride="carousel">
        <!-- Wrapper for slides -->
        <div class="carousel-inner" role="listbox" runat="server" id="CarouselImagesContent"></div>
        <!-- Left and right controls -->
        <a class="left carousel-control" href="#<%=myCarousel.ClientID%>" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#<%=myCarousel.ClientID%>" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
    <div class="post-container">
        <asp:Image ImageUrl="~/UserImages/MPlaceHolder.jpg" ID="UserImage" runat="server" AlternateText="User" CssClass="profile-photo-md pull-left" />
        <div class="post-detail">
            <div class="user-info">
                <h5>
                    <asp:HyperLink runat="server" ID="UserName" CssClass="profile-link" NavigateUrl="#" Text="SVU User" /></h5>
                <p class="text-muted" runat="server" id="PostDateTime" title="">About </p>
            </div>
            <div class="reaction">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:LinkButton CssClass="btn text-black" OnClick="ButtonLike_Click" runat="server" ID="ButtonLike" CausesValidation="false"><i class="icon ion-thumbsup"></i></asp:LinkButton>
                        <div id="LikeNumbers" runat="server" style="display: inline;">0</div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ButtonLike" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
            <div class="line-divider"></div>
            <div class="post-text">
                <p runat="server" id="PostContent"></p>
            </div>
            <div class="line-divider"></div>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <div runat="server" id="PostComments"></div>
                    <div class="post-comment">
                        <asp:Image ImageUrl="~/UserImages/MPlaceHolder.jpg" ID="CommentUserImage" runat="server" AlternateText="User" CssClass="profile-photo-sm" />
                        <textarea id="PostCommentText" runat="server" class="form-control" oninput="Grow(this)" style="overflow: hidden;" placeholder="Post a comment" cols="30" rows="10"></textarea>
                        <asp:Button ID="SendComment" runat="server" CssClass="btn btn-primary btn-small pull-right" Text="Post" OnClick="SendComment_Click" CausesValidation="False" />
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="SendComment" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</div>