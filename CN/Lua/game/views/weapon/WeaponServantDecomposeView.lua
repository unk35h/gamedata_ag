slot0 = class("WeaponServantDecomposeView", ReduxView)
slot1 = {
	STAR = 2,
	CULTIVATE = 1
}

function slot0.UIName(slot0)
	return "UI/Weapon/WeaponDecomposeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.rewardIndex_ = 0
	slot0.rewardItems_ = {}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.item_ = Asset.Load("UI/Common/CommonItem")
	slot0.scrollHelper = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, CommonItem)
	slot4 = "btn_decompose"
	slot0.btnController_ = ControllerUtil.GetController(slot0.btn_decomposeBtn_.transform, slot4)
	slot0.starSelect_ = {}

	for slot4 = 3, 4 do
		slot0.starSelect_[slot4] = slot0["select" .. slot4 .. "Go_"]
	end
end

function slot0.AddUIListener(slot0)
	function slot1(slot0)
		uv0.arrowTrs_.localEulerAngles = Vector3.New(0, 0, 0)

		SetActive(uv0.containerbgGo_, false)

		if slot0 == uv0.params_.priority then
			return
		end

		uv0.params_.priority = slot0

		uv0:Render()
	end

	slot0:AddBtnListener(slot0.starbutBtn_, nil, function ()
		uv0(uv1.STAR)
	end)
	slot0:AddBtnListener(slot0.culturetbutBtn_, nil, function ()
		uv0(uv1.CULTIVATE)
	end)
	slot0:AddBtnListener(slot0.currentbutBtn_, nil, function ()
		uv0.arrowTrs_.localEulerAngles = not uv0.containerbgGo_.activeSelf and Vector3.New(0, 0, 180) or Vector3.New(0, 0, 0)

		SetActive(uv0.containerbgGo_, slot0)
	end)

	slot5 = slot0.sortbutBtn_

	slot0:AddBtnListener(slot5, nil, function ()
		uv0.params_.order = uv0.selectStatus_.order == ItemConst.SORT_TYPE.DOWN and ItemConst.SORT_TYPE.UP or ItemConst.SORT_TYPE.DOWN

		uv0:Render()
	end)

	slot0.starIsOn_ = {}

	for slot5 = 3, 4 do
		slot0:AddBtnListener(slot0["star" .. slot5 .. "Btn_"], nil, function ()
			uv0:QuickSelectServant(uv1, not uv0.starIsOn_[uv1])
		end)
	end

	slot0:AddBtnListener(slot0.btn_decomposeBtn_, nil, function ()
		if uv0.currentselectnumText_ <= 0 then
			return
		end

		slot0 = false
		slot1 = false

		for slot5, slot6 in pairs(uv0.usedServantList_) do
			if WeaponServantCfg[slot6.id].starlevel >= 4 then
				slot0 = true
			end

			if slot6.stage >= 2 then
				slot1 = true
			end

			if slot0 and slot1 then
				break
			end
		end

		if slot0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("SERVANT_RESOLVE_COST_RARE"),
				OkCallback = function ()
					ServantAction.ServantDecompose(uv0.usedServantList_)
				end,
				CancelCallback = function ()
				end
			})
		elseif slot1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("SERVANT_RESOLVE_COST_REFINE"),
				OkCallback = function ()
					ServantAction.ServantDecompose(uv0.usedServantList_)
				end,
				CancelCallback = function ()
				end
			})
		else
			ServantAction.ServantDecompose(uv0.usedServantList_)
		end
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})

	slot0.selRace_ = slot0.params_.race
	slot0.usedServantList_ = {}
	slot0.starIsOn_ = {}
	slot0.arrowTrs_.localEulerAngles = Vector3.New(0, 0, 0)

	SetActive(slot0.containerbgGo_, false)
	slot0:Render()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnServantDecomposeResult(slot0, slot1, slot2)
	WeaponServantData:CostServantS(slot2.servant_list)

	slot3 = {}

	for slot7, slot8 in pairs(slot0.totalList_) do
		table.insert(slot3, {
			id = slot7,
			number = slot8
		})
		MaterialAction.MaterialModify(slot7, slot8)
	end

	slot0:Go("reward", {
		list = slot3
	})

	slot0.usedServantList_ = {}

	slot0:Render()
end

function slot0.RefreshCultureContainer(slot0)
	if slot0.selectStatus_.order == ItemConst.SORT_TYPE.DOWN then
		SetActive(slot0.upperGo_, false)
		SetActive(slot0.lowerGo_, true)
	else
		SetActive(slot0.upperGo_, true)
		SetActive(slot0.lowerGo_, false)
	end

	if slot0.selectStatus_.priority == uv0.CULTIVATE then
		SetActive(slot0.culturetbutSelect, true)
		SetActive(slot0.starbutSelect, false)

		slot0.currentbuttextText_.text = GetTips("TIP_UPGRADE")
	else
		SetActive(slot0.culturetbutSelect, false)
		SetActive(slot0.starbutSelect, true)

		slot0.currentbuttextText_.text = GetTips("TIP_RARE")
	end
