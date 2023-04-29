slot0 = class("PolyhedronRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PolyhedronBattle/PolyhedronRewardUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardList = LuaList.New(handler(slot0, slot0.indexRewardItem), slot0.m_rewardList, PolyhedronRewardItem)
	slot0.hasGiveUpRewadController = ControllerUtil.GetController(slot0.transform_, "hasGiveUpRewad")
	slot0.refreshController = ControllerUtil.GetController(slot0.transform_, "refresh")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_confirmBtn, nil, function ()
		uv0:OnRewardAction()
	end)
	slot0:AddBtnListener(slot0.m_giveUpBtn, nil, function ()
		slot6 = uv0.polyhedronInfo

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("POLYHEDRON_SHOP_GIVE_UP"), slot6:GetRewardGiveUpCoin()),
			OkCallback = function ()
				PolyhedronAction.QueryRewardPolyhedron(0)
			end
		})
	end)
	slot0:AddBtnListener(slot0.m_refreshBtn, nil, function ()
		PolyhedronAction.QueryResetRewardPolyhedron()
	end)
end

function slot0.OnUpdate(slot0)
	slot0:RefreshUI()
end

function slot0.OnEnter(slot0)
	SetActive(slot0.effectGo_, false)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.selectItemIndex = -1
	slot0.m_confirmBtn.interactable = false
	slot1 = PolyhedronData:GetPolyhedronInfo()
	slot0.polyhedronInfo = slot1
	slot0.rewardArray = slot1:GetRewardList()

	if #slot0.rewardArray > 0 then
		slot4 = slot0.rewardArray[1].class
		slot0.m_title.text = slot0:GetRewardTitleitemType(slot4)

		if slot4 == PolyhedronConst.ITEM_TYPE.ARTIFACT then
			slot0.hasGiveUpRewadController:SetSelectedIndex(1)

			slot0.m_giveUpLab.text = string.format(GetTips("POLYHEDRON_SHOP_GIVE_UP"), slot0.polyhedronInfo:GetRewardGiveUpCoin())

			if slot1:GetRollRewardCount() == 0 then
				slot0.refreshController:SetSelectedIndex(0)
			else
				slot0.refreshController:SetSelectedIndex(1)
			end

			slot0.m_refreshCount.text = "x" .. slot5
		else
			slot0.hasGiveUpRewadController:SetSelectedIndex(0)
			slot0.refreshController:SetSelectedIndex(0)
		end
	else
		slot0.hasGiveUpRewadController:SetSelectedIndex(0)
		slot0.refreshController:SetSelectedIndex(0)

		slot0.m_title.text = ""
	end

	if slot2 == 1 then
		slot0.selectItemIndex = 1
		slot0.m_confirmBtn.interactable = true
	end

	slot0.rewardList:StartScroll(slot2)
end

function slot0.GetRewardTitleitemType(slot0, slot1)
	if slot1 == PolyhedronConst.ITEM_TYPE.ARTIFACT then
		return GetTips("POLYHEDRON_REWARD_TITLE_ARTIFACT")
	elseif slot1 == PolyhedronConst.ITEM_TYPE.ARTIFACT_UP_LEVEL then
		return GetTips("POLYHEDRON_REWARD_TITLE_ARTIFACT_UP")
	elseif slot1 == PolyhedronConst.ITEM_TYPE.COIN then
		return GetTips("POLYHEDRON_REWARD_TITLE_COIN")
	elseif slot1 == PolyhedronConst.ITEM_TYPE.HERO then
		return GetTips("POLYHEDRON_REWARD_TITLE_ROLE")
	elseif slot1 == PolyhedronConst.ITEM_TYPE.BUFF then
		return GetTips("POLYHEDRON_REWARD_TITLE_EFFECT")
	elseif slot1 == PolyhedronConst.ITEM_TYPE.BLOOD then
		return GetTips("POLYHEDRON_REWARD_TITLE_BLOOD")
	else
		return ""
	end
end

function slot0.OnExit(slot0)
	SetActive(slot0.effectGo_, false)
	UpdatePolyhedronBattleHpUI()
end

function slot0.indexRewardItem(slot0, slot1, slot2)
	slot2:RegistCallBack(handler(slot0, slot0.OnRewardItemClick))
	slot2:SetData(slot0.polyhedronInfo, slot0.rewardArray[slot1], slot1)
	slot2:SetSelected(slot0.selectItemIndex)
end

function slot0.OnRewardItemClick(slot0, slot1)
	if slot1 == slot0.selectItemIndex then
		return
	end

	slot0.selectItemIndex = slot1

	for slot6, slot7 in pairs(slot0.rewardList:GetItemList()) do
		slot7:SetSelected(slot0.selectItemIndex)
	end

	slot0.m_confirmBtn.interactable = true

	if slot0.rewardArray[slot0.selectItemIndex].class == PolyhedronConst.ITEM_TYPE.BLOOD then
		SetActive(slot0.effectGo_, true)
	end
end

function slot0.OnRewardAction(slot0)
	if slot0.selectItemIndex == -1 then
		return
	end

	PolyhedronAction.QueryRewardPolyhedron(slot0.selectItemIndex)
end

function slot0.Dispose(slot0)
	slot0.rewardList:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
