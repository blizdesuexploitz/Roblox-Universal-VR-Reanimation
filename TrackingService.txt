-- Script Path: game:GetService("ReplicatedStorage").Libraries.VR.TrackingService
-- Took 0s to decompile.
-- Executor: Potassium (v2.5.3)

-- Decompiled with Potassium's decompiler.

local u1 = {};
local VRService = game:GetService("VRService");
local StarterGui = game:GetService("StarterGui");
local _ = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local u2 = CFrame;
local CFrame_fromEulerAnglesXYZ = CFrame.fromEulerAnglesXYZ;

function GetXYZ(p3)
    return p3:ToEulerAnglesXYZ();
end;

function Lerp(p4, p5, p6)
    return p4 + (p5 - p4) * p6;
end;

function u1.SetupCamera(p7) -- Line: 24
    -- upvalues: workspace_CurrentCamera (copy), VRService (copy), StarterGui (copy)
    local v8 = p7 or {
        CameraLocked = true,
        FOV = 70,
        RightControllerTouchType = Enum.VRTouchpadMode.ABXY,
        LeftControllerTouchType = Enum.VRTouchpadMode.VirtualThumbstick
    };
    workspace_CurrentCamera.HeadLocked = v8.CameraLocked;
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    workspace_CurrentCamera.FieldOfView = v8.FOV;
    VRService:SetTouchpadMode(Enum.VRTouchpad.Right, v8.RightControllerTouchType);
    VRService:SetTouchpadMode(Enum.VRTouchpad.Left, v8.LeftControllerTouchType);
    StarterGui:SetCore("VRLaserPointerMode", 0);
    StarterGui:SetCore("VREnableControllerModels", false);
    VRService:RecenterUserHeadCFrame();
    print("Deleted Laser");
end;

function u1.GetHeadlockedCFrame() -- Line: 51
    -- upvalues: VRService (copy), u2 (copy)
    local _ = workspace.CurrentCamera;
    local UserCFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head);

    return u2.fromEulerAnglesXYZ(UserCFrame:ToEulerAnglesXYZ()) * UserCFrame:Inverse();
end;

function u1.UpdateSit(p9, p10) -- Line: 66
    -- upvalues: VRService (copy), u2 (copy), CFrame_fromEulerAnglesXYZ (copy)
    local Character = p9.Player.Character;

    if not Character:FindFirstChild("HumanoidRootPart") then
        return;
    end;

    if not p9.Sitting and Character.Humanoid.Sit then
        VRService:RecenterUserHeadCFrame();
    end;

    p9.Sitting = true;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local UserCFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head);
    local v11 = u2.new(u2.new(UserCFrame.p).Position * Vector3.new(1, 0, 1));
    local LookVector = p9.Camera:GetRenderCFrame().LookVector;
    local math_atan2_ret = math.atan2(-LookVector.X, -LookVector.Z);
    local v12 = u2.fromEulerAnglesXYZ(0, math_atan2_ret, 0);
    local math_clamp_ret = math.clamp(1.52 + UserCFrame.p.Y, -1, 1.65);
    local v13 = HumanoidRootPart.CFrame * u2.new(0, math_clamp_ret, 0) * v11 * p9.TrackingService.GetHeadlockedCFrame();
    p9.Camera.CFrame = v13;
    p9.HeadAtt.WorldCFrame = p9.Camera:GetRenderCFrame();
    local v14 = VRService:GetUserCFrame(Enum.UserCFrame.LeftHand) * p10.ControllerOffset;
    local v15 = VRService:GetUserCFrame(Enum.UserCFrame.RightHand) * p10.ControllerOffset;
    p9.TrackerR.WorldCFrame = v13 * v15;
    p9.TrackerL.WorldCFrame = v13 * v14;
    local math_max_ret = math.max(0, -LookVector.Y * 0.75);
    local v16 = u2.new(v13.p + Vector3.new(0, math_max_ret / 2 + -1.52, 0)) * CFrame_fromEulerAnglesXYZ(GetXYZ(p9.LastLookRot));
    local p = (CFrame_fromEulerAnglesXYZ(GetXYZ(p9.LastLookRot)) * u2.new(0, 0, (math.max(0, -LookVector.Y * 0.75)))).p;
    p9.TorsoAtt.WorldCFrame = v16 + p;
    p9.FootPlanting(p9.RightL, p9.LeftL, 0);
    p9.LastPosition = Vector3.new();
    p9.LastLookRot = p9.LastLookRot:Lerp(v12, 0.1);
