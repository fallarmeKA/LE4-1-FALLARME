CREATE PROCEDURE [dbo].[spPosts_Insert]
	@userId int,
	@title nvarchar(150),
	@body text,
	@dataCreated datetime2

AS
begin
	INSERT INTO dbo.Posts
	(UserId, Title, Body, DataCreated)
	VALUES
	(@userId, @title, @body, @dataCreated)

end
