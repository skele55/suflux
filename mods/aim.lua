local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character
local Humanoid = Character.Humanoid
local RunService = game:GetService("RunService")

if _G.aims then
	_G.aims.con:Disconnect()
	_G.aims = nil
	return
end

_G.aims = {}

local partToAimAt = _G.partToAim

function GetClosestCharacter()
	local dist = math.huge 
	local closessst = nil
	for i,v in pairs(Players:GetPlayers()) do
		if v == Player then continue end

		local vhrp = v.Character.Humanoid.RootPart
		local vdist = (vhrp.Position - Humanoid.RootPart.Position).Magnitude
		if vdist < dist then
			dist = vdist
			closessst = v.Character
		end
	end

	return closessst
end		

_G.aims.con = RunService.RenderStepped:Connect(function()
	local closestvic = GetClosestCharacter()

	if closestvic then
		local aimPart = closestvic[partToAimAt]
		local _, OnScreen = workspace.CurrentCamera:WorldToScreenPoint(aimPart.Position)

		if OnScreen then
			if #workspace.CurrentCamera:GetPartsObscuringTarget({workspace.CurrentCamera.CFrame.Position,aimPart.Position},{aimPart}) == 0 then
    	   		local pos = workspace.CurrentCamera.CFrame.Position
				workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.lookAt(pos, aimPart.Position), 0.1)
    		end
		end
	end
end)