end;

function u1.Update(p17, p18) -- Line: 141
    -- upvalues: u1 (copy), VRService (copy), u2 (copy), CFrame_fromEulerAnglesXYZ (copy)
    local Character = p17.Player.Character;

    if not Character:FindFirstChild("HumanoidRootPart") then
        return;
    end;

    if Character.Humanoid.Sit then
        u1.UpdateSit(p17, p18);

        return;
    end;

    p17.Sitting = false;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local UserCFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head);
    local v19 = u2.new(u2.new(UserCFrame.p - p17.LastPosition).Position * Vector3.new(1, 0, 1));
    local LookVector = p17.Camera:GetRenderCFrame().LookVector;
    local v20 = CFrame_fromEulerAnglesXYZ(0, math.atan2(-LookVector.X, -LookVector.Z), 0);
    local v21 = CFrame_fromEulerAnglesXYZ(0, math.rad(p17.Theta), 0);
    local math_clamp_ret = math.clamp(1.52 + UserCFrame.p.Y, -2.375, 1.65);
    local v22 = HumanoidRootPart.CFrame * u2.new((v20:Inverse() * v21 * v19).p);
    local v23 = v22 * u2.new(0, math_clamp_ret, 0);
    p17.Camera.CFrame = u2.new(v23.Position) * v21 * p17.TrackingService.GetHeadlockedCFrame();
    p17.HeadAtt.WorldCFrame = p17.Camera:GetRenderCFrame();
    local LookVector2 = p17.Camera:GetRenderCFrame().LookVector;
    local v24 = CFrame_fromEulerAnglesXYZ(0, math.atan2(-LookVector2.X, -LookVector2.Z), 0);
    local v25 = VRService:GetUserCFrame(Enum.UserCFrame.LeftHand) * p18.ControllerOffset;
    local v26 = VRService:GetUserCFrame(Enum.UserCFrame.RightHand) * p18.ControllerOffset;
    local v27 = v23 * v24:Inverse() * v21 * u2.new(v25.p - UserCFrame.p) * CFrame_fromEulerAnglesXYZ(GetXYZ(v25));
    local v28 = v23 * v24:Inverse() * v21 * u2.new(v26.p - UserCFrame.p) * CFrame_fromEulerAnglesXYZ(GetXYZ(v26));
    p17.TrackerR.WorldCFrame = v28;
    p17.TrackerL.WorldCFrame = v27;
    local v29 = v22 * CFrame.new(v22:Inverse().Position);
    local math_clamp_ret2 = math.clamp(-math_clamp_ret / 3, 0, 1);
    local v30 = math.max(0, -LookVector2.Y * 0.75) * (1 - math_clamp_ret2);
    local v31 = CFrame_fromEulerAnglesXYZ(GetXYZ(p17.LastLookRot)) * CFrame_fromEulerAnglesXYZ(0, math.rad(-p17.TorsoMoveDot * 20), 0);
    local v32 = u2.new(p17.Camera:GetRenderCFrame().p + (v29 * CFrame.new(0, v30 / 2 + -1.52, 0)).p) * v31;
    local p = (p17.LastLookRot * u2.new(0, math_clamp_ret2 * 1.5, v30 + math_clamp_ret2 * 2)).p;
    p17.TorsoAtt.WorldCFrame = v32 * u2.fromEulerAnglesXYZ(math.rad(math_clamp_ret2 * 1.25 * -90), 0, 0) + p;
    local _ = HumanoidRootPart.CFrame;
    HumanoidRootPart.CFrame = u2.new(v22.p) * v24;
    p17.FootPlanting(p17.RightL, p17.LeftL, math_clamp_ret2);
    p17.LastPosition = UserCFrame.p;
    p17.LastLookRot = p17.LastLookRot:Lerp(v24, 0.23);
    p17.TorsoMoveDot = Lerp(p17.TorsoMoveDot, HumanoidRootPart.CFrame.RightVector:Dot(p17.Player.Character.Humanoid.MoveDirection), 0.065);
end;

return u1;
