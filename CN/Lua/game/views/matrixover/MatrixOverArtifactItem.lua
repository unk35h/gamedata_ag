slot0 = class("MatrixOverArtifactItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.id and uv0.id ~= 0 then
			slot0 = uv0.transform_.position

			manager.matrixPop:ShowMatrixPopItem(uv0.id, Vector3(-1, slot0.y + 0.1, slot0.z), uv0.level)
		end
	end)
end

function slot0.Refresh(slot0, slot1)
	slot0.id = slot1.id
	slot2 = slot1.wins
	slot0.level = nil

	if MatrixConst.EFFECT_ACTION.AFFIX == MatrixEffectCfg[MatrixItemCfg[slot1.id].params[1]].action and AffixTypeCfg[slot5.params[1]].max_level ~= 1 then
		slot0.level = math.min(slot2, slot8.max_level)
	end

	slot0.icon_.sprite = MatrixTools.GetMatrixItemSprite(slot1.id)
end

return slot0
