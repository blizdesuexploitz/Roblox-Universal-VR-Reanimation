-- Script Path: game:GetService("ReplicatedStorage").Libraries.VR.FootPlanter
-- Took 0s to decompile.
-- Executor: Potassium (v2.5.3)

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
game:GetService("PhysicsService");
local CFrame_new_ret = CFrame.new(0.5, -1, 0);
local CFrame_new_ret2 = CFrame.new(-0.5, -1, 0);
local TweenInfo_new = TweenInfo.new;
local Linear = Enum.EasingStyle.Linear;
local Out = Enum.EasingDirection.Out;
local _ = Vector3.new;
local u1 = false;
local u2 = false;
local Vector3Value = Instance.new("Vector3Value", workspace.Terrain);
local Vector3Value2 = Instance.new("Vector3Value", workspace.Terrain);
local u3 = { Players.LocalPlayer.Character };

function RayCast(p4)
    -- upvalues: u3 (copy)
    local v5, v6 = workspace:FindPartOnRayWithIgnoreList(p4, u3);

    if not v5 or v5.CanCollide then
        return v5, v6;
    end;

    table.insert(u3, v5);
    local Ray_new_ret = Ray.new(v6, p4.Direction);

    return RayCast(Ray_new_ret);
end;

function CanStep(p7, p8)
    -- upvalues: u2 (ref), u1 (ref)
    local v9;

    if p7 > 0.75 or p8 > 0.75 then
        v9 = not u2 and not u1;
    else
        v9 = false;
    end;

    return v9;
end;

function SolveIK(p10, p11, p12, p13, p14)
    local v15 = p10:pointToObjectSpace(p11);
    local Unit = v15.Unit;
    local Magnitude = v15.Magnitude;
    local v16 = p10 * CFrame.fromAxisAngle((Vector3.new(0, 0, -1)):Cross(Unit), (math.acos(-Unit.Z)));
    local Sit = p13.Humanoid.Sit;
    local v17 = v16 * CFrame.new(0, 0, p12 - Magnitude + math.max(0, Magnitude - p12));
    local _ = -1.5707963267948966 * (1 - p14 * 1.25);

    if Sit and p10 then
        v17 = p10;
    elseif p14 > 0 then
        v17 = p10 or v17;
    end;

    return v17, p14 > 0 and -1.5707963267948966 * (1 - p14 * 1.25) or 1.5707963267948966;
end;

function TweenTargets(p18)
    -- upvalues: Vector3Value (copy), Vector3Value2 (copy), CFrame_new_ret (copy), CFrame_new_ret2 (copy), u2 (ref), TweenService (copy), TweenInfo_new (copy), Linear (copy), Out (copy), u1 (ref)
    local u19 = Vector3Value;
    local u20 = Vector3Value2;
    local Torso = p18.Torso;
    local Magnitude = ((u19.Value - (Torso.CFrame * CFrame_new_ret).p) * Vector3.new(1, 0, 1)).Magnitude;
    local Magnitude2 = ((u20.Value - (Torso.CFrame * CFrame_new_ret2).p) * Vector3.new(1, 0, 1)).Magnitude;

    if CanStep(Magnitude, Magnitude2) then
        local Velocity = Torso.Velocity;
        local u21 = Velocity * Vector3.new(1, 0, 1) / (p18.Humanoid.WalkSpeed / 2.6) * 1.2;
        local u22 = 0.09 - (Velocity * Vector3.new(1, 0, 1)).Magnitude / 800;

        if Magnitude2 < Magnitude then
            coroutine.wrap(function() -- Line: 102
                -- upvalues: Torso (copy), CFrame_new_ret (ref), u21 (copy), u2 (ref), TweenService (ref), u19 (copy), TweenInfo_new (ref), u22 (copy), Linear (ref), Out (ref)
                local Ray_new_ret = Ray.new((Torso.CFrame * CFrame_new_ret).p + u21, Vector3.new(0, -12, 0));
                local _, v23 = RayCast(Ray_new_ret);
                u2 = true;
                TweenService:Create(u19, TweenInfo_new(u22, Linear, Out), {
                    Value = v23
                }):Play();
                wait(u22);
                TweenService:Create(u19, TweenInfo_new(u22, Linear, Out), {
                    Value = v23
                }):Play();
                wait(u22);
                u2 = false;
            end)();

            return;
        end;

        coroutine.wrap(function() -- Line: 113
            -- upvalues: Torso (copy), CFrame_new_ret2 (ref), u21 (copy), u1 (ref), TweenService (ref), u20 (copy), TweenInfo_new (ref), u22 (copy), Linear (ref), Out (ref)
            local Ray_new_ret = Ray.new((Torso.CFrame * CFrame_new_ret2).p + u21, Vector3.new(0, -12, 0));
            local _, v24 = RayCast(Ray_new_ret);
            u1 = true;
            TweenService:Create(u20, TweenInfo_new(u22, Linear, Out), {
                Value = v24
            }):Play();
            wait(u22);
            TweenService:Create(u20, TweenInfo_new(u22, Linear, Out), {
                Value = v24
            }):Play();
            wait(u22);
            u1 = false;
        end)();
    end;
end;

function UpdateLocal(p25, p26, p27)
    -- upvalues: Players (copy), CFrame_new_ret (copy), Vector3Value (copy), CFrame_new_ret2 (copy), Vector3Value2 (copy)
    local Character = Players.LocalPlayer.Character;

    if not Character then
        return;
    end;

    local Torso = Character:FindFirstChild("Torso");
    Character:FindFirstChild("Right Leg");
    Character:FindFirstChild("Left Leg");
    local v28 = p27 or 0;
    local v29, v30 = SolveIK(Torso.CFrame * CFrame_new_ret, Vector3Value.Value, 2, Character, v28);
    local v31, v32 = SolveIK(Torso.CFrame * CFrame_new_ret2, Vector3Value2.Value, 2, Character, v28);
    p25.WorldCFrame = v29 * CFrame.Angles(v30 or 0, 0, 0) * CFrame.new(Vector3.new(0, -1, 0));
    p26.WorldCFrame = v31 * CFrame.Angles(v32 or 0, 0, 0) * CFrame.new(Vector3.new(0, -1, 0));
    TweenTargets(Character);
end;

return UpdateLocal;
