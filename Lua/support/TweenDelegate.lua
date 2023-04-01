slot0 = class("TweenDelegate")
slot1 = import("game.tools.GameObjectTools")
slot2 = require("cjson")
slot3 = {
	listShow = 5,
	value = 6,
	hide = 4,
	rotate = 7,
	alpha = 3,
	pivot = 8,
	scale = 1,
	move = 2
}

function slot0.Ctor(slot0, slot1, slot2)
	slot0.tweenManager_ = slot1
	slot0.transform_ = slot2

	slot0:OnCtor()
end

function slot0.OnCtor(slot0)
	slot0.tweenManager_.luaPlayFuc = LuaHelper.StringAction(function (slot0)
		uv0:Play(slot0, uv0.extraData_)
	end)
end

function slot0.Play(slot0, slot1, slot2, slot3)
	if not slot0.tweenManager_ or not slot1 or slot1 == "" then
		return
	end

	slot4 = nil

	for slot8 = 0, slot0.tweenManager_.tweenS.Count - 1 do
		if slot0.tweenManager_.tweenS[slot8].name == slot1 then
			slot4 = slot0.tweenManager_.tweenS[slot8].tweenJson
		end
	end

	if not slot4 then
		return
	end

	if slot0.timerTmp_ then
		for slot8, slot9 in ipairs(slot0.timerTmp_) do
			slot9:Stop()
		end
	end

	slot0.timerTmp_ = {}

	if slot0.childTween_ then
		for slot8, slot9 in ipairs(slot0.childTween_) do
			slot9:Dispose()
		end
	end

	slot0.childTween_ = {}
	slot5 = uv0.decode(slot4) or {}

	for slot10 = 1, #slot5 do
		if slot3 then
			slot5[slot10].delay = slot5[slot10].delay + slot3
		end

		if slot2 and slot2[slot10] then
			slot0:PlayTween(slot5[slot10], slot2[slot10])
		else
			slot0:PlayTween(slot5[slot10])
		end
	end
end

function slot0.PlayTween(slot0, slot1, slot2)
	if slot1.type == uv0.scale then
		slot0:PlayScale(slot1, slot2)
	elseif slot1.type == uv0.move then
		slot0:PlayMove(slot1, slot2)
	elseif slot1.type == uv0.alpha then
		slot0:PlayAlpha(slot1, slot2)
	elseif slot1.type == uv0.hide then
		slot0:PlayHide(slot1, slot2)
	elseif slot1.type == uv0.listShow then
		slot0:PlayListShow(slot1, slot2)
	elseif slot1.type == uv0.value then
		slot0:PlayValue(slot1, slot2)
	elseif slot1.type == uv0.rotate then
		slot0:PlayRotate(slot1, slot2)
	elseif slot1.type == uv0.pivot then
		slot0:PlayPivot(slot1, slot2)
	end
end

function slot0.PlayScale(slot0, slot1, slot2)
	slot3 = slot0.transform_:Find(slot1.go).gameObject

	if slot1.isInitFrom == 1 then
		LuaHelper.SetTfLoalScaleValue(slot3.transform, slot1.fromData.x, slot1.fromData.y, slot1.fromData.z)
	end

	slot4 = LeanTween.scale(slot3, Vector3(slot1.toData.x, slot1.toData.y, slot1.toData.z), slot1.time):setEase(LeanTweenType.IntToEnum(slot1.easeType)):setDelay(slot1.delay)

	if slot2 and slot2.onComplete then
		slot4:setOnComplete(LuaHelper.VoidAction(function ()
			uv0.onComplete()
		end))
	end
end

function slot0.PlayMove(slot0, slot1, slot2)
	slot3 = slot0.transform_:Find(slot1.go).gameObject

	if slot1.isInitFrom == 1 then
		slot5 = uv0.GetAdaptedLocalPosition(slot3, slot1.fromData)

		LuaHelper.SetTfLocalPosValue(slot3.transform, slot5.x, slot5.y, slot5.z)
	end

	slot5 = LeanTween.moveLocal(slot3, uv0.GetAdaptedLocalPosition(slot3, slot1.toData), slot1.time):setEase(LeanTweenType.IntToEnum(slot1.easeType)):setDelay(slot1.delay)

	if slot2 and slot2.onComplete then
		slot5:setOnComplete(LuaHelper.VoidAction(function ()
			uv0.onComplete()
		end))
	end
end

