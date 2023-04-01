slot0 = class("RecallSystemRecallNumberInfoItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddBtnListener(slot0.copyBrn_, nil, function ()
		ShowTips("COPY_SUCCESS")

		UnityEngine.GUIUtility.systemCopyBuffer = uv0.data.user_id
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.data = slot1

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.recallNameTxt_.text = slot0.data.nick
	slot0.recallUIDTxt_.text = slot0.data.user_id
	slot0.recallHeadshotImg_.sprite = ItemTools.getItemSprite(slot0.data.icon)

	slot0.recallHeadshotImg_:SetNativeSize()
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
