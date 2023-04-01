slot0 = class("MaterialPreview", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/MaterialPreviewUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.messageGo_, CommonItem)
	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "conName")
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshData(slot0.itemList_[slot1])
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.textText_.text = slot0.params_.content

	slot0:UpdateData()

	if #slot0.itemList_ > 2 then
		slot0.scrollHelper_:SetOrientation(0)
		slot0.controller_:SetSelectedState("exist")
	else
		slot0.scrollHelper_:SetOrientation(1)
		slot0.controller_:SetSelectedState("notExist")
	end

	slot0.scrollHelper_:StartScroll(#slot0.itemList_)
end

function slot0.OnExit(slot0)
end

function slot0.UpdateData(slot0)
	slot0.itemList_ = {}

	for slot5, slot6 in pairs(slot0.params_.itemList) do
		table.insert(slot0.itemList_, {
			id = slot6[1],
			number = slot6[2]
		})
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.cancelbtnBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.okbtnBtn_, nil, function ()
		uv0.params_.OkCallback()
		uv0:Back()
	end)
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
