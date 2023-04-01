slot1 = class("ChatItemView", import("game.views.chat.loopScrollView.LoopScrollViewBaseItem"))
slot1.bgExtendHeight = 40
slot1.contentMaxWidth = 540

function slot1.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.scrollView_ = slot3

	slot0:BindCfgUI()

	slot0.contentSizeFitter_ = slot0.textContent_:GetComponent("ContentSizeFitter")

	slot0:AddListeners()
	slot0:Show(true)
end

function slot1.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot1.GetUserID(slot0)
	return slot0.itemData_.id
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonHead_, nil, function ()
		if CooperationData:CheckInRoom() then
			return
		end

		ForeignInfoAction:TryToCheckForeignDetailInfo(uv0:GetUserID())
	end)
	slot0:AddBtnListener(slot0.buttonContent_, nil, function ()
		manager.notify:Invoke(CHAT_REPORT, {
			reportData = {
				nick = uv0:GetNick(),
				msgID = uv0.itemData_.msgID
			},
			parentRect = uv0.rectReportParent_,
			x = uv0:CalcOffsetX(),
			y = uv0:CalcOffsetY()
		})
	end)
end

function slot1.GetNick(slot0)
	return slot0.itemData_.nick
end

function slot1.SetText(slot0, slot1)
	if slot1.id == USER_ID then
		slot2 = PlayerData:GetPlayerInfo()
		slot0.textName_.text = slot2.nick
		slot0.imageIcon_.sprite = ItemTools.getItemSprite(slot2.portrait)
		slot0.imageFrame_.sprite = ItemTools.getItemSprite(slot2.icon_frame)
	else
		slot0.textName_.text = slot1.nick
		slot0.imageIcon_.sprite = getSpriteViaConfig("HeroLittleIcon", ItemCfg[slot1.icon].icon)
		slot0.imageFrame_.sprite = ItemTools.getItemSprite(slot1.iconFrame)
	end
end

function slot1.SetData(slot0, slot1, slot2)
	slot0.itemData_ = slot1
	slot0.index_ = slot2

	slot0:SetText(slot1)
	slot0:Show(true)

	if slot1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT then
		slot0.textContent_.text = slot1.content

		SetActive(slot0.goImage_, false)
		SetActive(slot0.goContent_, true)
		slot0:Adaption()
		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rectText_)

		slot0.imageBubble_.enabled = true
	else
		slot0.imageSticker_.sprite = getSpriteViaConfig("ChatSticker", ChatStickerCfg[tonumber(slot1.content)].icon .. SettingData:GetCurrentLanguageKey())

		SetActive(slot0.goImage_, true)
		SetActive(slot0.goContent_, false)

		slot0.imageBubble_.enabled = false
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rectBg_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rectContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rectGo_)
	slot0:SetIP(slot1)
end

function slot1.SetIP(slot0, slot1)
	if not slot0.ipGo_ then
		return
	end

	slot0.ip_.text = slot1.ip

	SetActive(slot0.ipGo_, GameToSDK.CURRENT_SERVER == AreaConst.CHINA)

	if slot0.gameObject_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.ipGo_.transform)
	end
end

function slot1.Adaption(slot0)
	slot0.rectText_.sizeDelta = Vector2(uv0.contentMaxWidth, uv0.bgExtendHeight)

	if uv0.contentMaxWidth < slot0.textContent_.preferredWidth then
		slot0.contentSizeFitter_.horizontalFit = ContentSizeFitter.FitMode.Unconstrained
	else
		slot0.contentSizeFitter_.horizontalFit = ContentSizeFitter.FitMode.PreferredSize
	end

	slot0.contentSizeFitter_.verticalFit = ContentSizeFitter.FitMode.PreferredSize
	slot1.sizeDelta = Vector2(uv0.contentMaxWidth, slot1.sizeDelta.y)
end

function slot1.SetAsLastSibling(slot0)
	slot0.transform_:SetAsLastSibling()
end

function slot1.SetAsFirstSibling(slot0)
	slot0.transform_:SetAsFirstSibling()
end

function slot1.Show(slot0, slot1)
	if slot0.gameObject_.activeSelf == false and slot1 == true then
		manager.notify:Invoke(CHAT_REPORT_HIDE)
	end

	SetActive(slot0.gameObject_, slot1)
end

function slot1.CalcOffsetX(slot0)
	return slot0.rectReportParent_:InverseTransformPoint(slot0.rectBg_:TransformPoint(Vector3(slot0.rectBg_.rect.width / 2, 0, 0))).x
end

function slot1.CalcOffsetY(slot0)
	if slot0.rectReportParent_:InverseTransformPoint(slot0.rectScrollView_:TransformPoint(Vector3.zero)).y < slot0.rectReportParent_.rect.height / 2 then
		return slot1.y + slot2 - slot0.rectReportParent_:TransformPoint(Vector3(0, slot1.y + slot2, 0)).y - 20
	else
		return 0
	end
end

return slot1
