slot0 = class("MailTextItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.onResize_ = slot2

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0.richText_ = slot0:FindCom("RichText", "")
end

function slot0.AddListeners(slot0)
	slot1 = slot0.richText_

	slot1:AddListener(function (slot0, slot1)
		if slot0 == "1" then
			Application.OpenURL(slot1)
		elseif slot0 == "2" then
			slot3 = {}

			for slot7, slot8 in ipairs(string.split(slot1, ",")) do
				table.insert(slot3, tonumber(slot8) or slot8)
			end

			JumpTools.JumpToPage2(slot3)
		end
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.richText_:RemoveAllListeners()
end

function slot0.SetData(slot0, slot1)
	slot0.data_ = slot1

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.richText_.text = string.gsub(slot0.data_.text, "\\n", "\n")

	slot0.transform_:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, slot0:GetTextHeight())
	SetActive(slot0.gameObject_, true)

	if slot0.onResize_ ~= nil then
		slot0.onResize_()
	end
end

function slot0.GetTextHeight(slot0)
	slot2 = slot0.gameObject_:GetComponent(typeof(Text))

	return slot2.cachedTextGenerator:GetPreferredHeight(slot2.text, slot2:GetGenerationSettings(slot0.transform_.rect.size)) * 1 / slot2.pixelsPerUnit
end

function slot0.GetHeight(slot0)
	return slot0:GetTextHeight()
end

return slot0
