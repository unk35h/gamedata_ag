slot0 = class("ObtainSkinView", ObtainBaseView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2)
	slot0.transform_ = slot0.gameObject_.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	uv0.super.Init(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.AdaptImg_ = slot0:FindCom("AdaptImage", nil, slot0.portrait_.transform)
end

function slot0.SetInfo(slot0, slot1)
	if not SkinCfg[slot1] then
		return
	end

	slot0.portrait_.sprite = AssetEx.LoadSprite("Textures/Character/Portrait/" .. slot1)

	slot0.AdaptImg_:AdaptImg()

	slot0.name_.text = slot2.name
end

function slot0.GetTimeLineEndTime(slot0)
	return 6.27
end

function slot0.Hide(slot0)
	uv0.super.Hide(slot0)

	slot0.portrait_.sprite = nil
end

return slot0
