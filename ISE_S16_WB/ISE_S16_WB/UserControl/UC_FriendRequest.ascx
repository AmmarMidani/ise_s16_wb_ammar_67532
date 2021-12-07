<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_FriendRequest.ascx.cs" Inherits="ISE_S16_WB.UC_FriendRequest" %>
<div class="nearby-user">
    <div class="row">
        <div class="col-md-2 col-sm-2">
            <asp:Image ImageUrl="" ID="PersonImage" CssClass="profile-photo-lg" AlternateText="" runat="server" />
        </div>
        <div class="col-md-4 col-sm-4">
            <h5><a href="#" class="profile-link" id="PersonName" runat="server"></a></h5>
        </div>
        <div class="col-md-3 col-sm-3">
            <asp:Button ID="btn_Accept" runat="server" Text="Accept" CausesValidation="false" CssClass="btn btn-success pull-right" OnClick="btn_Accept_Click"/>
        </div>
        <div class="col-md-3 col-sm-3">
            <asp:Button ID="btn_Reject" runat="server" Text="Reject" CausesValidation="false" CssClass="btn btn-danger pull-right" OnClick="btn_Reject_Click"/>
        </div>
    </div>
</div>
