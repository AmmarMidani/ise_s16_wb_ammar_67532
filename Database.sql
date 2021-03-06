USE [SocialMedia]
GO
ALTER TABLE [dbo].[PostsImages] DROP CONSTRAINT [FK_PostsImages_Posts]
GO
ALTER TABLE [dbo].[Posts] DROP CONSTRAINT [FK_Posts_Users]
GO
ALTER TABLE [dbo].[PostLikes] DROP CONSTRAINT [FK_PostLikes_Users]
GO
ALTER TABLE [dbo].[PostLikes] DROP CONSTRAINT [FK_PostLikes_Posts]
GO
ALTER TABLE [dbo].[PostComments] DROP CONSTRAINT [FK_PostComments_Users]
GO
ALTER TABLE [dbo].[PostComments] DROP CONSTRAINT [FK_PostComments_Posts]
GO
ALTER TABLE [dbo].[FriendshipRequests] DROP CONSTRAINT [FK_FriendshipRequests_Users1]
GO
ALTER TABLE [dbo].[FriendshipRequests] DROP CONSTRAINT [FK_FriendshipRequests_Users]
GO
ALTER TABLE [dbo].[Chat] DROP CONSTRAINT [FK_Chat_Users1]
GO
ALTER TABLE [dbo].[Chat] DROP CONSTRAINT [FK_Chat_Users]
GO
/****** Object:  Index [IX_Users_Username]    Script Date: 2/5/2017 12:29:55 PM ******/
ALTER TABLE [dbo].[Users] DROP CONSTRAINT [IX_Users_Username]
GO
/****** Object:  Index [IX_Users_Email]    Script Date: 2/5/2017 12:29:55 PM ******/
ALTER TABLE [dbo].[Users] DROP CONSTRAINT [IX_Users_Email]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2/5/2017 12:29:55 PM ******/
DROP TABLE [dbo].[Users]
GO
/****** Object:  Table [dbo].[PostsImages]    Script Date: 2/5/2017 12:29:55 PM ******/
DROP TABLE [dbo].[PostsImages]
GO
/****** Object:  Table [dbo].[Posts]    Script Date: 2/5/2017 12:29:55 PM ******/
DROP TABLE [dbo].[Posts]
GO
/****** Object:  Table [dbo].[PostLikes]    Script Date: 2/5/2017 12:29:55 PM ******/
DROP TABLE [dbo].[PostLikes]
GO
/****** Object:  Table [dbo].[PostComments]    Script Date: 2/5/2017 12:29:55 PM ******/
DROP TABLE [dbo].[PostComments]
GO
/****** Object:  Table [dbo].[Inbox]    Script Date: 2/5/2017 12:29:55 PM ******/
DROP TABLE [dbo].[Inbox]
GO
/****** Object:  Table [dbo].[FriendshipRequests]    Script Date: 2/5/2017 12:29:55 PM ******/
DROP TABLE [dbo].[FriendshipRequests]
GO
/****** Object:  Table [dbo].[Chat]    Script Date: 2/5/2017 12:29:55 PM ******/
DROP TABLE [dbo].[Chat]
GO
/****** Object:  Table [dbo].[Chat]    Script Date: 2/5/2017 12:29:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chat](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[EventDateTime] [datetime] NOT NULL CONSTRAINT [DF_Chat_EventDateTime]  DEFAULT (getdate()),
	[FromUserID] [bigint] NOT NULL,
	[ToUserID] [bigint] NOT NULL,
	[MessageContent] [nvarchar](4000) NOT NULL,
	[IsRead] [bit] NOT NULL CONSTRAINT [DF_Chat_IsRead]  DEFAULT ((0)),
 CONSTRAINT [PK_Chat] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FriendshipRequests]    Script Date: 2/5/2017 12:29:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FriendshipRequests](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[FromUserID] [bigint] NOT NULL,
	[ToUserID] [bigint] NOT NULL,
	[RelationStatus] [int] NOT NULL CONSTRAINT [DF_FriendshipRequests_IsIgnored]  DEFAULT ((0)),
	[EventDateTime] [datetime] NOT NULL CONSTRAINT [DF_FriendshipRequests_EventDateTime]  DEFAULT (getdate()),
 CONSTRAINT [PK_FriendshipRequests] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Inbox]    Script Date: 2/5/2017 12:29:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inbox](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[InboxContent] [nvarchar](4000) NOT NULL,
	[EventDateTime] [datetime] NOT NULL,
	[RelatedID] [bigint] NOT NULL,
	[Type] [int] NOT NULL,
 CONSTRAINT [PK_Inbox] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PostComments]    Script Date: 2/5/2017 12:29:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostComments](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NOT NULL,
	[PostID] [bigint] NOT NULL,
	[CommentContent] [nvarchar](4000) NOT NULL,
	[EventDateTime] [datetime] NOT NULL CONSTRAINT [DF_PostComments_EventDateTime]  DEFAULT (getdate()),
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_PostComments_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_PostComments] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PostLikes]    Script Date: 2/5/2017 12:29:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostLikes](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NOT NULL,
	[PostID] [bigint] NOT NULL,
	[EventDateTime] [datetime] NOT NULL CONSTRAINT [DF_PostLikes_EventDateTime]  DEFAULT (getdate()),
 CONSTRAINT [PK_PostLikes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Posts]    Script Date: 2/5/2017 12:29:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Posts](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NOT NULL,
	[PostingDateTime] [datetime] NOT NULL CONSTRAINT [DF_Posts_PostingDateTime]  DEFAULT (getdate()),
	[PostContent] [ntext] NOT NULL,
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Posts_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_Posts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PostsImages]    Script Date: 2/5/2017 12:29:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostsImages](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[PostID] [bigint] NOT NULL,
	[ImageURL] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_PostsImages] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 2/5/2017 12:29:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](255) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[Firstname] [nvarchar](255) NOT NULL,
	[Lastname] [nvarchar](255) NOT NULL,
	[Mobile] [nvarchar](50) NULL,
	[Map_Lon] [nvarchar](50) NOT NULL CONSTRAINT [DF_Users_Map_Lon]  DEFAULT ((0)),
	[Map_Lat] [nvarchar](50) NOT NULL CONSTRAINT [DF_Users_Map_Lat]  DEFAULT ((0)),
	[Birthdate] [date] NULL,
	[PersonalImageURL] [nvarchar](1000) NULL,
	[WallImageURL] [nvarchar](1000) NULL,
	[LastSeen] [datetime] NOT NULL CONSTRAINT [DF_Users_LastSeen]  DEFAULT (getdate()),
	[IsOnline] [bit] NOT NULL,
	[Gender] [bit] NOT NULL,
	[RegisterationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Chat] ON 

GO
INSERT [dbo].[Chat] ([ID], [EventDateTime], [FromUserID], [ToUserID], [MessageContent], [IsRead]) VALUES (1, CAST(N'2016-12-22 02:53:30.000' AS DateTime), 1, 2, N'مرحبا', 1)
GO
INSERT [dbo].[Chat] ([ID], [EventDateTime], [FromUserID], [ToUserID], [MessageContent], [IsRead]) VALUES (2, CAST(N'2016-12-22 02:53:33.000' AS DateTime), 2, 1, N'أهلين', 1)
GO
INSERT [dbo].[Chat] ([ID], [EventDateTime], [FromUserID], [ToUserID], [MessageContent], [IsRead]) VALUES (6, CAST(N'2016-12-23 02:53:37.000' AS DateTime), 2, 3, N'صباح الخير', 0)
GO
INSERT [dbo].[Chat] ([ID], [EventDateTime], [FromUserID], [ToUserID], [MessageContent], [IsRead]) VALUES (7, CAST(N'2016-12-23 02:55:34.000' AS DateTime), 2, 3, N'كيفك', 0)
GO
INSERT [dbo].[Chat] ([ID], [EventDateTime], [FromUserID], [ToUserID], [MessageContent], [IsRead]) VALUES (8, CAST(N'2016-12-23 02:56:34.000' AS DateTime), 2, 3, N'ان شاء الله تمام', 0)
GO
INSERT [dbo].[Chat] ([ID], [EventDateTime], [FromUserID], [ToUserID], [MessageContent], [IsRead]) VALUES (9, CAST(N'2016-12-23 02:57:34.000' AS DateTime), 2, 3, N'ليش ما عم ترد', 0)
GO
INSERT [dbo].[Chat] ([ID], [EventDateTime], [FromUserID], [ToUserID], [MessageContent], [IsRead]) VALUES (10, CAST(N'2016-12-23 02:58:34.000' AS DateTime), 1, 2, N'asd', 1)
GO
INSERT [dbo].[Chat] ([ID], [EventDateTime], [FromUserID], [ToUserID], [MessageContent], [IsRead]) VALUES (11, CAST(N'2016-12-23 02:59:34.000' AS DateTime), 2, 1, N'6a8sd7', 0)
GO
INSERT [dbo].[Chat] ([ID], [EventDateTime], [FromUserID], [ToUserID], [MessageContent], [IsRead]) VALUES (12, CAST(N'2016-12-23 14:25:00.000' AS DateTime), 2, 1, N'ليش ما عم ترد', 0)
GO
INSERT [dbo].[Chat] ([ID], [EventDateTime], [FromUserID], [ToUserID], [MessageContent], [IsRead]) VALUES (13, CAST(N'2016-12-23 14:26:00.000' AS DateTime), 3, 1, N'مرحبا', 1)
GO
INSERT [dbo].[Chat] ([ID], [EventDateTime], [FromUserID], [ToUserID], [MessageContent], [IsRead]) VALUES (14, CAST(N'2016-12-23 14:50:00.000' AS DateTime), 3, 1, N'تذكرت قلك شغلة', 1)
GO
INSERT [dbo].[Chat] ([ID], [EventDateTime], [FromUserID], [ToUserID], [MessageContent], [IsRead]) VALUES (15, CAST(N'2016-12-23 14:55:00.000' AS DateTime), 3, 1, N'كودك ظريف :3', 1)
GO
INSERT [dbo].[Chat] ([ID], [EventDateTime], [FromUserID], [ToUserID], [MessageContent], [IsRead]) VALUES (16, CAST(N'2016-12-23 17:47:08.517' AS DateTime), 1, 3, N'بالله خجلتني', 1)
GO
INSERT [dbo].[Chat] ([ID], [EventDateTime], [FromUserID], [ToUserID], [MessageContent], [IsRead]) VALUES (21, CAST(N'2016-12-23 19:00:00.000' AS DateTime), 1, 3, N'يوهوو', 1)
GO
INSERT [dbo].[Chat] ([ID], [EventDateTime], [FromUserID], [ToUserID], [MessageContent], [IsRead]) VALUES (22, CAST(N'2016-12-23 22:35:31.007' AS DateTime), 1, 3, N'مسا الخير', 1)
GO
INSERT [dbo].[Chat] ([ID], [EventDateTime], [FromUserID], [ToUserID], [MessageContent], [IsRead]) VALUES (26, CAST(N'2016-12-27 22:35:23.370' AS DateTime), 1, 3, N'كيفك اشتقناك', 1)
GO
INSERT [dbo].[Chat] ([ID], [EventDateTime], [FromUserID], [ToUserID], [MessageContent], [IsRead]) VALUES (28, CAST(N'2016-12-28 00:20:53.080' AS DateTime), 1, 3, N'بالله', 1)
GO
INSERT [dbo].[Chat] ([ID], [EventDateTime], [FromUserID], [ToUserID], [MessageContent], [IsRead]) VALUES (47, CAST(N'2016-12-29 11:42:22.883' AS DateTime), 3, 1, N'احم احم', 1)
GO
INSERT [dbo].[Chat] ([ID], [EventDateTime], [FromUserID], [ToUserID], [MessageContent], [IsRead]) VALUES (48, CAST(N'2016-12-29 11:43:08.790' AS DateTime), 3, 1, N'شلونك', 1)
GO
INSERT [dbo].[Chat] ([ID], [EventDateTime], [FromUserID], [ToUserID], [MessageContent], [IsRead]) VALUES (78, CAST(N'2017-01-09 00:19:43.600' AS DateTime), 1, 3, N'منيح', 1)
GO
INSERT [dbo].[Chat] ([ID], [EventDateTime], [FromUserID], [ToUserID], [MessageContent], [IsRead]) VALUES (79, CAST(N'2017-01-09 00:19:48.393' AS DateTime), 1, 3, N'وانت كيفك', 1)
GO
INSERT [dbo].[Chat] ([ID], [EventDateTime], [FromUserID], [ToUserID], [MessageContent], [IsRead]) VALUES (80, CAST(N'2017-01-09 00:20:46.203' AS DateTime), 3, 1, N'على كيفك :D', 1)
GO
SET IDENTITY_INSERT [dbo].[Chat] OFF
GO
SET IDENTITY_INSERT [dbo].[FriendshipRequests] ON 

GO
INSERT [dbo].[FriendshipRequests] ([ID], [FromUserID], [ToUserID], [RelationStatus], [EventDateTime]) VALUES (1, 1, 2, 1, CAST(N'2016-01-01 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[FriendshipRequests] ([ID], [FromUserID], [ToUserID], [RelationStatus], [EventDateTime]) VALUES (6, 1, 3, 1, CAST(N'2017-01-02 17:34:53.430' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[FriendshipRequests] OFF
GO
SET IDENTITY_INSERT [dbo].[PostComments] ON 

GO
INSERT [dbo].[PostComments] ([ID], [UserID], [PostID], [CommentContent], [EventDateTime], [IsDeleted]) VALUES (1, 1, 1, N'والله شي ظريف تعا شوف', CAST(N'2016-01-01 00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[PostComments] ([ID], [UserID], [PostID], [CommentContent], [EventDateTime], [IsDeleted]) VALUES (2, 1, 1, N'Awesome', CAST(N'2016-02-01 00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[PostComments] ([ID], [UserID], [PostID], [CommentContent], [EventDateTime], [IsDeleted]) VALUES (3, 2, 1, N'Commect user 2 on post 1 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', CAST(N'2016-12-20 01:49:43.473' AS DateTime), 0)
GO
INSERT [dbo].[PostComments] ([ID], [UserID], [PostID], [CommentContent], [EventDateTime], [IsDeleted]) VALUES (10, 1, 1, N'Wooowww Ammar Midani & Danial Abbas', CAST(N'2016-12-20 18:43:07.577' AS DateTime), 0)
GO
INSERT [dbo].[PostComments] ([ID], [UserID], [PostID], [CommentContent], [EventDateTime], [IsDeleted]) VALUES (11, 1, 1, N'يا سلام ^_^', CAST(N'2016-12-20 18:44:31.200' AS DateTime), 0)
GO
INSERT [dbo].[PostComments] ([ID], [UserID], [PostID], [CommentContent], [EventDateTime], [IsDeleted]) VALUES (19, 4, 1, N'Wowo Ammar Account Commenting', CAST(N'2016-12-20 18:50:29.847' AS DateTime), 0)
GO
INSERT [dbo].[PostComments] ([ID], [UserID], [PostID], [CommentContent], [EventDateTime], [IsDeleted]) VALUES (21, 1, 1, N'Hello', CAST(N'2016-12-20 22:39:13.367' AS DateTime), 0)
GO
INSERT [dbo].[PostComments] ([ID], [UserID], [PostID], [CommentContent], [EventDateTime], [IsDeleted]) VALUES (22, 1, 2, N'ما حدا حطلي لايك [@[angry]]', CAST(N'2016-12-20 23:05:53.377' AS DateTime), 0)
GO
INSERT [dbo].[PostComments] ([ID], [UserID], [PostID], [CommentContent], [EventDateTime], [IsDeleted]) VALUES (23, 1, 2, N'لح حط لايك لحالي', CAST(N'2016-12-20 23:05:58.427' AS DateTime), 0)
GO
INSERT [dbo].[PostComments] ([ID], [UserID], [PostID], [CommentContent], [EventDateTime], [IsDeleted]) VALUES (24, 1, 2, N'Thats Good :(', CAST(N'2016-12-20 23:51:37.260' AS DateTime), 0)
GO
INSERT [dbo].[PostComments] ([ID], [UserID], [PostID], [CommentContent], [EventDateTime], [IsDeleted]) VALUES (25, 1, 3, N'هلوز فيك :P', CAST(N'2016-12-22 03:16:55.000' AS DateTime), 0)
GO
INSERT [dbo].[PostComments] ([ID], [UserID], [PostID], [CommentContent], [EventDateTime], [IsDeleted]) VALUES (28, 1, 4, N'zxc', CAST(N'2016-12-27 04:10:00.533' AS DateTime), 0)
GO
INSERT [dbo].[PostComments] ([ID], [UserID], [PostID], [CommentContent], [EventDateTime], [IsDeleted]) VALUES (29, 1, 4, N'شو هااااد', CAST(N'2016-12-31 15:20:26.420' AS DateTime), 0)
GO
INSERT [dbo].[PostComments] ([ID], [UserID], [PostID], [CommentContent], [EventDateTime], [IsDeleted]) VALUES (30, 3, 4, N'تسلم يا حبيبي', CAST(N'2016-12-31 15:20:34.557' AS DateTime), 0)
GO
INSERT [dbo].[PostComments] ([ID], [UserID], [PostID], [CommentContent], [EventDateTime], [IsDeleted]) VALUES (31, 3, 4, N':D', CAST(N'2016-12-31 15:21:01.983' AS DateTime), 0)
GO
INSERT [dbo].[PostComments] ([ID], [UserID], [PostID], [CommentContent], [EventDateTime], [IsDeleted]) VALUES (32, 3, 4, N':*', CAST(N'2016-12-31 15:21:05.607' AS DateTime), 0)
GO
INSERT [dbo].[PostComments] ([ID], [UserID], [PostID], [CommentContent], [EventDateTime], [IsDeleted]) VALUES (33, 3, 4, N':( :)', CAST(N'2016-12-31 15:21:14.023' AS DateTime), 0)
GO
INSERT [dbo].[PostComments] ([ID], [UserID], [PostID], [CommentContent], [EventDateTime], [IsDeleted]) VALUES (34, 3, 4, N'Test emoji', CAST(N'2016-12-31 15:21:28.313' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[PostComments] OFF
GO
SET IDENTITY_INSERT [dbo].[PostLikes] ON 

GO
INSERT [dbo].[PostLikes] ([ID], [UserID], [PostID], [EventDateTime]) VALUES (27, 2, 1, CAST(N'2016-12-20 00:40:20.537' AS DateTime))
GO
INSERT [dbo].[PostLikes] ([ID], [UserID], [PostID], [EventDateTime]) VALUES (28, 3, 1, CAST(N'2016-12-20 00:40:20.537' AS DateTime))
GO
INSERT [dbo].[PostLikes] ([ID], [UserID], [PostID], [EventDateTime]) VALUES (65, 1, 1, CAST(N'2016-12-20 23:51:26.747' AS DateTime))
GO
INSERT [dbo].[PostLikes] ([ID], [UserID], [PostID], [EventDateTime]) VALUES (68, 1, 3, CAST(N'2016-12-22 03:16:46.467' AS DateTime))
GO
INSERT [dbo].[PostLikes] ([ID], [UserID], [PostID], [EventDateTime]) VALUES (70, 1, 2, CAST(N'2016-12-31 12:31:03.253' AS DateTime))
GO
INSERT [dbo].[PostLikes] ([ID], [UserID], [PostID], [EventDateTime]) VALUES (71, 3, 4, CAST(N'2016-12-31 15:20:17.370' AS DateTime))
GO
INSERT [dbo].[PostLikes] ([ID], [UserID], [PostID], [EventDateTime]) VALUES (73, 1, 4, CAST(N'2017-01-05 22:42:50.923' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[PostLikes] OFF
GO
SET IDENTITY_INSERT [dbo].[Posts] ON 

GO
INSERT [dbo].[Posts] ([ID], [UserID], [PostingDateTime], [PostContent], [IsDeleted]) VALUES (1, 1, CAST(N'2016-12-19 16:50:10.000' AS DateTime), N'Admin Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 0)
GO
INSERT [dbo].[Posts] ([ID], [UserID], [PostingDateTime], [PostContent], [IsDeleted]) VALUES (2, 1, CAST(N'2016-02-01 00:00:00.000' AS DateTime), N'Admin 222 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 0)
GO
INSERT [dbo].[Posts] ([ID], [UserID], [PostingDateTime], [PostContent], [IsDeleted]) VALUES (3, 2, CAST(N'2016-12-20 00:00:00.000' AS DateTime), N'Hellooooo ;alsdk asdl;kqw poqkw ;laksd ', 0)
GO
INSERT [dbo].[Posts] ([ID], [UserID], [PostingDateTime], [PostContent], [IsDeleted]) VALUES (4, 3, CAST(N'2016-12-21 00:00:00.000' AS DateTime), N'User 3 said : Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 0)
GO
SET IDENTITY_INSERT [dbo].[Posts] OFF
GO
SET IDENTITY_INSERT [dbo].[PostsImages] ON 

GO
INSERT [dbo].[PostsImages] ([ID], [PostID], [ImageURL]) VALUES (1, 1, N'1_b250055549905dc94a15471a20005c70_1.jpg')
GO
INSERT [dbo].[PostsImages] ([ID], [PostID], [ImageURL]) VALUES (2, 1, N'1_6603ccbbffb33d066dc339f53583d8eb_2.jpg')
GO
INSERT [dbo].[PostsImages] ([ID], [PostID], [ImageURL]) VALUES (5, 1, N'1_c798bebf289c15fa440629f760cdbbee_4.jpg')
GO
SET IDENTITY_INSERT [dbo].[PostsImages] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

GO
INSERT [dbo].[Users] ([ID], [Username], [Password], [Email], [Firstname], [Lastname], [Mobile], [Map_Lon], [Map_Lat], [Birthdate], [PersonalImageURL], [WallImageURL], [LastSeen], [IsOnline], [Gender], [RegisterationDate]) VALUES (1, N'admin', N'f6fdffe48c908deb0f4c3bd36c032e72', N'admin@gmail.com', N'admin', N'admin', N'0991402237', N'0', N'0', CAST(N'1994-07-18' AS Date), N'1_e26fb580e459b8b774826b8f7a49928c.jpg', N'1_8812ae0701827b0f20bcb4015fb65e7e.jpg', CAST(N'2017-01-09 13:25:46.487' AS DateTime), 0, 0, CAST(N'2016-01-05 15:09:24.977' AS DateTime))
GO
INSERT [dbo].[Users] ([ID], [Username], [Password], [Email], [Firstname], [Lastname], [Mobile], [Map_Lon], [Map_Lat], [Birthdate], [PersonalImageURL], [WallImageURL], [LastSeen], [IsOnline], [Gender], [RegisterationDate]) VALUES (2, N'admin2', N'af8eb328301d219cfd1d50e6c6a48f58', N'admin2@gmail.com', N'Admin', N'LAdmin', NULL, N'0', N'0', NULL, N'2_f61d2a4687e8e5d8ee981cf4d3c527c3.jpg', N'2_120b8269fe21efb52c883e9ed6004c64.jpg', CAST(N'2017-01-07 13:46:12.297' AS DateTime), 0, 1, CAST(N'2016-09-05 09:09:24.977' AS DateTime))
GO
INSERT [dbo].[Users] ([ID], [Username], [Password], [Email], [Firstname], [Lastname], [Mobile], [Map_Lon], [Map_Lat], [Birthdate], [PersonalImageURL], [WallImageURL], [LastSeen], [IsOnline], [Gender], [RegisterationDate]) VALUES (3, N'awab', N'1e39d1e90f122eeeb57b6b8e195fc03a', N'awab@gmail.com', N'Awab', N'Midani', NULL, N'0', N'0', NULL, NULL, NULL, CAST(N'2017-01-09 01:24:20.857' AS DateTime), 1, 1, CAST(N'2016-12-10 00:17:38.000' AS DateTime))
GO
INSERT [dbo].[Users] ([ID], [Username], [Password], [Email], [Firstname], [Lastname], [Mobile], [Map_Lon], [Map_Lat], [Birthdate], [PersonalImageURL], [WallImageURL], [LastSeen], [IsOnline], [Gender], [RegisterationDate]) VALUES (4, N'ammar', N'c720c1110b56d1482216fe77e597f5cf', N'ammar@gmail.com', N'Ammar', N'Midani', NULL, N'0', N'0', NULL, NULL, NULL, CAST(N'2017-01-05 15:04:11.563' AS DateTime), 0, 1, CAST(N'2016-12-19 00:46:09.313' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  Index [IX_Users_Email]    Script Date: 2/5/2017 12:29:55 PM ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [IX_Users_Email] UNIQUE NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Users_Username]    Script Date: 2/5/2017 12:29:55 PM ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [IX_Users_Username] UNIQUE NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Chat]  WITH CHECK ADD  CONSTRAINT [FK_Chat_Users] FOREIGN KEY([FromUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Chat] CHECK CONSTRAINT [FK_Chat_Users]
GO
ALTER TABLE [dbo].[Chat]  WITH CHECK ADD  CONSTRAINT [FK_Chat_Users1] FOREIGN KEY([ToUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Chat] CHECK CONSTRAINT [FK_Chat_Users1]
GO
ALTER TABLE [dbo].[FriendshipRequests]  WITH CHECK ADD  CONSTRAINT [FK_FriendshipRequests_Users] FOREIGN KEY([FromUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[FriendshipRequests] CHECK CONSTRAINT [FK_FriendshipRequests_Users]
GO
ALTER TABLE [dbo].[FriendshipRequests]  WITH CHECK ADD  CONSTRAINT [FK_FriendshipRequests_Users1] FOREIGN KEY([ToUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[FriendshipRequests] CHECK CONSTRAINT [FK_FriendshipRequests_Users1]
GO
ALTER TABLE [dbo].[PostComments]  WITH CHECK ADD  CONSTRAINT [FK_PostComments_Posts] FOREIGN KEY([PostID])
REFERENCES [dbo].[Posts] ([ID])
GO
ALTER TABLE [dbo].[PostComments] CHECK CONSTRAINT [FK_PostComments_Posts]
GO
ALTER TABLE [dbo].[PostComments]  WITH CHECK ADD  CONSTRAINT [FK_PostComments_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[PostComments] CHECK CONSTRAINT [FK_PostComments_Users]
GO
ALTER TABLE [dbo].[PostLikes]  WITH CHECK ADD  CONSTRAINT [FK_PostLikes_Posts] FOREIGN KEY([PostID])
REFERENCES [dbo].[Posts] ([ID])
GO
ALTER TABLE [dbo].[PostLikes] CHECK CONSTRAINT [FK_PostLikes_Posts]
GO
ALTER TABLE [dbo].[PostLikes]  WITH CHECK ADD  CONSTRAINT [FK_PostLikes_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[PostLikes] CHECK CONSTRAINT [FK_PostLikes_Users]
GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD  CONSTRAINT [FK_Posts_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Posts] CHECK CONSTRAINT [FK_Posts_Users]
GO
ALTER TABLE [dbo].[PostsImages]  WITH CHECK ADD  CONSTRAINT [FK_PostsImages_Posts] FOREIGN KEY([PostID])
REFERENCES [dbo].[Posts] ([ID])
GO
ALTER TABLE [dbo].[PostsImages] CHECK CONSTRAINT [FK_PostsImages_Posts]
GO
