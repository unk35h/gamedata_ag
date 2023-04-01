slot0 = class("LoginBulletinView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Common/NoticeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.richText_ = slot0:FindCom("RichText", "", slot0.richTextTrs_)
end

function slot0.AddListeners(slot0)
	slot1 = slot0.richText_

	slot1:AddListener(function (slot0, slot1)
		if slot0 == "1" then
			Application.OpenURL(slot1)
		end
	end)
	slot0:AddBtnListener(slot0.sureButton_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	if type(slot0.params_.content or "") ~= "string" then
		slot0.richText_.text = ""

		return
	end

	slot0.richText_.text = string.gsub(slot1, "< *a .-href *= *\"(.-)\".->(.-)< */a *>", function (slot0, slot1)
		return string.format("<material=underline h=2 event=1 args=%s>%s</material>", slot0 or "", slot1 or "")
	end)
end

return slot0
