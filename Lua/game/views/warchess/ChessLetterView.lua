slot0 = class("ChessLetterView", ReduxView)
slot1 = {
	Playing = 2,
	Stop = 3,
	Init = 1
}
slot2 = 40
slot3 = 1
slot4 = 1.5
slot5 = 0.5
slot6 = false

function slot0.UIName(slot0)
	return "UI/WarChess/WarChessLetterUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.typeTime_ = 0
	slot0.textComs = {}
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		if uv0.state_ == uv1.Playing then
			-- Nothing
		elseif uv0.state_ == uv1.Stop then
			if uv0.contentID_ == 0 then
				uv0:Back()
				uv0.callBack()
			else
				uv0.state_ = uv1.Init
				uv2 = false
			end
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.callBack = slot0.params_.callBack

	if not slot0.handle then
		slot1 = FuncTimerManager.inst
		slot0.handle = slot1:CreateFuncFrameTimer(function ()
			uv0:Update()
		end, -1, true)
	end

	uv0 = true
	slot0.state_ = uv1.Init
	slot0.contentID_ = slot0.params_.ID
	slot0.scrollbar_.value = 1
end

function slot0.OnExit(slot0)
	if slot0.handle then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.handle)

		slot0.handle = nil
	end
end

function slot0.Update(slot0)
	slot0:Play(Time.deltaTime)
end

function slot0.Play(slot0, slot1)
	if slot0.state_ == uv0.Init then
		slot0.pageText_ = ""
		slot0.typeTime_ = 0
		slot2 = 1
		slot3 = -1

		while true do
			if slot0.contentID_ == 0 then
				error("WarchessContentCfg配置错误")
			end

			slot5 = WarchessContentCfg[slot0.contentID_].alignment or 0

			if slot3 == -1 then
				slot0.pageText_ = slot0.pageText_ .. GetI18NText(slot4.content)
				slot3 = slot5
			elseif slot3 == slot5 then
				slot0.pageText_ = slot0.pageText_ .. "\n" .. GetI18NText(slot4.content)
			else
				slot0:CreateText(slot2, slot3, slot0.pageText_)

				slot0.pageText_ = GetI18NText(slot4.content)
				slot2 = slot2 + 1
				slot3 = slot5
			end

			slot0.contentID_ = slot4.next

			if slot4.page_end ~= 0 then
				slot0:CreateText(slot2, slot3, slot0.pageText_)

				break
			end
		end

		for slot7 = slot2 + 1, #slot0.textComs do
			SetActive(slot0.textComs[slot7].gameObject, false)
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.textContent_)

		if uv1 then
			slot0:SetTextColor(Color(1, 1, 1, 0))
		end

		slot0.state_ = uv0.Playing
	elseif slot0.state_ == uv0.Playing then
		slot0.typeTime_ = slot0.typeTime_ + slot1

		if uv1 then
			if uv2 < slot0.typeTime_ then
				slot0.state_ = uv0.Stop
			else
				slot2 = slot0.typeTime_ / uv3

				slot0:SetTextColor(Color(1, 1, 1, slot2 * slot2))
			end
		elseif uv4 < slot0.typeTime_ then
			slot0.state_ = uv0.Stop
		end
	elseif slot0.state_ ~= uv0.Stop then
		error("错误的State")
	end
end

function slot0.CreateText(slot0, slot1, slot2, slot3)
	if not slot0.textComs[slot1] then
		slot4 = Object.Instantiate(slot0.textText_, slot0.textContent_)
		slot4.transform.sizeDelta = Vector2.New(slot0.textContent_.rect.width, 0)
		slot0.textComs[slot1] = slot4:GetComponent(typeof(Text))
	end

	print("<color=#00ff00>CreateText</color> Network connected")

	slot4 = slot0.textComs[slot1]

	SetActive(slot4.gameObject, true)

	slot4.alignment = slot0:GetAlignmentNum(slot2)
	slot4.text = GetI18NText(slot3)

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.textContent_)
end

function slot0.SetTextColor(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.textComs) do
		slot6.color = slot1
	end
end

function slot0.GetAlignmentNum(slot0, slot1)
	if slot1 == 1 then
		return UnityEngine.TextAnchor.UpperCenter
	elseif slot1 == 2 then
		return UnityEngine.TextAnchor.UpperRight
	else
		return UnityEngine.TextAnchor.UpperLeft
	end
end

function slot0.Dispose(slot0)
	slot0.textComs = {}

	uv0.super.Dispose(slot0)
end

return slot0
