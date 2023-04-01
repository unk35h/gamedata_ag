slot0 = class("TransitionSkillItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectCon_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.useCon_ = ControllerUtil.GetController(slot0.transform_, "use")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickFunc_ then
			uv0.clickFunc_(uv0.skillID_)
		end
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.level_ = slot2
	slot0.skillID_ = slot1
	slot0.cfg_ = EquipSkillCfg[slot0.skillID_]
	slot0.icon_.sprite = getEquipSkillSprite(slot0.skillID_)
	slot0.levelTxt_.text = GetTips("LEVEL") .. slot0.level_
	slot0.name_.text = slot0.cfg_.name
end

function slot0.SetUsed(slot0, slot1)
	slot0.useCon_:SetSelectedState(slot1 and "on" or "off")
end

function slot0.SetSelect(slot0, slot1)
	slot0.selectCon_:SetSelectedState(slot1 and "on" or "off")
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc_ = slot1
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