function slot0.PlayAlpha(slot0, slot1, slot2)
	slot3 = nil
	slot4 = uv0.GetOrAddComponent((type(slot1.go) ~= "string" or slot0.transform_:Find(slot1.go).gameObject) and slot1.go, typeof(CanvasGroup))

	if slot1.isInitFrom == 1 then
		LeanTween.alphaCanvas(slot4, slot1.fromData.x, 0)
	end

	slot5 = LeanTween.alphaCanvas(slot4, slot1.toData.x, slot1.time):setEase(LeanTweenType.IntToEnum(slot1.easeType)):setDelay(slot1.delay)

	if slot2 and slot2.onComplete then
		slot5:setOnComplete(LuaHelper.VoidAction(function ()
			uv0.onComplete()
		end))
	end
end

function slot0.PlayHide(slot0, slot1, slot2)
	slot3 = slot0.transform_
	slot3 = slot3:Find(slot1.go).gameObject

	LeanTween.delayedCall(slot1.delay, System.Action(function ()
		SetActive(uv0, false)
	end))

	slot4 = LeanTween.delayedCall(slot1.delay + slot1.time, LuaHelper.VoidAction(function ()
		SetActive(uv0, true)
	end))

	if slot2 and slot2.onComplete then
		slot4:setOnComplete(LuaHelper.VoidAction(function ()
			uv0.onComplete()
		end))
	end
end

function slot0.PlayListShow(slot0, slot1, slot2)
	slot3 = 0

	for slot9 = 1, slot0.transform_:Find(slot1.go).childCount do
		if slot4:GetChild(slot3).gameObject:GetComponent("TweenManager") ~= nil then
			slot13 = TweenDelegate.New(slot12, slot10)
			slot14 = slot1.delay + slot3 * slot1.toData.x

			if slot1.fromData.x == 0 then
				slot13:Play("ItemShow", nil, slot14)
			else
				slot13:Play(tostring(slot1.fromData.x), nil, slot14)
			end

			table.insert(slot0.childTween_, slot13)
		end

		slot3 = slot3 + 1
	end

	if slot2 and slot2.onComplete then
		slot7 = Timer.New(function ()
			uv0.onComplete()
		end, slot1.delay + slot1.time, 1)

		slot7:Start()
		table.insert(slot0.timerTmp_, slot7)
	end
end

function slot0.PlayValue(slot0, slot1, slot2)
	slot3 = slot1.toData.x

	if slot2 then
		slot4 = slot2

		LeanTween.value(slot4.fromData, slot4.toData, slot1.time).setEase(LeanTweenType.IntToEnum(slot1.easeType)).setDelay(slot1.delay).setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv0.onUpdate(slot0)
		end))
	end
end

function slot0.PlayRotate(slot0, slot1, slot2)
	slot3 = slot0.transform_:Find(slot1.go).gameObject

	if slot1.isInitFrom == 1 then
		LuaHelper.SetTfLocalRotateValue(slot3.transform, slot1.fromData.x, slot1.fromData.y, slot1.fromData.z)
	end

	slot4 = LeanTween.rotateLocal(slot3, Vector3(slot1.toData.x, slot1.toData.y, slot1.toData.z), slot1.time):setEase(LeanTweenType.IntToEnum(slot1.easeType)):setDelay(slot1.delay)

	if slot2 and slot2.onComplete then
		slot4:setOnComplete(LuaHelper.VoidAction(function ()
			uv0.onComplete()
		end))
	end
end

function slot0.PlayPivot(slot0, slot1, slot2)
	slot4 = slot0.transform_:Find(slot1.go).gameObject:GetComponent("RectTransform")
	slot5 = Timer.New(function ()
		if uv0 then
			slot0 = Vector2(uv0.pivot.x, uv0.pivot.y)
			slot1 = uv1.toData.x - uv0.pivot.x
			slot2 = uv1.toData.y - uv0.pivot.y
			slot3 = uv0.sizeDelta
			uv0.pivot = Vector2(uv1.toData.x, uv1.toData.y)
			uv0.localPosition = Vector3(uv0.localPosition.x + slot1 * uv0.sizeDelta.x * math.cos(math.rad(uv0.localEulerAngles.z)) + slot2 * uv0.sizeDelta.y * math.sin(math.rad(uv0.localEulerAngles.z)), uv0.localPosition.y + slot2 * uv0.sizeDelta.y * math.cos(math.rad(uv0.localEulerAngles.z)) + slot1 * uv0.sizeDelta.x * math.sin(math.rad(uv0.localEulerAngles.z)), uv0.localPosition.z)
		end
	end, slot1.delay, 1)

	slot5:Start()
	table.insert(slot0.timerTmp_, slot5)
end

function slot0.Dispose(slot0)
	if slot0.timerTmp_ then
		for slot4, slot5 in ipairs(slot0.timerTmp_) do
			slot5:Stop()
		end
	end

	slot0.timerTmp_ = nil

	if slot0.childTween_ then
		for slot4, slot5 in ipairs(slot0.childTween_) do
			slot5:Dispose()
		end
	end

	slot0.childTween_ = nil
end

return slot0
