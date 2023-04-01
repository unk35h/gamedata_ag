slot0 = class("MatrixRotationDiagramItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot3 = Object.Instantiate(slot1, slot2)
	slot0.gameObject_ = slot3
	slot0.transform_ = slot3.transform
	slot0.rectTransform_ = slot3:GetComponent(typeof(RectTransform))

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.campController = ControllerUtil.GetController(slot0.transform_, "camp")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.index = slot1

	slot0.campController:SetSelectedIndex(slot1 - 1)

	slot0.img = slot0["m_img" .. slot1]
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.SetPosId(slot0, slot1)
	slot0.posId = slot1
end

function slot0.GetPosId(slot0)
	return slot0.posId
end

function slot0.GetIndex(slot0)
	return slot0.index
end

function slot0.InitPosData(slot0, slot1)
	slot0.rectTransform_.anchoredPosition = slot1.pos
	slot0.m_container.transform.localScale = Vector2.one * slot1.scale
	slot0.img.color = slot1.color

	slot0.transform_:SetSiblingIndex(slot1.order)
end

function slot0.SetPosData(slot0, slot1)
	LeanTween.scale(slot0.m_container, Vector3.one * slot1.scale, 0.5):setEase(LeanTweenType.easeOutQuad)
	LeanTween.moveLocal(slot0.gameObject_, slot1.pos, 0.5):setEase(LeanTweenType.easeOutQuad)

	slot4 = slot0.img.color
	slot5 = slot1.color

	LeanTween.value(slot0.gameObject_, 0, 1, 0.5):setEase(LeanTweenType.easeOutQuad):setOnUpdate(LuaHelper.FloatAction(function (slot0)
		uv0.img.color = Color.Lerp(uv1, uv2, slot0)
	end))
	slot0.transform_:SetSiblingIndex(slot1.order)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
