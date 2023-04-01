slot0 = class("ActivityNoobSignView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot0:GetUIName(slot2)), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.RefreshReward), slot0.scrollView_, ActivityNoobSignItem)
	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")
end

function slot0.GetUIName(slot0, slot1)
	if slot1 == 1 then
		return "UI/Activity/NewbieSignUI1_new"
	else
		return "UI/Activity/NewbieSignUI2_new"
	end
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

function slot0.SetData(slot0, slot1)
	slot0.pageIndex_ = slot1
	slot3 = math.floor(ActivityNoobData:GetSignDay() / 7) + 1

	if slot0.lockController_ ~= nil then
		slot0.lockController_:SetSelectedIndex(slot3 < slot0.pageIndex_ and 1 or 0)
	end

	slot4 = GameSetting.newbie_sign_14.value
	slot0.rewardList_ = {}
	slot5 = (slot1 - 1) * 7 + 1

	for slot10 = slot5, slot5 + 7 do
		slot0.rewardList_[#slot0.rewardList_ + 1] = slot4[slot10]
	end

	slot0.uiList_:StartScroll(#slot0.rewardList_)
end

function slot0.RefreshReward(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.rewardList_[slot1], slot0.pageIndex_, slot1)
end

return slot0
