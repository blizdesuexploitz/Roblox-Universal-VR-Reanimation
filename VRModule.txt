-- Script Path: game:GetService("ReplicatedStorage").Libraries.VR.VRModule
-- Took 0s to decompile.
-- Executor: Potassium (v2.5.3)

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local HttpService = game:GetService("HttpService");
local VRService = game:GetService("VRService");
local ContextActionService = game:GetService("ContextActionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Libraries = ReplicatedStorage:WaitForChild("Libraries");
ReplicatedStorage:WaitForChild("Remotes");
local u1 = nil;
u1 = not pcall(function() -- Line: 17
    -- upvalues: u1 (ref), Libraries (copy)
    u1 = require(Libraries:WaitForChild("Settings"));
end) and {} or u1;
local u2 = true;
local u3 = VRService.VREnabled or u1.ForceVRMode;

function SetProperties(p4, p5)
    if p4 then
        for i, v in pairs(p5) do
            p4[i] = v;
        end;
    end;
end;

function Lerp(p6, p7, p8)
    return p6 + (p7 - p6) * p8;
end;

return {
    New = function(p9) -- Line: 60, Name: New
        -- upvalues: u3 (copy), Players (copy), Libraries (copy), u1 (ref)
        if not u3 then
            return;
        end;

        p9.Player = Players.LocalPlayer;
        p9.HasCharacter = true;
        p9.Camera = workspace.CurrentCamera;
        p9.Events = {};
        p9.TorsoMoveDot = 0;
        p9.LastLookRot = CFrame.new();
        p9.LastPosition = Vector3.new();
        p9.IsDead = false;
        p9.Sitting = false;
        p9.Theta = 0;
        p9.TurnDeb = false;
        p9.CharacterCreation = require(Libraries.VR:WaitForChild("CharacterCreation"));
        p9.FootPlanting = require(Libraries.VR:WaitForChild("FootPlanter"));
        p9.TrackingService = require(Libraries.VR:WaitForChild("TrackingService"));
        p9.TrackingService.SetupCamera(u1);
        p9.CharacterCreation.SetSettings(u1);
        p9.CharacterCreation.SetCharacter(p9);
        p9:Bind();
    end,

    Bind = function(u10) -- Line: 108, Name: Bind
        -- upvalues: RunService (copy), u2 (ref), u1 (ref), HttpService (copy), ContextActionService (copy)
        local ControlModule = require(u10.Player:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule").ControlModule);
        local _ = u10.Player.Character;
        u10.Events.Stepped = RunService.Stepped:Connect(function() -- Line: 112
            -- upvalues: u2 (ref), ControlModule (copy), u10 (copy), u1 (ref)
            if u2 then
                ControlModule:Enable(false);

                if not u10.IsDead then
                    local Character = u10.Player.Character;

                    if Character.Humanoid.RigType ~= Enum.HumanoidRigType.R6 then
                        return;
                    end;

                    local Sit = Character.Humanoid.Sit;
                    SetProperties(Character:FindFirstChild("Head"), {
                        CanCollide = false
                    });
                    SetProperties(Character:FindFirstChild("Torso"), {
                        CanCollide = false
                    });
                    SetProperties(Character:FindFirstChild("HumanoidRootPart"), {
                        CanCollide = true
                    });
                    local _ = (Character["Left Arm"].Position - u10.TrackerL.WorldPosition).Magnitude < u1.CollideDistance and (not Sit and u1.ArmsCollidable);
                    local v11;

                    if (Character["Right Arm"].Position - u10.TrackerR.WorldPosition).Magnitude < u1.CollideDistance and not Sit then
                        v11 = u1.ArmsCollidable or false;
                    else
                        v11 = false;
                    end;

                    SetProperties(Character:FindFirstChild("Left Arm"), {
                        CanCollide = v11
                    });
                    SetProperties(Character:FindFirstChild("Right Arm"), {
                        CanCollide = v11
                    });
                end;
            end;
        end);
        RunService:BindToRenderStep("VirtualRealityRS_" .. HttpService:GenerateGUID(), u1.Priority, function(p12) -- Line: 153
            -- upvalues: u10 (copy), u2 (ref), u1 (ref)
            local Character = u10.Player.Character;

            if u2 and Character then
                if Character.Humanoid.RigType ~= Enum.HumanoidRigType.R6 then
                    return;
                end;

                if not u10.IsDead then
                    u10.TrackingService.Update(u10, u1);

                    return;
                end;

                if Character.Humanoid.Health > 0 then
                    u10.CharacterCreation.SetCharacter(u10);
                end;
            end;
        end);
        ContextActionService:BindActionAtPriority("VRJump", function(p13, p14, p15) -- Line: 187
            -- upvalues: u10 (copy)
            u10.Player.Character.Humanoid.Jump = p14 == Enum.UserInputState.Begin;
        end, false, u1.Priority, u1.JumpButton);
        ContextActionService:BindActionAtPriority("VRMenu", function(p16, p17, p18) -- Line: 192
        end, false, u1.Priority + 1, u1.MenuButton);
        ContextActionService:BindActionAtPriority("VRTurn", function(p19, p20, p21) -- Line: 199
            -- upvalues: u10 (copy)
            if math.abs(p21.Position.X) <= 0.7 or (u10.TurnDeb or u10.Player.Character.Humanoid.Sit) then
                if math.abs(p21.Position.X) < 0.7 then
                    u10.TurnDeb = false;
                end;

                return;
            end;

            u10.TurnDeb = true;
            u10.Theta = u10.Theta + -math.sign(p21.Position.X) * 45;
            local LookVector = u10.Camera:GetRenderCFrame().LookVector;
            local CFrame_fromEulerAnglesXYZ_ret = CFrame.fromEulerAnglesXYZ(0, math.atan2(-LookVector.X, -LookVector.Z), 0);
            u10.LastLookRot = CFrame_fromEulerAnglesXYZ_ret * (CFrame_fromEulerAnglesXYZ_ret * u10.LastLookRot:Inverse());
        end, false, u1.Priority, u1.Turn);
        local u22 = nil;
        ContextActionService:BindActionAtPriority("VRMove", function(p23, p24, p25) -- Line: 215
            -- upvalues: u22 (ref)
            u22 = Vector3.new(p25.Position.X, 0, -p25.Position.Y);
        end, false, u1.Priority, u1.Move);
        RunService.Heartbeat:Connect(function() -- Line: 219
            -- upvalues: u22 (ref), u10 (copy)
            if u22 then
                u10.Player:Move(u22, true);
            end;
        end);
    end,

    OnDeath = function(p26) -- Line: 232, Name: OnDeath
        if p26.IsDead then
            return;
        end;

        p26.IsDead = true;

        if p26.Player.Character then
            for _, descendant in pairs(p26.Player.Character:GetDescendants()) do
                if descendant:IsA("AlignPosition") or descendant:IsA("AlignOrientation") then
                    descendant:Destroy();
                end;
            end;
        end;

        SetProperties(p26.Player.Character:FindFirstChild("Head"), {
            CanCollide = true
        });
        SetProperties(p26.Player.Character:FindFirstChild("Torso"), {
            CanCollide = true
        });
        SetProperties(p26.Player.Character:FindFirstChild("HumanoidRootPart"), {
            CanCollide = false
        });
    end,

    ChangeSettings = function(p27) -- Line: 264, Name: ChangeSettings
        -- upvalues: u1 (ref)
        for i, v in pairs(p27) do
            if u1[i] then
                u1[i] = v;
            else
                warn(tostring(i) .. " is not a valid setting");
            end;
        end;
    end,

    SetEnabled = function(p28) -- Line: 275, Name: SetEnabled
        -- upvalues: u2 (ref)
        u2 = p28;
    end
};
