slot0 = class("StickerView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot0.gameObject_.transform
	slot0.id_ = slot3

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.btn_ = {}
	slot0.img_ = {}
	slot0.sizeCon_ = {}
	slot0.stateCon_ = {}
	slot0.cfg_ = StickViewTemplateCfg[slot0.id_]

	for slot4, slot5 in ipairs(slot0.cfg_.range_list) do
		slot0.btn_[slot4] = slot0["btn_" .. slot4]
		slot0.sizeCon_[slot4] = ControllerUtil.GetController(slot0.btn_[slot4].transform, "size")
		slot9 = slot0.btn_[slot4].transform
		slot0.stateCon_[slot4] = ControllerUtil.GetController(slot9, "state")
		slot0.img_[slot4] = {}

		for slot9 = 1, 3 do
			slot0.img_[slot4][slot9] = slot0["img_" .. slot4 .. "_" .. slot9]
		end
	end
end

function slot0.AddUIListeners(slot0)
	for slot4, slot5 in ipairs(slot0.btn_) do
		slot0:AddBtnListener(slot5, nil, function ()
			if uv0.clickFunc_ then
				uv0.clickFunc_(uv0.info_[uv1], uv1)
			end
		end)
	end
end

function slot0.SetData(slot0, slot1)
	slot0.info_ = slot1
end

function slot0.RefreshUI(slot0, slot1)
	slot2 = true
	slot0.isEditor_ = slot1

	for slot6, slot7 in ipairs(slot0.cfg_.range_list) do
		if slot0.cfg_.range_list[slot6][2][1] < slot0.info_[slot6].size then
			slot8.size = slot0.cfg_.range_list[slot6][2][1]
		end

		slot0.sizeCon_[slot6]:SetSelectedState(slot8.size)
		slot0.stateCon_[slot6]:SetSelectedState(slot8.stickerID > 0 and "active" or "add")
		SetActive(slot0.btn_[slot6].gameObject, slot0.isEditor_ or slot8.stickerID > 0)

		if slot8.stickerID > 0 then
			slot2 = false
			slot0.img_[slot6][slot8.size].sprite = ItemTools.getItemSprite(slot8.stickerID, {
				size = slot8.size
			})

			slot0.img_[slot6][slot8.size]:SetNativeSize()
		end
	end

	SetActive(slot0.nothingGo_, not slot0.isEditor_ and slot2)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.RegistClickFunc(slot0, slot1)
	slot0.clickFunc_ = slot1
end

function slot0.OnExit(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
