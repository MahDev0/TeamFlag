game.ReplicatedStorage.KillFeed.OnClientEvent:Connect(function(Killer, plrwhoiskilled, plrteam, killerteam)
	if killerteam == "Blue" then
		if game.Players.LocalPlayer.Name == Killer or plrwhoiskilled then
			local temp:Frame = script.Temp:clone()
			temp.Killed.Text = plrwhoiskilled
			temp.Killer.Text = Killer
			temp.Killer.TextColor3 = Color3.new(0, 0, 1)
			temp.Killed.TextColor3 = Color3.new(1, 0, 0)
			temp.Parent = script.Parent.ScrollingFrame
			temp.BackgroundTransparency = 0
		else
			local temp:Frame = script.Temp:clone()
			temp.Killed.Text = plrwhoiskilled
			temp.Killer.Text = Killer
			temp.Killer.TextColor3 = Color3.new(1, 0, 0)
			temp.Killed.TextColor3 = Color3.new(0, 0, 1)
			temp.Parent = script.Parent.ScrollingFrame
		end
		
	else
		if game.Players.LocalPlayer.Name == Killer or plrwhoiskilled then
			local temp:Frame = script.Temp:clone()
			temp.Killed.Text = plrwhoiskilled
			temp.Killer.Text = Killer
			temp.Killer.TextColor3 = Color3.new(1, 0, 0)
			temp.Killed.TextColor3 = Color3.new(0, 0, 1)
			temp.Parent = script.Parent.ScrollingFrame
			temp.BackgroundTransparency = 0
		else
			local temp:Frame = script.Temp:clone()
			temp.Killed.Text = plrwhoiskilled
			temp.Killer.Text = Killer
			temp.Killer.TextColor3 = Color3.new(1, 0, 0)
			temp.Killed.TextColor3 = Color3.new(0, 0, 1)
			temp.Parent = script.Parent.ScrollingFrame
		end
	end
	
end)
