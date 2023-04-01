slot0 = class("IlluIllustrationDetail", ReduxView)

function slot0.UIName(slot0)
	return "UI/IllustratedHandbook/IlluIllustrationDetail"
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

	slot0.loadCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "loading")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.shareBtn_, nil, function ()
		slot0 = manager.share

		slot0:Share(function ()
			SetActive(uv0.shareGo_, false)
			SetActive(uv0.backGo_, false)
			SetActive(uv0.descGo_, false)
			SetActive(uv0.addBtn_.gameObject, false)
			SetActive(uv0.content_, false)
		end, function ()
			SetActive(uv0.shareGo_, true)
			SetActive(uv0.backGo_, true)
			SetActive(uv0.descGo_, true)
			SetActive(uv0.addBtn_.gameObject, true)

			if #uv0.list_ > 1 then
				SetActive(uv0.content_, true)
			end
		end)
	end)
	slot0:AddBtnListener(slot0.addBtn_, nil, function ()
		if not getData("illustrated", "loading") or slot0 == 0 then
			JumpTools.OpenPageByJump("illustratedPop", {
				ID = uv0.ID_
			})
			saveData("illustrated", "loading", 1)
		elseif IllustratedData:IsInLoadingSet(uv0.ID_) then
			IllustratedAction.ChangeLoadingSet(false, uv0.ID_)
		else
			if GameSetting.loading_pic_max.value[1] <= #IllustratedData:GetAllLoadingSet() then
				ShowTips("SET_FAILED")

				return
			end

			IllustratedAction.ChangeLoadingSet(true, uv0.ID_)
			ShowTips("SET_CONFIRMED")
		end
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		if #uv0.list_ > 1 then
			if table.indexof(uv0.list_, uv0.ID_) ~= #uv0.list_ then
				uv0.ID_ = uv0.list_[slot0 + 1]
			else
				uv0.ID_ = uv0.list_[1]
			end

			uv0:RefreshUI()
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.ID_ = slot0.params_.ID
	slot0.list_ = CollectPictureCfg.get_id_list_by_group_id[CollectPictureCfg[slot0.ID_].group_id] or {}

	table.sort(slot0.list_, function (slot0, slot1)
		return CollectPictureCfg[slot0].group_display_order < CollectPictureCfg[slot1].group_display_order
	end)
	SetActive(slot0.content_, #slot0.list_ > 1)

	slot0.bgBtn_.interactable = #slot0.list_ > 1

	slot0:RefreshLiner()
	slot0:RefreshUI()
end

function slot0.RefreshLiner(slot0)
	slot0:SetBarPosition(0)

	slot3 = slot0.sliderBg_.transform.childCount > #slot0.list_ and slot1 or slot2

	for slot7 = 1, slot3 do
		if slot7 <= slot1 then
			slot8 = slot0.sliderBg_.transform:GetChild(slot7 - 1)

			if slot7 <= slot2 then
				SetActive(slot8.gameObject, true)
			else
				SetActive(slot8.gameObject, false)
			end
		else
			SetActive(Object.Instantiate(slot0.barTemp_, slot0.sliderBg_.transform), true)
		end
	end
end

function slot0.SetBarPosition(slot0, slot1)
	slot0.selectItem_.transform:SetSiblingIndex(slot1)
end

function slot0.RefreshUI(slot0)
	slot0.imageImg_.sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. CollectPictureCfg[slot0.ID_].picture)
	slot0.titleText_.text = CollectPictureCfg[slot0.ID_].name
	slot0.descText_.text = CollectPictureCfg[slot0.ID_].desc

	slot0:RefreshLoading()
	slot0:SetBarPosition(table.indexof(slot0.list_, slot0.ID_) - 1)
end

function slot0.RefreshLoading(slot0)
	slot0.loadCon_:SetSelectedState(IllustratedData:IsInLoadingSet(slot0.ID_) and "true" or "false")
end

function slot0.OnSaveLoadingSet(slot0)
	slot0:RefreshLoading()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
