slot0 = class("BulletinImageItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:SetViewProp("bulletinID", slot2)
	slot0:SetViewProp("contentIndex", slot3)
	slot0:InitUI()
	slot0:RefreshUI()
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
		if uv0:GetContent(uv0:GetViewProp("bulletinID"), uv0:GetViewProp("contentIndex")).event then
			if slot0.event[1] == 1 and slot0.event[2] ~= "" then
				Application.OpenURL(slot0.event[2])
			elseif slot1 == 2 and slot0.event[2] ~= "" then
				slot3 = {}

				for slot7, slot8 in ipairs(string.split(slot0.event[2], ",")) do
					table.insert(slot3, tonumber(slot8) or slot8)
				end

				JumpTools.JumpToPage2(slot3)
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

function slot0.RefreshUI(slot0)
	if slot0:GetContent(slot0:GetViewProp("bulletinID"), slot0:GetViewProp("contentIndex")).text then
		slot0.richText_.text = slot2
	end

	SetForceShowQuanquan(true)
	slot0:GetImageByUrl(slot1.spriteUrl, function (slot0, slot1)
		SetForceShowQuanquan(false)

		if slot0 ~= uv0.spriteUrl then
			return
		end

		if uv1.gameObject_ == nil then
			return
		end

		uv1.bg_.sprite = slot1

		uv1.bg_:SetNativeSize()
		uv1:AddListeners()
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

		slot3:GetSprite(slot0:GetViewProp("bulletinID"), slot1, function (slot0)
			uv0(uv1, slot0)
		end)
	end
end

function slot0.GetContent(slot0, slot1, slot2)
	for slot6, slot7 in pairs(BulletinData.GetBulletinPageList()) do
		if slot7.id == slot1 then
			return slot7.content[slot2]
		end
	end
end

return slot0
