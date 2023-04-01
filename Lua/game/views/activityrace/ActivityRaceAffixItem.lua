slot0 = class("ActivityRaceAffixItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.levelController_ = ControllerUtil.GetController(slot0.transform_, "level")
	slot0.unlockController_ = ControllerUtil.GetController(slot0.transform_, "unlock")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	if slot0.btn_ then
		slot0:AddBtnListener(slot0.btn_, nil, function ()
			if uv0.selectCallBack_ then
				uv0.selectCallBack_(uv0.index_, uv0.affixID_, uv0.affixLv_)
			end
		end)
	end
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.index_ = slot1
	slot0.affixID_ = slot2
	slot0.affixLv_ = slot3
	slot0.unlock_ = slot4

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshAffixImage()

	if slot0.affixLv_ ~= nil then
		slot0.levelController_:SetSelectedState(slot0.affixLv_)
	else
		slot0.levelController_:SetSelectedState(0)
	end

	slot0.unlockController_:SetSelectedState(tostring(slot0.unlock_))
end

function slot0.RefreshAffixImage(slot0)
	if slot0.affixID_ then
		if PublicBuffCfg[AffixTypeCfg[slot0.affixID_].affix_buff_id].icon == "" then
			-- Nothing
		end

		slot0.icon_.sprite = getSpriteWithoutAtlas(SpritePathCfg.AffixIcon.path .. slot2)
		slot0.name_.text = slot1.name
	end
end

function slot0.RegistSelectCallBack(slot0, slot1)
	slot0.selectCallBack_ = slot1
end

function slot0.Dispose(slot0)
	slot0.selectCallBack_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