end

function slot0.Render(slot0)
	slot0:InitData()
	slot0.scrollHelper:StartScroll(#slot0.itemList_)
	slot0:RefreshRewardItem()
	slot0:RefreshQuickClick()
	slot0:RefreshCultureContainer()
end

function slot0.RefreshQuickClick(slot0)
	slot1 = 0

	for slot5, slot6 in ipairs(slot0.itemList_) do
		slot7 = WeaponServantCfg[slot6.id].starlevel

		if slot6.stage == 1 and not slot0.usedServantList_[slot6.uid] and slot0.starIsOn_[slot7] then
			slot0.starIsOn_[slot7] = false
		end
	end

	for slot5 = 3, 4 do
		SetActive(slot0.starSelect_[slot5], slot0.starIsOn_[slot5])
	end

	slot1 = table.length(slot0.usedServantList_)
	slot0.currentselectnumText_ = slot1
	slot0.selectnumText_.text = slot1
end

function slot0.RefreshRewardItem(slot0)
	slot0.totalList_ = ServantTools.GetServantDecomposeRewardItem(slot0.usedServantList_)

	SetActive(slot0.nullGo_, table.length(slot0.totalList_) == 0)

	if slot1 > 0 then
		slot0.btnController_:SetSelectedState("select")
	else
		slot0.btnController_:SetSelectedState("ash")
	end

	slot0.btn_decomposeBtn_.interactable = slot1 > 0
	slot2 = 1

	for slot6, slot7 in pairs(slot0.totalList_) do
		if slot0.rewardIndex_ < slot2 then
			slot0.rewardItems_[slot2] = CommonItem.New(Object.Instantiate(slot0.item_, slot0.gridTrs_))
			slot9 = slot0.rewardItems_[slot2]

			slot9:RegistCallBack(function (slot0)
				ShowPopItem(POP_ITEM, {
					slot0.id,
					slot0.number
				})
			end)

			slot0.rewardIndex_ = slot0.rewardIndex_ + 1
		end

		slot0.rewardItems_[slot2]:RefreshData({
			id = slot6,
			number = slot7
		})

		slot2 = slot2 + 1
	end

	for slot6, slot7 in ipairs(slot0.rewardItems_) do
		slot7:Show(slot6 <= slot1)
	end
end

function slot0.InitData(slot0)
	slot0.selectStatus_ = slot0:GetSelectStatus(slot0.params_.order or ItemConst.SORT_TYPE.UP, slot0.params_.priority or uv0.CULTIVATE)
	slot0.itemList_ = slot0:GetItemList(slot0.params_.order or ItemConst.SORT_TYPE.UP, slot0.params_.priority or uv0.CULTIVATE)
end

function slot0.GetItemList(slot0, slot1, slot2)
	slot3 = {}
	slot4 = ServantTools.GetServantMap()
	slot7 = WeaponServantData
	slot9 = slot7

	for slot8, slot9 in pairs(slot7.GetWeaponServantList(slot9)) do
		slot10 = slot4[slot9.uid]
		slot11 = slot9.locked
		slot12 = WeaponServantCfg[slot9.id].race
		slot13 = true

		if slot0.selRace_ and slot0.selRace_ ~= slot12 then
			slot13 = false
		end

		if not slot10 and slot11 == 0 and WeaponServantCfg[slot9.id].starlevel ~= 5 and slot13 then
			table.insert(slot3, deepClone(slot9))
		end
	end

	function slot5(slot0, slot1)
		if slot0.id == slot1.id then
			slot2 = WeaponServantCfg[slot0.id].starlevel
			slot3 = WeaponServantCfg[slot1.id].starlevel
			slot6 = WeaponServantCfg[slot0.id].race
			slot7 = WeaponServantCfg[slot1.id].race
			slot8 = slot0.id
			slot9 = slot1.id
			slot10 = slot0.uid
			slot11 = slot1.uid

			if slot0.stage ~= slot1.stage then
				return slot5 < slot4
			end

			if slot2 ~= slot3 then
				return slot3 < slot2
			end

			if slot6 ~= slot7 then
				return slot7 < slot6
			end

			if slot8 ~= slot9 then
				return slot9 < slot8
			end

			return slot11 < slot10
		else
			slot2 = WeaponServantCfg[slot0.id].starlevel
			slot3 = WeaponServantCfg[slot1.id].starlevel
			slot6 = WeaponServantCfg[slot0.id].race
			slot7 = WeaponServantCfg[slot1.id].race
			slot8 = slot0.id
			slot9 = slot1.id
			slot10 = slot0.uid
			slot11 = slot1.uid

			if slot0.stage ~= slot1.stage then
				return slot5 < slot4
			end

			if slot2 ~= slot3 then
				return slot3 < slot2
			end

			if slot6 ~= slot7 then
				return slot7 < slot6
			end

			if slot8 ~= slot9 then
				return slot9 < slot8
			end

			return slot11 < slot10
		end
	end

	function slot6(slot0, slot1)
		if slot0.id == slot1.id then
			slot4 = slot0.stage
			slot5 = slot1.stage
			slot6 = WeaponServantCfg[slot0.id].race
			slot7 = WeaponServantCfg[slot1.id].race
			slot8 = slot0.id
			slot9 = slot1.id
			slot10 = slot0.uid
			slot11 = slot1.uid

			if WeaponServantCfg[slot0.id].starlevel ~= WeaponServantCfg[slot1.id].starlevel then
				return slot3 < slot2
			end

			if slot4 ~= slot5 then
				return slot5 < slot4
			end

			if slot6 ~= slot7 then
				return slot7 < slot6
			end

			if slot8 ~= slot9 then
				return slot9 < slot8
			end

			return slot11 < slot10
		else
			slot4 = slot0.stage
			slot5 = slot1.stage
			slot6 = WeaponServantCfg[slot0.id].race
			slot7 = WeaponServantCfg[slot1.id].race
			slot8 = slot0.id
			slot9 = slot1.id
			slot10 = slot0.uid
			slot11 = slot1.uid

			if WeaponServantCfg[slot0.id].starlevel ~= WeaponServantCfg[slot1.id].starlevel then
				return slot3 < slot2
			end

			if slot4 ~= slot5 then
				return slot5 < slot4
			end

			if slot6 ~= slot7 then
				return slot7 < slot6
			end

			if slot8 ~= slot9 then
				return slot9 < slot8
			end

			return slot11 < slot10
		end
	end

	table.sort(slot3, function (slot0, slot1)
		if uv0 == 1 then
			if uv1 == 0 then
				return uv2(slot0, slot1)
			else
				return uv2(slot1, slot0)
			end
		elseif uv0 == 2 then
			if uv1 == 0 then
				return uv3(slot0, slot1)
			else
				return uv3(slot1, slot0)
			end
		end
	end)

	return slot3
end

function slot0.QuickSelectServant(slot0, slot1, slot2)
	slot0.starIsOn_[slot1] = slot2

	SetActive(slot0.starSelect_[slot1], slot0.starIsOn_[slot1])

	if slot2 then
		for slot7 = 1, #slot0.itemList_ do
			slot8 = slot0.itemList_[slot7]
			slot10 = slot8.stage

			if WeaponServantCfg[slot8.id].starlevel == slot1 and slot10 == 1 then
				slot0.usedServantList_[slot8.uid] = slot8
			end
		end
	else
		for slot6, slot7 in pairs(slot0.usedServantList_) do
			if WeaponServantCfg[slot7.id].starlevel == slot1 then
				slot0.usedServantList_[slot6] = nil
			end
		end
	end

	slot0:RefreshRewardItem()
	slot0:RefreshQuickClick()
	slot0:RefreshSelect()
end

function slot0.RefreshSelect(slot0)
	slot3 = slot0.scrollHelper
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
		slot5:ShowSelect(slot0.usedServantList_[slot5:GetItemInfo().uid] and 1 or 0)
	end
end

function slot0.GetSelectStatus(slot0, slot1, slot2)
	return {
		order = slot1,
		priority = slot2
	}
end

function slot0.indexItem(slot0, slot1, slot2)
	if slot1 < 0 or slot1 > #slot0.itemList_ then
		return nil
	end

	slot3 = slot0.itemList_[slot1]

	slot2:RefreshData({
		isEquip = true,
		uid = slot3.uid,
		id = slot3.id,
		number = slot3.stage,
		stage = slot3.stage
	})
	slot2:RegistCallBack(function (slot0)
		if uv0.usedServantList_[slot0.uid] then
			uv1:ShowSelect(0)

			uv0.usedServantList_[slot0.uid] = nil
		else
			uv1:ShowSelect(1)

			uv0.usedServantList_[slot0.uid] = {
				uid = slot0.uid,
				id = slot0.id,
				stage = slot0.number
			}
		end

		uv0:RefreshRewardItem()
		uv0:RefreshQuickClick()
	end)
	slot2:ShowSelect(slot0.usedServantList_[slot3.uid] and 1 or 0)

	return slot2
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = {}

	slot0.scrollHelper:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
