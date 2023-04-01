slot0 = class("DormLevelInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BackHouseUI/Dorm/DormPoplevelUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.maxController = ControllerUtil.GetController(slot0.gameObject_.transform, "level")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.OnEnter(slot0)
	slot0.roomID = DormData:GetCurrectSceneID()

	if BackHomeCfg[slot0.roomID].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		slot0.archiveID = slot0.params_.archiveID
	end

	slot0:RefreshList()
	slot0:RefreshExp()
end

function slot0.OnExit(slot0)
	for slot4, slot5 in pairs(slot0.obList) do
		Object.Destroy(slot5.go)
		slot5.item:Dispose()

		slot5.item = nil
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.RefreshList(slot0)
	slot0.itemList = BackHomeHeroCfg[DormData:GetHeroInfo(slot0.archiveID).canUseHero[1]].level_reward
	slot0.obList = {}

	for slot5, slot6 in ipairs(slot0.itemList) do
		slot7 = 1

		for slot11, slot12 in ipairs(slot6) do
			if BackHomeDormLevelRewardCfg[slot12].type == 3 then
				slot7 = 2

				break
			end
		end

		slot0.obList[slot5] = {}

		if slot7 == 1 then
			slot0.obList[slot5].go = GameObject.Instantiate(slot0.item1Go_, slot0.contentTrs_)
			slot0.obList[slot5].item = DormLevelAwardItem.New(slot0.obList[slot5].go, 1)
		else
			slot0.obList[slot5].go = GameObject.Instantiate(slot0.item2Go_, slot0.contentTrs_)
			slot0.obList[slot5].item = DormLevelAwardItem.New(slot0.obList[slot5].go, 2)
		end

		slot8 = slot0.obList[slot5].item

		slot8:RegisterSelCallBack(function (slot0)
			uv0.selIndex = slot0

			uv0:RefreshUI()
		end)
	end

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	for slot4 = 1, #slot0.itemList do
		slot0.obList[slot4].item:RefreshUI(slot0.itemList[slot4], slot4, slot0.selIndex)
	end
end

function slot0.RefreshExp(slot0)
	slot1 = DormitoryData:GetDormLevel(slot0.roomID)
	slot0.level.text = slot1

	if slot1 == #BackHomeDormLevel.all then
		slot0.maxController:SetSelectedState("full_rank")

		slot0.curExp.text = ""
		slot0.maxExp.text = ""
		slot0.progress.value = 1

		return
	end

	slot2 = DormitoryData:GetDormExp(slot0.roomID)
	slot3 = BackHomeDormLevel[slot1].exp

	if slot1 > 1 then
		for slot7 = 1, slot1 - 1 do
			slot2 = slot2 - BackHomeDormLevel[slot7].exp
		end
	end

	slot0.curExp.text = slot2
	slot0.maxExp.text = "/" .. slot3
	slot0.progress.value = slot2 / slot3
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
