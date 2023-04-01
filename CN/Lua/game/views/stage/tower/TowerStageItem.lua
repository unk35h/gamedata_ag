slot0 = class("TowerStageItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
	slot0:AddClickListen()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.romanController = ControllerUtil.GetController(slot0.transform_, "roman")
	slot0.rewardList = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_rewardList, CommonItem)
end

function slot0.AddClickListen(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		if PlayerData:GetPlayerInfo().userLevel < uv0.limitLv then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), uv0.limitLv))

			return
		end

		JumpTools.GoToSystem("/tower", {
			chapterId = uv0.chapterId
		}, ViewConst.SYSTEM_ID.TOWER)

		if uv0.clickFunc then
			uv0.clickFunc()
		end
	end)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.chapterId = slot1

	slot0.romanController:SetSelectedIndex(slot2)

	slot4 = ChapterCfg[slot1].section_id_list
	slot6 = #slot4
	slot7 = table.indexof(slot4, TowerData:GetOverId(slot1)) or 0
	slot0.m_processText.text = slot7 .. "/" .. slot6
	slot0.m_process.value = slot6 == 0 and 0 or slot7 / slot6

	if (slot4[slot6] or 0) == 0 then
		slot0.rewardList:StartScroll(0)
	elseif (BattleTowerStageCfg[slot8] or {}).drop_lib_id ~= 0 then
		slot0.rewardData = getRewardFromDropCfg(slot10, true)

		slot0.rewardList:StartScroll(#slot0.rewardData)
	else
		slot0.rewardList:StartScroll(0)
	end

	slot0.limitLv = slot3.level or 0

	if PlayerData:GetPlayerInfo().userLevel < slot0.limitLv then
		slot0.stateController:SetSelectedIndex(0)
	elseif slot8 == slot5 then
		slot0.stateController:SetSelectedIndex(2)
	else
		slot0.stateController:SetSelectedIndex(1)
	end

	slot0.m_role.sprite = getSpriteWithoutAtlas("Textures/TowerUI/Boss/" .. (ChapterClientCfg[slot1] and slot9.chapter_paint or ""))
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.rewardData[slot1]))
	slot2:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
	slot2:HideNum()
end

function slot0.Dispose(slot0)
	slot0.rewardList:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
