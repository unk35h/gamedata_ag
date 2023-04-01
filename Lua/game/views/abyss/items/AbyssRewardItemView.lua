slot0 = class("AbyssRewardItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, CommonItem)
	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshData({
		id = slot0.cfg_.reward_list[slot1][1],
		number = slot0.cfg_.reward_list[slot1][2]
	})
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number,
			0,
			slot0.time_valid
		})
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.receivebtn_, nil, function ()
		AbyssAction.GetLayerBonus({
			uv0.id_
		})
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.id_ = slot2
	slot0.cfg_ = AbyssCfg[slot2]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	if slot0.id_ == #AbyssCfg.all then
		slot0.itemtext_.text = string.format(GetTips("ABYSS_LAYER_MAX_AWARD_TIP"), slot0.id_)
	else
		slot0.itemtext_.text = string.format(GetTips("ABYSS_LAYER_AWARD_TIP"), slot0.id_)
	end

	slot0.uiList_:StartScroll(#slot0.cfg_.reward_list)

	if AbyssData:IsLayerBonusGet(slot0.id_) then
		slot0.statusController_:SetSelectedState("haveGet")
	elseif slot0.id_ <= AbyssData:GetMaxLayer() then
		slot0.statusController_:SetSelectedState("canGet")
	else
		slot0.statusController_:SetSelectedState("cannotGet")
	end
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0.data_ = nil

	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
