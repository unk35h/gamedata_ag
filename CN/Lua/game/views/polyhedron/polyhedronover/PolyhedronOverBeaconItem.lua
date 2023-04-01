slot0 = class("PolyhedronOverBeaconItem", ReduxView)

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
			slot0 = uv0.transform_.position
			slot1 = PolyhedronBeaconCfg[uv0.id]

			uv0.clickFunc(slot1.name, slot1.desc, Vector3(-0.9, slot0.y, slot0.z))
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.id = slot1
	slot0.icon_.sprite = getSpriteWithoutAtlas(PolyhedronConst.BEACON_ICON_PATH .. PolyhedronBeaconCfg[slot1].icon)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
