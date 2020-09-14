USE [master]
GO
/****** Object:  Database [Weather]    Script Date: 14/09/2020 11:37:48 ******/
CREATE DATABASE [Weather]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WeatherForecast', FILENAME = N'C:\Users\Shaun.Obsidian\WeatherForecast.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'WeatherForecast_log', FILENAME = N'C:\Users\Shaun.Obsidian\WeatherForecast_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Weather] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Weather].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Weather] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Weather] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Weather] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Weather] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Weather] SET ARITHABORT OFF 
GO
ALTER DATABASE [Weather] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Weather] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Weather] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Weather] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Weather] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Weather] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Weather] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Weather] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Weather] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Weather] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Weather] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Weather] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Weather] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Weather] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Weather] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Weather] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Weather] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Weather] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Weather] SET  MULTI_USER 
GO
ALTER DATABASE [Weather] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Weather] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Weather] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Weather] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Weather] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Weather] SET QUERY_STORE = OFF
GO
USE [Weather]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Weather]
GO
/****** Object:  Table [dbo].[WeatherForecast]    Script Date: 14/09/2020 11:37:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WeatherForecast](
	[WeatherForecastID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [smalldatetime] NOT NULL,
	[TemperatureC] [decimal](4, 1) NOT NULL,
	[Frost] [bit] NOT NULL,
	[SummaryValue] [int] NOT NULL,
	[OutlookValue] [int] NOT NULL,
	[Description] [varchar](max) NULL,
	[PostCode] [varchar](50) NULL,
	[Detail] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_WeatherForecasts]    Script Date: 14/09/2020 11:37:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_WeatherForecasts]
AS
SELECT        WeatherForecastID, Date, TemperatureC, Frost, Description, PostCode, Detail, SummaryValue, OutlookValue
FROM            dbo.WeatherForecast
GO
ALTER TABLE [dbo].[WeatherForecast] ADD  CONSTRAINT [DF_WeatherForecast_Frost]  DEFAULT ((0)) FOR [Frost]
GO
/****** Object:  StoredProcedure [dbo].[sp_Create_WeatherForecast]    Script Date: 14/09/2020 11:37:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Shaun Curtis
-- Create date: 10 Aug-2020
-- Description:	Adds a new WeatherForecast Record
-- =============================================
CREATE PROCEDURE [dbo].[sp_Create_WeatherForecast]
	@WeatherForecastID int output
	,@Date smalldatetime
    ,@TemperatureC decimal(4,1)
    ,@Frost bit
    ,@SummaryValue int
    ,@OutlookValue int
    ,@Description varchar(max)
    ,@PostCode varchar(50)
    ,@Detail varchar(max)
AS
BEGIN
INSERT INTO [dbo].[WeatherForecast]
           ([Date]
           ,[TemperatureC]
           ,[Frost]
           ,[SummaryValue]
           ,[OutlookValue]
           ,[Description]
           ,[PostCode]
           ,[Detail])
     VALUES (
			@Date
           ,@TemperatureC
           ,@Frost
           ,@SummaryValue
           ,@OutlookValue
           ,@Description
           ,@PostCode
           ,@Detail
		   )

SELECT @WeatherForecastID  = SCOPE_IDENTITY();

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_WeatherForecast]    Script Date: 14/09/2020 11:37:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Shaun Curtis
-- Create date: 10 Aug-2020
-- Description:	Deletes a WeatherForecast Record
-- =============================================
CREATE PROCEDURE [dbo].[sp_Delete_WeatherForecast]
	@WeatherForecastID int
AS
BEGIN
DELETE FROM 
	WeatherForecast
 WHERE 
	WeatherForecastID = @WeatherForecastID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_WeatherForecast]    Script Date: 14/09/2020 11:37:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Shaun Curtis
-- Create date: 10 Aug-2020
-- Description:	Updates a WeatherForecast Record
-- =============================================
CREATE PROCEDURE [dbo].[sp_Update_WeatherForecast]
	@WeatherForecastID int
	,@Date smalldatetime
    ,@TemperatureC decimal(4,1)
    ,@Frost bit
    ,@SummaryValue int
    ,@OutlookValue int
    ,@Description varchar(max)
    ,@PostCode varchar(50)
    ,@Detail varchar(max)
AS
BEGIN
UPDATE WeatherForecast
   SET [Date] = @Date
      ,[TemperatureC] = @TemperatureC
      ,[Frost] = @Frost
      ,[SummaryValue] = @SummaryValue
      ,[OutlookValue] = @OutlookValue
      ,[Description] = @Description
      ,[PostCode] = @PostCode
      ,[Detail] = @Detail
 WHERE 
	WeatherForecastID = @WeatherForecastID
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "WeatherForecast"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 226
            End
            DisplayFlags = 280
            TopColumn = 5
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_WeatherForecasts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_WeatherForecasts'
GO
USE [master]
GO
ALTER DATABASE [Weather] SET  READ_WRITE 
GO
