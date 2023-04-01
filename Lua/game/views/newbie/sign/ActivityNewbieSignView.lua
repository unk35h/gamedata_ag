slot0 = class("ActivityNewbieSignView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/Activity/NewbieSignUI"), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.RefreshReward), slot0.scrollView_, ActivityNewbieSignItem)

	slot0.uiList_:StartScroll(#GameSetting.newbie_sign.value, 1)
end

function slot0.SetData(slot0)
	slot1 = #GameSetting.newbie_sign.value
	slot3 = 0

	if ActivityNewbieData:GetSignDay() - 2 > 0 then
		slot3 = slot2 - 2
	end

	if ActivityNewbieData:GetSignTimestamp() < manager.time:GetTodayFreshTime() then
		slot3 = slot3 + 1
	end

	slot0.uiList_:StartScroll(slot1, slot3)
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.RefreshReward(slot0, slot1, slot2)
	slot2:RefreshUI(GameSetting.newbie_sign.value[slot1])
end

return slot0
