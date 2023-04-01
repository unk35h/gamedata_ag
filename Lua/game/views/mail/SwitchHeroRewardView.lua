slot0 = class("SwitchHeroRewardView", RewardView)

function slot0.OnCtor(slot0)
	uv0.super.OnCtor(slot0)

	slot0.timerList = {}
end

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.effctItem_ = Asset.Load("UI/Common/ZhuanHuaAni")
end

function slot0.indexItem(slot0, slot1, slot2)
	uv0.super.indexItem(slot0, slot1, slot2)

	slot3 = slot0.itemList_[slot1]

	if slot2:FindTrs("ZhuanHuaAni") then
		SetActive(slot4.gameObject, false)
	end

	if slot3.convert then
		slot5 = slot3.convert

		if not slot4 then
			slot4 = Object.Instantiate(slot0.effctItem_, slot2.transform_)
			slot4.name = "ZhuanHuaAni"

			SetActive(slot4.gameObject, false)
		end

		SetActive(slot4.gameObject, true)

		slot4.transform.localPosition = Vector3.New(127, -124, 0)

		slot4:GetComponent("Animator"):Play("CommonItem_zhuanhua", 0, 0)
		slot0:AddTimer(TimeTools.StartAfterSeconds(1, function (slot0, slot1)
			slot0:RefreshData(slot1)
		end, {
			slot2,
			slot5
		}))
		manager.audio:PlayEffect("ui_system_search", "search_itemTransform", "")

		slot0.itemList_[slot1] = slot5
	else
		slot2:RefreshData(slot0.itemList_[slot1])
	end
end

function slot0.AddTimer(slot0, slot1)
	table.insert(slot0.timerList, slot1)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI(slot0.params_.list)

	slot0.callBack_ = slot0.params_.callBack
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		if uv0.params_.lateCallback then
			uv0:StopTime()
			uv0:Back()

			if uv0.callBack_ then
				uv0.callBack_()
			end
		else
			if uv0.params_.callBack then
				uv0.params_.callBack()
			end

			uv0:Back()
		end
	end)
end

function slot0.StopTime(slot0)
	for slot4, slot5 in ipairs(slot0.timerList) do
		slot5:Stop()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.OnExit(slot0)
	slot0.params_.callBack = nil

	for slot4, slot5 in pairs(slot0.timerList) do
		if slot5 then
			slot5:Stop()

			slot5 = nil
		end
	end

	slot0.timerList = {}

	uv0.super.OnExit(slot0)
end

return slot0
