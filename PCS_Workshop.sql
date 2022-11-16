/****** Object:  Schema [srsdev]    Script Date: 11/9/2022 9:23:35 AM ******/
CREATE SCHEMA [srsdev]
GO
/****** Object:  Table [dbo].[Student_Info]    Script Date: 11/9/2022 9:23:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student_Info](
	[First_Name] [nchar](30) NOT NULL,
	[Last_Name] [nchar](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [srsdev].[Address]    Script Date: 11/9/2022 9:23:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srsdev].[Address](
	[Address_ID] [int] NOT NULL,
	[Parent_ID] [int] NULL,
	[Student_ID] [int] NULL,
	[street_number] [nvarchar](8) NULL,
	[street_name] [nvarchar](38) NULL,
	[zip] [nvarchar](10) NULL,
	[city] [nvarchar](20) NULL,
	[state_code] [int] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Student_Info] ([First_Name], [Last_Name]) VALUES (N'John                          ', N'Doe                           ')
INSERT [dbo].[Student_Info] ([First_Name], [Last_Name]) VALUES (N'Mary                          ', N'Beth                          ')
GO
