slot0 = class("ActivityInfinityPoolRewardPreviewBaseItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
	slot0.rewardItem_ = slot0:GetRewardItem(slot3)

	slot0:SetData(slot3, slot4, slot5)
end

function slot0.GetRewardItem(slot0, slot1)
	return RewardPoolItem.New(slot0.gameObject_, slot1)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.rewardItem_:SetData(slot1)

	if slot0.gameObject_.activeSelf == false then
		slot0:Show(true)
	end

	slot0.textCnt_.text = string.format("%s/%s", slot2, slot3)

	if slot3 <= slot2 then
		slot0.controller_:SetSelectedState("get")
	else
		slot0.controller_:SetSelectedState("normal")
	end
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.rewardItem_:Dispose()

	slot0.rewardItem_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
