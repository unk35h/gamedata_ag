slot0 = class("RegressionNewPage", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot3 = Object.Instantiate(Asset.Load("UI/ReturnUI/RegressionNewUI"), slot1)
	slot0.gameObject_ = slot3
	slot0.transform_ = slot3.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.Adapt(slot0)
	slot1 = slot0.m_contentTransform.rect.size
	slot2 = slot0.m_rectTransform.rect.size
	slot0.m_rectTransform.sizeDelta = Vector2.New(slot1.x, slot2.y * slot1.x / slot2.x)
end

function slot0.AddUIListener(slot0)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.SetData(slot0)
	slot1 = RegressionData

	SetForceShowQuanquan(true)
	slot0:GetImageByUrl(slot1:GetUrl(), function (slot0, slot1)
		SetForceShowQuanquan(false)

		if slot0 ~= uv0 then
			return
		end

		if uv1.gameObject_ == nil then
			return
		end

		uv1.m_bg.sprite = slot1

		uv1.m_bg:SetNativeSize()
		uv1:Adapt()
	end)
end

function slot0.GetImageByUrl(slot0, slot1, slot2)
	if string.find(slot1, "game://") then
		getSpriteWithoutAtlasAsync(string.gsub(slot1, "game://", ""), function (slot0)
			uv0(uv1, slot0)
		end)
	else
		slot3 = BulletinBoardMgr.inst

		slot3:GetSprite("mail", slot1, function (slot0)
			uv0(uv1, slot0)
		end)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
