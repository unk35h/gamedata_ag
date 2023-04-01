slot0 = class("BlackPlayerInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Friends/AdminInfoPop_Blacklist"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.onLineController_ = ControllerUtil.GetController(slot0.goOnline_.transform, "online")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonCopy_, nil, function ()
		UnityEngine.GUIUtility.systemCopyBuffer = uv0.userID_

		ShowTips("COPY_SUCCESS")
	end)
	slot0:AddBtnListener(slot0.buttonDelete_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("BLACKLIST_REMOVE_QUEST"), uv0.data_.nick),
			OkCallback = function ()
				FriendsAction:TryToDelectFromBlackList(uv0.userID_, 2)
				uv0:Back()
			end
		})
	end)
	slot0:AddBtnListener(slot0.buttonReport_, nil, function ()
		JumpTools.OpenPageByJump("chatReport", {
			reportType = ChatConst.CHAT_REPORT_TYPE.USER,
			reportData = {
				nick = uv0.data_.nick,
				userID = uv0.data_.user_id
			}
		}, ViewConst.SYSTEM_ID.CHAT_REPORT)
	end)
end

function slot0.OnEnter(slot0)
	slot0.data_ = slot0.params_.data
	slot0.userID_ = slot0.data_.user_id

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.imageHead_.sprite = ItemTools.getItemSprite(slot0.data_.icon)

	slot0.imageHead_:SetNativeSize()

	slot0.data_.icon_frame = slot0.data_.icon_frame ~= 0 and slot0.data_.icon_frame or 2001
	slot0.iconFrame_.sprite = ItemTools.getItemSprite(slot0.data_.icon_frame)
	slot0.textName_.text = slot0.data_.nick
	slot0.textID_.text = slot0.data_.user_id
	slot0.textLevel_.text = slot0.data_.level
	slot0.ip_.text = slot0.data_.ip

	SetActive(slot0.ipGo_, GameToSDK.CURRENT_SERVER == AreaConst.CHINA)

	if slot0.gameObject_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.ipGo_.transform)
	end

	slot0.onLineController_:SetSelectedState(slot0.data_.online_state == 0 and "on" or "off")
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
