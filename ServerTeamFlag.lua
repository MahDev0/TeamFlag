local teamModule = require(game.ReplicatedStorage.Main) -- require module
teamModule.Start("Red","Blue") -- start create game
teamModule.FlagTouch() -- init functions and events
teamModule.CheckPlayerFlagDied() -- players die event
teamModule.PlayerLeft()  -- player left event

game.Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(chr)
		chr.Humanoid.Died:Connect(function()
			if chr.Humanoid:FindFirstChild("creator") then --- check if player died from enemy team
				
				game.ReplicatedStorage.KillFeed:FireAllClients(chr.Humanoid:WaitForChild("creator").Value.Name, plr.Name ,plr.Team.Name,chr.Humanoid:WaitForChild("creator").Value.Team.Name)
			else
				return
			end
		end)
	end)
end)
