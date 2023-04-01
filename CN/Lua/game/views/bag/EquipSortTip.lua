slot0 = class("EquipSortTip", ReduxView)
slot1 = import("game.const.EquipConst")
slot2 = import("game.tools.EquipTools")

function slot0.UIName(slot0)
	return "UI/EquipSortTip"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
	slot0:CreateSelector()
end

function slot0.CreateSelector(slot0)
end

function slot0.InitUI(slot0)
	slot0.bg_ = slot0:FindCom(typeof(Image), "bg")
	slot0.sort_ = slot0:FindCom(typeof(Text), "select/sort")
	slot0.position_ = slot0:FindCom(typeof(Text), "select/position")
	slot0.suit_ = slot0:FindCom(typeof(Text), "select/suit")
	slot0.suitItem_ = slot0:FindGo("tmp")
	slot0.suitList_ = slot0:FindTrs("suitswitch/Grid")

	slot0:InitSuit()

	slot0.priorityList_ = {
		lv = "LEVEL",
		time = "ID",
		rare = "RARE"
	}
end

function slot0.InitSuit(slot0)
	slot0.suitToggle_ = {
		[0] = slot0:FindCom(typeof(Toggle), "suitswitch/Grid/0")
	}

	slot0:AddToggleListener(slot0.suitToggle_[0], function (slot0)
		if slot0 then
			uv0.state_.suit = 0

			uv0:RefreshState()
		end
	end)

	slot5 = "suitswitch/Grid/0/numbg/num"
	slot4 = 0
	slot0:FindCom(typeof(Text), slot5).text = uv0.GetSuitEquipNum(slot4)

	for slot4, slot5 in ipairs(EquipSuitCfg.get_id_list_by_suit) do
		slot6 = Object.Instantiate(slot0.suitItem_, slot0.suitList_)

		SetActive(slot6, true)

		slot7 = slot6.transform
		slot8 = EquipSuitCfg[slot5[1]]
		slot0:FindCom(typeof(Text), "Label", slot7).text = slot8.name
		slot0:FindCom(typeof(Text), "numbg/num", slot7).text = uv0.GetSuitEquipNum(slot4)
		slot0:FindCom(typeof(Image), "image", slot7).sprite = getSprite("Atlas/Bag", slot8.shading)
		slot0.suitToggle_[slot4] = slot0:FindCom(typeof(Toggle), "", slot7)

		slot0:AddToggleListener(slot0.suitToggle_[slot4], function (slot0)
			if slot0 then
				uv0.state_.suit = uv1

				uv0:RefreshState()
			end
		end)
	end
end

function slot0.AddUIListener(slot0)
	slot0.posToggle_ = {}
	slot0.posToggleSelect_ = {}
	slot0.posToggleUnSelect_ = {}
	slot0.posToggle_[0] = slot0:FindCom(typeof(Toggle), "posswitch/0")
	slot4 = slot0.posToggle_[0]

	slot0:AddToggleListener(slot4, function (slot0)
		if slot0 then
			uv0.state_.pos = 0

			uv0:RefreshState()
		end
	end)

	for slot4 = 1, uv0.EQUIP_MAX_POS do
		slot0.posToggle_[slot4] = slot0:FindCom(typeof(Toggle), "posswitch/" .. slot4)
		slot0.posToggleUnSelect_[slot4] = slot0:FindGo("posswitch/" .. slot4 .. "/unselect")
		slot0.posToggleSelect_[slot4] = slot0:FindGo("posswitch/" .. slot4 .. "/select")

		slot0:AddToggleListener(slot0.posToggle_[slot4], function (slot0)
			SetActive(uv0.posToggleUnSelect_[uv1], not slot0)
			SetActive(uv0.posToggleSelect_[uv1], slot0)

			if slot0 then
				uv0.state_.suitPos = uv1

				uv0:RefreshState()
			end
		end)
	end

	slot0.toggle_ = {}

	for slot4, slot5 in pairs(slot0.priorityList_) do
		slot0.toggle_[slot5] = slot0:FindCom(typeof(Toggle), "sortswitch/" .. slot4)

		slot0:AddToggleListener(slot0.toggle_[slot5], function (slot0)
			if slot0 then
				uv0.state_.priority = uv1.EQUIP_SORT[uv2]

				uv0:RefreshState()
			end
		end)
	end

	slot0:AddBtnListenerScale("btn_sure", nil, function ()
		uv0.params_.priority = uv0.state_.priority
		uv0.params_.suitPos = uv0.state_.suitPos
		uv0.params_.suit = uv0.state_.suit

		uv0:Back()
	end)
	slot0:AddBtnListenerScale("btn_close", nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener("mask", nil, function ()
	end)
	slot0:AddBtnListener("select", nil, function ()
		uv0:Back()
	end)
end

function slot0.RefreshState(slot0)
	slot1 = slot0.state_

	for slot5, slot6 in pairs(uv0.EQUIP_SORT) do
		if slot6 == slot1.priority then
			slot0.sort_.text = GetTips(uv0.EQUIP_SORT_NAME[slot5])
		end
	end

	if slot1.suitPos == 0 then
		slot0.position_.text = GetTips("ALL")
	else
		slot0.position_.text = string.format(GetTips("POSITION_TIP"), slot1.suitPos)
	end

	if slot1.suit == 0 then
		slot0.suit_.text = GetTips("ALL")
	else
		slot0.suit_.text = EquipSuitCfg[EquipSuitCfg.get_id_list_by_suit[slot1.suit][1]].name
	end
end

function slot0.InitState(slot0)
	slot1 = slot0.state_

	for slot5, slot6 in pairs(uv0.EQUIP_SORT) do
		if slot6 == slot1.priority then
			slot0.toggle_[slot5].isOn = true
		end
	end

	slot0.posToggle_[slot1.suitPos].isOn = true
	slot0.suitToggle_[slot1.suit].isOn = true
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0.state_ = {
		priority = slot0.params_.priority or uv0.EQUIP_SORT.LEVEL,
		suitPos = slot0.params_.suitPos or 0,
		suit = slot0.params_.suit or 0
	}

	slot0:RefreshState()
	slot0:InitState()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.suitToggle_ then
		for slot4, slot5 in pairs(slot0.suitToggle_) do
			slot5.onValueChanged:RemoveAllListeners()
		end

		slot0.suitToggle_ = nil
	end

	if slot0.suitToggle_ then
		for slot4, slot5 in pairs(slot0.suitToggle_) do
			slot5.onValueChanged:RemoveAllListeners()
		end

		slot0.suitToggle_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
