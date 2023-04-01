slot0 = class("ObtainBaseView", ReduxView)

function slot0.OnClick(slot0)
	if not slot0.playableDirector_ then
		return true
	end

	if slot0.playableDirector_.time == 0 or slot0:GetTimeLineEndTime() <= slot0.playableDirector_.time then
		return true
	else
		slot0.playableDirector_.time = slot0:GetTimeLineEndTime()

		return false
	end
end

function slot0.Skip2End(slot0)
	if slot0.playableDirector_ then
		slot0.playableDirector_.time = slot0:GetTimeLineEndTime()
	end
end

function slot0.HideShareUI(slot0, slot1)
	if slot0.rebateGo_ then
		SetActive(slot0.rebateGo_, false)
	end
end

function slot0.ShowShareUI(slot0, slot1)
	if slot0.rebateGo_ and slot1.draw_rebate and slot1.draw_rebate ~= 0 then
		SetActive(slot0.rebateGo_, true)
	end
end

function slot0.Show(slot0, slot1)
	slot2 = slot1.id

	if slot0.gameObject_ then
		SetActive(slot0.gameObject_, true)
	end

	if slot0.playableDirector_ then
		slot0.playableDirector_:Evaluate()
		slot0.playableDirector_:Play()
	end

	slot0:SetInfo(slot2)
end

function slot0.Hide(slot0)
	if slot0.gameObject_ then
		SetActive(slot0.gameObject_, false)
	end
end

function slot0.SetInfo(slot0)
end

function slot0.GetTimeLineEndTime(slot0)
	return 0
end

function slot0.OnObtainHeroMovieAnimtionEvent(slot0)
end

return slot0
