return {
	Routes = {
		{
			name = "blank",
			component = BlankView
		},
		{
			name = "login",
			precedenceMerge = true,
			component = LoginView
		},
		{
			name = "loginBulletinView",
			component = LoginBulletinView
		},
		{
			name = "banAccount",
			component = BanAccountView
		},
		{
			name = "awakeName",
			component = AwakeNameView
		},
		{
			name = "activityAdvertise",
			component = ActivityAdvertiseView
		},
		{
			name = "home",
			precedenceMerge = true,
			component = MainHomeView,
			children = {
				{
					name = "gm",
					component = GMView
				},
				{
					name = "heroInteractionGM",
					component = HeroInteractionGMView
				},
				{
					name = "heroInteractionGMContent",
					component = HeroInteractionGMContentView
				},
				{
					name = "sign",
					component = SignView
				},
				{
					name = "setting",
					component = SettingView,
					children = {
						{
							name = "pic",
							component = SettingPicView
						},
						{
							name = "sound",
							component = SettingSoundView
						},
						{
							name = "push",
							component = SettingPushView
						},
						{
							name = "game",
							component = SettingGameView
						},
						{
							name = "battleUIAdjust",
							component = BattleUIAdjustView
						}
					}
				}
			}
		},
		{
			name = "menuPop",
			component = MenuPopView
		},
		{
			name = "reward",
			component = RewardView
		},
		{
			name = "switchHeroReward",
			component = SwitchHeroRewardView
		},
		{
			name = "getSkin",
			component = GetSkinView
		},
		{
			name = "heroSkin",
			component = NewHeroSkinView
		},
		{
			name = "skinBuyCheck",
			component = SkinBuyCheckView
		},
		{
			name = "heroSkinPreview",
			component = NewHeroSkinPreview
		},
		{
			name = "shop",
			component = NewShopView
		},
		{
			name = "shopBuy",
			component = ShopBuyView
		},
		{
			name = "astrolabeAdjust",
			component = AstrolabeAdjustView
		},
		{
			name = "newHero",
			component = NewHeroView
		},
		{
			name = "newBreak",
			component = NewHeroBreakView
		},
		{
			name = "newBreakPreview",
			component = NewHeroBreakPreviewView
		},
		{
			name = "newBreakSuccess",
			component = NewHeroBreakSuccessView
		},
		{
			name = "heroArchive",
			component = HeroArchiveView
		},
		{
			name = "heroStory",
			component = HeroStoryView
		},
		{
			name = "newAddExp",
			component = NewHeroAddExpView
		},
		{
			name = "newHeroUpgradeSuccess",
			component = NewHeroUpgradeSuccessView
		},
		{
			name = "starUpSuccess",
			component = StarUpSuccessView
		},
		{
			name = "heroShow",
			component = HeroShowView
		},
		{
			name = "heroSurpass",
			component = HeroSurpassView
		},
		{
			name = "heroSurpassStarUp",
			component = HeroSurpassStarUpView
		},
		{
			name = "heroSurpassPhaseUp",
			component = HeroSurpassPhaseUpView
		},
		{
			name = "materialPreview",
			component = MaterialPreview
		},
		{
			name = "heroRaceDetails",
			component = HeroRaceDetailsView
		},
		{
			name = "heroAttribute",
			component = HeroAttributeView
		},
		{
			name = "heroCommonAttribute",
			component = HeroCommonAttributeView
		},
		{
			name = "heroEquipBag",
			component = HeroEquipBagView
		},
		{
			name = "equipSwap",
			component = EquipSwapView
		},
		{
			name = "equipDecompose",
			component = EquipDecomposeView
		},
		{
			name = "equipSkill",
			component = EquipSkillView
		},
		{
			name = "equipHeroSkillUI",
			component = EquipHeroSkillView
		},
		{
			name = "heropreview",
			component = HeroPreView,
			children = {
				{
					name = "currencyBuyGold",
					component = CurrencyBuyGoldView
				},
				{
					name = "rechargeDiamondExchange",
					component = RechargeDiamondExchangeView
				},
				{
					name = "rechargeTotalRecharge",
					component = RechargeTotalRechargeView
				},
				{
					name = "currencyBuyFatigue",
					component = CurrencyBuyFatigueView
				},
				{
					name = "diamondExchange",
					component = DiamondExchangeView
				},
				{
					name = "fragmentExchange",
					component = FragmentExchangeView
				},
				{
					name = "totalRecharge",
					component = TotalRechargeView
				},
				{
					name = "itemBuy",
					component = ItemBuyView
				}
			}
		},
		{
			name = "skillUpgrade",
			component = HeroSkillUpgradeView
		},
		{
			name = "chapterMap",
			component = ChapterMapView
		},
		{
			name = "chapterSection",
			ignoreMerge = true,
			component = ChapterSectionView
		},
		{
			name = "chapterSectionReward",
			component = ChapterSectionRewardView
		},
		{
			name = "chapterStageArchiveInfo",
			component = ChapterStageArchiveInfoView
		},
		{
			name = "chapterSectionInfo",
			component = ChapterSectionInfoView
		},
		{
			name = "chapterVariantBase",
			component = ChapterVariantBaseView
		},
		{
			name = "subPlotSectionInfo",
			component = SubPlotSectionInfoView
		},
		{
			name = "dailySectionInfo",
			component = DailySectionInfoView
		},
		{
			name = "challengeSectionInfo",
			component = ChallengeSectionInfoView
		},
		{
			name = "mythicSectionInfo",
			component = MythicSectionInfoView
		},
		{
			name = "teachSectionInfo",
			component = TeachSectionInfoView
		},
		{
			name = "equipSectionInfo",
			component = EquipSectionInfoView
		},
		{
			name = "gameHelp",
			component = GameHelpView
		},
		{
			name = "gameHelpPro",
			component = GameHelpProView
		},
		{
			name = "storyKipView",
			component = StoryKipView
		},
		{
			name = "affixBox",
			component = AffixBoxView
		},
		{
			name = "suitSelect",
			component = SuitSelectView
		},
		{
			name = "damageTestMode",
			component = DamageTestModeView
		},
		{
			name = "damageTestBossSwitch",
			component = DamageTestBossSwitchView
		},
		{
			name = "damageTestBossInfo",
			component = DamageTestBossInfoView
		},
		{
			name = "bossCombatSelect",
			component = BossCombatSelectView
		},
		{
			name = "bossMode",
			component = BossChallengeModeView
		},
		{
			name = "bossMode",
			component = BossChallengeModeView
		},
		{
			name = "bossSwitch",
			ignoreMerge = true,
			component = BossSwitchView
		},
		{
			name = "bossAdvanceSwitch",
			ignoreMerge = true,
			component = BossAdvanceSwitchView
		},
		{
			name = "bossChallenge",
			component = BattleBossChallengeView
		},
		{
			name = "bossAdvanceInfo",
			component = BattleBossAdvanceInfoView
		},
		{
			name = "bossStarExchange",
			component = BossStarExchangeView
		},
		{
			name = "bossAdvanceTarget",
			component = BossAdvanceTargetView
		},
		{
			name = "bossAdvanceReward",
			component = BattleBossAdvanceRewardView
		},
		{
			name = "bossAdvanceTarget",
			component = BossAdvanceTargetView
		},
		{
			name = "bossAdvanceReward",
			component = BattleBossAdvanceRewardView
		},
		{
			name = "sectionSelectHeroBoss",
			component = SectionSelectHeroBossChallengeView
		},
		{
			name = "heroTeamInfoBoss",
			component = HeroTeamInfoBossView
		},
		{
			name = "battleBossChallengeResult",
			component = BattleBossResultView
		},
		{
			name = "battlefailedBossChallenge",
			component = BattleFailedBossChallengeView
		},
		{
			name = "teachStage",
			ignoreMerge = true,
			component = TeachStageView
		},
		{
			name = "sectionSelectHeroTeach",
			component = SectionSelectHeroTeachView
		},
		{
			name = "enchantment",
			ignoreMerge = true,
			component = EnchantmentInfoView
		},
		{
			name = "daily",
			ignoreMerge = true,
			component = DailyView
		},
		{
			name = "resourceHeroBreak",
			ignoreMerge = true,
			component = ResourceHeroBreakStageView
		},
		{
			name = "warChessStage",
			component = WarChessStageView
		},
		{
			name = "chessMenu",
			component = ChessMenu
		},
		{
			name = "chessLog",
			component = ChessLog
		},
		{
			name = "equipSection",
			ignoreMerge = true,
			component = EquipSectionView
		},
		{
			name = "challenge",
			ignoreMerge = true,
			component = ChallengeView
		},
		{
			name = "sectionSelectHero",
			component = SectionSelectHeroBaseView
		},
		{
			name = "sectionSelectHeroMythicView",
			component = SectionSelectHeroMythicView
		},
		{
			name = "heroTeamInfo",
			component = HeroTeamInfoBaseView
		},
		{
			name = "battleMultipleResult",
			component = BattleMultipleResultView
		},
		{
			name = "battleStatistics",
			component = BattleStatisticsView
		},
		{
			name = "battleScorResult",
			component = BattleScoreResultView
		},
		{
			name = "battleVolumeRaceTrailScoreResult",
			component = BattleVolumeRaceTrailScoreResultView
		},
		{
			name = "battleActivityWorldBossResult",
			component = BattleActivityWorldBossResultView
		},
		{
			name = "sectionSelectHeroMatrix",
			component = SectionSelectHeroMatrixView
		},
		{
			name = "chipMatrixManager",
			component = ChipManagerMatrixView
		},
		{
			name = "chipMatrixInfo",
			component = ChipInfoMatrixView
		},
		{
			name = "comboSkillSelectMatrix",
			component = ComboSkillSelectMatrixView
		},
		{
			name = "battleMatrixResult",
			component = BattleMatrixResultView
		},
		{
			name = "reservesComboSkillSelect",
			component = ReservesComboSkillSelectView
		},
		{
			name = "battleActivityMatrixResult",
			component = BattleActivityMatrixResultView
		},
		{
			name = "battleStatisticsMatrix",
			component = BattleStatisticsMatrixView
		},
		{
			name = "matrixOver",
			component = MatrixOverView
		},
		{
			name = "battleStatisticsMatrixOver",
			component = BattleStatisticsMatrixOverView
		},
		{
			name = "matrixOverEvaluate",
			component = MatrixOverEvaluateView
		},
		{
			name = "battleMatrixFailed",
			component = BattleMatrixFailedView
		},
		{
			name = "matrixScoreExchange",
			component = MatrixScoreExchangeView
		},
		{
			name = "matrixScoreExchangeMini",
			component = MatrixScoreExchangeMiniView
		},
		{
			name = "matrixPrepare",
			component = MatrixPrepareView
		},
		{
			name = "matrixSelect",
			component = MatrixSelectView
		},
		{
			name = "matrixBlank",
			component = BlankView
		},
		{
			name = "matrixHero",
			component = MatrixHeroView
		},
		{
			name = "matrixMiniHero",
			component = MatrixMiniHeroView
		},
		{
			name = "matrixAstrolabeAdjust",
			component = MatrixAstrolabeAdjustView
		},
		{
			name = "matrixSkillUpgrade",
			component = MatrixHeroSkillUpgradeView
		},
		{
			name = "matrixComboSkillInfo",
			component = MatrixComboSkillInfoView
		},
		{
			name = "matrixOrigin",
			component = MatrixOriginView
		},
		{
			name = "matrixTerminalTalent",
			component = MatrixTerminalTalentView
		},
		{
			name = "matrixTerminalLevel",
			component = MatrixTerminalLevelView
		},
		{
			name = "matrixTerminalLevelUpgrade",
			component = MatrixTerminalLevelUpgradeView
		},
		{
			name = "matrixTerminalTalentPreview",
			component = MatrixTerminalTalentPreviewView
		},
		{
			name = "matrixTerminalTalentMini",
			component = MatrixTerminalTalentMiniView
		},
		{
			name = "matrixSelectAffix",
			component = MatrixSelectAffixView
		},
		{
			name = "matrixAffixMini",
			component = MatrixAffixMiniView
		},
		{
			name = "matrixTreasureAtlas",
			component = MatrixTreasureAtlasView
		},
		{
			name = "matrixBeaconOperate",
			component = MatrixBeaconOperateView
		},
		{
			name = "matrixBeaconMini",
			component = MatrixBeaconMiniView
		},
		{
			name = "matrixProcess",
			component = MatrixProcessView
		},
		{
			name = "matrixProcessSelectHero",
			component = MatrixProcessSelectHeroView
		},
		{
			name = "matrixProcessAstrolabeReplace",
			component = MatrixProcessAstrolabeReplaceView
		},
		{
			name = "matrixProcessEquipReplace",
			component = MatrixProcessEquipReplaceView
		},
		{
			name = "matrixProcessWeaponReplace",
			component = MatrixProcessWeaponReplaceView
		},
		{
			name = "matrixProcessShop",
			component = MatrixProcessShopView
		},
		{
			name = "matrixProcessShopSelectHero",
			component = MatrixProcessShopSelectHeroView
		},
		{
			name = "matrixTreasureMini",
			component = MatrixTreasureMiniView
		},
		{
			name = "matrixRank",
			component = MatrixRankView
		},
		{
			name = "activityMatrixOrigin",
			component = ActivityMatrixOriginView
		},
		{
			name = "activityMatrixProcess",
			component = ActivityMatrixProcessView
		},
		{
			name = "activityMatrixProcessSelectHero",
			component = ActivityMatrixProcessSelectHeroView
		},
		{
			name = "activityMatrixProcessShopSelectHero",
			component = ActivityMatrixProcessShopSelectHeroView
		},
		{
			name = "activityMatrixProcessShop",
			component = ActivityMatrixProcessShopView
		},
		{
			name = "activityMatrixProcessAstrolabeReplace",
			component = ActivityMatrixProcessAstrolabeReplaceView
		},
		{
			name = "activityMatrixProcessEquipReplace",
			component = ActivityMatrixProcessEquipReplaceView
		},
		{
			name = "activityMatrixProcessWeaponReplace",
			component = ActivityMatrixProcessWeaponReplaceView
		},
		{
			name = "activityMatrixMiniHero",
			component = ActivityMatrixMiniHeroView
		},
		{
			name = "activityMatrixTreasureMini",
			component = ActivityMatrixTreasureMiniView
		},
		{
			name = "activityMatrixTreasureMini",
			component = ActivityMatrixTreasureMiniView
		},
		{
			name = "activityMatrixAffixMini",
			component = ActivityMatrixAffixMiniView
		},
		{
			name = "activityMatrixScoreExchangeMini",
			component = ActivityMatrixScoreExchangeMiniView
		},
		{
			name = "activityMatrixScoreExchange",
			component = ActivityMatrixScoreExchangeView
		},
		{
			name = "activityMatrixOver",
			component = ActivityMatrixOverView
		},
		{
			name = "battleStatisticsActivityMatrixOver",
			component = BattleStatisticsActivityMatrixOverView
		},
		{
			name = "activityMatrixAstrolabeAdjust",
			component = ActivityMatrixAstrolabeAdjustView
		},
		{
			name = "activityMatrixComboSkillInfo",
			component = ActivityMatrixComboSkillInfoView
		},
		{
			name = "activityMatrix",
			component = ActivityMatrixView
		},
		{
			name = "activityMatrixSelectHero",
			component = ActivityMatrixSelectHeroView
		},
		{
			name = "activityMatrixSelectAffix",
			component = ActivityMatrixSelectAffixView
		},
		{
			name = "sectionSelectHeroActivityMatrix",
			component = SectionSelectHeroActivityMatrixView
		},
		{
			name = "activityMatrixStoryReview",
			component = ActivityMatrixStoryReviewView
		},
		{
			name = "activityMatrixClue",
			component = ActivityMatrixClueView
		},
		{
			name = "activityMatrixRank",
			component = ActivityMatrixRankView
		},
		{
			name = "strategyMatrixHero",
			component = StrategyMatrixHeroView
		},
		{
			name = "strategyMatrixAstrolabeAdjust",
			component = StrategyMatrixAstrolabeAdjustView
		},
		{
			name = "strategyMatrixIncident",
			component = StrategyMatrixIncidentView
		},
		{
			name = "strategyMatrixProcess",
			component = StrategyMatrixProcessView
		},
		{
			name = "strategyMatrixProcessSelectHero",
			component = StrategyMatrixProcessSelectHeroView
		},
		{
			name = "strategyMatrixProcessShopSelectHero",
			component = StrategyMatrixProcessShopSelectHeroView
		},
		{
			name = "strategyMatrixProcessShop",
			component = StrategyMatrixProcessShopView
		},
		{
			name = "strategyMatrixProcessAstrolabeReplace",
			component = StrategyMatrixProcessAstrolabeReplaceView
		},
		{
			name = "strategyMatrixProcessEquipReplace",
			component = StrategyMatrixProcessEquipReplaceView
		},
		{
			name = "strategyMatrixProcessWeaponReplace",
			component = StrategyMatrixProcessWeaponReplaceView
		},
		{
			name = "strategyMatrixOver",
			component = StrategyMatrixOverView
		},
		{
			name = "battleStatisticsStrategyMatrixOver",
			component = BattleStatisticsStrategyMatrixOverView
		},
		{
			name = "strategyMatrix",
			component = StrategyMatrixView
		},
		{
			name = "strategyMatrixInfo",
			component = StrategyMatrixInfoView
		},
		{
			name = "sectionSelectHeroStrategyMatrix",
			component = SectionSelectHeroStrategyMatrixView
		},
		{
			name = "strategyMatrixRward",
			component = StrategyMatrixRwardView
		},
		{
			name = "strategyMatrixThor",
			component = StrategyMatrixThorView
		},
		{
			name = "strategyMatrixThorStoryReview",
			component = StrategyMatrixThorStoryReviewView
		},
		{
			name = "bag",
			component = BagView
		},
		{
			name = "settlement",
			component = BattleResultBaseView
		},
		{
			name = "battleChapterResult",
			component = BattleResultChapterView
		},
		{
			name = "draw",
			component = DrawView
		},
		{
			name = "drawInfo",
			component = DrawInfoView
		},
		{
			name = "drawRecord",
			component = DrawRecordView
		},
		{
			name = "drawSelect",
			component = DrawServantSelectView
		},
		{
			name = "drawHeroSelect",
			component = DrawHeroSelectView
		},
		{
			name = "drawTenTimesReward",
			component = DrawTenTimesRewardView
		},
		{
			name = "task",
			component = TaskView
		},
		{
			name = "previewTaskMain",
			component = PreviewTaskMainView
		},
		{
			name = "equipbag",
			component = EquipBagView
		},
		{
			name = "equipArchive",
			component = EquipArchiveView
		},
		{
			name = "equipinfo",
			component = EquipInfoView
		},
		{
			name = "userinfo",
			component = NewUserAndPlayerInfoView
		},
		{
			name = "HeadIconChange",
			component = HeadIconChangeView
		},
		{
			name = "BirthdayView",
			component = BirthdaySettingView
		},
		{
			name = "HeroShowChange",
			component = HeroShowChangeView
		},
		{
			name = "MainSticker",
			component = MainStickerView
		},
		{
			name = "illustratedMain",
			component = IllustratedMain
		},
		{
			name = "illuInformation",
			component = IlluInformation
		},
		{
			name = "illuEnemyFiles",
			component = IlluEnemyFiles
		},
		{
			name = "illuEnemyFileDetail",
			component = IlluEnemyFileDetail
		},
		{
			name = "illuEquipManual",
			component = IlluEquipManual
		},
		{
			name = "illuServantManual",
			component = IlluServantManual
		},
		{
			name = "illuWorldView",
			component = IlluWorldView
		},
		{
			name = "illustratedPop",
			component = IlluIllustrationDetailPopView
		},
		{
			name = "illuPlot",
			component = IlluPlot
		},
		{
			name = "illuPlotDetail",
			component = IlluPlotDetail
		},
		{
			name = "illuIllustration",
			component = IlluIllustration
		},
		{
			name = "illuIllustrationDetail",
			component = IlluIllustrationDetail
		},
		{
			name = "illuMusic",
			component = IlluMusicView
		},
		{
			name = "showHeroSelect",
			component = ShowHeroSelectView
		},
		{
			name = "posterGirlSelect",
			component = PosterGirlSelectView
		},
		{
			name = "portraitSelect",
			component = PortraitSelectView
		},
		{
			name = "changeName",
			component = ChangeNameView
		},
		{
			name = "GiftPopUp",
			component = GiftPopUp
		},
		{
			name = "ProposalPopup",
			component = ProposalPopup
		},
		{
			name = "EquipProposal",
			component = EquipProposalView
		},
		{
			name = "ProposalCheck",
			component = ProposalCheck
		},
		{
			name = "playerInfo",
			component = PlayerInfoView
		},
		{
			name = "blackPlayerInfo",
			component = BlackPlayerInfoView
		},
		{
			name = "friendInfo",
			component = FriendInfoView
		},
		{
			name = "battleheartfailed",
			component = BattleHeartFailedView
		},
		{
			name = "battlefailed",
			component = BattleFailedView
		},
		{
			name = "battlefailedWithButton",
			component = BattleFailedWithButtonView
		},
		{
			name = "battlevictory",
			component = BattleVictoryView
		},
		{
			name = "friendsUI",
			component = FriendsView
		},
		{
			name = "friendManager",
			component = FriendManagerView
		},
		{
			name = "storylist",
			component = StoryListView
		},
		{
			name = "navibar",
			component = NaviBar
		},
		{
			name = "bulletin",
			component = BulletinSwitchView
		},
		{
			name = "equipsort",
			component = EquipSortTip
		},
		{
			name = "popItem",
			component = PopItemNormalView
		},
		{
			name = "followGift",
			component = FollowGiftView
		},
		{
			name = "survey",
			component = SurveyView
		},
		{
			name = "praise",
			component = PraiseView
		},
		{
			name = "followPop",
			component = FollowPopView
		},
		{
			name = "popCostItem",
			component = PopCostItemView
		},
		{
			name = "popNeedCostItemView",
			component = PopNeedCostItemView
		},
		{
			name = "popSourceItem",
			component = PopItemSourceView
		},
		{
			name = "popMergeItem",
			component = PopItemMergeView
		},
		{
			name = "popEquipSourceView",
			component = PopEquipSourceView
		},
		{
			name = "popSourceDesItem",
			component = PopItemSourceDesView
		},
		{
			name = "optionalItemSelect",
			component = OptionalItemSelectView
		},
		{
			name = "popOperateItem",
			component = PopItemOperateView
		},
		{
			name = "mailBox",
			component = MailBoxView
		},
		{
			name = "letterBox",
			component = LetterBoxView
		},
		{
			name = "letterPop",
			component = LetterPopView
		},
		{
			name = "rewardPreview",
			component = RewardPreviewView
		},
		{
			name = "AlphaActivityView",
			component = AlphaActivityView
		},
		{
			name = "PopupPhaseActivityUI",
			component = PhaseActivityUI
		},
		{
			name = "changePoster",
			component = ChangePosterView
		},
		{
			name = "levelUp",
			component = LevelUpView
		},
		{
			name = "equipRec",
			component = EquipRecView
		},
		{
			name = "towerStage",
			component = TowerStageView
		},
		{
			name = "tower",
			ignoreMerge = true,
			component = TowerView
		},
		{
			name = "mythic",
			ignoreMerge = true,
			component = MythicView
		},
		{
			name = "mythicDifficulty",
			component = MythicDifficultyView
		},
		{
			name = "mythicSectionReward",
			component = MythicSectionRewardView
		},
		{
			name = "weapon",
			component = WeaponView,
			children = {
				{
					name = "weaponBreak",
					component = WeaponBreakView
				},
				{
					name = "weaponStr",
					component = WeaponStrView
				}
			}
		},
		{
			name = "weaponServant",
			component = WeaponServantView,
			children = {
				{
					name = "servantBreak",
					component = ServantBreakView
				}
			}
		},
		{
			name = "showServantView",
			component = ShowServantView
		},
		{
			name = "equipCultureView",
			component = EquipCultureView
		},
		{
			name = "equipDetail",
			component = EquipDetailView
		},
		{
			name = "equipPrefabDetailView",
			component = EquipPrefabDetailView
		},
		{
			name = "equipStrengthView",
			component = EquipStrengthView
		},
		{
			name = "equipEnchantView",
			component = EquipEnchantView
		},
		{
			name = "equipRaceView",
			component = EquipRaceView
		},
		{
			name = "equipHeroRebuild",
			component = EquipHeroRebuildView
		},
		{
			name = "equipRaceConfirmView",
			component = EquipRaceConfirmView
		},
		{
			name = "equipUpgradeView",
			component = EquipUpgradeView
		},
		{
			name = "equipEnchantMainView",
			component = EquipEnchantMainView
		},
		{
			name = "equipStrengthSuccessView",
			component = EquipStrengthSuccessView
		},
		{
			name = "equipUpgradeSuccessView",
			component = EquipUpgradeSuccessView
		},
		{
			name = "equipInherit",
			component = EquipInheritView
		},
		{
			name = "equipInheritPrefabSelect",
			component = EquipInheritPrefabSelectView
		},
		{
			name = "equipInheritComfirm",
			component = EquipInheritComfirmView
		},
		{
			name = "equipInheritSelect",
			component = EquipInheritSelectView
		},
		{
			name = "obtainView",
			component = ObtainView
		},
		{
			name = "warHome",
			component = ChessHome
		},
		{
			name = "chessBag",
			component = ChessBag
		},
		{
			name = "chessLetter",
			component = ChessLetterView
		},
		{
			name = "chessChoose",
			component = ChessChoose
		},
		{
			name = "chessDebuffPop",
			component = ChessDebuffPop
		},
		{
			name = "chessPurify",
			component = ChessPurify
		},
		{
			name = "chessBattlePop",
			component = ChessBattlePopView
		},
		{
			name = "chessRevive",
			component = ChessReviveView
		},
		{
			name = "chessMessage",
			component = ChessMessage
		},
		{
			name = "chessMessageBtn",
			component = ChessMessageBtn
		},
		{
			name = "chipManager",
			component = ChipManagerView
		},
		{
			name = "chipInfo",
			component = ChipInfoView
		},
		{
			name = "chipScheme",
			component = ChipSchemeView
		},
		{
			name = "reservesChipManager",
			component = ReservesChipManagerView
		},
		{
			name = "reservesChipInfo",
			component = ReservesChipInfoView
		},
		{
			name = "reservesChipScheme",
			component = ReservesChipSchemeView
		},
		{
			name = "battleChipManager",
			component = BattleChipManagerView
		},
		{
			name = "battleChipScheme",
			component = BattleChipSchemeView
		},
		{
			name = "battleChipInfo",
			component = BattleChipInfoView
		},
		{
			name = "heroChipView",
			component = HeroChipView
		},
		{
			name = "graphicRecommend",
			component = GraphicRecommendView
		},
		{
			name = "weaponServantEnter",
			component = WeaponServantEnterView
		},
		{
			name = "weaponServantList",
			component = WeaponServantListView
		},
		{
			name = "weaponServantMerge",
			component = WeaponServantMergeView
		},
		{
			name = "synthesise",
			component = SynthesiseView
		},
		{
			name = "serveropencountdown",
			component = ServerOpenCountdownView
		},
		{
			name = "comboSkillInfo",
			component = ComboSkillInfoView
		},
		{
			name = "comboSkillSelect",
			component = ComboSkillSelectView
		},
		{
			name = "comboSkillSelectBoss",
			component = ComboSkillSelectBossView
		},
		{
			name = "recallMain",
			component = RecallMainView
		},
		{
			name = "RecallRewardPop",
			component = RecallSystemRewardView
		},
		{
			name = "RecallInfoPop",
			component = RecallSystemRecallInfoPopView
		},
		{
			name = "RecallCodeInput",
			component = RecallSystemInputWordPopView
		},
		{
			name = "rechargeEnter",
			component = RechargeEnterView
		},
		{
			name = "rechargeMain",
			component = RechargeMainView
		},
		{
			name = "rechargeGiftPop",
			component = RechargeGiftPopView
		},
		{
			name = "achievementManager",
			component = AchievementManagerView
		},
		{
			name = "achievementInfo",
			component = AchievementInfoView
		},
		{
			name = "achievementStory",
			component = AchievementStoryView
		},
		{
			name = "achievementStoryInfo",
			component = AchievementStoryInfoView
		},
		{
			name = "achievementUpgrade",
			component = AchievementUpgradeView
		},
		{
			name = "chat",
			component = ChatSwitchView
		},
		{
			name = "chatCustomSticker",
			component = CustomStickerView
		},
		{
			name = "chatFriend",
			component = ChatFriendView
		},
		{
			name = "chatReport",
			component = ChatReportView
		},
		{
			name = "chatMuted",
			component = ChatMutedView
		},
		{
			name = "passportBuy",
			component = PassportBuyView
		},
		{
			name = "passportBuyLevel",
			component = PassportBuyLevelView
		},
		{
			name = "passportNote",
			component = PassportNoteView
		},
		{
			name = "weaponServantSleepySelect",
			component = WeaponServantSleepySelectView
		},
		{
			name = "weaponServantWakeUp",
			component = WeaponServantWakeUpView
		},
		{
			name = "passportPoster",
			component = PassportPosterView
		},
		{
			name = "passportMain",
			component = PassportMainView
		},
		{
			name = "passportBuyLevelConfirm",
			component = PassportBuyLevelConfirmView
		},
		{
			name = "downLoadPage",
			component = DownloadPageView
		},
		{
			name = "languagePackage",
			component = LanguagePackageView
		},
		{
			name = "heroDisplay",
			component = HeroDisplayView
		},
		{
			name = "activityNewbie",
			component = ActivityNewbieView
		},
		{
			name = "activityNewbieRebateIllustrate",
			component = ActivityNewbieRebateIllustrateView
		},
		{
			name = "activityNoob",
			component = ActivityNoobView
		},
		{
			name = "noobAdvanceTask",
			component = NoobAdvanceTaskView
		},
		{
			name = "threeButtonBox",
			component = ThreeButtonBoxView
		},
		{
			name = "guildEntrace",
			component = GuildEntraceView
		},
		{
			name = "guildFounded",
			component = GuildFoundedManagerView
		},
		{
			name = "guildHeadIconSelect",
			component = GuildHeadIconSelectView
		},
		{
			name = "guildMain",
			component = GuildMainView
		},
		{
			name = "guildManager",
			component = GuildManagerView
		},
		{
			name = "guildMemberList",
			component = GuildMemberListView
		},
		{
			name = "guildRename",
			component = GuildRenameView
		},
		{
			name = "guildChangeNotice",
			component = GuildChangeNoticeView
		},
		{
			name = "guildMobilityPost",
			component = GuildMobilityPostView
		},
		{
			name = "guildImpeachTips",
			component = GuildImpeachTipsView
		},
		{
			name = "guildRequestSetting",
			component = GuildRequestSettingView
		},
		{
			name = "guildInfo",
			component = GuildInfoView
		},
		{
			name = "guildShareInfo",
			component = GuildShareInfoView
		},
		{
			name = "rechargeMonthCardDesc",
			component = RechargeMonthCardDescView
		},
		{
			name = "backHomeEnterView",
			component = BackHomeEnterView
		},
		{
			name = "dormHeroDeployView",
			component = DormHeroDeployView
		},
		{
			name = "dorm",
			component = DormHomeView
		},
		{
			name = "dormLevelInfoView",
			component = DormLevelInfoView
		},
		{
			name = "dormChooseRoomView",
			component = DormChooseRoomView
		},
		{
			name = "dormVisitView",
			component = DormVisitView
		},
		{
			name = "roomEdit",
			component = RoomEditView
		},
		{
			name = "dormHeroGiftView",
			component = DormHeroGiftView
		},
		{
			name = "dormUnLockRoomConfirmView",
			component = DormUnLockRoomConfirmView
		},
		{
			name = "dormTemplateView",
			component = DormTemplateView
		},
		{
			name = "dormPrivateOccupySuccessView",
			component = DormPrivateOccupySuccessView
		},
		{
			name = "dormPreviewTemplateView",
			component = DormPreviewTemplateView
		},
		{
			name = "dormChangeTemplateNameView",
			component = DormChangeTemplateNameView
		},
		{
			name = "furnitureEdit",
			component = FurnitureEditView
		},
		{
			name = "furnitureBuyPop",
			component = FurnitureBuyPopItem
		},
		{
			name = "furnitureBuyView",
			component = FurnitureBuyView
		},
		{
			name = "dormUpgrade",
			component = DormUpgradeView
		},
		{
			name = "dormBuy",
			component = DormBuyView
		},
		{
			name = "dormSaleDetail",
			component = DormSaleDetailView
		},
		{
			name = "dormSale",
			component = DormSaleView
		},
		{
			name = "specialEventPop",
			component = SpecialEventPopView
		},
		{
			name = "dormPopularEvent",
			component = DormPopularEventPop
		},
		{
			name = "communityWelfare",
			component = CommunityWelfareView
		},
		{
			name = "communitySpecialWelfareShop",
			component = CommunitySpecialWelfareShopView
		},
		{
			name = "communityTask",
			component = CommunityTaskView
		},
		{
			name = "dormPopularReplace",
			component = DormPopularReplace
		},
		{
			name = "enchantmentMultiPop",
			component = EnchantmentMultiPop
		},
		{
			name = "stickersList",
			component = StickersListView
		},
		{
			name = "chooseStickers",
			component = ChooseStickersView
		},
		{
			name = "chooseStickerBg",
			component = ChooseStickerBgView
		},
		{
			name = "chooseStickerTemplate",
			component = ChooseStickerTemplateView
		},
		{
			name = "osirisMain",
			component = OsirisMainView
		},
		{
			name = "osirisStoryStage",
			component = OsirisStoryStageView
		},
		{
			name = "osirisStoryStageInfo",
			component = OsirisStoryStageInfoView
		},
		{
			name = "osirisChess",
			component = OsirisChessView
		},
		{
			name = "osirisActivity",
			component = OsirisActivityView
		},
		{
			name = "osirisRewardPreview",
			component = OsirisRewardPreview
		},
		{
			name = "osirisRecall",
			component = OsirisRecallView
		},
		{
			name = "heroInteractView",
			component = HeroInteractView
		},
		{
			name = "chooseCharacterView",
			component = ChooseCharacterView
		},
		{
			name = "restaurantMain",
			component = RestaurantMainView
		},
		{
			name = "restaurantCookUpView",
			component = RestaurantCookUpView
		},
		{
			name = "reviseSignFoodNumView",
			component = ReviseSignFoodNumView
		},
		{
			name = "restaurantJobSetView",
			component = RestaurantJobSetView
		},
		{
			name = "restaurantJobView",
			component = RestaurantJobView
		},
		{
			name = "chooseSignFoodView",
			component = ChooseSignFoodView
		},
		{
			name = "popCharacterView",
			component = PopCharacterView
		},
		{
			name = "cookFoodView",
			component = CookFoodView
		},
		{
			name = "pickFoodView",
			component = CanteenPassTablePop
		},
		{
			name = "restaurantFoodMenuView",
			component = RestaurantFoodMenuView
		},
		{
			name = "restaurantCustomerCollectionView",
			component = DormCustomerCollectionView
		},
		{
			name = "dormPlayerControlView",
			component = DormPlayerControllerView
		},
		{
			name = "PopSetFoodView",
			component = PopSetFoodView
		},
		{
			name = "dormTaskDispatchView",
			component = DormTaskDispatchView
		},
		{
			name = "canteenManualRewardView",
			component = CanteenManualRewardView
		},
		{
			name = "canteenLackFoodIngredientsView",
			component = CanteenLackFoodIngredientsView
		},
		{
			name = "canteenLevelInfoView",
			component = CanteenLevelInfoView
		},
		{
			name = "canteenEntrustAwardView",
			component = CanteenEntrustAwardView
		},
		{
			name = "canteenProDesView",
			component = CanteenProDesView
		},
		{
			name = "canteenLevelUpView",
			component = CanteenLevelUpView
		},
		{
			name = "demonChallenge",
			component = DemonChallengeView
		},
		{
			name = "demonChallengeReward",
			component = DemonChallengeRewardView
		},
		{
			name = "demonChallengeSelect",
			component = DemonChallengeSelectView
		},
		{
			name = "raceTrail",
			component = RaceTrailMainView
		},
		{
			name = "raceTrailFirstReward",
			component = RaceTrailFirstRewardPopView
		},
		{
			name = "raceTrailScoreReward",
			component = RaceTrailScoreRewardPopView
		},
		{
			name = "heroRaceTrailDetails",
			component = HeroRaceTrailDetailsPopView
		},
		{
			name = "raceTrailReady",
			component = RaceTrailReadyView
		},
		{
			name = "volumeRaceTrailMain",
			component = VolumeRaceTrailMainView
		},
		{
			name = "volumeHeroRaceTrailDetails",
			component = VolumeHeroRaceTrailDetailsView
		},
		{
			name = "volumeRaceTrailScoreRewardPop",
			component = VolumeRaceTrailScoreRewardPopView
		},
		{
			name = "heroTrialActivite",
			component = HeroTrialActiviteView
		},
		{
			name = "dreamHeroTrial",
			component = DreamHeroTrialView
		},
		{
			name = "factoryHeroTrial",
			component = FactoryHeroTrialView
		},
		{
			name = "heroTrialView_1_7",
			component = HeroTrialView_1_7
		},
		{
			name = "bagExpired",
			component = BagExpiredView
		},
		{
			name = "weaponServantDecomposeView",
			component = WeaponServantDecomposeView
		},
		{
			name = "weaponServantMergeResultView",
			component = WeaponServantMergeResultView
		},
		{
			name = "repairAssetsView",
			component = RepairAssetsView
		},
		{
			name = "passportTask",
			component = PassportTaskView
		},
		{
			name = "hellaMain",
			component = HellaMainView
		},
		{
			name = "activityChessView",
			component = ActivityChessView
		},
		{
			name = "sortHeroType",
			component = SortHeroTypeView
		},
		{
			name = "demonChallengeMain",
			component = DemonChallengeMainView
		},
		{
			name = "demonChallengeAward",
			component = DemonChallengeAwardView
		},
		{
			name = "demonChallengeDifficultySelect",
			component = DemonChallengeDifficultySelectView
		},
		{
			name = "volumeDemonChallengeMain",
			component = VolumeDemonChallengeMainView
		},
		{
			name = "volumeDemonChallengeDifficultySelect",
			component = VolumeDemonChallengeDifficultySelectView
		},
		{
			name = "talentTree",
			component = TalentTreeMainView
		},
		{
			name = "FrameExpired",
			component = FrameExpiredView
		},
		{
			name = "hellaParkour",
			component = HellaParkourView
		},
		{
			name = "hellaParkourEntrust",
			component = HellaParkourEntrustView
		},
		{
			name = "hellaParkourLose",
			component = HellaParkourLoseView
		},
		{
			name = "hellaParkourReward",
			component = HellaParkourRewardView
		},
		{
			name = "slayerSctionInfo",
			component = SlayerSectionInfoView
		},
		{
			name = "sectionSelectHeroSlayer",
			component = SectionSelectHeroSlayerView
		},
		{
			name = "battleSlayerResult",
			component = BattleSlayerResultView
		},
		{
			name = "hellaSlayer",
			component = HellaSlayerView
		},
		{
			name = "hellaSlayerReward",
			component = HellaSlayerRewardView
		},
		{
			name = "volumeSlayer",
			component = VolumeSlayerView
		},
		{
			name = "volumeSlayerMain",
			component = VolumeSlayerMainView
		},
		{
			name = "slayerMainView_1_7",
			component = SlayerMainView_1_7
		},
		{
			name = "slayerStageView_1_7",
			component = SlayerStageView_1_7
		},
		{
			name = "slayerRewardView_1_7",
			component = SlayerRewardView_1_7
		},
		{
			name = "sectionSelectHeroSlayerView_1_7",
			component = SectionSelectHeroSlayerView_1_7
		},
		{
			name = "hellaHeroTrialActivite",
			component = HellaHeroTrialActiviteView
		},
		{
			name = "skinTrialActivity",
			component = SkinTrialActivityView
		},
		{
			name = "summerSkinTrialActivity",
			component = SummerSkinTrialActivityView
		},
		{
			name = "volumeSkinTrialActivity",
			component = VolumeSkinTrialActivityView
		},
		{
			name = "factorySkinTrialActivity",
			component = FactorySkinTrialActivityView
		},
		{
			name = "dreamSkinTrialActivity",
			component = DreamSkinTrialActivityView
		},
		{
			name = "skinTrialActivitySelect",
			component = SkinTrialActivitySelectView
		},
		{
			name = "skinTrialSelect101",
			component = SkinTrialSelect101
		},
		{
			name = "skinTrialSelect102",
			component = SkinTrialSelect102
		},
		{
			name = "skinTrialSelect103",
			component = SkinTrialSelect103
		},
		{
			name = "skinTrialSelect104",
			component = SkinTrialSelect104
		},
		{
			name = "skinTrialSelect105",
			component = SkinTrialSelect105
		},
		{
			name = "skinTrialSelect106",
			component = SkinTrialSelect106
		},
		{
			name = "skinTrialSelect107",
			component = SkinTrialSelect107
		},
		{
			name = "skinTrialSelect108",
			component = SkinTrialSelect108
		},
		{
			name = "skinTrialSelect109",
			component = SkinTrialSelect109
		},
		{
			name = "skinTrialSelect110",
			component = SkinTrialSelect110
		},
		{
			name = "skinTrialSelect111",
			component = SkinTrialSelect111
		},
		{
			name = "skinTrialSelect112",
			component = SkinTrialSelect112
		},
		{
			name = "skinTrialSelect113",
			component = SkinTrialSelect113
		},
		{
			name = "skinTrialSelect114",
			component = SkinTrialSelect114
		},
		{
			name = "skinTrialSelect115",
			component = SkinTrialSelect115
		},
		{
			name = "skinTrialSelect116",
			component = SkinTrialSelect116
		},
		{
			name = "skinTrialSelect117",
			component = SkinTrialSelect117
		},
		{
			name = "skinTrialSelectView_2_0",
			component = SkinTrialSelectView_2_0
		},
		{
			name = "storyStageActivity",
			component = StoryStageActivityView
		},
		{
			name = "storyStageInfoActivity",
			component = StoryStageInfoActivityView
		},
		{
			name = "battleFirstPass",
			component = BattleFirstPassView
		},
		{
			name = "firstPassRewardPop",
			component = FirstPassRewardPopView
		},
		{
			name = "summerMain",
			component = ActivitySummerMainView
		},
		{
			name = "summerStoryMain",
			component = SummerStoryMainView
		},
		{
			name = "summerStageMain",
			component = SummerStageMainView
		},
		{
			name = "summerStageSeabed",
			component = SummerStageSeabedView
		},
		{
			name = "summerPlot",
			component = SummerPlotView
		},
		{
			name = "summerChess",
			component = SummerChessView
		},
		{
			name = "fishingEnter",
			component = FishingEnterView
		},
		{
			name = "fishEnding",
			component = FishingEndingView
		},
		{
			name = "fishingExchange",
			component = FishingExchangeView
		},
		{
			name = "fishingGame",
			component = FishingGameView
		},
		{
			name = "fishingGivePop",
			component = FishingGivePopView
		},
		{
			name = "fishingIllustrated",
			component = FishingIllustratedView
		},
		{
			name = "fishingReward",
			component = FishingRewardView
		},
		{
			name = "fishingInfoPop",
			component = FishingInfoPopView
		},
		{
			name = "fishingBuy",
			component = FishingBuyView
		},
		{
			name = "fishingNote",
			component = FishingNoteView
		},
		{
			name = "soloChallengeMain",
			component = SoloChallengeMainView
		},
		{
			name = "factorySoloChallengeMain",
			component = FactorySoloChallengeMainView
		},
		{
			name = "soloChallengeReward",
			component = SoloChallengeRewardView
		},
		{
			name = "soloChallengeDifficultySelect",
			component = SoloChallengeDifficultySelectView
		},
		{
			name = "soloChallengeBossInfo",
			component = SoloChallengeBossInfoView
		},
		{
			name = "soloChallengeSelect",
			component = SoloChallengeSelectView
		},
		{
			name = "factorySoloChallengeSelect",
			component = FactorySoloChallengeSelectView
		},
		{
			name = "soloChallengeAffix",
			component = SoloChallengeAffixView
		},
		{
			name = "heroTeamInfoSoloChallenge",
			component = HeroTeamInfoSoloChallengeView
		},
		{
			name = "sectionSelectHeroSoloChallenge",
			component = SectionSelectHeroSoloChallengeView
		},
		{
			name = "soloChallengeMainView_1_7",
			component = SoloChallengeMainView_1_7
		},
		{
			name = "soloChallengeDifficultySelectView_1_7",
			component = SoloChallengeDifficultySelectView_1_7
		},
		{
			name = "soloChallengeRewardView_1_7",
			component = SoloChallengeRewardView_1_7
		},
		{
			name = "soloChallengeSelectView_1_7",
			component = SoloChallengeSelectView_1_7
		},
		{
			name = "summerHeroTrialActivite",
			component = SummerHeroTrialActiviteView
		},
		{
			name = "limitedCalculation",
			component = LimitedCalculationMainView
		},
		{
			name = "limitedCalculationDifficulty",
			component = LimitedCalculationDifficultyView
		},
		{
			name = "buffDescription",
			component = BuffDescriptionMainView
		},
		{
			name = "limitedCalculationReward",
			component = LimitedCalculationRewardView
		},
		{
			name = "limitedCalculationRank",
			component = LimitedCalculationRankView
		},
		{
			name = "artifact",
			component = ArtifactView
		},
		{
			name = "artifactLevel",
			component = ArtifactLevelView
		},
		{
			name = "skadiLittleGame",
			component = SkadiLittleGameView
		},
		{
			name = "skadiGameReward",
			component = SkadiGameReward
		},
		{
			name = "leviathanGameReward",
			component = LeviathanGameReward
		},
		{
			name = "hellaHeroGift",
			component = HellaHeroGiftView
		},
		{
			name = "leviathanLittleGame",
			component = LeviathanLittleGameView
		},
		{
			name = "skadiLittleGame",
			component = SkadiLittleGameView
		},
		{
			name = "regression",
			component = RegressionView
		},
		{
			name = "regressionGift",
			component = RegressionGiftView
		},
		{
			name = "leviathanSectionInfo",
			component = LeviathanSectionInfoView
		},
		{
			name = "skadiSectionInfo",
			component = SkadiSectionInfoView
		},
		{
			name = "battleLittleGameResultView",
			component = BattleLittleGameResultView
		},
		{
			name = "moonBoResultView",
			component = MoonBoResultView
		},
		{
			name = "skinExchange",
			component = SkinExchangeView
		},
		{
			name = "thirdVolumeMain",
			component = ActivityThirdVolumeMainView
		},
		{
			name = "bossHelper",
			component = BossHelperView
		},
		{
			name = "puzzleMain",
			component = PuzzleMainView
		},
		{
			name = "puzzleSelect",
			component = PuzzleSelectView
		},
		{
			name = "thirdVolumeHeroTrial",
			component = ThirdVolumeHeroTrialView
		},
		{
			name = "activityPt",
			component = ActivityPtView
		},
		{
			name = "activityPtSectionInfo",
			component = ActivityPtSectionInfoView
		},
		{
			name = "moonBoView",
			component = MoonBoView
		},
		{
			name = "moonBoRewardView",
			component = MoonBoRewardView
		},
		{
			name = "moonBoResultView",
			component = MoonBoResultView
		},
		{
			name = "moonBoIntroduceView",
			component = MoonBoIntroduceView
		},
		{
			name = "activityPtNote",
			path = "/activityPtNote",
			component = ActivityPtNotView
		},
		{
			name = "guildBossChallenge",
			path = "/guildBossChallenge",
			component = GuildBossChallengeView
		},
		{
			name = "guildBossBattleResult",
			path = "/guildBossBattleResult",
			component = GuildBossBattleResultView
		},
		{
			name = "guildBossSetAssistant",
			path = "/guildBossSetAssistant",
			component = GuildBossSetAssistantView
		},
		{
			name = "guildBossTeamInfo",
			path = "/guildBossTeamInfo",
			component = GuildHeroTeamInfoView
		},
		{
			name = "guildBossReward",
			path = "/guildBossReward",
			component = GuildBossRewardView
		},
		{
			name = "guildDifficultChose",
			path = "/guildDifficultChose",
			component = GuildDifficultChoseView
		},
		{
			name = "guildBossRank",
			path = "/guildBossRank",
			component = GuildBossRankView
		},
		{
			name = "guildBossMain",
			path = "/guildBossMain",
			component = GuildBossMainView
		},
		{
			name = "guildBossNote",
			path = "/guildBossNote",
			component = GuildBossNoteView
		},
		{
			name = "guildBossSectionInfo",
			path = "/guildBossSectionInfo",
			component = GuildBossSectionInfoView
		},
		{
			name = "guildBossSelectHero",
			path = "/guildBossSelectHero",
			component = GuildBossSelectHeroView
		},
		{
			name = "cowboy",
			path = "/cowboy",
			component = CowboyMainView
		},
		{
			name = "cowboyReady",
			path = "cowboyReady",
			component = CowboyReadyView
		},
		{
			name = "chessMutiView",
			path = "/chessMutiView",
			component = ChessMutiBattleView
		},
		{
			name = "cowboyGame",
			path = "/cowboyGame",
			component = CowboyGameView
		},
		{
			name = "cowboyGameBack",
			path = "cowboyGameBack",
			component = CowboyGameBackPopView
		},
		{
			name = "cowboyGamePause",
			path = "cowboyGamePause",
			component = CowboyGamePausePopView
		},
		{
			name = "cowboyGameOver",
			path = "cowboyGameOver",
			component = CowboyGameOverView
		},
		{
			name = "cowBoyReward",
			path = "cowBoyReward",
			component = CowboyRewardView
		},
		{
			name = "cowBoyInfo",
			path = "cowBoyInfo",
			component = CowboyInfoView
		},
		{
			name = "chessChipManager",
			component = ChessChipManagerView
		},
		{
			name = "heroTeamInfoChessView",
			component = HeroTeamInfoChessView
		},
		{
			name = "chessCampAddPopView",
			component = ChessCampAddPopView
		},
		{
			name = "comboSkillSelectChessView",
			component = ComboSkillSelectChessView
		},
		{
			name = "weaponServantShowView",
			component = WeaponServantShowView
		},
		{
			name = "mythicUltimateView",
			component = MythicUltimateView
		},
		{
			name = "activityRaceMain",
			component = ActivityRaceMainView
		},
		{
			name = "activityRaceSwitch",
			component = ActivityRaceSwitchView
		},
		{
			name = "activityRaceRank",
			component = ActivityRaceRankView
		},
		{
			name = "activityRaceRewardPanel",
			component = ActivityRaceRewardPanelView
		},
		{
			name = "activityRaceSectionInfo",
			component = ActivityRaceSectionInfoView
		},
		{
			name = "battleActivityRaceResult",
			component = BattleActivityRaceResultView
		},
		{
			name = "battleActivityRaceScorResult",
			component = BattleActivityRaceScoreResultView
		},
		{
			name = "mythicFinalRewardView",
			component = MythicFinalRewardView
		},
		{
			name = "mythicFinalLevelView",
			component = MythicFinalLevelView
		},
		{
			name = "reservesUI",
			component = ReservesView
		},
		{
			name = "activityRaceSectionSelectHero",
			component = ActivityRaceSectionSelectHeroView
		},
		{
			name = "activityRaceHeroTeamInfo",
			component = ActivityRaceHeroTeamInfoView
		},
		{
			name = "activityRaceReservesUI",
			component = ActivityRaceReservesView
		},
		{
			name = "subPlotSection",
			ignoreMerge = true,
			component = SubPlotSectionView
		},
		{
			name = "osirisStoryRemastered",
			ignoreMerge = true,
			component = OsirisStoryStageRemasteredView
		},
		{
			name = "osirisRecallRemastered",
			ignoreMerge = true,
			component = OsirisRecallRemasteredView
		},
		{
			name = "hellaStoryRemastered",
			ignoreMerge = true,
			component = HellaStoryRemasteredView
		},
		{
			name = "summerStoryRemastered",
			ignoreMerge = true,
			component = SummerStoryRemasteredView
		},
		{
			name = "summerSeabedStoryRemastered",
			ignoreMerge = true,
			component = SummerSeabedStoryRemasteredView
		},
		{
			name = "summerPlotRemastered",
			ignoreMerge = true,
			component = SummerPlotRemasteredView
		},
		{
			name = "subPlotHera",
			ignoreMerge = true,
			component = SubPlotHeraView
		},
		{
			name = "subPlotTyr",
			ignoreMerge = true,
			component = SubPlotTyrView
		},
		{
			name = "heroTeam",
			component = ReservesSelectView
		},
		{
			name = "volumeMusicMain",
			component = VolumeMusicMainView
		},
		{
			name = "voumeMusicSetting",
			component = VolumeMusicSettingView
		},
		{
			name = "volumeMusicstop",
			component = VolumeMusicStopView
		},
		{
			name = "volumeMusicSettlement",
			component = VolumeMusicSettlementView
		},
		{
			name = "volumeMusicGame",
			component = VolumeMusicGameView
		},
		{
			name = "VolumeMusicReward",
			component = VolumeMusicRewardView
		},
		{
			name = "enternalMusicMain",
			component = EnternalMusicMainView
		},
		{
			name = "enternalMusicReward",
			component = EnternalMusicRewardView
		},
		{
			name = "enternalMusicStop",
			component = EnternalMusicStopView
		},
		{
			name = "enternalMusicSettlement",
			component = EnternalMusicSettlementView
		},
		{
			name = "enternalMusicGame",
			component = EnternalMusicGameView
		},
		{
			name = "enternalMusicSetting",
			component = EnternalMusicSettingView
		},
		{
			name = "equipBreakThroughMaterialMode",
			component = EquipBreakThroughMaterialModeView
		},
		{
			name = "equipBreakThroughMaterialMap",
			ignoreMerge = true,
			component = EquipBreakThroughMaterialMapView
		},
		{
			name = "equipBreakThroughMaterialStageInfo",
			component = EquipBreakThroughMaterialStageInfoView
		},
		{
			name = "equipBreakThroughMaterialBuffStage",
			component = EquipBreakThroughMaterialBuffStageView
		},
		{
			name = "equipBreakThroughMaterialMapInfo",
			component = EquipBreakThroughMaterialMapInfoView
		},
		{
			name = "equipBreakThroughMaterialTask",
			component = EquipBreakThroughMaterialTaskView
		},
		{
			name = "sectionSelectHeroEquipBreakThrough",
			component = SectionSelectHeroEquipBreakThroughView
		},
		{
			name = "comboSkillSelectEquipBreakThrough",
			component = ComboSkillSelectEquipBreakThroughView
		},
		{
			name = "chipEquipBreakThroughManager",
			component = ChipManagerEquipBreakThroughView
		},
		{
			name = "chipEquipBreakThroughInfo",
			component = ChipInfoEquipBreakThroughView
		},
		{
			name = "equipBreakThroughResult",
			component = EquipBreakThroughResultView
		},
		{
			name = "osirisMain",
			component = OsirisMainView
		},
		{
			name = "summerMain",
			component = ActivitySummerMainView
		},
		{
			name = "thirdVolumeMain",
			component = ActivityThirdVolumeMainView
		},
		{
			name = "thirdVolumePart2Main",
			component = ActivityThirdVolumePart2MainView
		},
		{
			name = "factoryMain",
			component = ActivityFactoryMainView
		},
		{
			name = "springFestivalMain",
			component = SpringFestivalMainView
		},
		{
			name = "activityMain_1_6",
			component = ActivityMainView_1_6
		},
		{
			name = "activityMain_1_7",
			component = ActivityMainView_1_7
		},
		{
			name = "activityMain_2_0",
			component = ActivityMainView_2_0
		},
		{
			name = "heroPreviewMain",
			component = HeroPreviewMain
		},
		{
			name = "heroPortrait",
			component = HeroPortraitView
		},
		{
			name = "guildActivitySignUp",
			component = GuildActivitySignUpView
		},
		{
			name = "guildActivityWarField",
			component = GuildActivityWarFieldView
		},
		{
			name = "guildActivityNormalPop",
			component = GuildActivityNormalPopView
		},
		{
			name = "guildActivityElitePop",
			component = GuildActivityElitePopView
		},
		{
			name = "guildActivityBossPop",
			component = GuildActivityBossPopView
		},
		{
			name = "guildActivityRecord",
			component = GuildActivityRecordView
		},
		{
			name = "guildActivityTeamInfo",
			component = GuildActivityTeamInfoView
		},
		{
			name = "guildActivityFightHeroSetting",
			component = GuildActivityFightHeroSettingView
		},
		{
			name = "guildActivitySetFightHero",
			component = GuildActivitySetFightHeroView
		},
		{
			name = "guildActivitySelectHero",
			component = GuildActivitySelectHeroView
		},
		{
			name = "guildActivityRank",
			component = GuildActivityRankView
		},
		{
			name = "guildActivityAffixMain",
			component = GuildActivityAffixMainView
		},
		{
			name = "guildActivityReward",
			component = GuildActivityRewardView
		},
		{
			name = "guildActivityRate",
			component = GuildActivityRateView
		},
		{
			name = "guildActivityRateUpgrad",
			component = GuildActivityRateUpgradView
		},
		{
			name = "guildActivityNodeResult",
			component = GuildActivityNodeResultView
		},
		{
			name = "guildActivityNote",
			component = GuildActivityNoteView
		},
		{
			name = "mythicFinalTeamView",
			component = MythicFinalTeamView
		},
		{
			name = "mythicFinalTeamViewItem",
			component = MythicFinalTeamViewItem
		},
		{
			name = "mythicChipManagerView",
			component = MythicChipManagerView
		},
		{
			name = "mythicChipManagerUnlockView",
			component = MythicChipManagerUnlockView
		},
		{
			name = "mythicChipManagerItem",
			component = MythicChipManagerItem
		},
		{
			name = "mythicHeroTeamInfoView",
			component = MythicHeroTeamInfoView
		},
		{
			name = "mythicCampAddPopView",
			component = MythicCampAddPopView
		},
		{
			name = "mythicComboSkillSelectView",
			component = MythicComboSkillSelectView
		},
		{
			name = "mythicComboSkillSelectItem",
			component = MythicComboSkillSelectItem
		},
		{
			name = "battleMythicFinalResultView",
			component = BattleMythicFinalResultView
		},
		{
			name = "battleMythicFinalFailedView",
			component = BattleMythicFinalFailedView
		},
		{
			name = "mythicFinalRankView",
			component = MythicFinalRankView
		},
		{
			name = "equipMoreAttribute",
			component = EquipMoreAttributeView
		},
		{
			name = "activityStoryStageBase",
			component = ActivityStoryStageBaseView
		},
		{
			name = "activityAthenaStoryStage",
			component = ActivityAthenaStoryView
		},
		{
			name = "activityFactoryStoryStage",
			component = ActivityFactoryStoryView
		},
		{
			name = "stageArchive",
			component = StageArchiveView
		},
		{
			name = "sequentialBattleFactory",
			component = SequentialBattleFactoryView
		},
		{
			name = "sequentialBattleFactoryTeam",
			component = SequentialBattleFactoryTeamView
		},
		{
			name = "sectionSelectHeroSequentialBattle",
			component = SectionSelectHeroSequentialBattleView
		},
		{
			name = "heroTeamInfoSequentialBattle",
			component = HeroTeamInfoSequentialBattleView
		},
		{
			name = "comboSkillSelectSequentialBattle",
			component = ComboSkillSelectSequentialBattleView
		},
		{
			name = "sequentialBattleBossInfo",
			component = SequentialBattleBossInfoView
		},
		{
			name = "sequentialBattleBuffInfo",
			component = SequentialBattleBuffInfoView
		},
		{
			name = "chipManagerSequentialBattle",
			component = ChipManagerSequentialBattleView
		},
		{
			name = "sequentialBattleReward",
			component = SequentialBattleRewardView
		},
		{
			name = "sequentialBattleResult",
			component = BattleSequentialBattleResultView
		},
		{
			name = "sequentialBattleFailed",
			component = BattleFailedSequentialView
		},
		{
			name = "towerGameView",
			component = TowerGameView
		},
		{
			name = "towerGameRewardView",
			component = TowerGameRewardView
		},
		{
			name = "towerGamePlaneView",
			component = TowerGamePlaneView
		},
		{
			name = "towerGameSectionInfoView",
			component = TowerGameSectionInfoView
		},
		{
			name = "infinityTaskBase",
			component = InfinityTaskBaseView
		},
		{
			name = "infinityRewardPreviewBase",
			component = ActivityInfinityPoolRewardPreviewBaseView
		},
		{
			name = "infinityTaskFactory",
			component = InfinityTaskFactoryView
		},
		{
			name = "infinityRewardPreviewFactory",
			component = ActivityInfinityPoolRewardPreviewFactoryView
		},
		{
			name = "springFestivalGreetingEnvelop",
			component = SpringFestivalGreetingEnvelopView
		},
		{
			name = "springFestivalGreetingLetter",
			component = SpringFestivalGreetingLetterView
		},
		{
			name = "springFestivalRiddleMain",
			component = SpringFestivalRiddleMainView
		},
		{
			name = "springFestivalRiddleQuestion",
			component = SpringFestivalRiddleQuestionView
		},
		{
			name = "springFestivalRiddleReward",
			component = SpringFestivalRiddleRewardView
		},
		{
			name = "cooperationBlank",
			component = BlankView
		},
		{
			name = "heroTeamInfoCooperation",
			component = HeroTeamInfoCooperationView
		},
		{
			name = "battleCooperationFailed",
			component = BattleCooperationFailedView
		},
		{
			name = "cooperation",
			component = CooperationView
		},
		{
			name = "cooperationInvitation",
			component = CooperationInvitationView
		},
		{
			name = "cooperationApply",
			component = CooperationApplyView
		},
		{
			name = "summerCooperationCreatRoom",
			component = SummerCooperationCreatRoomView
		},
		{
			name = "demoCooperationEntry",
			component = DemoCooperationEntryView
		},
		{
			name = "surviveSolo",
			component = SurviveSoloMainView
		},
		{
			name = "mardukSpecialMain",
			component = MardukSpecialMainView
		},
		{
			name = "mardukSpecialRank",
			component = MardukSpecialRankView
		},
		{
			name = "mardukSpecialReward",
			component = MardukSpecialRewardView
		},
		{
			name = "mardukSpecialNote",
			component = MardukSpecialNoteView
		},
		{
			name = "surviveSoloSectionInfo",
			component = SurviveSoloSectionInfoView
		},
		{
			name = "surviveSoloReward",
			component = SurviveSoloRewardPopView
		},
		{
			name = "mythicFinalRankHeroView",
			component = MythicFinalRankHeroView
		},
		{
			name = "skuldTravelView",
			component = SkuldTravelView
		},
		{
			name = "skuldTravelFinalResultView",
			component = SkuldTravelFinalResultView
		},
		{
			name = "skuldTravelItemSelectView",
			component = SkuldTravelItemSelectView
		},
		{
			name = "skuldTravelMapView",
			component = SkuldTravelMapView
		},
		{
			name = "skuldTravelPlotView",
			component = SkuldTravelPlotView
		},
		{
			name = "skuldTravelResultView",
			component = SkuldTravelResultView
		},
		{
			name = "skuldTravelRewardView",
			component = SkuldTravelRewardView
		},
		{
			name = "skuldTravelShowPlotView",
			component = SkuldTravelShowPlotView
		},
		{
			name = "skuldTravelTipsView",
			component = SkuldTravelTipsView
		},
		{
			name = "skuldTravelFinalPlotView",
			component = SkuldTravelFinalPlotView
		},
		{
			name = "nienWorldBoss",
			component = NienWorldBossView
		},
		{
			name = "ActivityWorldBossSkill",
			component = ActivityWorldBossSkillView
		},
		{
			name = "sectionSelectHeroActivityWorldBoss",
			component = SectionSelectHeroActivityWorldBossView
		},
		{
			name = "antitheticalCouplet",
			component = AntitheticalCoupletMainView
		},
		{
			name = "antitheticalCoupletResult",
			component = AntitheticalCoupletResultView
		},
		{
			name = "paperCutMain",
			component = PaperCutMainView
		},
		{
			name = "paperCutPlay",
			component = PaperCutPlayView
		},
		{
			name = "paperCutReward",
			component = PaperCutRewardView
		},
		{
			name = "paperCutResult",
			component = PaperCutResultView
		},
		{
			name = "fireWorkMain",
			component = FireWorkMainView
		},
		{
			name = "fireWorkMake",
			component = FireWorkMakeView
		},
		{
			name = "fireWorkShow",
			component = FireWorkShowView
		},
		{
			name = "fireWorkResult",
			component = FireWorkResultView
		},
		{
			name = "newDemonChallengeMain",
			component = NewDemonChallengeMainView
		},
		{
			name = "newDemonChallengeReward",
			component = NewDemonChallengeRewardView
		},
		{
			name = "newDemonChallengeDifficultySelect",
			component = NewDemonChallengeDifficultySelectView
		},
		{
			name = "dreamDemonChallengeMain",
			component = DreamDemonChallengeMainView
		},
		{
			name = "polyhedronBlank",
			component = BlankView
		},
		{
			name = "polyhedronLobby",
			component = PolyhedronLobbyView
		},
		{
			name = "polyhedronOver",
			component = PolyhedronOverView
		},
		{
			name = "battleStatisticsPolyhdronOver",
			component = BattleStatisticsPolyhdronOverView
		},
		{
			name = "polyhedronBeacon",
			component = PolyhedronBeaconView
		},
		{
			name = "polyhedronBeaconOperate",
			component = PolyhedronBeaconOperateView
		},
		{
			name = "polyhedronTerminal",
			component = PolyhedronTerminalView
		},
		{
			name = "polyhedronTerminalLevel",
			component = PolyhedronTerminalLevelView
		},
		{
			name = "polyhedronDifficulty",
			component = PolyhedronDifficultyView
		},
		{
			name = "polyhedronTask",
			component = PolyhedronTaskView
		},
		{
			name = "polyhedronRank",
			component = PolyhedronRankView
		},
		{
			name = "polyhedronRankSquads",
			component = PolyhedronRankSquadsView
		},
		{
			name = "polyhedronPolicyReward",
			component = PolyhedronPolicyRewardView
		},
		{
			name = "polyhedronLeader",
			component = PolyhedronLeaderView
		},
		{
			name = "heroTeamInfoPolyhedron",
			component = HeroTeamInfoPolyhedronView
		},
		{
			name = "polyhedronArtifactAtlas",
			component = PolyhedronArtifactAtlasView
		},
		{
			name = "polyhedronArtifactTips",
			component = PolyhedronArtifactTipsView
		},
		{
			name = "polyhedronHero",
			component = PolyhedronHeroView
		},
		{
			name = "polyhedronCampAddPop",
			component = PolyhedronCampAddPopView
		},
		{
			name = "polyhedronTeamInfo",
			component = PolyhedronTeamInfoView
		},
		{
			name = "battlePolyhedronFailed",
			component = BattlePolyhedronFailedView
		},
		{
			name = "polyhedronBattle",
			component = PolyhedronBattleView
		},
		{
			name = "polyhedronInteractive",
			component = PolyhedronInteractiveView
		},
		{
			name = "polyhedronInteractiveHero",
			component = PolyhedronInteractiveHeroView
		},
		{
			name = "polyhedronInteractiveShop",
			component = PolyhedronInteractiveShopView
		},
		{
			name = "polyhedronReward",
			component = PolyhedronRewardView
		},
		{
			name = "polyhedronShop",
			component = PolyhedronShopView
		},
		{
			name = "valentineGameMain",
			component = ValentineGameMainView
		},
		{
			name = "valentineGameLoading",
			component = ValentineGameLoadingView
		},
		{
			name = "valentineGameReward",
			component = ValentineGameRewardView
		},
		{
			name = "valentineGameTest",
			component = ValentineGameTestView
		},
		{
			name = "valentineGameLoading",
			component = ValentineGameLoadingView
		},
		{
			name = "valentineGame",
			component = ValentineGameView
		},
		{
			name = "valentineResult",
			component = ValentineGameResultView
		},
		{
			name = "affixSelectMain",
			component = AffixSelectMainView
		},
		{
			name = "affixSelectScoreReward",
			component = AffixSelectScoreRewardView
		},
		{
			name = "affixSelectFirstReward",
			component = AffixSelectFirstRewardView
		},
		{
			name = "affixSelectDetail",
			component = AffixSelectDetailView
		},
		{
			name = "affixSelectBossInfo",
			component = AffixSelectBossInfoView
		},
		{
			name = "xH1stSealHome",
			component = XH1stSealHomeView
		},
		{
			name = "xH1stSealGame",
			component = XH1stSealGameView
		},
		{
			name = "activityCultivateHeroMain",
			component = ActivityCultivateHeroMainView
		},
		{
			name = "cultivateAccumulateReward",
			component = CultivateAccumulateRewardView
		},
		{
			name = "activityPt2Enter",
			component = ActivityPt2EnterView
		},
		{
			name = "activityPt2",
			component = ActivityPt2View
		},
		{
			name = "activityPt2SectionInfo",
			component = ActivityPt2SectionInfoView
		},
		{
			name = "abyssMain",
			component = AbyssMainView
		},
		{
			name = "bossInfo",
			component = BossInfoView
		},
		{
			name = "abyssTip",
			component = AbyssTipView
		},
		{
			name = "abyssRank",
			component = AbyssRankView
		},
		{
			name = "abyssResetConfirm",
			component = AbyssResetConfirmView
		},
		{
			name = "abyssTeamCheck",
			component = AbyssTeamCheckView
		},
		{
			name = "abyssTeamInfo",
			component = AbyssTeamInfoView
		},
		{
			name = "abyssSelectHero",
			component = AbyssSelectHeroView
		},
		{
			name = "abyssReward",
			component = AbyssRewardView
		},
		{
			name = "abyssBattleResult",
			component = AbyssBattleResultView
		},
		{
			name = "abyssBossDetail",
			component = AbyssBossDetailView
		},
		{
			name = "capsuleToysReward",
			component = CapsuleToysRewardView
		},
		{
			name = "regressionNew",
			component = RegressionNewView
		},
		{
			name = "capsuleToysGetReward",
			component = CapsuleToysGetRewardView
		},
		{
			name = "regressionNewGift",
			component = RegressionNewGiftView
		},
		{
			name = "transitionSkill",
			component = TransitionSkillView
		},
		{
			name = "transitionGiftPt",
			component = TransitionGiftPtPopView
		},
		{
			name = "weaponModuleView",
			component = WeaponModuleView
		},
		{
			name = "weaponModuleStoryView",
			component = WeaponModuleStoryView
		},
		{
			name = "weaponModulePreviewView",
			component = WeaponModulePreviewView
		},
		{
			name = "weaponModuleServantInfoView",
			component = WeaponModuleServantInfoView
		},
		{
			name = "weaponModuleGodInfoView",
			component = WeaponModuleGodInfoView
		},
		{
			name = "weaponModuleUnlockView",
			component = WeaponModuleUnlockView
		},
		{
			name = "weaponModuleLevelUpView",
			component = WeaponModuleLevelUpView
		},
		{
			name = "weaponModuleUnlockPopView",
			component = WeaponModuleUnlockPopView
		},
		{
			name = "weaponModuleLevelUpPopView",
			component = WeaponModuleLevelUpPopView
		},
		{
			name = "moduleItemResolveView",
			component = ModuleItemResolveView
		},
		{
			name = "drawAllHeroSelect",
			component = DrawAllHeroSelectView
		},
		{
			name = "sectionSelectHeroMythicFinalView",
			component = SectionSelectHeroMythicFinalView
		}
	}
}
