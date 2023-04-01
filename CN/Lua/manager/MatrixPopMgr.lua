slot0 = class("MatrixMgr")

function slot0.Ctor(slot0)
end

function slot0.ShowPopItem(slot0, slot1, slot2, slot3)
	if not slot0.popItemView_ then
		slot0.popItemView_ = MatrixItemInfoView.New(manager.ui.uiMain.transform)
	end

	slot0.popItemView_:SetActive(true)
	slot0.popItemView_:SetWorldPosition(slot3)
	slot0.popItemView_:RefreshText(slot1, slot2)
	slot0:AddClickTimer()
end

function slot0.ShowMatrixPopItem(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot0.popItemView_ then
		slot0.popItemView_ = MatrixItemInfoView.New(manager.ui.uiMain.transform)
	end

	slot0.popItemView_:SetActive(true)
	slot0.popItemView_:SetWorldPosition(slot2)
	slot0.popItemView_:Refresh(slot1, slot3, slot4, slot5)
	slot0:AddClickTimer()
end

function slot0.ShowMatrixAiffixPopItem(slot0, slot1, slot2)
	if not slot0.popItemView_ then
		slot0.popItemView_ = MatrixItemInfoView.New(manager.ui.uiMain.transform)
	end

	slot0.popItemView_:SetActive(true)
	slot0.popItemView_:SetWorldPosition(slot2)
	slot0.popItemView_:RefreshAffix(slot1)
	slot0:AddClickTimer()
end

function slot0.ShowMatrixBeaconPopItem(slot0, slot1, slot2)
	if not slot0.popItemView_ then
		slot0.popItemView_ = MatrixItemInfoView.New(manager.ui.uiMain.transform)
	end

	slot0.popItemView_:SetActive(true)
	slot0.popItemView_:SetWorldPosition(slot2)
	slot0.popItemView_:RefreshBeacon(slot1)
	slot0:AddClickTimer()
end

function slot0.HideItem(slot0)
	slot0.popItemView_:SetActive(false)
end

function slot0.AddClickTimer(slot0)
	slot0:StopTimer()

	slot0.buttonUp_ = 0
	slot1 = FuncTimerManager.inst
	slot0.clickTimer_ = slot1:CreateFuncFrameTimer(function ()
		if Input.GetMouseButtonUp(0) then
			uv0.buttonUp_ = uv0.buttonUp_ + 1

			if uv0.buttonUp_ >= 2 then
				uv0:HideItem()
				FuncTimerManager.inst:RemoveFuncTimer(uv0.clickTimer_)

				uv0.clickTimer_ = nil
			end
		end
	end, -1, true)
end

function slot0.StopTimer(slot0)
	if slot0.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.clickTimer_)

		slot0.clickTimer_ = nil
	end
end

function slot0.Dispose(slot0)
	slot0:StopTimer()

	if slot0.popItemView_ then
		slot0.popItemView_:Dispose()

		slot0.popItemView_ = nil
	end
end

return slot0
