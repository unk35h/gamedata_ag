slot0 = class("LetterPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Mailbox/LetterPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.letterId_ = slot0.params_.letterId

	slot0:RefreshView()
end

function slot0.RefreshView(slot0)
	slot1 = MailSpecialLetterCfg[slot0.letterId_]
	slot0.titleText_.text = slot1.letter_title
	slot0.roleImage_.sprite = ItemTools.getItemSprite(slot1.letter_sender_face)
	slot0.contentText_.text = slot1.letter_desc
	slot0.nameText_.text = slot1.letter_sender
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
