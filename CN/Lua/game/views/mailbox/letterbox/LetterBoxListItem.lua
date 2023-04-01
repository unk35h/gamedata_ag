slot0 = class("LetterBoxListItem", ReduxView)

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

	slot0.posController_ = ControllerUtil.GetController(slot0.transform_, "pos")
	slot0.readController_ = ControllerUtil.GetController(slot0.transform_, "read")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.normalBtn_, nil, function ()
		if uv0.handler_ ~= nil then
			uv0:handler_()
		end
	end)
end

function slot0.AddEventListener(slot0)
	slot0:RegistEventListener(LETTER_READ_UPDATE, handler(slot0, slot0.OnLetterReadUpdate))
end

function slot0.OnLetterReadUpdate(slot0, slot1)
	if slot1 == slot0.data_.id then
		slot0:UpdateView()
	end
end

function slot0.UpdateView(slot0)
	slot1 = string.split(slot0.data_.send_time, ",")
	slot0.yearText_.text = slot1[1]
	slot0.monthText_.text = string.format("%02d", slot1[2])
	slot0.dayText_.text = slot1[3]

	slot0.readController_:SetSelectedState(slot0.data_.isViewed and "read" or "unread")

	slot0.titleText_.text = slot0.data_.title
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.data_ = slot2

	slot0.posController_:SetSelectedState(slot1 % 2 == 1 and "down" or "up")
	slot0:UpdateView()
	slot0:BindRedPoint()
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.noticePos_, RedPointConst.LETTER_ID .. slot0.data_.id, {
		x = 0,
		y = 0
	})
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.noticePos_)
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
