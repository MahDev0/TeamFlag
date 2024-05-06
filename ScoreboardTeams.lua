local team = {}
team.__index = team

function team.Update()
	local red = script.Parent.Redteam.value
	local blue = script.Parent.Blueteam.value
	local pointsr = game.ReplicatedStorage.Points.RedTeam
	local pointsb = game.ReplicatedStorage.Points.BlueTeam
	red.Text = pointsr.Value
	blue.Text = pointsb.Value
	pointsr.Changed:Connect(function()
		red.Text = pointsr.Value
	end)
	pointsb.Changed:Connect(function()
		blue.Text = pointsb.Value
	end)
end
-------------------------------------
-------------------------------------
function team.CheckGuiInFrame(name)
	local self = {}
	self.Gui = script.Parent.main.massage:Clone()
	self.Gui.Parent = script.Parent.hi
	self.Gui.Visible = true
	self.Gui.Name = name
	return setmetatable(self, team)
end

function team:ChangeTextAndColor(Text,Color)
	self.Gui.Text = Text
	self.Gui.TextColor3 = Color
	wait(3)
	self.Gui:Destroy()
end
-------------------------------
-------------------------------
function team.SendGuiToCharacter(Nameplayer, color)
	local self = {}
	self.Gui3d = script.Parent.main.Place:clone()
	self.Gui3d.flag.ImageColor3 = color
	self.Gui3d.Parent = game.Workspace[Nameplayer]
	self.Gui3d.Enabled = true
	return setmetatable(self, team)
end

function team:Destroy()
	self.Gui3d:Destroy()
end
---------------------------------
return team
