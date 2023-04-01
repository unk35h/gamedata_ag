slot0 = class("DormLevelAwardItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.type = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.count = 0
	slot0.rewardItemList_ = {}

	slot0:InitUI()
	slot0:AddUIListener()

	slot0.selController = ControllerUtil.GetController(slot0.transform_, "selectItem")

	if slot0.uilistGo_ then
		slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, CommonItem)
	end
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id
		})
	end)
	slot2:RefreshData({
		id = slot0.rewardItemList_[slot1][1],
		number = slot0.rewardItemList_[slot1][2]
	})
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3)
	slot0.index = slot2
	slot9 = "DORM_LEVEL_TIPS"
	slot8 = slot2
	slot0.levelText.text = string.format(GetTips(slot9), slot8)
	slot0.rewardItemList_ = {}
	slot4 = ""

	for slot8, slot9 in ipairs(slot1) do
		slot10 = BackHomeDormLevelRewardCfg[slot9].reward

		if BackHomeDormLevelRewardCfg[slot9].type == 3 then
			table.insert(slot0.rewardItemList_, slot10)
		elseif BackHomeDormLevelRewardCfg[slot9].type == 1 then
			slot4 = slot4 .. string.format(GetTips("DORM_LEVEL_AWARD_ATTRIB"), PublicAttrCfg[slot10[1]].name, slot10[2]) .. ","
		elseif BackHomeDormLevelRewardCfg[slot9].type == 2 then
			slot4 = slot4 .. string.format(GetTips("DORM_LEVEL_AWARD_VOICE"), HeroVoiceCfg[slot10[1]].title) .. ","
		end
	end

	slot0.decText.text = string.sub(slot4, 1, -2)

	slot0:RefreshRewardItem()

	if slot3 == slot2 then
		slot0.selController = ControllerUtil.GetController(slot0.transform_, "select")
	else
		slot0.selController = ControllerUtil.GetController(slot0.transform_, "normal")
	end
end

function slot0.indexAwardItem(slot0)
	slot0.awardList = {}
end

function slot0.RefreshRewardItem(slot0)
	if slot0.rewardItemList_ and slot0.scrollHelper_ then
		slot0.scrollHelper_:StartScroll(#slot0.rewardItemList_)
	end
end

function slot0.RegisterSelCallBack(slot0, slot1)
	if slot1 then
		slot0.selFunc = slot1
	end
end

function slot0.Dispose(slot0)
	if slot0.itemList then
		for slot4, slot5 in ipairs(slot0.itemList) do
			slot5:Dispose()
		end
	end

	uv0.super.Dispose(slot0)
end

return slot0
