-- Script Path: game:GetService("ReplicatedStorage").Libraries.Loader
-- Took 0s to decompile.
-- Executor: Potassium (v2.5.3)

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PhysicsService = game:GetService("PhysicsService");
local Players = game:GetService("Players");
local Remotes = ReplicatedStorage.Remotes;

function CollisionGroupExists(p1)
    local PhysicsService2 = game:GetService("PhysicsService");

    for _, v in pairs(PhysicsService2:GetRegisteredCollisionGroups()) do
        if v.name == p1 then
            return true;
        end;
    end;

    return false;
end;

function Network(p2, p3)
    -- upvalues: PhysicsService (copy)
    if not CollisionGroupExists("Players") then
        PhysicsService:RegisterCollisionGroup("Players");
    end;

    local v4 = workspace:FindFirstChild(p2.Name) or p3;

    for _, descendant in ipairs(v4:GetDescendants()) do
        if descendant:IsA("Part") then
            descendant:SetNetworkOwner(p2);
            descendant.CollisionGroup = "Players";
            PhysicsService:CollisionGroupSetCollidable("Players", "Players", false);

            if descendant.Parent:IsA("Accessory") then
                descendant.CanTouch = false;
            end;
        end;
    end;
end;

function EditCharacter(u5)
    coroutine.wrap(function() -- Line: 50
        -- upvalues: u5 (copy)
        while not u5.Character do
            wait();
        end;

        local v6 = u5.Character or u5.CharacterAdded:Wait();
        v6:WaitForChild("HumanoidRootPart");
        local Humanoid = v6:WaitForChild("Humanoid");
        Humanoid.RequiresNeck = false;
        Humanoid.AutoRotate = false;
        Instance.new("StringValue", v6).Name = "VR";

        for _, descendant in pairs(v6:GetDescendants()) do
            if descendant:IsA("Motor6D") then
                descendant.Enabled = false;
            end;
        end;

        while not v6:IsDescendantOf(workspace) do
            wait();
        end;

        Network(u5, v6);
    end)();
end;

function FindItemInTable(p7, p8)
    for _, v in pairs(p7) do
        if v == p8 then
            return true;
        end;
    end;

    return false;
end;

local v9 = {};
local u10 = {};

function v9.Load(p11) -- Line: 98
    -- upvalues: ReplicatedStorage (copy), PhysicsService (copy), u10 (copy), Remotes (copy), Players (copy)
    p11:Clone().Parent = ReplicatedStorage:WaitForChild("Libraries");
    local u12 = require(p11);
    local VRScript = script:FindFirstChild("VRScript");
    VRScript:Clone().Parent = game.StarterGui;
    PhysicsService:RegisterCollisionGroup("Players");
    PhysicsService:CollisionGroupSetCollidable("Players", "Players", false);
    Remotes.InVR.OnServerEvent:Connect(function(p13) -- Line: 116, Name: InsertPlayer
        -- upvalues: u10 (ref)
        if not FindItemInTable(u10, p13) then
            table.insert(u10, p13);

            if p13.Character then
                EditCharacter(p13);
            end;
        end;
    end);
    Players.PlayerAdded:Connect(function(u14) -- Line: 133
        -- upvalues: u12 (copy), u10 (ref)
        if u12.ForceVRMode and not FindItemInTable(u10, u14) then
            table.insert(u10, u14);

            if u14.Character then
                EditCharacter(u14);
            end;
        end;

        u14.CharacterAdded:Connect(function(p15) -- Line: 138
            -- upvalues: u10 (ref), u14 (copy)
            if FindItemInTable(u10, u14) then
                EditCharacter(u14);
            end;
        end);
    end);
    Players.PlayerRemoving:Connect(function(p16) -- Line: 150
        -- upvalues: u10 (ref)
        FindItemInTable(u10, p16);
    end);

    for _, v in pairs(Players:GetPlayers()) do
        coroutine.wrap(function() -- Line: 159
            -- upvalues: v (copy), VRScript (copy)
            local PlayerGui = v:WaitForChild("PlayerGui");

            if not PlayerGui:FindFirstChild("VRScript") then
                VRScript:Clone().Parent = PlayerGui;
            end;
        end)();
    end;
end;

return v9;
