slot0 = class("WeaponServantRaceDropdownView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.selectingRace_ = false

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.raceItemList_ = {}
end

function slot0.SetRaceData(slot0, slot1, slot2)
	slot0.raceList_ = slot1
	slot0.raceCount_ = slot2
	slot0.selectRace_ = slot0.selectRace_ or 1

	slot0:UpdateView()
end

function slot0.SetCallback(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.UpdateView(slot0)
	slot0:UpdateRaceList()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.campBtn_, nil, function ()
		uv0:SwitchRaceSelect()
	end)
	slot0:AddBtnListener(slot0.mask_, nil, function ()
		uv0.selectingRace_ = false

		SetActive(uv0.viewGo_, uv0.selectingRace_)
	end)
end

function slot0.SwitchRaceSelect(slot0)
	if slot0.selectingRace_ then
		slot0.selectingRace_ = false
	else
		slot0.selectingRace_ = true
	end

	SetActive(slot0.viewGo_, slot0.selectingRace_)

	if slot0.selectingRace_ then
		slot0:UpdateRaceList()
	end
end

function slot0.UpdateRaceList(slot0)
	for slot5 = 1, #slot0.raceList_ + 1 do
		if not slot0.raceItemList_[slot5] then
			slot0.raceItemList_[slot5] = WeaponServantRaceItem.New(Object.Instantiate(slot0.raceGo_, slot0.raceListContainer_), slot5)
			slot7 = slot0.raceItemList_[slot5]

			slot7:AddClickListener(function (slot0, slot1, slot2)
				uv0:OnSelectRace(slot0, slot1)
			end)
		end

		slot6 = slot5 == 1 and 0 or slot0.raceList_[slot5 - 1]

		slot0.raceItemList_[slot5]:SetRace(slot6, slot0.raceCount_[slot6])
		slot0.raceItemList_[slot5]:SetSelState(slot0.selectRace_ == slot5)
	end

	while slot1 < #slot0.raceItemList_ do
		slot0.raceItemList_[#slot0.raceItemList_]:Dispose()
		table.remove(slot0.raceItemList_, #slot0.raceItemList_)
	end
end

function slot0.OnSelectRace(slot0, slot1, slot2)
	slot0.selectRace_ = slot1

	slot0:SwitchRaceSelect()

	if slot1 == 1 then
		OperationRecorder.Record("WeaponServantRaceDropdownView", "all")
	else
		OperationRecorder.Record("WeaponServantRaceDropdownView", "one")
	end

	slot0.currentText_.text = slot0.raceItemList_[slot1]:GetName()
	slot0.iconImg_.sprite = slot0.raceItemList_[slot1]:GetSprite()

	if slot0.callback_ ~= nil then
		slot0.callback_(slot2, slot1)
	end
end

function slot0.SelectRaceWithoutCallback(slot0, slot1)
	slot0.selectRace_ = slot1
	slot0.currentText_.text = slot0.raceItemList_[slot1]:GetName()
	slot0.iconImg_.sprite = slot0.raceItemList_[slot1]:GetSprite()
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Reset(slot0)
	slot0.selectRace_ = 1
	slot0.selectingRace_ = false

	SetActive(slot0.viewGo_, slot0.selectingRace_)

	slot0.currentText_.text = TipsCfg[TipsCfg.get_id_list_by_define.ALL].desc
	slot0.iconImg_.sprite = slot0.raceItemList_[1]:GetSprite()
end

function slot0.Dispose(slot0)
	if slot0.raceItemList_ then
		for slot4, slot5 in ipairs(slot0.raceItemList_) do
			slot5:Dispose()
		end

		slot0.raceItemList_ = nil
	end

	slot0.callback_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
