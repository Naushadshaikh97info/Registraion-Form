USE [master]
GO
/****** Object:  Database [Registraion]    Script Date: 10/22/2017 2:16:20 PM ******/
CREATE DATABASE [Registraion] ON  PRIMARY 
( NAME = N'Registraion', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\Registraion.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Registraion_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\Registraion_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Registraion] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Registraion].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Registraion] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Registraion] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Registraion] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Registraion] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Registraion] SET ARITHABORT OFF 
GO
ALTER DATABASE [Registraion] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Registraion] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Registraion] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Registraion] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Registraion] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Registraion] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Registraion] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Registraion] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Registraion] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Registraion] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Registraion] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Registraion] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Registraion] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Registraion] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Registraion] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Registraion] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Registraion] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Registraion] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Registraion] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Registraion] SET  MULTI_USER 
GO
ALTER DATABASE [Registraion] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Registraion] SET DB_CHAINING OFF 
GO
USE [Registraion]
GO
/****** Object:  StoredProcedure [dbo].[deleteregistraion]    Script Date: 10/22/2017 2:16:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Naushad>
-- Create date: <10/17/2017>
-- Description:	<Delete>
-- =============================================
CREATE PROCEDURE [dbo].[deleteregistraion] 
	@RegistraionID	  int	      
AS
BEGIN
	
	SET NOCOUNT ON;
    -- Delete Store Procedure 

	DELETE FROM Registraion 
	WHERE RegistraionID=@RegistraionID
	
END

GO
/****** Object:  StoredProcedure [dbo].[insertregistraion]    Script Date: 10/22/2017 2:16:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Naushad>
-- Create date: <10/17/2017>
-- Description:	<Insert>
-- =============================================
CREATE PROCEDURE [dbo].[insertregistraion]
	@firstname	varchar(50)	,
	@lastname	varchar(50)	,
	@emailid	varchar(30)	,
	@mobileno	varchar(20)	,
	@gender		varchar(10)	,
	@country	int			,
	@state		int			,
	@hobbies	varchar(20)	,
	@images		varchar(MAX)
AS
BEGIN
	 SET NOCOUNT ON;

    -- Insert procedure
	INSERT INTO Registraion
	(
	firstname	,
	lastname	,
	emailid		,
	mobileno	,
	gender		,
	country		,
	state		,
	hobbies		,
	images		
	)
	values
	(
	@firstname	,
	@lastname	,
	@emailid	,
	@mobileno	,
	@gender		,
	@country	,
	@state		,
	@hobbies	,
	@images		
	)
END

GO
/****** Object:  StoredProcedure [dbo].[updateregistraion]    Script Date: 10/22/2017 2:16:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Naushad>
-- Create date: <10/17/2017>
-- Description:	<Update Store Procedure>
-- =============================================
CREATE PROCEDURE [dbo].[updateregistraion]
	@RegistraionID	int	         ,        
	@firstname		varchar(50)	 ,
	@lastname		varchar(50)	 ,
	@emailid		varchar(30)	 ,
	@mobileno	    varchar(20)	 ,
	@gender			varchar(10)	 ,
	@country		int			 ,
	@state			int			 ,
	@hobbies		varchar(20)	 ,
	@images			varchar(MAX)  
AS
BEGIN
	
	SET NOCOUNT ON;

    -- Update Procedure
	UPDATE Registraion SET
	firstname		=@firstname		,
	lastname		=@lastname		,
	emailid			=@emailid		,
	mobileno	    =@mobileno	    ,
	gender			=@gender		,	
	country			=@country		,
	state			=@state			,
	hobbies			=@hobbies		,
	images			=@images		
	WHERE RegistraionID=@RegistraionID	
	
END

GO
/****** Object:  Table [dbo].[country]    Script Date: 10/22/2017 2:16:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[country](
	[countryid] [int] IDENTITY(1,1) NOT NULL,
	[countryname] [varchar](50) NULL,
 CONSTRAINT [PK_country] PRIMARY KEY CLUSTERED 
(
	[countryid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Registraion]    Script Date: 10/22/2017 2:16:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Registraion](
	[RegistraionID] [int] IDENTITY(1,1) NOT NULL,
	[firstname] [varchar](50) NULL,
	[lastname] [varchar](50) NULL,
	[emailid] [varchar](30) NULL,
	[mobileno] [varchar](20) NULL,
	[gender] [varchar](10) NULL,
	[country] [int] NULL,
	[state] [int] NULL,
	[hobbies] [varchar](20) NULL,
	[images] [varchar](max) NULL,
 CONSTRAINT [PK_Registraion] PRIMARY KEY CLUSTERED 
(
	[RegistraionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[state]    Script Date: 10/22/2017 2:16:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[state](
	[stateid] [int] IDENTITY(1,1) NOT NULL,
	[statename] [varchar](50) NULL,
	[countryid] [int] NULL,
 CONSTRAINT [PK_state] PRIMARY KEY CLUSTERED 
(
	[stateid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[country] ON 

INSERT [dbo].[country] ([countryid], [countryname]) VALUES (1, N'India')
SET IDENTITY_INSERT [dbo].[country] OFF
SET IDENTITY_INSERT [dbo].[Registraion] ON 

INSERT [dbo].[Registraion] ([RegistraionID], [firstname], [lastname], [emailid], [mobileno], [gender], [country], [state], [hobbies], [images]) VALUES (4, N'Naushad', N'shaikh1', N'naushadshaikh97info@gmail.com', N'8754216598', N'Female', 1, 1, N'Chess,Cricket', N'image.jpg')
INSERT [dbo].[Registraion] ([RegistraionID], [firstname], [lastname], [emailid], [mobileno], [gender], [country], [state], [hobbies], [images]) VALUES (5, N'rahul', N'patel', N'rahul@gmail.com', N'8460787498', N'Male', 1, 1, N'Chess,Holly Ball,Foo', N'download (1).jpg')
INSERT [dbo].[Registraion] ([RegistraionID], [firstname], [lastname], [emailid], [mobileno], [gender], [country], [state], [hobbies], [images]) VALUES (6, N'dhurvit', N'patel', N'dhurvit@gmail.com', N'9654125877', N'Male', 1, 1, N'Chess,Holly Ball,Foo', N'image.jpg')
INSERT [dbo].[Registraion] ([RegistraionID], [firstname], [lastname], [emailid], [mobileno], [gender], [country], [state], [hobbies], [images]) VALUES (7, N'salman ', N'shaikh', N'salman@gmail.com', N'8745213659', N'Male', 1, 2, N'Chess,Holly Ball', N'download (1).jpg')
SET IDENTITY_INSERT [dbo].[Registraion] OFF
SET IDENTITY_INSERT [dbo].[state] ON 

INSERT [dbo].[state] ([stateid], [statename], [countryid]) VALUES (1, N'Gujrat', 1)
INSERT [dbo].[state] ([stateid], [statename], [countryid]) VALUES (2, N'delhi', 1)
INSERT [dbo].[state] ([stateid], [statename], [countryid]) VALUES (3, N'mumbay', 1)
SET IDENTITY_INSERT [dbo].[state] OFF
USE [master]
GO
ALTER DATABASE [Registraion] SET  READ_WRITE 
GO
