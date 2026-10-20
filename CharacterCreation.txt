-- Script Path: game:GetService("ReplicatedStorage").Libraries.VR.CharacterCreation
-- Took 0s to decompile.
-- Executor: Potassium (v2.5.3)

-- Decompiled with Potassium's decompiler.

local v1 = {};
UserSettings():GetService("UserGameSettings");
local RunService = game:GetService("RunService");
local u2 = nil;

function MakeAttchments(p3)
    p3.TrackerR = Instance.new("Attachment", p3.Player.Character.HumanoidRootPart);
    p3.TrackerL = Instance.new("Attachment", p3.Player.Character.HumanoidRootPart);
    p3.HeadAtt = Instance.new("Attachment", p3.Player.Character.HumanoidRootPart);
    p3.TorsoAtt = Instance.new("Attachment", p3.Player.Character.HumanoidRootPart);
    p3.RightL = Instance.new("Attachment", p3.Player.Character.HumanoidRootPart);
    p3.LeftL = Instance.new("Attachment", p3.Player.Character.HumanoidRootPart);
end;

function AddTracker(p4, p5)
    -- upvalues: u2 (ref)
    local Attachment = Instance.new("Attachment", p4);
    local AlignPosition = Instance.new("AlignPosition", p4);
    local AlignOrientation = Instance.new("AlignOrientation", p4);
    AlignPosition.MaxForce = u2.Strength or 3000;
    AlignPosition.MaxVelocity = 500;
    AlignPosition.Responsiveness = 200;
    AlignPosition.Attachment0 = Attachment;
    AlignPosition.Attachment1 = p5;
    AlignOrientation.MaxAngularVelocity = u2.Strength or 3000;
    AlignOrientation.MaxTorque = 500;
    AlignOrientation.Responsiveness = 200;
    AlignOrientation.Attachment0 = Attachment;
    AlignOrientation.Attachment1 = p5;
end;

function ChangePhysicalProperties(p6, p7, p8)
    p6.CustomPhysicalProperties = PhysicalProperties.new(p7, 0.3, p8 or 0.5, 1, 1);
end;

function SetProperties(p9, p10)
    if p9 then
        for i, v in pairs(p10) do
            p9[i] = v;
        end;
    end;
end;

function FilterCharacter(u11, u12)
    -- upvalues: u2 (ref), RunService (copy)
    local Character = u11.Player.Character;
    coroutine.wrap(function() -- Line: 76
        -- upvalues: u12 (copy), Character (copy), u11 (copy), u2 (ref), RunService (ref)
        for i = 1, u12 do
            local _ = i;

            for _, descendant in pairs(Character:GetDescendants()) do
                if descendant:IsA("Part") then
                    if string.match(descendant.Name, "Arm") then
                        descendant.Size = Vector3.new(0.8, 1.6, 0.8);
                    end;

                    if descendant.Parent:IsA("Accessory") then
                        descendant.LocalTransparencyModifier = 1;
                        descendant.CanTouch = false;
                    end;
                end;

                if descendant:IsA("CharacterMesh") then
                    descendant:Destroy();
                end;
            end;

            ChangePhysicalProperties(u11.Player.Character.Torso, 0.1);
            ChangePhysicalProperties(u11.Player.Character["Right Arm"], u2.ArmWeight or 0.4);
            ChangePhysicalProperties(u11.Player.Character["Left Arm"], u2.ArmWeight or 0.4);
            ChangePhysicalProperties(u11.Player.Character["Right Leg"], 0.1);
            ChangePhysicalProperties(u11.Player.Character["Left Leg"], 0.1);
            ChangePhysicalProperties(u11.Player.Character.Head, 0.1);
            ChangePhysicalProperties(u11.Player.Character.HumanoidRootPart, 3.15);
            RunService.Stepped:Wait();
        end;
    end)();
end;

function v1.SetCharacter(u13) -- Line: 127
    -- upvalues: RunService (copy)
    while not u13.Player.Character do
        RunService.RenderStepped:Wait();
    end;

    if u13.Player.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R6 then
        warn("R6 avatars are required for the module to work");

        return;
    end;

    MakeAttchments(u13);
    AddTracker(u13.Player.Character.Head, u13.HeadAtt);
    AddTracker(u13.Player.Character.Torso, u13.TorsoAtt);
    AddTracker(u13.Player.Character["Right Arm"], u13.TrackerR);
    AddTracker(u13.Player.Character["Left Arm"], u13.TrackerL);
    AddTracker(u13.Player.Character["Right Leg"], u13.RightL);
    AddTracker(u13.Player.Character["Left Leg"], u13.LeftL);
    u13.Player.Character.Humanoid.Died:Connect(function() -- Line: 149
        -- upvalues: u13 (copy)
        u13:OnDeath();
    end);
    u13.Player.Character.ChildAdded:Connect(function(u14) -- Line: 155
        -- upvalues: RunService (ref)
        for i = 1, 10 do
            pcall(function() -- Line: 157
                -- upvalues: u14 (copy)
                for _, descendant in pairs(u14:GetDescendants()) do
                    if descendant:IsA("Part") and descendant.Parent:IsA("Accessory") then
                        SetProperties(descendant, {
                            LocalTransparencyModifier = 1
                        });
                    end;

                    if descendant:IsA("CharacterMesh") then
                        descendant:Destroy();
                    end;
                end;
            end);
            RunService.Stepped:Wait();
            local _ = i;
        end;
    end);
    u13.Player.Character.ChildRemoved:Connect(function(u15) -- Line: 174
        -- upvalues: u13 (copy), RunService (ref)
        for i = 1, 10 do
            pcall(function() -- Line: 176
                -- upvalues: u15 (copy), u13 (ref)
                if u15:IsA("Part") and (u15.Name == "Head" or (u15.Name == "Torso" or u15.Name == "HumanoidRootPart")) then
                    u13.Player.Character.Humanoid.Health = 0;
                end;
            end);
            RunService.Stepped:Wait();
            local _ = i;
        end;
    end);
    FilterCharacter(u13, 60);
    u13.IsDead = false;
end;

function v1.SetSettings(p16) -- Line: 198
    -- upvalues: u2 (ref)
    u2 = p16;
end;

return v1;
