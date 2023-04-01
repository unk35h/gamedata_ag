slot0 = class("BulletinBtnItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.clickHandler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectedController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "selected")
	slot0.newController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "new")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener("", nil, function ()
		if uv0.clickHandler_ then
			uv0.clickHandler_(uv0.data_)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.data_ = slot1

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot1 = manager.time:GetServerTime()
	slot0.content_.text = slot0.data_.name
	slot0.content1_.text = slot0.data_.name

	if not getData("bulletin", "bulletin_" .. slot0.data_.id) and slot1 < slot0.data_.endTime then
		slot0.newController_:SetSelectedState("true")
	else
		slot0.newController_:SetSelectedState("false")
	end
end

function slot0.SetSelected(slot0, slot1)
	slot0.selectedController_:SetSelectedState(slot1 and "true" or "false")
end

function slot0.OnEnter(slot0)
	slot0:RegistEventListener(BULLETIN_SINGLE_READ_UPDATE, handler(slot0, slot0.OnBulletReadUpdate))
end

function slot0.OnExit(slot0)
end

function slot0.OnBulletReadUpdate(slot0, slot1)
	if slot1 == slot0.data_.id then
		slot0:UpdateView()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.transform_:SetParent(nil)
	Object.Destroy(slot0.gameObject_)
	uv0.super.Dispose(slot0)
end

return slot0
