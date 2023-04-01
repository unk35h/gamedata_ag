slot0 = import("game.views.matrix.matrixTools.MatrixTreeItemGroup")
slot1 = class("MatrixOriginView", ReduxView)
slot2 = {
	MATRIX = 1,
	TERMINAL = 5,
	TREASURE = 3,
	SCORE = 7,
	AFFIX = 4,
	HERO = 2,
	ARTIFACT = 6
}

function slot1.UIBackCount(slot0)
	return 2
end

function slot1.UIName(slot0)
	return "UI/Matrix/Mend/MatrixOrigin"
end

function slot1.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemGroup_ = uv0.New(slot0.m_itemGroup, slot0.m_treeItemPrefab)
	slot1 = slot0.itemGroup_

	slot1:SetSelectCallback(function (slot0, slot1, slot2)
		if uv0.subIndex_ == slot1 then
			return
		end

		uv0:ShowSubIndex(slot0, slot1, slot2)
	end)

	slot0.toggles_ = {}

	for slot5 = 1, slot0.m_switchContainer.childCount do
		table.insert(slot0.toggles_, slot0.m_switchContainer:GetChild(slot5 - 1):GetComponent(typeof(Toggle)))
	end
end

function slot1.AddUIListener(slot0)
	for slot4, slot5 in ipairs(slot0.toggles_) do
		slot0:AddToggleListener(slot5, function (slot0)
			if slot0 then
				uv0:SelectGroup(uv1)
			end
		end)
	end
end

function slot1.SelectGroup(slot0, slot1, slot2)
	if uv0.MATRIX == slot1 then
		slot0:HideTreeItems()
		JumpTools.OpenPageByJump("matrixOrigin/matrixProcess")
	elseif uv0.HERO == slot1 then
		slot0.heroList = MatrixData:GetMatrixHeroTeam()

		slot0:ShowTreeItems(slot1, slot2, slot0.heroList)
	elseif uv0.TREASURE == slot1 then
		slot0:HideTreeItems()
		JumpTools.OpenPageByJump("matrixOrigin/matrixTreasureMini")
	elseif uv0.AFFIX == slot1 then
		slot0:HideTreeItems()
		JumpTools.OpenPageByJump("matrixOrigin/matrixAffixMini")
	elseif uv0.TERMINAL == slot1 then
		slot0:HideTreeItems()
		JumpTools.OpenPageByJump("matrixOrigin/matrixTerminalTalentMini")
	elseif uv0.ARTIFACT == slot1 then
		slot0:HideTreeItems()
		JumpTools.OpenPageByJump("matrixOrigin/matrixBeaconMini")
	elseif uv0.SCORE == slot1 then
		slot0:HideTreeItems()
		JumpTools.OpenPageByJump("matrixOrigin/matrixScoreExchangeMini")
	end
end

function slot1.ShowSubIndex(slot0, slot1, slot2, slot3)
	JumpTools.OpenPageByJump("matrixOrigin/matrixMiniHero", {
		heroId = slot0.heroList[slot2]
	})
	slot0.transform_:SetAsLastSibling()
end

function slot1.ShowTreeItems(slot0, slot1, slot2, slot3)
	slot0.itemGroup_:GetContainer().parent = slot0.m_switchContainer

	slot0.itemGroup_:SetData(slot1, slot2 or 1, slot3)
	slot0.itemGroup_:GetContainer():SetSiblingIndex(slot1)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_switchContainer)
end

function slot1.HideTreeItems(slot0)
	slot0.subIndex_ = nil

	slot0.itemGroup_:GetContainer():SetParent(slot0.m_groupFreePlace)
end

function slot1.OnEnter(slot0)
	manager.ui:SetMainCamera("hero")

	if MatrixData:GetDifficulty() == 1 then
		SetActive(slot0.toggles_[uv0.AFFIX].gameObject, false)
	else
		SetActive(slot0.toggles_[uv0.AFFIX].gameObject, true)
	end

	slot0.toggles_[1].isOn = true

	slot0:SelectGroup(1)
	manager.windowBar:RegistBackCallBack(function ()
		JumpTools.GoToSystem("/matrixBlank/matrixPrepare")
	end)
	manager.redPoint:bindUIandKey(slot0.toggles_[uv0.SCORE].transform, RedPointConst.MATRIX_EXCHANGE_BONUS, {
		x = 139.6,
		y = 112.6
	})
end

function slot1.OnTop(slot0)
	slot0.toggles_[1].isOn = true

	slot0:SelectGroup(1)
end

function slot1.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	manager.redPoint:unbindUIandKey(slot0.toggles_[uv0.SCORE].transform, RedPointConst.MATRIX_EXCHANGE_BONUS)
end

function slot1.Dispose(slot0)
	if slot0.itemGroup_ then
		slot0.itemGroup_:Dispose()

		slot0.itemGroup_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot1.OnMatrixUserUpdate(slot0)
	if MatrixConst.STATE_TYPE.NOTSTARTED == MatrixData:GetGameState() then
		JumpTools.GoToSystem("/matrixBlank/matrixPrepare", {
			isTimeOut = true
		})
	elseif MatrixConst.STATE_TYPE.SUCCESS == slot1 or MatrixConst.STATE_TYPE.FAIL == slot1 then
		JumpTools.GoToSystem("/matrixBlank/matrixOver")
	end
end

return slot1
