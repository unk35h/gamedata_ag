slot0 = class("LetterBoxRoleItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:AddEventListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.isSelectedController_ = ControllerUtil.GetController(slot0.transform_, "isSelected")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.normalBtn_, nil, function ()
		if uv0.handler_ ~= nil then
			uv0:handler_()
		end
	end)
end

function slot0.AddEventListener(slot0)
end

function slot0.UpdateView(slot0)
	slot0.nameText_.text = slot0.data_.sender
	slot0.headIcon_.sprite = ItemTools.getItemSprite(slot0.data_.sender_face)

	slot0.headIcon_:SetNativeSize()
end

function slot0.SetSelected(slot0, slot1)
	slot0.isSelectedController_:SetSelectedState(slot1 and "true" or "false")
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.noticePos_, RedPointConst.LETTER_SENDER_ID .. slot0.data_.id, {
		x = 0,
		y = 0
	})
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.noticePos_)
end

function slot0.SetData(slot0, slot1)
	slot0.data_ = slot1

	slot0:UpdateView()
	slot0:BindRedPoint()
end

function slot0.GetData(slot0)
	return slot0.data_
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:UnBindRedPoint()
	slot0:RemoveAllListeners()
	slot0:RemoveAllEventListener()
	uv0.super.Dispose(slot0)
end

return slot0
