slot0 = class("HeroDisplayExpressionItemView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.AddListeners(slot0)
	slot0:AddToggleListener(slot0.slider_, function (slot0)
		uv0.skinMesh_:SetBlendShapeWeight(uv0.index_, slot0)
		HeroDisplayData:SetCacheExpressionParams(uv0.index_ + 1, slot0)
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.skinMesh_ = slot1
	slot0.index_ = slot2 - 1
	slot4 = HeroSkinMeshCfg[slot3]
	slot0.textName_.text = slot4.name
	slot0.textLeft_.text = slot4.leftName
	slot0.textRight_.text = slot4.rightName

	slot0:Show(true)
end

function slot0.SetValue(slot0, slot1)
	slot0.slider_.value = slot1

	slot0.skinMesh_:SetBlendShapeWeight(slot0.index_, slot1)
	HeroDisplayData:SetCacheExpressionParams(slot0.index_ + 1, slot1)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
