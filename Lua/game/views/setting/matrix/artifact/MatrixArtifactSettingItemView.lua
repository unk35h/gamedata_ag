slot0 = class("MatrixArtifactSettingItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
end

function slot0.SetData(slot0, slot1)
	slot0.name_.text = MatrixItemCfg[slot1].name
	slot0.desc_.text = MatrixTools.GetMatrixItemDes(slot1)
	slot0.icon_.sprite = MatrixTools.GetMatrixItemSprite(slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.icon_.sprite = nil

	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
