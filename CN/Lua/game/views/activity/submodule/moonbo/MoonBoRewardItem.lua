slot0 = class("MoonBoRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.awardList_ = LuaList.New(handler(slot0, slot0.AwardIndexItem), slot0.listGo_, CommonItem)
end

function slot0.AwardIndexItem(slot0, slot1, slot2)
	slot3 = slot0.curAwardsList_[slot1]

	slot2:RefreshData(formatReward(slot3))

	slot4 = ControllerUtil.GetController(slot2.transform_, "received")

	if MoonBoData:GetRewardIsShow(MoonBoCfg[slot0.levelNum_].reward_level, slot3[1]) then
		slot4:SetSelectedState("false")
	else
		slot4:SetSelectedState("true")
	end

	slot2:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
	end)

	slot2.countText_.text = string.format("%s/%s", MoonBoData:GetCurCanGetRewardCount(MoonBoCfg[slot0.levelNum_].reward_level, slot3[1]), MoonBoData:GetCfgRewardsCount(slot0.levelNum_, slot3[1]))
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.levelNum_ = MoonBoCfg.all[#MoonBoCfg.all - slot1 + 1]
	slot0.need_.text = MoonBoData:LevelNumToLanguage(slot0.levelNum_ - 100)
	slot0.curAwardsList_ = MoonBoData:GetCfgRewards(slot0.levelNum_)

	slot0.awardList_:StartScroll(#slot0.curAwardsList_)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.awardList_ then
		slot0.awardList_:Dispose()

		slot0.awardList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
