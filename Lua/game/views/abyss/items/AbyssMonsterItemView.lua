slot0 = class("AbyssMonsterItemView", ReduxView)

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
		if uv0.clickListener_ ~= nil then
			uv0.clickListener_()
		end
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.monsterId_ = slot2
	slot0.abyssUICfg_ = AbyssUICfg[slot2]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.bossImg_.sprite = getSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. slot0.monsterId_)

	if slot0.abyssUICfg_ ~= nil then
		if slot0.abyssUICfg_.icon_pos ~= nil and slot0.abyssUICfg_.icon_pos ~= "" and #slot0.abyssUICfg_.icon_pos > 0 then
			slot0.bossImg_.transform.anchoredPosition = Vector3(slot0.abyssUICfg_.icon_pos[1], slot0.abyssUICfg_.icon_pos[2], slot0.abyssUICfg_.icon_pos[3])
		end

		if slot0.abyssUICfg_.icon_scale ~= nil and slot0.abyssUICfg_.icon_scale ~= "" and #slot0.abyssUICfg_.icon_scale > 0 then
			slot0.bossImg_.transform.localScale = Vector3(slot0.abyssUICfg_.icon_scale[1], slot0.abyssUICfg_.icon_scale[2], slot0.abyssUICfg_.icon_scale[3])
		end

		if slot0.abyssUICfg_.icon_rot ~= nil and slot0.abyssUICfg_.icon_rot ~= "" and #slot0.abyssUICfg_.icon_rot > 0 then
			slot0.bossImg_.transform.localEulerAngles = Vector3(slot0.abyssUICfg_.icon_rot[1], slot0.abyssUICfg_.icon_rot[2], slot0.abyssUICfg_.icon_rot[3])
		end
	end
end

function slot0.RegisterClickListener(slot0, slot1)
	slot0.clickListener_ = slot1
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0.data_ = nil
	slot0.clickListener_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
