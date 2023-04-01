slot0 = class("AffixItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	if slot2 == nil then
		slot0.gameObject_ = slot1
	else
		slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	end

	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	if slot3 ~= nil then
		slot0:SetData(slot3)
	end

	slot0.hideInfoHandler_ = handler(slot0, slot0.HideInfo)

	manager.notify:RegistListener(CLICK_AFFIX, slot0.hideInfoHandler_)
end

function slot0.SetData(slot0, slot1)
	slot0:ShowInfo(false)

	slot0.nameText_.text = getAffixName(slot1)
	slot0.icon_.sprite = getAffixSprite(slot1)
	slot0.level_.text = slot1[2]

	slot0:Show(true)

	slot0.textInfoName_.text = getAffixName(slot1)
	slot0.textInfoDesc_.text = getAffixDesc(slot1)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	manager.notify:RemoveListener(CLICK_AFFIX, slot0.hideInfoHandler_)

	slot0.hideInofHandler_ = nil

	slot0:StopHideTimer()
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		manager.notify:Invoke(CLICK_AFFIX)
		uv0:ShowInfo(true)
	end)
end

function slot0.HideInfo(slot0)
	slot0:ShowInfo(false)
end

function slot0.ShowInfo(slot0, slot1)
	SetActive(slot0.goInfo_, slot1)

	if slot1 then
		slot0:AddHideTimer()
		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transformInfoName_)
		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transformInfoDesc_)
	else
		slot0:StopHideTimer()
	end
end

function slot0.AddHideTimer(slot0)
	slot0:StopHideTimer()

	slot0.hideTimer_ = Timer.New(function ()
		uv0:ShowInfo(false)
	end, 3, 1)

	slot0.hideTimer_:Start()
end

function slot0.StopHideTimer(slot0)
	if slot0.hideTimer_ then
		slot0.hideTimer_:Stop()

		slot0.hideTimer_ = nil
	end
end

function slot0.AddClickTimer(slot0)
	slot0:StopTimer()

	slot0.buttonUp_ = 0
	slot1 = FuncTimerManager.inst
	slot0.clickTimer_ = slot1:CreateFuncFrameTimer(function ()
		if Input.GetMouseButtonUp(0) then
			uv0.buttonUp_ = uv0.buttonUp_ + 1

			if uv0.buttonUp_ >= 2 then
				uv0:ShowInfo(false)

				if uv0.clickTimer_ then
					FuncTimerManager.inst:RemoveFuncTimer(uv0.clickTimer_)

					uv0.clickTimer_ = nil
				end
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

return slot0
