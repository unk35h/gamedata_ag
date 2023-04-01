slot0 = class("ChessHome", ReduxView)

function slot0.UIName(slot0)
	return "UI/WarChess/WarChessMain"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.shipBtnController_ = ControllerUtil.GetController(slot0.testbuttonBtn_.transform, "name")
	slot0.shipHpCon_ = ControllerUtil.GetController(slot0.shipconTrs_, "shiphp")
	slot0.bannerCon_ = ControllerUtil.GetController(slot0.summerbalanceGo_.transform, "success")
	slot0.bugFixGo_ = GameObject.Find("6075_tpose(Clone)1")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_itemBtn_, nil, function ()
		uv0:Go("/chessBag")
	end)
	slot0:AddBtnListener(slot0.btn_menuBtn_, nil, function ()
		uv0:Go("chessMenu")
	end)
	slot0:AddBtnListener(slot0.btn_logBtn_, nil, function ()
		uv0:Go("chessLog")
	end)
	slot0:AddBtnListener(slot0.lookatBtn_, nil, function ()
		ChessLuaBridge.LookAtPlayer()
		SetActive(uv0.lookatBtn_.gameObject, false)
	end)
	slot0:AddBtnListener(slot0.skillBtn_, nil, function ()
		manager.ChessManager:FireBullet()
	end)

	slot1 = {
		30,
		90,
		150,
		210,
		270,
		330
	}

	slot0:AddBtnListener(slot0.testbuttonBtn_, nil, function ()
		if manager.ChessManager.forceBattle:IsForcingBattle() then
			ShowTips("ERROR_BOSS_RECOVERY_DETECTOR")

			return
		end

		if not manager.ChessManager.current:IsDetector() then
			if uv0.bugFixGo_ then
				slot0 = uv0.bugFixGo_.transform.localEulerAngles
				slot1 = 999
				slot2 = 0

				for slot6, slot7 in ipairs(uv1) do
					if math.abs(slot0.y - slot7) < math.abs(slot1) then
						slot1 = slot8
						slot2 = slot7
					end
				end

				if math.abs(slot1) > 7 then
					uv0.bugFixGo_.transform.localEulerAngles = Vector3(0, slot2, 0)
				end
			end

			slot0 = manager.ChessManager.current
			slot0 = slot0:LayDownOrUpShip(true, function ()
				uv0.shipBtnController_:SetSelectedState("2")
			end)
		else
			slot0 = manager.ChessManager.current
			slot0 = slot0:LayDownOrUpShip(false, function ()
				uv0.shipBtnController_:SetSelectedState("1")
			end)
		end
	end)
end

function slot0.OnEnter(slot0)
	manager.ui:SetMainCamera(WarchessLevelCfg[WarChessData:GetCurrentWarChessMapData().mapId].scene_id, true)
	manager.ChessManager:BattleFinish()
	manager.ChessManager.forceBattle:BattleFinish()
	slot0:RefreshUI()
	slot0:RefreshFireBtn(table.indexof(WarchessLevelCfg[WarChessData:GetCurrentWarChessMapData().mapId].extra_gameplay, ChessConst.GAME_PLAY.FIRE_BULLET) and true or false)
	slot0:RefreshShipUI(table.indexof(slot2, ChessConst.GAME_PLAY.SHIP) and true or false)

	if table.indexof(slot2, ChessConst.GAME_PLAY.SHIP) then
		SetActive(slot0.testbuttonBtn_.gameObject, true)

		if #WarChessData:GetDetectorPos() > 0 then
			slot0.shipBtnController_:SetSelectedState(2)
		else
			slot0.shipBtnController_:SetSelectedState(1)
		end
	else
		SetActive(slot0.testbuttonBtn_.gameObject, false)
	end
end

function slot0.OnExit(slot0)
end

function slot0.RefreshUI(slot0)
	slot0.topImg_.sprite = getSprite("Atlas/BattleFlag", WarchessLevelCfg[WarChessData:GetCurrentWarChessMapData().mapId].return_icon)
end

function slot0.RefreshFireBtn(slot0, slot1)
	slot2 = WarChessData:GetBulletNum()

	if slot1 then
		slot0.bulletnumText_.text = slot2

		if slot2 <= 0 then
			slot0.skillBtn_.interactable = false
		else
			slot0.skillBtn_.interactable = true
		end
	end

	SetActive(slot0.fireGo_, slot1)
end

function slot0.RefreshStepCountDown(slot0, slot1)
	slot2 = WarChessData:GetStepCountDownNum()

	if slot1 then
		slot0.stepcountdownText_.text = slot2
	end

	SetActive(slot0.stepcountdownGo_, slot1)
end

function slot0.RefreshShipUI(slot0, slot1)
	slot2 = WarChessData:GetShipHp()

	if slot1 then
		slot0.shiphpImg_.fillAmount = slot2 / 100
		slot0.hptextText_.text = slot2 .. "/100"

		if slot2 >= 75 then
			slot0.shipHpCon_:SetSelectedState("green")
		elseif slot2 >= 50 then
			slot0.shipHpCon_:SetSelectedState("yellow")
		elseif slot2 >= 25 then
			slot0.shipHpCon_:SetSelectedState("orange")
		else
			slot0.shipHpCon_:SetSelectedState("red")
		end
	end

	SetActive(slot0.shiphpGo_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.OnCameraMove(slot0, slot1)
	SetActive(slot0.lookatBtn_.gameObject, slot1)
end

function slot0.OnGetBullet(slot0)
	slot0:RefreshFireBtn(true)
end

function slot0.OnStepCountDown(slot0, slot1)
end

function slot0.OnShipHpChange(slot0)
	slot0:RefreshShipUI(true)
end

function slot0.OnShipDie(slot0)
	slot0.bannerCon_:SetSelectedState("false")
	SetActive(slot0.summerbalanceGo_, true)
end

function slot0.OnChessSuccess(slot0)
	slot0.bannerCon_:SetSelectedState("true")
	SetActive(slot0.summerbalanceGo_, true)
end

return slot0
