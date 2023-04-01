slot0 = class("ActivityMatrixOriginView", MatrixOriginView)
slot1 = {
	MATRIX = 1,
	TERMINAL = 5,
	TREASURE = 3,
	SCORE = 7,
	AFFIX = 4,
	HERO = 2,
	ARTIFACT = 6
}

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemGroup_ = ActivityMatrixTreeItemGroup.New(slot0.m_itemGroup, slot0.m_treeItemPrefab)
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

	SetActive(slot0.toggles_[uv0.TERMINAL].gameObject, false)
	SetActive(slot0.toggles_[uv0.ARTIFACT].gameObject, false)
	SetActive(slot0.toggles_[uv0.SCORE].gameObject, false)
end

function slot0.SelectGroup(slot0, slot1, slot2)
	if uv0.MATRIX == slot1 then
		slot0:HideTreeItems()
		JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixProcess")
	elseif uv0.HERO == slot1 then
		slot0.heroList = ActivityMatrixData:GetMatrixHeroTeam(slot0.matrix_activity_id)

		slot0:ShowTreeItems(slot1, slot2, slot0.heroList)
	elseif uv0.TREASURE == slot1 then
		slot0:HideTreeItems()
		JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixTreasureMini")
	elseif uv0.AFFIX == slot1 then
		slot0:HideTreeItems()
		JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixAffixMini")
	elseif uv0.SCORE == slot1 then
		slot0:HideTreeItems()
		JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixScoreExchangeMini")
	end
end

function slot0.ShowSubIndex(slot0, slot1, slot2, slot3)
	JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixMiniHero", {
		heroId = slot0.heroList[slot2]
	})
	slot0.transform_:SetAsLastSibling()
end

function slot0.ShowTreeItems(slot0, slot1, slot2, slot3)
	slot0.itemGroup_:GetContainer().parent = slot0.m_switchContainer

	slot0.itemGroup_:SetData(slot1, slot2 or 1, slot3, slot0.matrix_activity_id)
	slot0.itemGroup_:GetContainer():SetSiblingIndex(slot1)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_switchContainer)
end

function slot0.OnEnter(slot0)
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id

	manager.ui:SetMainCamera("hero")

	if ActivityMatrixCfg[slot0.matrix_activity_id].type == 2 then
		SetActive(slot0.toggles_[uv0.AFFIX].gameObject, true)
	else
		SetActive(slot0.toggles_[uv0.AFFIX].gameObject, false)
	end

	slot0.toggles_[1].isOn = true

	slot0:SelectGroup(1)
	manager.windowBar:RegistBackCallBack(function ()
		JumpTools.GoToSystem("/matrixBlank/activityMatrix", {
			main_matrix_activity_id = ActivityMatrixData:GetMainActivityId(uv0.matrix_activity_id),
			matrix_activity_id = uv0.matrix_activity_id
		})
	end)

	slot3 = ActivityMatrixCfg[slot0.matrix_activity_id] and slot2.before_story_id or {}
	slot4 = false

	for slot8, slot9 in ipairs(slot3) do
		if slot9 and not manager.story:IsStoryPlayed(slot9) then
			slot4 = true

			break
		end
	end

	if slot4 then
		slot0.storyList = clone(slot3)
		slot5 = manager.story

		slot5:StartStoryById(slot0.storyList[1], function (slot0)
			uv0:CheckStoryPlay()
		end)
	end
end

function slot0.CheckStoryPlay(slot0)
	PlayerAction.ChangeStoryList(slot0.storyList[1])
	table.remove(slot0.storyList, 1)

	if #slot0.storyList > 0 then
		slot1 = manager.story

		slot1:StartStoryById(slot0.storyList[1], function (slot0)
			uv0:CheckStoryPlay()
		end)
	else
		TimeTools.StartAfterSeconds(0.033, function ()
			manager.ui:SetMainCamera("hero")
		end, {})
	end
end

function slot0.InitBackScene(slot0)
	slot0.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	slot0.backGroundTrs_ = slot0.backGround_.transform

	slot0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	slot0.backGroundTrs_.localPosition = Vector3(0, 0, 20)
	slot0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	slot0.backGroundTrs_.localScale = Vector3(1, 1, 1)
	slot0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("Textures/VolumeIIIUI/Volume_bg_00210")
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()

	if slot0.backGround_ then
		manager.resourcePool:DestroyOrReturn(slot0.backGround_, ASSET_TYPE.SCENE)
	end
end

function slot0.OnMatrixUserUpdate(slot0)
end

return slot0
