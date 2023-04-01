slot0 = class("BossSwitchItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.info_ = slot2

	slot0:InitUI()
	slot0:Init()
end

function slot0.RefreshData(slot0, slot1)
	slot0.info_ = slot1
	slot3 = BossChallengeUICfg[DamageTestCfg[slot0.info_.id].boss_id]
	slot0.icon_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.BossLittlePaint.path, slot3.icon))
	slot0.nameText_.text = slot3.main_name
	slot0.numText_.text = string.format("NO.%02d", slot0.info_.index)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddBtnListener(nil, , "OnClick")
end

function slot0.Init(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
	end)
end

function slot0.OnClick(slot0)
	if slot0.clickFunc_ then
		slot0.clickFunc_(slot0.info_)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc_ = slot1
end

function slot0.GetItemInfo(slot0)
	return slot0.info_
end

function slot0.Dispose(slot0)
	slot0.clickFunc_ = nil

	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
