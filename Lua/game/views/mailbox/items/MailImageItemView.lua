slot0 = class("MailImageItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.onResize_ = slot2

	slot0:InitUI()
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0.bg_ = slot0:FindCom(typeof(Image), "")
	slot0.richText_ = slot0:FindCom("RichText", "RichText")
	slot0.btn_ = slot0:FindCom(typeof(Button), "")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.data_.event_type > 0 then
			if uv0.data_.event_type == 1 and uv0.data_.event_arg ~= "" then
				Application.OpenURL(uv0.data_.event_arg)
			elseif slot0 == 2 and uv0.data_.event_arg ~= "" then
				slot2 = {}

				for slot6, slot7 in ipairs(string.split(uv0.data_.event_arg, ",")) do
					table.insert(slot2, tonumber(slot7) or slot7)
				end

				JumpTools.JumpToPage2(slot2)
			end
		end
	end)

	slot1 = slot0.richText_

	slot1:AddListener(function (slot0, slot1)
		if slot0 == 1 then
			Application.OpenURL(slot1)
		elseif slot0 == 2 then
			slot3 = {}

			for slot7, slot8 in ipairs(string.split(slot1, ",")) do
				table.insert(slot3, tonumber(slot8) or slot8)
			end

			JumpTools.JumpToPage2(slot3)
		end
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.btn_.onClick:RemoveAllListeners()
	slot0.richText_:RemoveAllListeners()
end

function slot0.SetData(slot0, slot1)
	slot0.data_ = slot1

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if slot0.data_.text then
		slot0.richText_.text = slot1
	end

	SetForceShowQuanquan(true)
	slot0:GetImageByUrl(slot0.data_.image, function (slot0, slot1)
		SetForceShowQuanquan(false)

		if slot0 ~= uv0.data_.image then
			return
		end

		if uv0.gameObject_ == nil then
			return
		end

		uv0.bg_.sprite = slot1

		uv0.bg_:SetNativeSize()

		if uv0.onResize_ ~= nil then
			uv0.onResize_()
		end

		uv0:AddListeners()
	end)
	SetActive(slot0.gameObject_, true)
end

function slot0.GetImageByUrl(slot0, slot1, slot2)
	if string.find(slot1, "game://") then
		getSpriteWithoutAtlasAsync(string.gsub(slot1, "game://", ""), function (slot0)
			uv0(uv1, slot0)
		end)
	else
		slot3 = BulletinBoardMgr.inst

		slot3:GetSprite("mail", slot0.data_.image, function (slot0)
			uv0(uv1, slot0)
		end)
	end
end

function slot0.GetHeight(slot0)
	return slot0.bg_.transform.rect.height
end

return slot0
