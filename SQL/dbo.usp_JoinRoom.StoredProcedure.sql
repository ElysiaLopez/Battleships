USE [ElysiaLopezBattleships2017]
GO
/****** Object:  StoredProcedure [dbo].[usp_JoinRoom]    Script Date: 11/3/2017 12:44:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[usp_JoinRoom]
	@UserID int
,	@RoomID int
as	
DECLARE @HostPlayerID int = (SELECT HostPlayerID FROM Rooms WHERE RoomID = @RoomID)

IF @UserID != @HostPlayerID
BEGIN
	SELECT RoomID
	FROM Rooms
	WHERE RoomID = @RoomID
		
	UPDATE Rooms
	SET JoinedPlayerID = @UserID 
	WHERE RoomID = @RoomID

--	SELECT	Rooms.RoomID 
--,			Rooms.RoomName
--	FROM Rooms		
--	JOIN Users	
--	ON Rooms.JoinedPlayerID		=	JoinedPlayerID
--	WHERE Rooms.RoomID			=	@RoomID
--	AND	Users.UserID			=	@UserID
		

	SELECT	RoomID
	,		RoomName
	,		hp.UserID		AS HostPlayerID
	,		jp.UserID
	,		Rooms.isHostPlayerReady
	,		Rooms.isJoinedPlayerReady
	FROM	Rooms
	JOIN	Users		jp
	ON		Rooms.JoinedPlayerID	=	jp.UserID
	JOIN	Users		hp
	ON		Rooms.HostPlayerID		=	hp.UserID
	WHERE RoomID	=	@RoomID
	AND		jp.UserID	=	Rooms.JoinedPlayerID
END

GO
