slot0 = class("PolyhedronArtifactAtlasIItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		if uv0.state == 2 then
			JumpTools.OpenPageByJump("polyhedronArtifactTips", {
				artifact_id = uv0.artifact_id
			})
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.artifact_id = slot1
	slot2 = PolyhedronArtifactCfg[slot1]
	slot0.m_name.text = slot2.name
	slot0.m_des.text = slot2.note or ""
	slot0.m_icon.sprite = getSpriteWithoutAtlas(PolyhedronConst.ARTIFACT_ICON_PATH .. slot2.icon)
	slot0.state = PolyhedronData:GetArtifaceAtlasState(slot1)

	if slot0.state == 2 then
		slot0.stateController:SetSelectedIndex(0)
	elseif slot0.state == 1 then
		slot0.stateController:SetSelectedIndex(2)
	else
		slot0.stateController:SetSelectedIndex(1)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
