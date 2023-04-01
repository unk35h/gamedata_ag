slot0 = class("MatrixItemInfoView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/Matrix/Main/MatrixItemInfo"), slot1)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:initUI()
	slot0:AddUIListener()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
end

function slot0.Refresh(slot0, slot1, slot2, slot3, slot4)
	if not MatrixItemCfg[slot1] then
		return
	end

	slot6 = ""
	slot7 = nil

	if slot3 then
		if slot4 then
			if ActivityTools.GetActivityType(activity_id) == ActivityTemplateConst.SUB_SINGLE_MATRIX then
				slot7 = ActivityMatrixData:GetHeroData(slot4, slot3)
			elseif slot8 == ActivityTemplateConst.STRATEGY_MATRIX then
				slot7 = StrategyMatrixData:GetHeroData(slot4, slot3)
			end
		else
			slot7 = MatrixData:GetHeroData(slot3)
		end
	end

	if slot5.matrix_item_type == MatrixConst.ITEM_TYPE.ASTROLABE and slot7 then
		for slot12 = 1, slot7:GetAstrolabeNum(slot5.params[1]) do
			slot6 = slot6 and slot6 .. GetI18NText(MatrixTools.GetMatrixItemDes(slot1, slot12)) .. "\n" or GetI18NText(MatrixTools.GetMatrixItemDes(slot1, slot12, slot4))
		end
	else
		slot6 = GetI18NText(MatrixTools.GetMatrixItemDes(slot1, slot2, slot4))
	end

	slot0:RefreshText(slot5.name, slot6, slot2)
end

function slot0.RefreshAffix(slot0, slot1)
	slot0:RefreshText(getAffixName(slot1), getAffixDesc(slot1))
end

function slot0.RefreshBeacon(slot0, slot1)
	slot2 = MatrixBeaconCfg[slot1]

	slot0:RefreshText(slot2.name, slot2.desc)
end

function slot0.RefreshText(slot0, slot1, slot2, slot3)
	print(slot1)
	print(slot2)

	slot0.m_name.text = GetI18NText(slot1)
	slot0.m_content.text = GetI18NText(slot2)

	if slot3 then
		slot0.m_levelText.text = slot3
	else
		slot0.m_levelText.text = ""
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.textTrs_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_contentTrs)

	if manager.ui.uiMain.transform.transform.rect.height / 2 < -manager.ui.uiMain.transform:InverseTransformPoint(slot0.m_bottom:TransformPoint(Vector3(0, 0, 0))).y then
		slot8 = slot0.transform_.localPosition
		slot0.transform_.localPosition = Vector3(slot8.x, slot8.y + -slot5.y - slot6, slot8.z)
	end
end

function slot0.SetPosition(slot0, slot1, slot2)
	slot0.transform_.localPosition = Vector3(slot1, slot2, 0)
end

function slot0.SetWorldPosition(slot0, slot1)
	slot0.transform_.position = slot1
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 then
		slot0.gameObject_.transform:SetAsLastSibling()
	end
end

function slot0.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
	uv0.super.Dispose(slot0)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
