slot0 = class("GuildActivityAffixItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1.gameObject
	slot0.transform_ = slot1

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.unlockController_ = ControllerUtil.GetController(slot0.transform_, "unlock")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.Btn_, nil, function ()
		if uv0.selectCallBack_ then
			uv0.selectCallBack_(uv0.affixID_, uv0.level_)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	if slot0.affixID_ == nil then
		manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, TalentTreeCfg[slot1].activity_id, TalentTreeCfg[slot1].race, slot1))
	elseif slot0.affixID_ ~= slot1 then
		manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, TalentTreeCfg[slot0.affixID_].activity_id, TalentTreeCfg[slot0.affixID_].race, slot0.affixID_))
		manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, TalentTreeCfg[slot1].activity_id, TalentTreeCfg[slot1].race, slot1))
	end

	slot0.affixID_ = slot1
	slot0.unlock_ = slot2
	slot0.level_ = slot3

	slot0.unlockController_:SetSelectedState(tostring(slot2))

	if slot2 then
		slot0.levelText_.text = GetTips("LEVEL") .. slot3
	end

	slot0.nameText_.text = AffixTypeCfg[TalentTreeCfg[slot1].affix_id].name
end

function slot0.SetSelectCallBack(slot0, slot1)
	slot0.selectCallBack_ = slot1
end

function slot0.SetSelect(slot0, slot1)
	slot0.selectController_:SetSelectedState(tostring(slot0.affixID_ == slot1))
end

function slot0.Dispose(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, TalentTreeCfg[slot0.affixID_].activity_id, TalentTreeCfg[slot0.affixID_].race, slot0.affixID_))

	slot0.gameObject_ = nil
	slot0.transform_ = nil
	slot0.selectCallBack_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
