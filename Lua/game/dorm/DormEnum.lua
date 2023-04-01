slot0 = {
	RestaurantMode = {
		Start = "Start",
		RestaurantManual = "RestaurantManual",
		Close = "Close",
		RestaurantAuto = "RestaurantAuto"
	},
	CateenCharacterBubbleType = {
		onlyString = "onlyString",
		hasTimer = "hasTimer"
	},
	EntityType = {
		FoodItem = "FoodItem",
		Furniture = "Furniture",
		Character = "Character"
	},
	ControlType = {
		Player = "Player",
		AI = "AI"
	},
	CharacterType = {
		RestaurantSpecialCustomer = "RestaurantSpecialCustomer",
		RestaurantCashier = "RestaurantCashier",
		DormNormalHero = "DormNormalHero",
		RestaurantWaiter = "RestaurantWaiter",
		RestaurantNormalCustomer = "RestaurantNormalCustomer",
		RestaurantCook = "RestaurantCook"
	},
	ItemType = {
		Steamer = "Steamer",
		TrashCan = "TrashCan",
		Pan = "Pan",
		CashierTable = "CashierTable",
		DinningChair = "DinningChair",
		OrderFoodDummy = "OrderFoodDummy",
		Food = "Food",
		Pot = "Pot",
		DinningTable = "DinningTable",
		Oven = "Oven",
		PassTable = "PassTable"
	},
	FurnitureTypeNum = {
		Pot = 6,
		Oven = 5,
		Pan = 3,
		Steamer = 4
	},
	BusinessStatus = {
		RestaurantClose = "关门中",
		RestaurantOpen = "营业中"
	},
	Namespace = {
		EntityOnTrigger = "entity.trigger",
		EntityCurrentAction = "entity.currentAction",
		RestaurantBusiness = "restaurant.data",
		EntityType = "entity",
		EntityData = "entity.data"
	},
	Points = {
		RestaurantCustomerPay = "RestaurantCustomerPay",
		RestaurantFoodSpawn = "RestaurantFoodSpawn",
		RestaurantCashier = "RestaurantCashier",
		RestaurantExit = "RestaurantExit",
		RestaurantWaiter = "RestaurantWaiter",
		RestaurantNormalCustomer = "RestaurantNormalCustomer",
		RestaurantCook = "RestaurantCook"
	},
	FoodState = {
		HasCook = "HasCook",
		Canceled = "Canceled",
		TimeOut = "TimeOut",
		HasServer = "HasServer",
		Cooking = "Cooking",
		Wait = "Wait"
	},
	UniversalUIType = {
		FoodName = "FoodName",
		TasteName = "TasteName"
	},
	BubbleType = {
		CharacterEmotion = "CharacterEmotion",
		Complete = "Complete",
		WaitForFood = "WaitForFood",
		Working = "Working",
		Award = "Award"
	},
	FoodQuality = {
		high = 3,
		low = 1,
		normal = 2
	},
	MenuType = {
		foodMenu = "foodMenu",
		bag = "bag",
		levleAward = "levleAward"
	},
	CharacterScene = {
		PrivateDorm = "PrivateDorm",
		None = "None",
		PublicDorm = "PublicDorm",
		Canteen = "Canteen"
	},
	CharacterAIState = {
		Interact = "Interact",
		None = "None",
		Observe = "Observe",
		Move = "Move"
	}
}
slot0.RestaurantKitchenWare = {
	[3] = slot0.ItemType.Pan,
	[4] = slot0.ItemType.Steamer,
	[5] = slot0.ItemType.Oven,
	[6] = slot0.ItemType.Pot
}
slot0.RestaurantJobToServerMap = {
	[slot0.CharacterType.RestaurantCook] = 1,
	[slot0.CharacterType.RestaurantWaiter] = 2,
	[slot0.CharacterType.RestaurantCashier] = 3
}
slot0.RestaurantJobToClientMap = {
	"RestaurantCook",
	"RestaurantWaiter",
	"RestaurantCashier"
}
slot0.DormRoomUseState = {
	Lock = "Lock",
	HadPlace = "HadPlace",
	Unlock = "Unlock"
}
slot0.DormHeroState = {
	InPrivateDorm = "InPrivateDorm",
	InCanteenJob = "InCanteenJob",
	InCanteenRntrust = "InCanteenRntrust",
	OutDorm = "OutDorm",
	InPublicDorm = "InPublicDorm"
}
slot0.DormSystemType = {
	Dormitory = "Dormitory",
	Canteen = "Canteen"
}
slot0.DormDeployType = {
	Occupy = "Occupy",
	Place = "Place",
	ReCall = "ReCall"
}
slot0.FurItemType = {
	Edit = "Edit",
	Gift = "Gift"
}
slot0.FoodSellType = {
	SignFood = "SignFood",
	ForSale = "ForSale"
}
slot0.FoodType = {
	[3] = GameDisplayCfg.canteen_cooker_food_type.value[1][2],
	[4] = GameDisplayCfg.canteen_cooker_food_type.value[2][2],
	[5] = GameDisplayCfg.canteen_cooker_food_type.value[3][2],
	[6] = GameDisplayCfg.canteen_cooker_food_type.value[4][2]
}
slot1, slot2 = pcall(require, "bit")

if not slot1 then
	slot1, slot2 = pcall(require, "bit32")
end

slot0.BeginStoryFlag = {
	HideFurniture = 2,
	HideCharacter = 1,
	HideBoth = 3,
	None = 0
}

function slot0.HasFlag(slot0, slot1)
	return uv0.band(uv0.tobit(slot0), uv0.tobit(slot1)) ~= 0
end

return slot0
