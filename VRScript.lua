-- Script Path: game:GetService("ReplicatedStorage").Libraries.Loader.VRScript.VRScript
-- Took 0s to decompile.
-- Executor: Potassium (v2.5.3)

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local StarterGui = game:GetService("StarterGui");
local VRService = game:GetService("VRService");
local VREnabled = VRService.VREnabled;
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Character = LocalPlayer.Character;
VRService.LaserPointer = Enum.VRLaserPointerMode.Disabled;
print("VR Properly setup");

while not (game:IsLoaded() and Character) do
    Character = LocalPlayer.Character;
    wait();
end;

Character:WaitForChild("HumanoidRootPart");
StarterGui:SetCore("VRLaserPointerMode", 0);

repeat
    wait(1);
until VRService.LaserPointer == Enum.VRLaserPointerMode.Disabled;

wait(1);

if VREnabled then
    ReplicatedStorage.Remotes.InVR:FireServer();
end;

require(ReplicatedStorage.Libraries.VR:WaitForChild("VRModule")):New();
