local team = {}
team.__index = team
local BlueTeamTouched = false
local RedTeamTouched = false

function team.ChangeNameCaptrue(value) --Change team name capture
	if game.Players[value].Team == game.Teams:WaitForChild("Blue") then
		game.ReplicatedStorage.FlagCaptrue.RedFlagCaptrue.Value = value
	else
		game.ReplicatedStorage.FlagCaptrue.BlueFlagCaptrue.Value = value
	end
end
function team.GetValues() --Make new object round or scoreboard function
	local self = {}
	local sss = game.ReplicatedStorage.Points
	self.Red = sss.RedTeam
	self.Blue = sss.BlueTeam
	return setmetatable(self, team)
end 

function team:IncreasePoints(teamname, num) --increase score for selected team
	self[teamname].Value += num
end

local function getPlayerFromCharacter(character) --get player  by  character
	for _, player in pairs(game:GetService("Players"):GetPlayers()) do
		if player.Character == character then
			return player
		end
	end
end

function team.PlayerLeft() -- check if player left game
	game.Players.PlayerRemoving:Connect(function(plr)
		local blueflag = game.Workspace.Blueland.BlueFlag
		local redflag = game.Workspace.Redland.RedFlag
		if plr.Team == game.Teams:WaitForChild("Blue") then
			
			if plr.Name == game.ReplicatedStorage.FlagCaptrue.RedFlagCaptrue.Value then
				game.ReplicatedStorage.FlagCaptrue.RedFlagCaptrue.Value = ""
				RedTeamTouched = false
				redflag.Transparency = 0
				redflag.CanCollide = true
				print("Flag Return To His Zone")
			end
		else
			if plr.Name == game.ReplicatedStorage.FlagCaptrue.BlueFlagCaptrue.Value then
				game.ReplicatedStorage.FlagCaptrue.BlueFlagCaptrue.Value = ""
				BlueTeamTouched = false
				blueflag.Transparency = 0
				blueflag.CanCollide = true
				print("Flag Return To His Zone23")
			end
		end
		
	end)
end
function team.CheckPlayerFlagDied() -- check if player died
	local blueflag = game.Workspace.Blueland.BlueFlag
	local redflag = game.Workspace.Redland.RedFlag
	game.Players.PlayerAdded:Connect(function(plr)
		plr.CharacterAdded:Connect(function(chr)
			chr.Humanoid.Died:Connect(function()
				for i, object:Accessory in pairs(chr:GetChildren()) do
					if object:IsA("Accessory") then
						if string.find(object.Name, "Blue") then
							object:Destroy()
							local clone:Part = blueflag:Clone()
							clone.Parent = workspace
							clone.CanCollide = true
							clone.Position = chr.HumanoidRootPart.Position 
							clone.CFrame = clone.CFrame * CFrame.new(3,0,0)
							clone.Transparency = 0
							game.ReplicatedStorage.FlagCaptrue.BlueFlagCaptrue.Value = ""
							wait(4)
							clone.Touched:Connect(function(hit)
								
								local chr1 = hit.Parent
								local plr1 = getPlayerFromCharacter(chr1)
								if plr1 then
									if plr1.Team ~= game.Teams:WaitForChild("Red") then
										BlueTeamTouched = false
										clone:Destroy()
										blueflag.Transparency = 0
										blueflag.CanCollide = true
									else
										local Acess = game.ServerScriptService.Team.BlueFlagAccessory:Clone()
										Acess.Parent = chr1
										clone:Destroy()
										team.ChangeNameCaptrue(plr.Name)
									end
								end
							end)
							
						end
						if string.find(object.Name, "Red") then
							object:Destroy()
							local clone:Part = redflag:Clone()
							clone.Parent = workspace
							clone.CanCollide = true
							clone.Position = chr.HumanoidRootPart.Position 
							clone.CFrame = clone.CFrame * CFrame.new(3,0,0)
							clone.Transparency = 0
							game.ReplicatedStorage.FlagCaptrue.RedFlagCaptrue.Value = ""
							wait(4)
							clone.Touched:Connect(function(hit)
								local chr1 = hit.Parent
								local plr1 = getPlayerFromCharacter(chr1)
								if plr1 then
									if plr1.Team ~= game.Teams:WaitForChild("Blue") then
										RedTeamTouched = false
										clone:Destroy()
										redflag.Transparency = 0
										redflag.CanCollide = true
									else
										local Acess = game.ServerScriptService.Team.RedFlagAccessory:Clone()
										Acess.Parent = chr1
										clone:Destroy()
										team.ChangeNameCaptrue(plr.Name)
									end
								end
							end)
						end
					end
				end
			end)
		end)
	end)
