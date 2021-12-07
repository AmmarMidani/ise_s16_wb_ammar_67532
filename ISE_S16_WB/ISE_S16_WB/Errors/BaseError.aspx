<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BaseError.aspx.cs" Inherits="ISE_S16_WB.BaseError" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Error Happend</title>
    <style type="text/css">
        #fof {
            display: block;
            width: 100%;
            padding: 150px 0;
            line-height: 1.6em;
            text-align: center;
        }
            #fof .fl_left {
            }
                #fof .fl_left img {
                }
            #fof .fl_right {
            }
                #fof .fl_right h1 {
                    font-size: 60px;
                    text-transform: uppercase;
                }
                #fof .fl_right p {
                    display: block;
                    margin: 0 0 25px 0;
                    padding: 0;
                    font-size: 16px;
                }
                #fof .fl_right #respond input {
                    width: 200px;
                    padding: 5px;
                    border: 1px solid #CCCCCC;
                }
                #fof .fl_right #respond #submit {
                    width: auto;
                }
    </style>
</head>
<body>
    <div class="wrapper row2">
        <div id="container" class="clear">
            <section id="fof" class="clear">
                <div class="fl_right">
                    <h1>SORRY!</h1>
                    <p>Somthing happend on our server please try again or call developers</p>
                    <p>Go back to the <a href="javascript:history.go(-1)">previous page</a> or go to <a href="<%=ResolveUrl("~/NewsFeed.aspx") %>">News Feed</a> Page</p>
                </div>
            </section>
        </div>
    </div>
</body>
</html>
