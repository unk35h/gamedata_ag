slot0 = class("PolyhedronOverArtifactItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickFunc then
			slot1 = PolyhedronArtifactCfg[uv0.id].affix_id
			slot4 = uv0.transform_.position

			uv0.clickFunc(getAffixName({
				slot1,
				uv0.level
			}), getAffixDesc({
				slot1,
				uv0.level
			}), Vector3(-0.9, slot4.y + 0.1, slot4.z), uv0.level)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.id = slot1.id
	slot0.level = slot1.level
	slot0.icon_.sprite = getSpriteWithoutAtlas(PolyhedronConst.ARTIFACT_ICON_PATH .. PolyhedronArtifactCfg[slot0.id].icon)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