end

--------------------------------MainSystem
function team.Start(teamname1,teamname2)--start create part spawn and flags and teams
	local redteam , blueteam = Instance.new("Team", game.Teams), Instance.new("Team",game.Teams)
	redteam.Name = teamname1
	blueteam.Name = teamname2
	redteam.TeamColor = game.Workspace.Redland.BrickColor
	blueteam.TeamColor = game.Workspace.Blueland.BrickColor
	local spawn1, spawn2 = Instance.new("SpawnLocation",workspace), Instance.new("SpawnLocation",workspace)
	spawn1.Name = teamname1
	spawn1.CanCollide = false
	spawn1.Anchored = true
	spawn1.Position = game.Workspace.point2.Position 
	spawn1.BrickColor = game.Workspace.Redland.BrickColor
	spawn1.Transparency = 0
	spawn1.TeamColor = game.Workspace.Redland.BrickColor
	spawn1.AllowTeamChangeOnTouch = true
	spawn1.Neutral = false
	spawn2.Name = teamname2
	spawn2.CanCollide = false
	spawn2.Anchored = true
	spawn2.Position = game.Workspace.point1.Position 
	spawn2.BrickColor = game.Workspace.Blueland.BrickColor
	spawn2.Transparency = 0
	spawn2.TeamColor = game.Workspace.Blueland.BrickColor
	spawn2.AllowTeamChangeOnTouch = true
	spawn2.Neutral = false
	----Touched
end

function team.FlagTouch () -- check if got touched by players
	local blueflag = game.Workspace.Blueland.BlueFlag
	local redflag = game.Workspace.Redland.RedFlag
	local Blueland = game.Workspace.Blueland.Union
	local redland = game.Workspace.Redland.Union
---------------------------------------------Flag Team If Touched
	blueflag.Touched:Connect(function(hit)
		local chr = hit.Parent
		local plr = getPlayerFromCharacter(chr)
		if plr then
			if plr.Team ~= game.Teams:WaitForChild("Blue") and not BlueTeamTouched then
				BlueTeamTouched= true
				local clone = game.ServerScriptService.Team.BlueFlagAccessory:clone()
				clone.Parent = chr
				script.SendMassage:FireAllClients(plr.Name, "Red")
				blueflag.Transparency = 1
				blueflag.CanCollide = false
				team.ChangeNameCaptrue(plr.Name)
			end
		end
	end)
	redflag.Touched:Connect(function(hit)
		local chr = hit.Parent
		local plr = getPlayerFromCharacter(chr)

		if plr then
			if plr.Team ~= game.Teams:WaitForChild("Red") and not RedTeamTouched then
				RedTeamTouched = true
				local clone = game.ServerScriptService.Team.RedFlagAccessory:clone()
				clone.Parent = chr
				script.SendMassage:FireAllClients(plr.Name, "Blue")
				redflag.Transparency = 1
				redflag.CanCollide = false
				team.ChangeNameCaptrue(plr.Name)
			end
		end
	end)
	----------------------------------------TeamLand Touched
	Blueland.Touched:Connect(function(hit)
		local chr = hit.Parent
		local plr = getPlayerFromCharacter(chr)
		local Values = team.GetValues()
		
		if plr then
			if plr.Team == game.Teams:WaitForChild("Blue") and RedTeamTouched and chr:FindFirstChild("RedFlagAccessory") then
				RedTeamTouched = false
				redflag.Transparency = 0
				redflag.CanCollide = true
				chr:WaitForChild("RedFlagAccessory"):Destroy()
				Values:IncreasePoints("Blue", 1)
			end
		end
	end)
	redland.Touched:Connect(function(hit)
		local chr = hit.Parent
		local plr = getPlayerFromCharacter(chr)
		local Values = team.GetValues()
		if plr then
			if plr.Team == game.Teams:WaitForChild("Red") and BlueTeamTouched and chr:FindFirstChild("BlueFlagAccessory") then
				BlueTeamTouched = false
				blueflag.Transparency = 0
				blueflag.CanCollide = true
				chr:WaitForChild("BlueFlagAccessory"):Destroy()
				Values:IncreasePoints("Red", 1)
			end
		end
	end)
end


return team
