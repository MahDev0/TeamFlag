local teamModule = require(game.ReplicatedStorage.Main)
teamModule.Start("Red","Blue")
teamModule.FlagTouch()
teamModule.CheckPlayerFlagDied()
teamModule.PlayerLeft()

game.Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(chr)
		chr.Humanoid.Died:Connect(function()
			if chr.Humanoid:FindFirstChild("creator") then
				
				game.ReplicatedStorage.KillFeed:FireAllClients(chr.Humanoid:WaitForChild("creator").Value.Name, plr.Name ,plr.Team.Name,chr.Humanoid:WaitForChild("creator").Value.Team.Name)
			else
				return
			end
		end)
	end)
end)