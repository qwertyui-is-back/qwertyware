local function notif(text)
	game.StarterGui:SetCore("SendNotification", {Title = "qwertyware", Text = text})
end
notif("Creating initial files")
makefolder("qwertyware")
notif("Creating game files")
makefolder("qwertyware/games")
notif("Fetching games")
writefile("qwertyware/games/test","")