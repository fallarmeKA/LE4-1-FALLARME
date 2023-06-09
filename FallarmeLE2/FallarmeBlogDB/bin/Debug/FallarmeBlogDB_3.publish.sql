﻿/*
Deployment script for BlogDB

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BlogDB"
:setvar DefaultFilePrefix "BlogDB"
:setvar DefaultDataPath "C:\Users\falla\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\falla\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'The following operation was generated from a refactoring log file 5afc0497-7fa6-43c0-86e3-18cccd4b3fbe';

PRINT N'Rename [dbo].[Posts].[DataCreated] to DateCreated';


GO
EXECUTE sp_rename @objname = N'[dbo].[Posts].[DataCreated]', @newname = N'DateCreated', @objtype = N'COLUMN';


GO
PRINT N'Creating Procedure [dbo].[spPosts_Insert]...';


GO
CREATE PROCEDURE [dbo].[spPosts_Insert]
	@userId int,
	@title nvarchar(150),
	@body text,
	@dateCreated datetime2

AS
begin
	INSERT INTO dbo.Posts
	(UserId, Title, Body, DateCreated)
	VALUES
	(@userId, @title, @body, @dateCreated)

end
GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '5afc0497-7fa6-43c0-86e3-18cccd4b3fbe')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('5afc0497-7fa6-43c0-86e3-18cccd4b3fbe')

GO

GO
PRINT N'Update complete.';


GO
