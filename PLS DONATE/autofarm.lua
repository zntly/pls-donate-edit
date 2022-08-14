repeat wait() until game:IsLoaded()
if game.PlaceId ~= 8737602449 then return end
for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
v:Disable()
end
wait(5)
if string.find(identifyexecutor(), "Synapse X") then
syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/tzechco/roblox-scripts/main/PLS%20DONATE/autofarm.lua'))()")
else
game.StarterGui:SetCore("SendNotification", {
Title = "Not using Synapse X";
Text = "Make sure this script is in the autoexec folder or it won't work properly";
Duration = 15;
})
end
local unclaimed = {}
local counter
local errCount = 0
local booths = {
  ["1"] = "72, 4, 36",
  ["2"] = "83, 4, 161",
  ["3"] = "11, 4, 36",
  ["4"] = "100, 4, 59",
  ["5"] = "72, 4, 166",
  ["6"] = "2, 4, 42",
  ["7"] = "-9, 4, 52",
  ["8"] = "10, 4, 166",
  ["9"] = "-17, 4, 60",
  ["10"] = "35, 4, 173",
  ["11"] = "24, 4, 170",
  ["12"] = "48, 4, 29",
  ["13"] = "24, 4, 33",
  ["14"] = "101, 4, 142",
  ["15"] = "-18, 4, 142",
  ["16"] = "60, 4, 33",
  ["17"] = "35, 4, 29",
  ["18"] = "0, 4, 160",
  ["19"] = "48, 4, 173",
  ["20"] = "61, 3, 170",
  ["21"] = "91, 4, 151",
  ["22"] = "-24, 4, 72",
  ["23"] = "-28, 4, 88",
  ["24"] = "92, 4, 51",
  ["25"] = "-28, 4, 112",
  ["26"] = "-24, 3, 129",
  ["27"] = "83, 4, 42",
  ["28"] = "-8, 4, 151"
}
for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.MapUIContainer.MapUI.BoothUI:GetChildren()) do
if(v.Details.Owner.Text == 'unclaimed') then
table.insert(unclaimed, tonumber(string.match(tostring(v), "%d+")))
end
end
local claimCount = #unclaimed
function boothclaim()
local claimevent = require(game.ReplicatedStorage.Remotes).Event("ClaimBooth")
claimevent:InvokeServer(unclaimed[1])
end
while not pcall(boothclaim) do
if errCount >= claimCount then
local Servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/8737602449/servers/Public?sortOrder=Desc&limit=100"))
for i,v in pairs(Servers.data) do
if v.playing > 19 and v.playing < 27 then
game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, v.id)
end
end
end
errCount = errCount + 1
end
game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(booths[tostring(unclaimed[1])]:match("(.+), (.+), (.+)")))
local atBooth = false
game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:Connect(function(reached)
atBooth = true
end)
while not atBooth do
wait(.25)
if game.Players.LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Seated then 
game.Players.LocalPlayer.Character.Humanoid.Jump = true
end
end
game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, Vector3.new(40,14,101)))
while true do
counter = 0
local Players = game:GetService("Players")
local Raised = Players.LocalPlayer.leaderstats.Raised
local boothText
function update(text)
if Raised.Value > 999 then
text = string.format("%.1fk", text / 10^3)
boothText = tostring('<font color="#32cd32">GOAL: '.. text.. '</font>')
else
boothText = tostring('<font color="#32cd32">GOAL: '.. Raised.value.. ' / '.. text.. '</font>')
end
require(game.ReplicatedStorage.Remotes).Event("SetBoothText"):FireServer(boothText, "booth")
end
if Raised.Value > 999 then
update(tostring(math.ceil(tonumber(Raised.Value + 1) / 100) * 100))
else
update(tostring(Raised.Value + 5))
end
local RaisedC = Players.LocalPlayer.leaderstats.Raised.value
while(Players.LocalPlayer.leaderstats.Raised.value == RaisedC)
do
wait(30)
counter = counter + 1
if counter >= 60 then
wait(math.random(1,60))
local Servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/8737602449/servers/Public?sortOrder=Desc&limit=100"))
for i,v in pairs(Servers.data) do
if v.playing > 19 and v.playing < 27 then
game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, v.id)
end
end
end
end
end
