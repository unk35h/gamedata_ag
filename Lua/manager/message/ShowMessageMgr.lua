slot0 = import("manager.message.MessageBoxItem")
slot1 = class("ShowMessageMgr", import("game.extend.BaseView"))

function slot1.Ctor(slot0)
	slot0:OnCtor()
end

function slot1.OnCtor(slot0)
	print("initializing show message manager ...")

	slot0.itemList_ = {}
end

function slot1.ShowMessage(slot0, slot1)
	if manager.ui.uiMessage == nil then
		return
	end

	if JumpTools.JudgeIsHaveGaussian(gameContext:GetAllOpenRoute()) then
		if slot1.boxType == nil or slot1.boxType == NORMAL_MESSAGE_BOX then
			slot0:ShowNormalBox(slot1)
		end
	elseif slot1.boxType == nil or slot1.boxType == NORMAL_MESSAGE_BOX then
		slot0:ShowNormalBox(slot1)
	end
end

function slot1.ShowNormalBox(slot0, slot1)
	slot0:GetFreeItem():SetData(slot1)
end

function slot1.GetFreeItem(slot0)
	if slot0.itemList_ == nil then
		print("弹窗已经被销毁，被调用")

		slot0.itemList_ = {}
	end

	for slot4, slot5 in pairs(slot0.itemList_) do
		if slot5:IsFree() then
			return slot5
		end
	end

	if not slot0.gameObject_ then
		slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/Common/MessageBox_UI"), manager.ui.uiMessage.transform)

		SetActive(slot0.gameObject_, false)
	end

	slot1 = uv0.New(slot0.gameObject_)

	table.insert(slot0.itemList_, slot1)

	return slot1
end

function slot1.HideAll(slot0)
	if slot0.itemList_ then
		for slot4, slot5 in pairs(slot0.itemList_) do
			slot5:Hide()
		end
	end
end

function slot1.GetItemList(slot0)
	return slot0.itemList_
end

function slot1.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.itemList_ = nil

	if slot0.gameObject_ then
		Object.Destroy(slot0.gameObject_)

		slot0.gameObject_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot1
