return {
	[0] = {
		id = 0,
		desc = "成功",
		define = "SUCCESS",
		audio = "success"
	},
	{
		id = 1,
		desc = "服务器内部错误",
		define = "ERROR_SERVER_INTERNAL",
		audio = "ban"
	},
	{
		id = 2,
		desc = "无效操作",
		define = "ERROR_INVALID_OPERATION",
		audio = "ban"
	},
	{
		id = 3,
		desc = "缺少配置",
		define = "ERROR_NO_TEMPLATE",
		audio = "ban"
	},
	{
		id = 4,
		desc = "配置错误",
		define = "ERROR_BAD_TEMPLATE",
		audio = "ban"
	},
	{
		id = 5,
		desc = "错误参数",
		define = "ERROR_BAD_ARG",
		audio = "ban"
	},
	{
		id = 6,
		desc = "服务器不存在",
		define = "ERROR_SERVER_NOT_EXIST",
		audio = "ban"
	},
	{
		id = 7,
		desc = "超时",
		define = "ERROR_TIME_OUT",
		audio = "ban"
	},
	{
		id = 8,
		desc = "时间未到",
		define = "ERROR_NOT_TIME",
		audio = "ban"
	},
	{
		id = 9,
		desc = "远程调用失败",
		define = "ERROR_RPC_EXCEPTION",
		audio = "ban"
	},
	{
		id = 10,
		desc = "功能未开放",
		define = "ERROR_FUNCTION_NOT_OPEN",
		audio = "ban"
	},
	{
		id = 11,
		desc = "时间戳错误",
		define = "ERROR_TIMESTAMP",
		audio = "ban"
	},
	{
		id = 12,
		desc = "进程不存在",
		define = "ERROR_PROC_NOT_ALIVE",
		audio = "ban"
	},
	{
		id = 13,
		desc = "服务器繁忙，请稍后重试",
		define = "ERROR_SERVER_BUSY",
		audio = "ban"
	},
	{
		id = 14,
		desc = "服务器繁忙，请稍后重试",
		define = "ERROR_PROC_EXCEPTION",
		audio = "ban"
	},
	{
		id = 15,
		desc = "服务器繁忙，请稍后重试",
		define = "ERROR_PROC_BAD_REQUEST",
		audio = "ban"
	},
	{
		id = 16,
		desc = "服务器非内网部署",
		define = "ERROR_NOT_INTERNAL_DEPLOY",
		audio = "ban"
	},
	{
		id = 17,
		desc = "功能暂时关闭，具体开放时间请关注公告",
		define = "ERROR_FUNCTION_STOP",
		audio = "ban"
	},
	[100] = {
		id = 100,
		desc = "数据库错误",
		define = "ERROR_DATABASE",
		audio = "ban"
	},
	[101] = {
		id = 101,
		desc = "数据不存在",
		define = "ERROR_NO_DATA",
		audio = "ban"
	},
	[200] = {
		id = 200,
		desc = "网络数据不完整",
		define = "ERROR_NET_DATA_INCOMPLETE",
		audio = "ban"
	},
	[201] = {
		id = 201,
		desc = "网络数据不合法（格式什么跟约定不符）",
		define = "ERROR_NET_DATA_ILLEGAL",
		audio = "ban"
	},
	[1000] = {
		id = 1000,
		desc = "账号已被使用",
		define = "ERROR_LOGIN_USED_ACCOUNT",
		audio = "ban"
	},
	[1001] = {
		id = 1001,
		desc = "登录密码错误",
		define = "ERROR_LOGIN_WRONG_PASSWORD",
		audio = "ban"
	},
	[1002] = {
		id = 1002,
		desc = "登录时serverid校验失败",
		define = "ERROR_LOGIN_SERVER_ID_CHECK_FAIL",
		audio = "ban"
	},
	[1003] = {
		id = 1003,
		desc = "管理员数据出现错误，请重新登录",
		define = "ERROR_LOGIN_TOKEN_CHK_FAIL",
		audio = "ban"
	},
	[1004] = {
		id = 1004,
		desc = "服务器正在维护中",
		define = "ERROR_LOGIN_SERVER_MAINTAIN",
		audio = "ban"
	},
	[1005] = {
		id = 1005,
		desc = "黑名单玩家不允许登录",
		define = "ERROR_LOGIN_BLACKLIST_USER",
		audio = "ban"
	},
	[1006] = {
		id = 1006,
		desc = "没有可用的mnesia节点",
		define = "ERROR_LOGIN_INVALID_USER_MNESIA",
		audio = "ban"
	},
	[1007] = {
		id = 1007,
		desc = "服务器已满，新账号暂时无法登录",
		define = "ERROR_LOGIN_REGISTER_LIMIT",
		audio = "ban"
	},
	[1008] = {
		id = 1008,
		desc = "登录前置状态错误",
		define = "ERROR_LOGIN_BEFORE_LOGIN",
		audio = "ban"
	},
	[1009] = {
		id = 1009,
		desc = "平台验证失败",
		define = "ERROR_LOGIN_PLATFORM_REJECT",
		audio = "ban"
	},
	[2000] = {
		id = 2000,
		desc = "已达到最大等级",
		define = "ERROR_USER_MAX_LV",
		audio = "success"
	},
	[2001] = {
		id = 2001,
		desc = "已达到最大数量",
		define = "ERROR_USER_MAX_NUMBER",
		audio = "success"
	},
	[2002] = {
		id = 2002,
		desc = "已经完成",
		define = "ERROR_USER_COMPLETED",
		audio = "success"
	},
	[2003] = {
		id = 2003,
		desc = "等级不符合",
		define = "ERROR_USER_LV_LIMIT",
		audio = "ban"
	},
	[2004] = {
		id = 2004,
		desc = "修正者属性类型不符合",
		define = "ERROR_USER_TYPE_LIMIT",
		audio = "ban"
	},
	[2005] = {
		id = 2005,
		desc = "未达到条件",
		define = "ERROR_USER_NOT_ACHIEVE_CONDITION",
		audio = "ban"
	},
	[2006] = {
		id = 2006,
		desc = "昵称已被使用",
		define = "ERROR_USER_NAME_EXIST",
		audio = "ban"
	},
	[2007] = {
		id = 2007,
		desc = "存在限制词汇",
		define = "ERROR_USER_NAME_VER_WORD",
		audio = "ban"
	},
	[2008] = {
		id = 2008,
		desc = "昵称不能为空",
		define = "ERROR_USER_NAME_TOO_SHORT",
		audio = "ban"
	},
	[2009] = {
		id = 2009,
		desc = "管理员等级不足",
		define = "ERROR_USER_LEVEL_LIMIT",
		audio = "ban"
	},
	[2010] = {
		id = 2010,
		desc = "不能使用默认昵称",
		define = "ERROR_USER_DEFAULT_NICK",
		audio = "ban"
	},
	[2011] = {
		id = 2011,
		desc = "未通关指定关卡",
		define = "ERROR_STAGE_NOT_CLEAR",
		audio = "ban"
	},
	[2012] = {
		id = 2012,
		desc = "玩家不存在",
		define = "ERROR_USER_NOT_EXIST",
		audio = "ban"
	},
	[2013] = {
		id = 2013,
		desc = "奖励已经领取过了",
		define = "ERROR_REWARD_ALREADY_RECEIVED",
		audio = "ban"
	},
	[2014] = {
		id = 2014,
		desc = "字符长度超过限制",
		define = "ERROR_STRING_LENGTH_LIMIT",
		audio = "ban"
	},
	[2015] = {
		id = 2015,
		desc = "版本不一致",
		define = "ERROR_VERSION_INCONSISTENT",
		audio = "ban"
	},
	[2016] = {
		id = 2016,
		desc = "数量限制",
		define = "ERROR_NUM_LIMIT",
		audio = "ban"
	},
	[2017] = {
		id = 2017,
		desc = "选择的词缀不合法",
		define = "ERROR_SELECT_AFFIX_NOT_LEGAL",
		audio = "ban"
	},
	[2018] = {
		id = 2018,
		desc = "刷新频率过快，请稍后再试",
		define = "ERROR_REFRESH_TOO_FAST",
		audio = "ban"
	},
	[2100] = {
		id = 2100,
		desc = "艾因索菲币不足",
		define = "ERROR_ITEM_NOT_ENOUGH_GOLD",
		audio = "ban"
	},
	[2101] = {
		id = 2101,
		desc = "移转之辉不足",
		define = "ERROR_ITEM_NOT_ENOUGH_DIAMOND",
		audio = "ban"
	},
	[2102] = {
		id = 2102,
		desc = "修正者情报不足",
		define = "ERROR_ITEM_NOT_ENOUGH_HERO_PIECE",
		audio = "ban"
	},
	[2103] = {
		id = 2103,
		desc = "探测凭证不足",
		define = "ERROR_ITEM_NOT_ENOUGH_DRAW",
		audio = "ban"
	},
	[2104] = {
		id = 2104,
		desc = "货币不足",
		define = "ERROR_ITEM_NOT_ENOUGH_CURRENCY",
		audio = "ban"
	},
	[2105] = {
		id = 2105,
		desc = "无此类型的资源",
		define = "ERROR_ITEM_NO_RESOURCE_TYPE",
		audio = "ban"
	},
	[2106] = {
		id = 2106,
		desc = "配置表中无此资源id",
		define = "ERROR_ITEM_NO_RESOURCE_ID_IN_CONFIG",
		audio = "ban"
	},
	[2107] = {
		id = 2107,
		desc = "购买艾因索菲币次数超出限制",
		define = "ERROR_ITEM_DIAMOND_COIN_TIMES_OVER_LIMIT",
		audio = "ban"
	},
	[2108] = {
		id = 2108,
		desc = "某种货币超出限制",
		define = "ERROR_ITEM_CURRENCY_OVER_LIMIT",
		audio = "ban"
	},
	[2109] = {
		id = 2109,
		desc = "吨吨值不足",
		define = "ERROR_ITEM_NOT_ENOUGH_FATIGUE",
		audio = "ban"
	},
	[2110] = {
		id = 2110,
		desc = "购买吨吨值次数超出限制",
		define = "ERROR_ITEM_DIAMOND_FATIGUE_TIMES_OVER_LIMIT",
		audio = "ban"
	},
	[2111] = {
		id = 2111,
		desc = "吨吨值达到上限",
		define = "ERROR_ITEM_FATIGUE_LIMIT",
		audio = "ban"
	},
	[2112] = {
		id = 2112,
		desc = "高级情报徽章数量不足",
		define = "ERROR_ITEM_NOT_ENOUGH_INFO_BADGE_TOP",
		audio = "ban"
	},
	[2113] = {
		id = 2113,
		desc = "中级情报徽章数量不足",
		define = "ERROR_ITEM_NOT_ENOUGH_INFO_BADGE_MID",
		audio = "ban"
	},
	[2114] = {
		id = 2114,
		desc = "低级情报徽章数量不足",
		define = "ERROR_ITEM_NOT_ENOUGH_INFO_BADGE_LOW",
		audio = "ban"
	},
	[2115] = {
		id = 2115,
		desc = "回溯之章数量不足",
		define = "ERROR_ITEM_NOT_ENOUGH_RECALL_CHAPTER",
		audio = "ban"
	},
	[2116] = {
		id = 2116,
		desc = "材料不足",
		define = "ERROR_ITEM_NOT_ENOUGH_MATERIAL",
		audio = "ban"
	},
	[2117] = {
		id = 2117,
		desc = "无材料",
		define = "ERROR_ITEM_NO_MATERIAL",
		audio = "ban"
	},
	[2118] = {
		id = 2118,
		desc = "材料不足",
		define = "ERROR_ITEM_NO_ENOUGH_MATERIAL",
		audio = "ban"
	},
	[2119] = {
		id = 2119,
		desc = "今日探测次数达到上限",
		define = "ERROR_ITEM_DRAW_LIMIT",
		audio = "ban"
	},
	[2120] = {
		id = 2120,
		desc = "无法使用已到期的道具",
		define = "ERROR_ITEM_TIME_INVALID",
		audio = "ban"
	},
	[2121] = {
		id = 2121,
		desc = "当前道具已过期，无法使用",
		define = "ERROR_FUNCTION_ITEM_TIME_INVALID",
		audio = "ban"
	},
	[2122] = {
		id = 2122,
		desc = "已经使用过相同配置的生贺道具",
		define = "ERROR_BIRTHDAY_ITEM_REPEAT",
		audio = "ban"
	},
	[2200] = {
		id = 2200,
		desc = "刻印方案数量已达上限",
		define = "ERROR_EQUIP_PROPOSAL_NUM_LIMIT",
		audio = "ban"
	},
	[2201] = {
		id = 2201,
		desc = "刻印方案已存在",
		define = "ERROR_EQUIP_PROPOSAL_EXIST",
		audio = "ban"
	},
	[2202] = {
		id = 2202,
		desc = "该方案不存在",
		define = "ERROR_EQUIP_PROPOSAL_ID_NOT_EXIST",
		audio = "ban"
	},
	[2203] = {
		id = 2203,
		desc = "无刻印",
		define = "ERROR_NO_EQUIP",
		audio = "ban"
	},
	[2204] = {
		id = 2204,
		desc = "用于消耗的刻印已经锁定",
		define = "ERROR_EQUIP_LOCK",
		audio = "ban"
	},
	[2205] = {
		id = 2205,
		desc = "不可使用被强化的刻印作为强化材料",
		define = "ERROR_EQUIP_STRENGTH_EQUIP_IN_MAT",
		audio = "ban"
	},
	[2206] = {
		id = 2206,
		desc = "不能分解装备中的刻印",
		define = "ERROR_EQUIP_NO_RESOLVE_USING_EQUIP",
		audio = "ban"
	},
	[2207] = {
		id = 2207,
		desc = "不能分解在方案中的刻印",
		define = "ERROR_EQUIP_IN_PROPOSAL",
		audio = "ban"
	},
	[2208] = {
		id = 2208,
		desc = "刻印等级不足",
		define = "ERROR_EQUIP_LEVEL_LIMIT",
		audio = "ban"
	},
	[2209] = {
		id = 2209,
		desc = "刻印星级不符合",
		define = "ERROR_EQUIP_STAR_LIMIT",
		audio = "ban"
	},
	[2210] = {
		id = 2210,
		desc = "刻印赋能预览无内容",
		define = "ERROR_EQUIP_ENCHANT_PREVIEW_NO_EXIST",
		audio = "ban"
	},
	[2211] = {
		id = 2211,
		desc = "刻印赋能预览已有",
		define = "ERROR_EQUIP_ENCHANT_PREVIEW_EXIST",
		audio = "ban"
	},
	[2212] = {
		id = 2212,
		desc = "刻印神系预览无内容",
		define = "ERROR_EQUIP_RACE_PREVIEW_NO_EXIST",
		audio = "ban"
	},
	[2213] = {
		id = 2213,
		desc = "刻印神系预览已有",
		define = "ERROR_EQUIP_RACE_PREVIEW_EXIST",
		audio = "ban"
	},
	[2214] = {
		id = 2214,
		desc = "超出刻印数量限制",
		define = "ERROR_EQUIP_EXCEED_LIMIT",
		audio = "ban"
	},
	[2220] = {
		id = 2220,
		desc = "不能继承原先的刻印",
		define = "ERROR_EQUIP_SAME_ID",
		audio = "ban"
	},
	[2221] = {
		id = 2221,
		desc = "刻印位置错误",
		define = "ERROR_EQUIP_POS_LIMIT",
		audio = "ban"
	},
	[2300] = {
		id = 2300,
		desc = "钥从超越材料星级不合法",
		define = "ERROR_SERVANT_STAR_LIMIT",
		audio = "ban"
	},
	[2301] = {
		id = 2301,
		desc = "钥从超越次数达到上限",
		define = "ERROR_SERVANT_REFINED_MAX_TIMES_LIMIT",
		audio = "starsup_max"
	},
	[2302] = {
		id = 2302,
		desc = "钥从被锁定",
		define = "ERROR_SERVANT_LOCKED",
		audio = "ban"
	},
	[2303] = {
		id = 2303,
		desc = "钥从不存在",
		define = "ERROR_SERVANT_NOT_EXIST",
		audio = "ban"
	},
	[2304] = {
		id = 2304,
		desc = "钥从参数相同",
		define = "ERROR_SERVANT_SAME",
		audio = "ban"
	},
	[2305] = {
		id = 2305,
		desc = "钥从神系不匹配",
		define = "ERROR_SERVANT_RACE_NO_MATCH",
		audio = "ban"
	},
	[2306] = {
		id = 2306,
		desc = "权钥未装备钥从",
		define = "ERROR_WEAPON_SERVANT_NOT_EQUIP",
		audio = "ban"
	},
	[2307] = {
		id = 2307,
		desc = "权钥已装备钥从",
		define = "ERROR_WEAPON_SERVANT_EQUIP",
		audio = "ban"
	},
	[2308] = {
		id = 2308,
		desc = "钥从类型错误",
		define = "ERROR_SERVANT_TYPE",
		audio = "ban"
	},
	[2309] = {
		id = 2309,
		desc = "消耗的钥从数量错误",
		define = "ERROR_SERVANT_COST_NUM",
		audio = "ban"
	},
	[2310] = {
		id = 2310,
		desc = "超出钥从数量限制",
		define = "ERROR_SERVANT_EXCEED_LIMIT",
		audio = "ban"
	},
	[2400] = {
		id = 2400,
		desc = "无法找到好友",
		define = "ERROR_FRIEND_CANT_FIND_FRIEND",
		audio = "ban"
	},
	[2401] = {
		id = 2401,
		desc = "已存在好友",
		define = "ERROR_FRIEND_EXIST_FRIEND",
		audio = "ban"
	},
	[2402] = {
		id = 2402,
		desc = "对方已存在于自己的黑名单中",
		define = "ERROR_FRIEND_EXIST_BLACK_TARGET",
		audio = "ban"
	},
	[2403] = {
		id = 2403,
		desc = "黑名单中找不到此玩家",
		define = "ERROR_FRIEND_CANT_FIND_BLACK",
		audio = "ban"
	},
	[2404] = {
		id = 2404,
		desc = "被目标玩家拉黑",
		define = "ERROR_FRIEND_IN_BLACK_NOW",
		audio = "ban"
	},
	[2405] = {
		id = 2405,
		desc = "好友数量已达上限",
		define = "ERROR_FRIEND_NUM_LIMIT_ME",
		audio = "ban"
	},
	[2406] = {
		id = 2406,
		desc = "已向此人发送过好友申请",
		define = "ERROR_FRIEND_EXIST_REQUEST",
		audio = "ban"
	},
	[2407] = {
		id = 2407,
		desc = "对方好友数量已达上限",
		define = "ERROR_FRIEND_NUM_LIMIT_TARGET",
		audio = "ban"
	},
	[2408] = {
		id = 2408,
		desc = "你已被对方拉黑，无法添加对方为好友",
		define = "ERROR_FRIEND_EXIST_BLACK_ME",
		audio = "ban"
	},
	[2409] = {
		id = 2409,
		desc = "对方不在自己的好友申请列表中",
		define = "ERROR_FRIEND_NOT_EXIST_REQUEST",
		audio = "ban"
	},
	[2410] = {
		id = 2410,
		desc = "黑名单人数已达上限",
		define = "ERROR_FRIEND_BLACK_NUM_LIMIT",
		audio = "ban"
	},
	[2411] = {
		id = 2411,
		desc = "对方可接收的好友申请数达到上限",
		define = "ERROR_FRIEND_REQUEST_NUM_LIMIT",
		audio = "ban"
	},
	[2412] = {
		id = 2412,
		desc = "推荐好友数量上限",
		define = "ERROR_FRIEND_RECOMMEND_FRIEND_LIMIT",
		audio = "ban"
	},
	[2413] = {
		id = 2413,
		desc = "请求过期",
		define = "ERROR_REQUEST_HAS_EXPIRED",
		audio = "ban"
	},
	[2414] = {
		id = 2414,
		desc = "无推荐信息",
		define = "ERROR_NOT_FIND_RECOMMEND_INFO",
		audio = "ban"
	},
	[2415] = {
		id = 2415,
		desc = "推荐好友刷新过快",
		define = "ERROR_RECOMMEND_REFRESH_TOO_FAST",
		audio = "ban"
	},
	[2416] = {
		id = 2416,
		desc = "不能申请自己好友",
		define = "ERROR_NOT_REQUEST_SELF",
		audio = "ban"
	},
	[2500] = {
		id = 2500,
		desc = "已和当前频道断开连接",
		define = "ERROR_CHAT_NOT_IN_ROOM",
		audio = "ban"
	},
	[2501] = {
		id = 2501,
		desc = "请输入1-10以内的频道号",
		define = "ERROR_CHAT_ROOM_ID_ILLEGAL",
		audio = "ban"
	},
	[2502] = {
		id = 2502,
		desc = "消息类型不合法",
		define = "ERROR_CHAT_ROOM_MSG_TYPE_ILLEGAL",
		audio = "ban"
	},
	[2503] = {
		id = 2503,
		desc = "房间已满",
		define = "ERROR_CHAT_ROOM_FULL",
		audio = "ban"
	},
	[2504] = {
		id = 2504,
		desc = "没有可用的聊天节点",
		define = "ERROR_CHAT_NODE_NOT_AVAILABLE",
		audio = "ban"
	},
	[2505] = {
		id = 2505,
		desc = "没有可用的聊天频道",
		define = "ERROR_CHAT_ROOM_NOT_AVAILABLE",
		audio = "ban"
	},
	[2506] = {
		id = 2506,
		desc = "聊天数据库暂时不可访问",
		define = "ERROR_CHAT_MNESIA_CANT_ACCESS",
		audio = "ban"
	},
	[2507] = {
		id = 2507,
		desc = "聊天室待广播消息超出队列长度",
		define = "ERROR_CHAT_ROOM_BUSY",
		audio = "ban"
	},
	[2508] = {
		id = 2508,
		desc = "不是活跃的聊天玩家",
		define = "ERROR_CHAT_NOT_ACTIVE_CHATER",
		audio = "ban"
	},
	[2509] = {
		id = 2509,
		desc = "聊天功能被禁止",
		define = "ERROR_CHAT_BAN",
		audio = "ban"
	},
	[2510] = {
		id = 2510,
		desc = "文字发送过于频繁",
		define = "ERROR_CHAT_WORD_TOO_FREQUENTLY",
		audio = "ban"
	},
	[2511] = {
		id = 2511,
		desc = "图片发送过于频繁",
		define = "ERROR_CHAT_EMOTION_TOO_FREQUENTLY",
		audio = "ban"
	},
	[2512] = {
		id = 2512,
		desc = "一次只能发送最多%s字符的消息",
		define = "ERROR_CHAT_MESSAGE_CONTENT_OVER_SIZE",
		audio = "ban"
	},
	[2600] = {
		id = 2600,
		desc = "未找到相应商店",
		define = "ERROR_SHOP_NOT_FOUND",
		audio = "ban"
	},
	[2601] = {
		id = 2601,
		desc = "商店手动刷新次数达到上限",
		define = "ERROR_SHOP_REFRESH_TIMES_LIMIT",
		audio = "ban"
	},
	[2602] = {
		id = 2602,
		desc = "购买次数已达上限",
		define = "ERROR_SHOP_BUY_TIMES_LIMIT",
		audio = "ban"
	},
	[2603] = {
		id = 2603,
		desc = "商品不存在",
		define = "ERROR_SHOP_GOODS_NOT_FOUND",
		audio = "ban"
	},
	[2604] = {
		id = 2604,
		desc = "商品不在列表内",
		define = "ERROR_SHOP_GOODS_NOT_IN_ITEM_LIST",
		audio = "ban"
	},
	[2605] = {
		id = 2605,
		desc = "商品未在售卖时间",
		define = "ERROR_SHOP_GOODS_OPEN_TIME",
		audio = "ban"
	},
	[2606] = {
		id = 2606,
		desc = "商品售价变动",
		define = "ERROR_SHOP_GOODS_CHEAP_OPEN_TIME",
		audio = "ban"
	},
	[2607] = {
		id = 2607,
		desc = "商品支付类型异常",
		define = "ERROR_SHOP_COST_TYPE",
		audio = "ban"
	},
	[2608] = {
		id = 2608,
		desc = "已拥有足够的情报将该角色超越至Ω",
		define = "ERROR_SHOP_PIECE_LIMIT",
		audio = "ban"
	},
	[2609] = {
		id = 2609,
		desc = "商品售价不一致",
		define = "ERROR_SHOP_GOODS_COST_INCONSISTENT",
		audio = "ban"
	},
	[2700] = {
		id = 2700,
		desc = "修正者未解锁",
		define = "ERROR_HERO_NOT_UNLOCK",
		audio = "ban"
	},
	[2701] = {
		id = 2701,
		desc = "修正者不存在",
		define = "ERROR_HERO_NO_HERO",
		audio = "ban"
	},
	[2702] = {
		id = 2702,
		desc = "神格已经解锁",
		define = "ERROR_HERO_ASTROLABE_UNLOCKED",
		audio = "success"
	},
	[2703] = {
		id = 2703,
		desc = "技能等级已达上限",
		define = "ERROR_HERO_SKILL_LEVEL_LIMIT",
		audio = "starsup_max"
	},
	[2704] = {
		id = 2704,
		desc = "修正者已经解锁",
		define = "ERROR_HERO_UNLOCKED",
		audio = "success"
	},
	[2705] = {
		id = 2705,
		desc = "修正者已经满超越",
		define = "ERROR_HERO_STAR_MAX",
		audio = "starsup_max"
	},
	[2706] = {
		id = 2706,
		desc = "超出修正者等级限制",
		define = "ERROR_HERO_LEVEL_LIMIT",
		audio = "ban"
	},
	[2707] = {
		id = 2707,
		desc = "对应修正者超越不足",
		define = "ERROR_HERO_STAR_LOW",
		audio = "ban"
	},
	[2708] = {
		id = 2708,
		desc = "对应修正者解锁神格数量不足",
		define = "ERROR_HERO_UNLOCK_ASTROLABE_LOW",
		audio = "ban"
	},
	[2709] = {
		id = 2709,
		desc = "对应修正者等级不足",
		define = "ERROR_HERO_LEVEL_LOW",
		audio = "ban"
	},
	[2710] = {
		id = 2710,
		desc = "对应修正者未通关指定关卡",
		define = "ERROR_HERO_STAGE_NOT_CLEAR",
		audio = "ban"
	},
	[2711] = {
		id = 2711,
		desc = "对应修正者技能等级总和不足",
		define = "ERROR_HERO_SKILL_LEVEL_SUM_LOW",
		audio = "ban"
	},
	[2712] = {
		id = 2712,
		desc = "对应修正者胜利次数不足",
		define = "ERROR_HERO_WIN_LOW",
		audio = "ban"
	},
	[2713] = {
		id = 2713,
		desc = "操作对应的神格未解锁",
		define = "ERROR_HERO_ASTROLABE_NOT_UNLOCK",
		audio = "ban"
	},
	[2714] = {
		id = 2714,
		desc = "修正者升星时情报不足",
		define = "ERROR_HERO_STAR_PIECE_LIMIT",
		audio = "ban"
	},
	[2715] = {
		id = 2715,
		desc = "修正者升级时使用的材料不合法",
		define = "ERROR_HERO_LEVEL_UP_ITEM_ILLEGAL",
		audio = "ban"
	},
	[2716] = {
		id = 2716,
		desc = "修正者分解碎片时碎片没有溢出",
		define = "ERROR_HERO_PIECE_NOT_OVERFLOW",
		audio = "ban"
	},
	[2717] = {
		id = 2717,
		desc = "修正者不可以解锁该神格",
		define = "ERROR_HERO_ASTROLABE_ILLEGAL",
		audio = "ban"
	},
	[2718] = {
		id = 2718,
		desc = "修正者皮肤未解锁",
		define = "ERROR_HERO_SKIN_ILLEGAL",
		audio = "ban"
	},
	[2719] = {
		id = 2719,
		desc = "前置神格未解锁",
		define = "ERROR_HERO_PRE_ASTROLABE_NOT_UNLOCKED",
		audio = "ban"
	},
	[2720] = {
		id = 2720,
		desc = "前置神格未装备",
		define = "ERROR_HERO_PRE_ASTROLABE_NOT_USED",
		audio = "ban"
	},
	[2721] = {
		id = 2721,
		desc = "使用的神格已经被装备",
		define = "ERROR_HERO_ASTROLABE_USING",
		audio = "ban"
	},
	[2722] = {
		id = 2722,
		desc = "要卸下的神格没有装备",
		define = "ERROR_HERO_ASTROLABE_NOT_USING",
		audio = "ban"
	},
	[2723] = {
		id = 2723,
		desc = "修正者神格已满",
		define = "ERROR_HERO_ASTROLABE_NUMBER_LIMIT",
		audio = "starsup_max"
	},
	[2724] = {
		id = 2724,
		desc = "修正者技能升级材料不足",
		define = "ERROR_HERO_NO_SKILL_UP_MAT",
		audio = "ban"
	},
	[2725] = {
		id = 2725,
		desc = "修正者突破等级不足",
		define = "ERROR_HERO_BREAK_LEVEL_LIMIT",
		audio = "ban"
	},
	[2726] = {
		id = 2726,
		desc = "修正者奥义等级不足",
		define = "ERROR_HERO_ULTRA_SKILL_LEVEL_LIMIT",
		audio = "ban"
	},
	[2727] = {
		id = 2727,
		desc = "修正者突破阶段不足",
		define = "ERROR_HERO_BREAK_LIMIT",
		audio = "ban"
	},
	[2728] = {
		id = 2728,
		desc = "修正者武器等级不足",
		define = "ERROR_HERO_WEAPON_LEVEL_LIMIT",
		audio = "ban"
	},
	[2729] = {
		id = 2729,
		desc = "修正者机制类型不满足",
		define = "ERROR_HERO_BAD_MECHANISM_TYPE",
		audio = "ban"
	},
	[2730] = {
		id = 2730,
		desc = "专属技能天赋点不足",
		define = "ERROR_HERO_EXCLUSIVE_SKILL_TALENT_POINTS_NOT_ENOUGH",
		audio = "ban"
	},
	[2731] = {
		id = 2731,
		desc = "专属技能槽位不合法",
		define = "ERROR_HERO_EXCLUSIVE_SKILL_SLOT_ID_ILLEGAL",
		audio = "ban"
	},
	[2732] = {
		id = 2732,
		desc = "专属技能不存在",
		define = "ERROR_HERO_EXCLUSIVE_SKILL_NOT_EXIST",
		audio = "ban"
	},
	[2733] = {
		id = 2733,
		desc = "专属技能超过最大等级",
		define = "ERROR_HERO_EXCLUSIVE_SKILL_LEVEL_MAX",
		audio = "ban"
	},
	[2734] = {
		id = 2734,
		desc = "天赋点超过最大等级",
		define = "ERROR_HERO_EXCLUSIVE_SKILL_TALENTS_POINTS_LEVEL_MAX",
		audio = "ban"
	},
	[2735] = {
		id = 2735,
		desc = "专属技能超过最大数量",
		define = "ERROR_HERO_EXCLUSIVE_SKILL_NUM_MAX",
		audio = "ban"
	},
	[2736] = {
		id = 2736,
		desc = "专属技能重复",
		define = "ERROR_HERO_EXCLUSIVE_SKILL_REPEAT",
		audio = "ban"
	},
	[2900] = {
		id = 2900,
		desc = "邮件不存在",
		define = "ERROR_NO_MAIL",
		audio = "ban"
	},
	[2901] = {
		id = 2901,
		desc = "溢出邮件存储数量上限",
		define = "ERROR_OVERFLOW_MAIL_NUM_LIMIT",
		audio = "ban"
	},
	[2902] = {
		id = 2902,
		desc = "没有可以领取的邮件",
		define = "ERROR_NO_MAIL_CAN_RECEIVE",
		audio = "ban"
	},
	[3000] = {
		id = 3000,
		desc = "此章未解锁",
		define = "ERROR_BATTLE_CHAPTER_NOT_UNLOCKED",
		audio = "ban"
	},
	[3001] = {
		id = 3001,
		desc = "不能获取相应的进度奖励",
		define = "ERROR_BATTLE_CAN_NOT_GET_STARS_REWARD",
		audio = "ban"
	},
	[3002] = {
		id = 3002,
		desc = "已经领取过进度奖励",
		define = "ERROR_BATTLE_ALREADY_GET_STARS_REWARD",
		audio = "ban"
	},
	[3003] = {
		id = 3003,
		desc = "相应的进度奖励id未定义",
		define = "ERROR_BATTLE_STARS_REWARD_ID_UNDEFINED",
		audio = "ban"
	},
	[3004] = {
		id = 3004,
		desc = "此物资副本未解锁",
		define = "ERROR_BATTLE_DAILY_BATTLE_NOT_UNLOCKED",
		audio = "ban"
	},
	[3005] = {
		id = 3005,
		desc = "已到达挑战次数上限",
		define = "ERROR_BATTLE_DAILY_BATTLE_TIMES_LIMIT",
		audio = "ban"
	},
	[3006] = {
		id = 3006,
		desc = "此挑战本未解锁",
		define = "ERROR_BATTLE_CHALLENGE_BATTLE_NOT_UNLOCKED",
		audio = "ban"
	},
	[3007] = {
		id = 3007,
		desc = "历战轮回关卡校验失败",
		define = "ERROR_BATTLE_TOWER_STAGE_NO_MATCH",
		audio = "ban"
	},
	[3008] = {
		id = 3008,
		desc = "黑区净化难度已锁定",
		define = "ERROR_BATTLE_MYTHIC_DIFFICULTY_CANT_MATCH",
		audio = "ban"
	},
	[3009] = {
		id = 3009,
		desc = "黑区净化难度未解锁",
		define = "ERROR_BATTLE_MYTHIC_DIFFICULTY_NOT_OPEN",
		audio = "ban"
	},
	[3012] = {
		id = 3012,
		desc = "梦境再构等级限制未解锁",
		define = "ERROR_BATTLE_BOSS_CHALLENGE_BOSS_LOCK",
		audio = "ban"
	},
	[3013] = {
		id = 3013,
		desc = "教学训练基础教学关卡未解锁",
		define = "ERROR_BATTLE_BASE_TEACHING_LOCK",
		audio = "ban"
	},
	[3014] = {
		id = 3014,
		desc = "教学训练角色教学关卡未解锁",
		define = "ERROR_BATTLE_HERO_TEACHING_LOCK",
		audio = "ban"
	},
	[3015] = {
		id = 3015,
		desc = "此关卡不能复活",
		define = "ERROR_BATTLE_NOT_RESURRECT",
		audio = "ban"
	},
	[3100] = {
		id = 3100,
		desc = "选择的up不存在",
		define = "ERROR_UP_ERROR",
		audio = "ban"
	},
	[3101] = {
		id = 3101,
		desc = "未选择up",
		define = "ERROR_UP_NO_EXIST",
		audio = "ban"
	},
	[3102] = {
		id = 3102,
		desc = "卡池未开放",
		define = "ERROR_POOL_UNOPEN",
		audio = "ban"
	},
	[3201] = {
		id = 3201,
		desc = "未解锁此插图图鉴",
		define = "ERROR_NO_UNLOCK_INBETWEENING",
		audio = "ban"
	},
	[3202] = {
		id = 3202,
		desc = "未解锁此敌人图鉴",
		define = "ERROR_NO_UNLOCK_ENEMY",
		audio = "ban"
	},
	[3203] = {
		id = 3203,
		desc = "未解锁此钥从图鉴",
		define = "ERROR_NO_UNLOCK_SERVANT",
		audio = "ban"
	},
	[3204] = {
		id = 3204,
		desc = "未解锁此装备图鉴",
		define = "ERROR_NO_UNLOCK_EQUIP",
		audio = "ban"
	},
	[3205] = {
		id = 3205,
		desc = "未解锁此剧情图鉴",
		define = "ERROR_NO_UNLOCK_PLOT",
		audio = "ban"
	},
	[3206] = {
		id = 3206,
		desc = "未解锁此词条图鉴",
		define = "ERROR_NO_UNLOCK_AFFIX",
		audio = "ban"
	},
	[3207] = {
		id = 3207,
		desc = "该音乐不能设为背景音乐",
		define = "ERROR_NO_ABLE_BGM",
		audio = "ban"
	},
	[3300] = {
		id = 3300,
		desc = "不是回归玩家",
		define = "ERROR_NO_RETURN",
		audio = "ban"
	},
	[3301] = {
		id = 3301,
		desc = "已领取回归礼包",
		define = "ERROR_RECEIVED_GIFT",
		audio = "ban"
	},
	[3302] = {
		id = 3302,
		desc = "已购买",
		define = "ERROR_RETURN_BP_HAS_BUY",
		audio = "ban"
	},
	[3303] = {
		id = 3303,
		desc = "回归即将结束",
		define = "ERROR_RETURN_GOING_TO_STOP",
		audio = "ban"
	},
	[3401] = {
		id = 3401,
		desc = "选择的套装不存在",
		define = "ERROR_BATTLE_EQUIP_SUIT_NO_EXIST",
		audio = "ban"
	},
	[3501] = {
		id = 3501,
		desc = "编队队伍英雄不能为空",
		define = "ERROR_TEAMS_HERO_LIST_NULL",
		audio = "ban"
	},
	[3502] = {
		id = 3502,
		desc = "未设置编队",
		define = "ERROR_TEAMS_NO_EXIST",
		audio = "ban"
	},
	[3503] = {
		id = 3503,
		desc = "编队队伍不存在",
		define = "ERROR_TEAM_NO_EXIST",
		audio = "ban"
	},
	[3504] = {
		id = 3504,
		desc = "编队队伍重复",
		define = "ERROR_TEAM_LIST_REPEAT",
		audio = "ban"
	},
	[3505] = {
		id = 3505,
		desc = "编队队伍数量有误",
		define = "ERROR_TEAMS_NUMBER",
		audio = "ban"
	},
	[3506] = {
		id = 3506,
		desc = "编队与之前上传不一致",
		define = "ERROR_TEAMS_NOT_MATCH",
		audio = "ban"
	},
	[3507] = {
		id = 3507,
		desc = "连续作战未完成不能重新上传编队",
		define = "ERROR_TEAMS_IN_STAGE",
		audio = "ban"
	},
	[6000] = {
		id = 6000,
		desc = "玩家已加入了公会",
		define = "ERROR_CLUB_USER_ALREADY_HAS_CLUB",
		audio = "success"
	},
	[6001] = {
		id = 6001,
		desc = "管理员未加入矩阵公会",
		define = "ERROR_CLUB_USER_NOT_JOIN_CLUB",
		audio = "ban"
	},
	[6002] = {
		id = 6002,
		desc = "公会可以接收的申请已达到最大",
		define = "ERROR_CLUB_RECEIVE_REQUEST_MAX",
		audio = "ban"
	},
	[6003] = {
		id = 6003,
		desc = "玩家可以发出的加入公会申请已达到最大",
		define = "ERROR_CLUB_USER_REQUEST_JOIN_MAX",
		audio = "ban"
	},
	[6004] = {
		id = 6004,
		desc = "玩家可以接收的加入公会邀请已经达到最大",
		define = "ERROR_CLUB_USER_RECEIVE_INVITES_MAX",
		audio = "ban"
	},
	[6005] = {
		id = 6005,
		desc = "公会成员已满",
		define = "ERROR_CLUB_MEMBER_FULL",
		audio = "ban"
	},
	[6006] = {
		id = 6006,
		desc = "公会名已经存在 不能重复创建",
		define = "ERROR_CLUB_NAME_EXIST",
		audio = "ban"
	},
	[6007] = {
		id = 6007,
		desc = "此操作仅会长和副会长能够进行",
		define = "ERROR_CLUB_ONLY_LEADERS_CMD",
		audio = "ban"
	},
	[6008] = {
		id = 6008,
		desc = "不在同一公会中",
		define = "ERROR_CLUB_NOT_IN_SAME_CLUB",
		audio = "ban"
	},
	[6009] = {
		id = 6009,
		desc = "此邀请者id在（被邀请者）数据中不存在",
		define = "ERROR_CLUB_INVITER_ID_NOT_EXIST",
		audio = "ban"
	},
	[6010] = {
		id = 6010,
		desc = "此玩家允许邀请开关关闭",
		define = "ERROR_CLUB_ALLOW_INVITE_SWITCH_OFF",
		audio = "ban"
	},
	[6011] = {
		id = 6011,
		desc = "任命失败，副会长数量达到上限",
		define = "ERROR_CLUB_VICE_CHAIRMAN_NUM_LIMIT",
		audio = "ban"
	},
	[6012] = {
		id = 6012,
		desc = "仅会长能进行此操作",
		define = "ERROR_CLUB_ONLY_CHAIRMAN",
		audio = "ban"
	},
	[6013] = {
		id = 6013,
		desc = "此成员今日已签到",
		define = "ERROR_CLUB_MEMBER_SIGNED_TODAY",
		audio = "ban"
	},
	[6014] = {
		id = 6014,
		desc = "公会人气值不足",
		define = "ERROR_CLUB_POPULARITY_NOT_ENOUGH",
		audio = "ban"
	},
	[6015] = {
		id = 6015,
		desc = "超过了允许拖欠维护费用的天数",
		define = "ERROR_CLUB_DEBTS_DAYS_LIMIT",
		audio = "ban"
	},
	[6016] = {
		id = 6016,
		desc = "公会建设度不足",
		define = "ERROR_CLUB_CONTRIBUTION_NOT_ENOUGH",
		audio = "ban"
	},
	[6017] = {
		id = 6017,
		desc = "已申请过该公会 不能重复申请",
		define = "ERROR_CLUB_REQUEST_TWICE",
		audio = "ban"
	},
	[6018] = {
		id = 6018,
		desc = "特殊签到时间未到",
		define = "ERROR_CLUB_NOT_SIGN_EXTRA_TIME",
		audio = "ban"
	},
	[6019] = {
		id = 6019,
		desc = "特殊签到时间已过",
		define = "ERROR_CLUB_OVER_SIGN_EXTRA_TIME",
		audio = "ban"
	},
	[6020] = {
		id = 6020,
		desc = "两次签到均已签过",
		define = "ERROR_CLUB_ALREADY_SIGN_TWICE",
		audio = "ban"
	},
	[6021] = {
		id = 6021,
		desc = "公会不存在",
		define = "ERROR_NO_CLUB",
		audio = "ban"
	},
	[6022] = {
		id = 6022,
		desc = "没有满足条件允许加入公会的玩家",
		define = "ERROR_CLUB_NO_SATISFY_REQUEST",
		audio = "ban"
	},
	[6023] = {
		id = 6023,
		desc = "你是会长，请先转让会长",
		define = "ERROR_CLUB_CHAIRMAN_CAN_NOT_QUIT",
		audio = "ban"
	},
	[6024] = {
		id = 6024,
		desc = "交错结晶不足",
		define = "ERROR_CLUB_COIN_NO_ENOUGH",
		audio = "ban"
	},
	[6025] = {
		id = 6025,
		desc = "奖励已存在",
		define = "ERROR_CLUB_REWARD_EXIST",
		audio = "ban"
	},
	[6026] = {
		id = 6026,
		desc = "奖励不存在",
		define = "ERROR_CLUB_REWARD_NO_EXIST",
		audio = "ban"
	},
	[6027] = {
		id = 6027,
		desc = "奖励已经领取过了",
		define = "ERROR_CLUB_REWARD_ALREADY_SIGN",
		audio = "ban"
	},
	[6028] = {
		id = 6028,
		desc = "新晋成员无法领取矩阵常规补给",
		define = "ERROR_CLUB_REWARD_ONLY_FORMAT_RECEIVE",
		audio = "ban"
	},
	[6029] = {
		id = 6029,
		desc = "错误公会ID",
		define = "ERROR_CLUB_ID",
		audio = "ban"
	},
	[6030] = {
		id = 6030,
		desc = "该公会禁止加入，无法申请",
		define = "ERROR_CLUB_REFUSE_RECRUIT",
		audio = "ban"
	},
	[6031] = {
		id = 6031,
		desc = "申请人数太多，无法申请",
		define = "ERROR_CLUB_MAX_REQUEST",
		audio = "ban"
	},
	[6032] = {
		id = 6032,
		desc = "申请不存在",
		define = "ERROR_REQUEST_NOT_EXIST",
		audio = "ban"
	},
	[6033] = {
		id = 6033,
		desc = "不满足公会的申请等级限制",
		define = "ERROR_CLUB_REQUEST_JOIN_LEVEL_LIMIT",
		audio = "ban"
	},
	[6034] = {
		id = 6034,
		desc = "公会人数到达上限，无法申请",
		define = "ERROR_CLUB_REQUEST_JOIN_MEMBER_FULL",
		audio = "ban"
	},
	[6035] = {
		id = 6035,
		desc = "公会名称重复",
		define = "ERROR_CLUB_NAME_REPEAT",
		audio = "ban"
	},
	[6036] = {
		id = 6036,
		desc = "公会名称长度超过上限",
		define = "ERROR_CLUB_NAME_LENGTH",
		audio = "ban"
	},
	[6037] = {
		id = 6037,
		desc = "公会公告长度超过上限",
		define = "ERROR_CLUB_NOTICE_LENGTH",
		audio = "ban"
	},
	[6038] = {
		id = 6038,
		desc = "公会不存在",
		define = "ERROR_CLUB_NOT_EXIST",
		audio = "ban"
	},
	[6039] = {
		id = 6039,
		desc = "该玩家已加入其他矩阵公会",
		define = "ERROR_USER_HAS_JOINED_OTHER_CLUB",
		audio = "ban"
	},
	[6040] = {
		id = 6040,
		desc = "申请成功",
		define = "USER_REQUEST_JOIN_CLUB_SUCCESS",
		audio = "success"
	},
	[6041] = {
		id = 6041,
		desc = "当前处于退团CD中",
		define = "ERROR_USER_JOIN_COOL_DOWN",
		audio = "ban"
	},
	[6042] = {
		id = 6042,
		desc = "本周购买次数已达上限",
		define = "ERROR_CLUB_SPECIAL_REWARD_BUY_TIME_LIMIT",
		audio = "ban"
	},
	[6043] = {
		id = 6043,
		desc = "下期联合攻坚开启后可参与",
		define = "ERROR_CLUB_BOSS_CHALLENGE_CAN_NOT_JOIN",
		audio = "ban"
	},
	[6044] = {
		id = 6044,
		desc = "当前时间无法设置难度",
		define = "ERROR_CLUB_BOSS_CHALLENGE_SELECT_DIFFICULTY",
		audio = "ban"
	},
	[6045] = {
		id = 6045,
		desc = "裂隙还未开启",
		define = "ERROR_CLUB_BOSS_CHALLENGE_NOT_START",
		audio = "ban"
	},
	[6046] = {
		id = 6046,
		desc = "裂隙征兆已结束",
		define = "ERROR_CLUB_BOSS_CHALLENGE_FINISHED",
		audio = "ban"
	},
	[6047] = {
		id = 6047,
		desc = "社团分享未到时间间隔",
		define = "ERROR_CLUB_SHARE_IN_COLD_DOWN",
		audio = "ban"
	},
	[6048] = {
		id = 6048,
		desc = "社团分享权限不足",
		define = "ERROR_CLUB_SHARE_POWER_LIMIT",
		audio = "ban"
	},
	[6049] = {
		id = 6049,
		desc = "今日移除次数达到上限",
		define = "ERROR_CLUB_KICK_TIMES_LIMIT",
		audio = "ban"
	},
	[6050] = {
		id = 6050,
		desc = "该成员加入不足24小时，无法移除",
		define = "ERROR_CLUB_MEMBER_JOIN_TIME_IN_PROTECTING",
		audio = "ban"
	},
	[6100] = {
		id = 6100,
		desc = "网络波动，请重试",
		define = "ERROR_NO_AVAILABLE_COORDINATOR",
		audio = "ban"
	},
	[6101] = {
		id = 6101,
		desc = "当前房间上限已经爆满 无法创建",
		define = "ERROR_COORDINATOR_ROOM_LIMITED",
		audio = "ban"
	},
	[6102] = {
		id = 6102,
		desc = "不在房间内",
		define = "ERROR_COORDINATOR_NOT_IN_ROOM",
		audio = "ban"
	},
	[6103] = {
		id = 6103,
		desc = "房间参数错误",
		define = "ERROR_COORDINATOR_ROOM_ARG_ILLEGAL",
		audio = "ban"
	},
	[6104] = {
		id = 6104,
		desc = "玩家没有在线",
		define = "ERROR_COORDINATOR_PLAYER_NOT_ONLINE",
		audio = "ban"
	},
	[6105] = {
		id = 6105,
		desc = "没有可用的战斗服",
		define = "ERROR_COORDINATOR_NOT_BATTLE_SERVER",
		audio = "ban"
	},
	[6106] = {
		id = 6106,
		desc = "请求的战斗不存在",
		define = "ERROR_COORDINATOR_BATTLE_NO_EXIST",
		audio = "ban"
	},
	[6107] = {
		id = 6107,
		desc = "请求的战斗结果不符合服务端结果",
		define = "ERROR_COORDINATOR_BATTLE_RESULT_ILLEGAL",
		audio = "ban"
	},
	[6108] = {
		id = 6108,
		desc = "战斗结果重复推送",
		define = "ERROR_COORDINATOR_BATTLE_RESULT_REPEATED",
		audio = "ban"
	},
	[6109] = {
		id = 6109,
		desc = "尝试领取已经领取的奖励",
		define = "ERROR_COORDINATOR_BATTLE_REWARD_REPEATED",
		audio = "ban"
	},
	[6110] = {
		id = 6110,
		desc = "战斗服与协调服务器连接请求失败",
		define = "ERROR_COORDINATOR_CONNECT_BATTLE_SERVER_FAILED",
		audio = "ban"
	},
	[6111] = {
		id = 6111,
		desc = "指定的房间不存在",
		define = "ERROR_COORDINATOR_ROOM_INVALID",
		audio = "ban"
	},
	[6112] = {
		id = 6112,
		desc = "非房主无法操作",
		define = "ERROR_COORDINATOR_NOT_OWNER",
		audio = "ban"
	},
	[6113] = {
		id = 6113,
		desc = "操作对象不能是房主",
		define = "ERROR_COORDINATOR_OWNER",
		audio = "ban"
	},
	[6114] = {
		id = 6114,
		desc = "操作对象无法为自己",
		define = "ERROR_COORDINATOR_NOT_SELF_TARGET",
		audio = "ban"
	},
	[6115] = {
		id = 6115,
		desc = "还有成员未准备",
		define = "ERROR_COORDINATOR_NOT_ALL_READY",
		audio = "ban"
	},
	[6116] = {
		id = 6116,
		desc = "成员不存在",
		define = "ERROR_COORDINATOR_MEMBER_NOT_EXIST",
		audio = "ban"
	},
	[6117] = {
		id = 6117,
		desc = "已经在房间内",
		define = "ERROR_COORDINATOR_ALREADY_IN_ROOM",
		audio = "ban"
	},
	[6118] = {
		id = 6118,
		desc = "已经准备",
		define = "ERROR_COORDINATOR_READY",
		audio = "ban"
	},
	[6119] = {
		id = 6119,
		desc = "尚未准备",
		define = "ERROR_COORDINATOR_NOT_READY",
		audio = "ban"
	},
	[6120] = {
		id = 6120,
		desc = "当前房间已满",
		define = "ERROR_COORDINATOR_ROOM_FULL",
		audio = "ban"
	},
	[6121] = {
		id = 6121,
		desc = "出战角色重复",
		define = "ERROR_COORDINATOR_HERO_REPEAT",
		audio = "ban"
	},
	[6200] = {
		id = 6200,
		desc = "充值AppId无效",
		define = "ERROR_RECHARGE_ORDER_APP_ID",
		audio = "ban"
	},
	[6210] = {
		id = 6210,
		desc = "月卡已到期",
		define = "ERROR_RECHARGE_MONTH_CARD_EXPIRED",
		audio = "ban"
	},
	[6211] = {
		id = 6211,
		desc = "当日月卡奖励已经领取",
		define = "ERROR_RECHARGE_MONTH_CARD_REWARD_DELIVERED",
		audio = "ban"
	},
	[6213] = {
		id = 6213,
		desc = "月卡购买次数限制",
		define = "ERROR_RECHARGE_MONTH_CARD_BUY_TIMES",
		audio = "ban"
	},
	[6214] = {
		id = 6214,
		desc = "累充奖励已领取",
		define = "ERROR_RECHARGE_TOTAL_RECHARGE_REWARD_HAS_RECEIVE",
		audio = "ban"
	},
	[6215] = {
		id = 6215,
		desc = "累充数量不足",
		define = "ERROR_RECHARGE_TOTAL_RECHARGE_REWARD_LIMIT",
		audio = "ban"
	},
	[6300] = {
		id = 6300,
		desc = "GM后台系统异常",
		define = "ERROR_ADMIN_SERVER_EXCEPTION",
		audio = "ban"
	},
	[6400] = {
		id = 6400,
		desc = "使用失败，兑换码不存在",
		define = "ERROR_REDEMPTION_CODE",
		audio = "ban"
	},
	[6401] = {
		id = 6401,
		desc = "已达到本次活动的最高限领次数",
		define = "ERROR_REDEMPTION_CODE_RECEIVE_MAX",
		audio = "ban"
	},
	[6402] = {
		id = 6402,
		desc = "该兑换码已达领取上限",
		define = "ERROR_REDEMPTION_CODE_GIFT_RECEIVE_MAX",
		audio = "ban"
	},
	[6403] = {
		id = 6403,
		desc = "使用失败，兑换码已被使用",
		define = "ERROR_REDEMPTION_CODE_USED",
		audio = "ban"
	},
	[6404] = {
		id = 6404,
		desc = "使用失败，该账号已经使用过同类兑换码",
		define = "ERROR_REDEMPTION_CODE_RECEIVE_THE_SAME_TYPE_1",
		audio = "ban"
	},
	[6405] = {
		id = 6405,
		desc = "使用失败，该角色已经兑换过",
		define = "ERROR_REDEMPTION_CODE_RECEIVE_THE_SAME_TYPE_2",
		audio = "ban"
	},
	[6406] = {
		id = 6406,
		desc = "使用失败，已经兑换过",
		define = "ERROR_REDEMPTION_CODE_RECEIVE_THE_SAME_TYPE_3",
		audio = "ban"
	},
	[6407] = {
		id = 6407,
		desc = "使用失败，兑换码已过期",
		define = "ERROR_REDEMPTION_CODE_TIME_OUT",
		audio = "ban"
	},
	[6408] = {
		id = 6408,
		desc = "使用失败，未满足领取条件",
		define = "ERROR_REDEMPTION_CODE_NOT_RECEIVE_CONDITION",
		audio = "ban"
	},
	[6500] = {
		id = 6500,
		desc = "多维变量进入战斗时使用的修正者不存在",
		define = "ERROR_MATRIX_BATTLE_SELECT_HERO_ILLEGAL",
		audio = "ban"
	},
	[6501] = {
		id = 6501,
		desc = "多维变量在已经开始的状态下还请求开始",
		define = "ERROR_MATRIX_STARTED",
		audio = "ban"
	},
	[6502] = {
		id = 6502,
		desc = "多维变量开始时选用的修正者不存在",
		define = "ERROR_MATRIX_START_SELECT_HERO_ILLEGAL",
		audio = "ban"
	},
	[6503] = {
		id = 6503,
		desc = "多维变量开始时选用的难度不存在",
		define = "ERROR_MATRIX_START_DIFFICULTY_ILLEGAL",
		audio = "ban"
	},
	[6504] = {
		id = 6504,
		desc = "多维变量在已经结束的情况下请求结束",
		define = "ERROR_MATRIX_CLOSED",
		audio = "ban"
	},
	[6505] = {
		id = 6505,
		desc = "多维变量在无法开始战斗的情况下请求开始",
		define = "ERROR_MATRIX_NOT_IN_PROGRESS",
		audio = "ban"
	},
	[6506] = {
		id = 6506,
		desc = "多维变量修正者不存在",
		define = "ERROR_MATRIX_HERO_ILLEGAL",
		audio = "ban"
	},
	[6507] = {
		id = 6507,
		desc = "多维变量选择了非法的事件ID",
		define = "ERROR_MATRIX_EVENT_ILLEGAL",
		audio = "ban"
	},
	[6508] = {
		id = 6508,
		desc = "多维变量还没有通过战斗事件就请求下一阶段",
		define = "ERROR_MATRIX_NOT_CLEAR_BATTLE",
		audio = "ban"
	},
	[6509] = {
		id = 6509,
		desc = "多维变量选择的奖励不存在",
		define = "ERROR_MATRIX_SELECT_REWARD_ILLEGAL",
		audio = "ban"
	},
	[6510] = {
		id = 6510,
		desc = "多维变量该修正者选择的神格数量达到上限",
		define = "ERROR_MATRIX_ASTROLABE_REWARD_MAX",
		audio = "ban"
	},
	[6511] = {
		id = 6511,
		desc = "多维变量不能替换前置神格",
		define = "ERROR_MATRIX_ASTROLABE_CAN_NOT_REPLACE_PRE",
		audio = "ban"
	},
	[6512] = {
		id = 6512,
		desc = "多维变量该修正者选择的刻印数量达到上限",
		define = "ERROR_MATRIX_EQUIP_REWARD_MAX",
		audio = "ban"
	},
	[6513] = {
		id = 6513,
		desc = "多维变量该修正者选择的钥从数量达到上限",
		define = "ERROR_MATRIX_WEAPON_REWARD_MAX",
		audio = "ban"
	},
	[6514] = {
		id = 6514,
		desc = "多维变量队伍记忆珍宝数量达到上限",
		define = "ERROR_MATRIX_ARTIFACT_REWARD_MAX",
		audio = "ban"
	},
	[6515] = {
		id = 6515,
		desc = "多维变量机遇终点没有配置奖励",
		define = "ERROR_MATRIX_CHANCE_REWARD_NOT_TEMPLATE",
		audio = "ban"
	},
	[6516] = {
		id = 6516,
		desc = "多维变量机遇的起点不能到达该终点",
		define = "ERROR_MATRIX_CHANCE_ILLEGAL_END_STORY_LINE",
		audio = "ban"
	},
	[6517] = {
		id = 6517,
		desc = "多维变量已经领取过当前的积分奖励",
		define = "ERROR_MATRIX_ALREADY_GOT_POINT_REWARD",
		audio = "ban"
	},
	[6518] = {
		id = 6518,
		desc = "多维变量没有积分奖励配置",
		define = "ERROR_MATRIX_POINT_REWRAD_NO_TEMPLATE",
		audio = "ban"
	},
	[6519] = {
		id = 6519,
		desc = "多维变量当前积分不足",
		define = "ERROR_MATRIX_NOT_ENOUGH_POINT",
		audio = "ban"
	},
	[6520] = {
		id = 6520,
		desc = "多维变量商店事件剩余物品不足",
		define = "ERROR_MATRIX_SHOP_ITEM_NOT_ENOUGH",
		audio = "ban"
	},
	[6521] = {
		id = 6521,
		desc = "多维变量终端选项不在可以升级的列表中",
		define = "ERROR_MATRIX_TERMIANL_CAN_NOT_UPGRADE",
		audio = "ban"
	},
	[6522] = {
		id = 6522,
		desc = "多维变量奖励道具参数不合法",
		define = "ERROR_MATRIX_REWRAD_ITEM_BAD_ARGS",
		audio = "ban"
	},
	[6523] = {
		id = 6523,
		desc = "多维变量不能获得重复的神器",
		define = "ERROR_MATRIX_GET_REPEATED_ARTIFACT",
		audio = "ban"
	},
	[6524] = {
		id = 6524,
		desc = "多维变量在已经失败的情况下请求放弃",
		define = "ERROR_MATRIX_LOSED",
		audio = "ban"
	},
	[6525] = {
		id = 6525,
		desc = "多维变量缺少复活道具配置",
		define = "ERROR_MATRIX_TIER_REBORN_ITEM_NO_TEMPLATE",
		audio = "ban"
	},
	[6526] = {
		id = 6526,
		desc = "多维变量修正者使用了其他修正者的专属钥从",
		define = "ERROR_MATRIX_USE_ILLEGAL_WEAPON_SERVANT",
		audio = "ban"
	},
	[6527] = {
		id = 6527,
		desc = "多维变量修正者使用了其他修正者的神格",
		define = "ERROR_MATRIX_USE_ILLEGAL_ASTROLABE",
		audio = "ban"
	},
	[6528] = {
		id = 6528,
		desc = "多维变量选择的信标超过限制数量",
		define = "ERROR_MATRIX_BEACON_OVER_LIMIT",
		audio = "ban"
	},
	[6529] = {
		id = 6529,
		desc = "多维终端等级不足",
		define = "ERROR_MATRIX_TERMINAL_LEVEL_NOT_ENOUGH",
		audio = "ban"
	},
	[6530] = {
		id = 6530,
		desc = "多维变量信标已经解锁",
		define = "ERROR_MATRIX_BEACON_ALREADY_UNLOCKED",
		audio = "ban"
	},
	[6531] = {
		id = 6531,
		desc = "多维变量事件类型非法",
		define = "ERROR_MATRIX_EVENT_TYPE_ILLEGAL",
		audio = "ban"
	},
	[6532] = {
		id = 6532,
		desc = "多维变量商店刷新次数已经达到上限",
		define = "ERROR_MATRIX_SHOP_REFRESH_OVER_LIMIT",
		audio = "ban"
	},
	[6533] = {
		id = 6533,
		desc = "多维变量通关次数不足",
		define = "ERROR_MATRIX_ACCOMPLISH_NOT_ENOUGH",
		audio = "ban"
	},
	[6535] = {
		id = 6535,
		desc = "没有足够的物品",
		define = "ERROR_MATRIX_NOT_ENOUGH_ITEM",
		audio = "ban"
	},
	[6536] = {
		id = 6536,
		desc = "进入参数错误",
		define = "ERROR_MATRIX_ENTER_ARG_ILLEGAL",
		audio = "ban"
	},
	[6537] = {
		id = 6537,
		desc = "前置未完成",
		define = "ERROR_MATRIX_PRE_CONDITION_NOT_CLEAR",
		audio = "ban"
	},
	[6600] = {
		id = 6600,
		desc = "未探索任何地图",
		define = "ERROR_NO_EXPLORE",
		audio = "ban"
	},
	[6601] = {
		id = 6601,
		desc = "格子未相邻",
		define = "ERROR_NO_ADJACENT",
		audio = "ban"
	},
	[6602] = {
		id = 6602,
		desc = "坐标越界",
		define = "ERROR_OVERSTEP_THE_BOUNDARY",
		audio = "ban"
	},
	[6603] = {
		id = 6603,
		desc = "不可互动",
		define = "ERROR_NO_INTERACT",
		audio = "ban"
	},
	[6604] = {
		id = 6604,
		desc = "不可移动指定位置",
		define = "ERROR_NO_MOVE",
		audio = "ban"
	},
	[6605] = {
		id = 6605,
		desc = "未解锁地图",
		define = "ERROR_MAP_LOCK",
		audio = "ban"
	},
	[6606] = {
		id = 6606,
		desc = "未通关前置地图",
		define = "ERROR_PRE_MAP_NOT_CLEAR",
		audio = "ban"
	},
	[6607] = {
		id = 6607,
		desc = "没有对应的钥匙",
		define = "ERROR_NO_CORRESPONDING_KEY",
		audio = "ban"
	},
	[6608] = {
		id = 6608,
		desc = "没有对应的神器",
		define = "ERROR_NO_CORRESPONDING_ARTIFACT",
		audio = "ban"
	},
	[6609] = {
		id = 6609,
		desc = "修正者未死亡",
		define = "ERROR_HERO_NO_DEATH",
		audio = "ban"
	},
	[6610] = {
		id = 6610,
		desc = "地图生成失败",
		define = "ERROR_MAP_INIT_SIZE_DISCREPANCY",
		audio = "ban"
	},
	[6611] = {
		id = 6611,
		desc = "修正者已死亡",
		define = "ERROR_HERO_DEATH",
		audio = "ban"
	},
	[6612] = {
		id = 6612,
		desc = "不可切换探测器",
		define = "ERROR_NOT_SWITCH_DETECTOR",
		audio = "ban"
	},
	[6613] = {
		id = 6613,
		desc = "不可回收探测器",
		define = "ERROR_NOT_RECOVERY_DETECTOR",
		audio = "ban"
	},
	[6614] = {
		id = 6614,
		desc = "已经切换探测器",
		define = "ERROR_ALREADY_SWITCH_DETECTOR",
		audio = "ban"
	},
	[6615] = {
		id = 6615,
		desc = "已经回收探测器",
		define = "ERROR_ALREADY_RECOVERY_DETECTOR",
		audio = "ban"
	},
	[6700] = {
		id = 6700,
		desc = "修正者档案未解锁",
		define = "ERROR_HERO_ARCHIVES_LOCK",
		audio = "ban"
	},
	[6701] = {
		id = 6701,
		desc = "修正者档案礼物类型错误",
		define = "ERROR_HERO_ARCHIVES_GITF_TYPE",
		audio = "ban"
	},
	[6702] = {
		id = 6702,
		desc = "修正者档案好感度达到上限",
		define = "ERROR_HERO_ARCHIVES_EXP_LIMIT",
		audio = "success"
	},
	[6703] = {
		id = 6703,
		desc = "修正者档案好感度等级不足",
		define = "ERROR_HERO_ARCHIVES_LV",
		audio = "ban"
	},
	[6704] = {
		id = 6704,
		desc = "修正者档案送礼物次数不足",
		define = "ERROR_HERO_ARCHIVES_GIFT_TIMES",
		audio = "ban"
	},
	[6800] = {
		id = 6800,
		desc = "芯片未解锁",
		define = "ERROR_CHIP_LOCK",
		audio = "ban"
	},
	[6801] = {
		id = 6801,
		desc = "方案不存在",
		define = "ERROR_PROPOSAL_NO_EXIST",
		audio = "ban"
	},
	[6802] = {
		id = 6802,
		desc = "方案已存在",
		define = "ERROR_PROPOSAL_EXIST",
		audio = "ban"
	},
	[6803] = {
		id = 6803,
		desc = "方案达到上限",
		define = "ERROR_PROPOSALS_MAX",
		audio = "ban"
	},
	[6804] = {
		id = 6804,
		desc = "不是核心芯片",
		define = "ERROR_NOT_KERNEL_CHIP",
		audio = "ban"
	},
	[6805] = {
		id = 6805,
		desc = "次要芯片冲突",
		define = "ERROR_SECONDARY_CONFLICT",
		audio = "ban"
	},
	[6806] = {
		id = 6806,
		desc = "已装备次要芯片",
		define = "ERROR_USED_SECONDARY_CHIP",
		audio = "ban"
	},
	[6807] = {
		id = 6807,
		desc = "次要芯片装备数量最大",
		define = "ERROR_USED_SECONDARY_CHIP_MAX",
		audio = "ban"
	},
	[6808] = {
		id = 6808,
		desc = "不是次要芯片",
		define = "ERROR_NOT_SECONDARY_CHIP",
		audio = "ban"
	},
	[6809] = {
		id = 6809,
		desc = "方案名称为空",
		define = "ERROR_PROPOSAL_NAME_IS_EMPTY",
		audio = "ban"
	},
	[6900] = {
		id = 6900,
		desc = "问卷未完成",
		define = "ERROR_PLATFORM_SURVEY_NOT_FINISHED",
		audio = "ban"
	},
	[6901] = {
		id = 6901,
		desc = "问卷奖励已领取",
		define = "ERROR_PLATFORM_SURVEY_HAS_RECEIVED",
		audio = "ban"
	},
	[6902] = {
		id = 6902,
		desc = "问卷不存在",
		define = "ERROR_PLATFORM_SURVEY_DATA_NOT_EXIST",
		audio = "ban"
	},
	[6903] = {
		id = 6903,
		desc = "已领取过该奖励，无法再次领取",
		define = "ERROR_WEIBO_REWARD_COLLECTED",
		audio = "ban"
	},
	[7000] = {
		id = 7000,
		desc = "合约未开始",
		define = "ERROR_BATTLEPASS_NOT_START",
		audio = "ban"
	},
	[7001] = {
		id = 7001,
		desc = "合约已购买",
		define = "ERROR_BATTLEPASS_HAS_BUY",
		audio = "ban"
	},
	[7002] = {
		id = 7002,
		desc = "前置合约未购买",
		define = "ERROR_BATTLEPASS_PREV_HAS_NOT_BUY",
		audio = "ban"
	},
	[7003] = {
		id = 7003,
		desc = "合约即将结束",
		define = "ERROR_BATTLEPASS_GOING_TO_STOP",
		audio = "ban"
	},
	[7004] = {
		id = 7004,
		desc = "合约经验等级不足",
		define = "ERROR_BATTLEPASS_EXP",
		audio = "ban"
	},
	[7005] = {
		id = 7005,
		desc = "合约权限不足",
		define = "ERROR_BATTLEPASS_BUY_LEVEL_INVALID",
		audio = "ban"
	},
	[7006] = {
		id = 7006,
		desc = "合约奖励已领取",
		define = "ERROR_BATTLEPASS_HAS_RECEIVE",
		audio = "ban"
	},
	[7007] = {
		id = 7007,
		desc = "每周合约经验已达上限",
		define = "ERROR_BATTLEPASS_WEEKLY_EXP_LIMIT",
		audio = "ban"
	},
	[7100] = {
		id = 7100,
		desc = "后宅建筑未解锁",
		define = "ERROR_BACKHOME_ARCHITECTURE_LOCK",
		audio = "ban"
	},
	[7101] = {
		id = 7101,
		desc = "后宅食材不足",
		define = "ERROR_BACKHOME_INGREDIENT_LACKING",
		audio = "ban"
	},
	[7102] = {
		id = 7102,
		desc = "后宅食材不存在",
		define = "ERROR_BACKHOME_INGREDIENT_NO_EXIST",
		audio = "ban"
	},
	[7103] = {
		id = 7103,
		desc = "后宅英雄已经派遣",
		define = "ERROR_BACKHOME_HERO_ALREADY_ENTRUST",
		audio = "ban"
	},
	[7104] = {
		id = 7104,
		desc = "后宅英雄已经设置职业",
		define = "ERROR_BACKHOME_HERO_ALREADY_CAREER",
		audio = "ban"
	},
	[7105] = {
		id = 7105,
		desc = "后宅饭堂收益不存在",
		define = "ERROR_BACKHOME_CANTEEN_EARNINGS_NO_EXIST",
		audio = "ban"
	},
	[7106] = {
		id = 7106,
		desc = "后宅饭堂委托刷新上限",
		define = "ERROR_BACKHOME_CANTEEN_ENTRUST_REFRESH_TIMES_MAX",
		audio = "ban"
	},
	[7107] = {
		id = 7107,
		desc = "后宅饭堂不存在",
		define = "ERROR_BACKHOME_CANTEEN_LOCK",
		audio = "ban"
	},
	[7108] = {
		id = 7108,
		desc = "后宅饭堂食物未解锁",
		define = "ERROR_BACKHOME_CANTEEN_FOOD_LOCK",
		audio = "ban"
	},
	[7109] = {
		id = 7109,
		desc = "后宅家具不存在",
		define = "ERROR_BACKHOME_FURNITURE_NO_EXIST",
		audio = "ban"
	},
	[7110] = {
		id = 7110,
		desc = "后宅家具不足",
		define = "ERROR_BACKHOME_FURNITURE_LACKING",
		audio = "ban"
	},
	[7111] = {
		id = 7111,
		desc = "后宅饭堂售卖上限",
		define = "ERROR_BACKHOME_CANTEEN_SELL_MAX",
		audio = "ban"
	},
	[7112] = {
		id = 7112,
		desc = "后宅英雄体力不足",
		define = "ERROR_BACKHOME_HERO_FATIGUE_LACKING",
		audio = "ban"
	},
	[7113] = {
		id = 7113,
		desc = "后宅模板类型与建筑不一致",
		define = "ERROR_BACKHOME_TEMPLATE_TYPE_DIFF_FROM_ARCHITECTURE",
		audio = "ban"
	},
	[7114] = {
		id = 7114,
		desc = "后宅宿舍未安置修正者",
		define = "ERROR_BACKHOME_DORM_NO_SET_HERO",
		audio = "ban"
	},
	[7115] = {
		id = 7115,
		desc = "后宅宿舍已安置修正者",
		define = "ERROR_BACKHOME_DORM_ALREADY_SET_HERO",
		audio = "ban"
	},
	[7116] = {
		id = 7116,
		desc = "后宅投喂修正者上限",
		define = "ERROR_BACKHOME_FEED_HERO_MAX",
		audio = "ban"
	},
	[7117] = {
		id = 7117,
		desc = "后宅模板不存在",
		define = "ERROR_BACKHOME_TEMPLATE_NO_EXIST",
		audio = "ban"
	},
	[7118] = {
		id = 7118,
		desc = "后宅建筑已解锁",
		define = "ERROR_BACKHOME_ARCHITECTURE_ALREADY_UNLOCK",
		audio = "ban"
	},
	[7119] = {
		id = 7119,
		desc = "后宅英雄不存在",
		define = "ERROR_BACKHOME_HERO_NO_EXIST",
		audio = "ban"
	},
	[7120] = {
		id = 7120,
		desc = "后宅宿舍不存在",
		define = "ERROR_BACKHOME_DORM_NO_EXIST",
		audio = "ban"
	},
	[7121] = {
		id = 7121,
		desc = "无推荐宿舍",
		define = "ERROR_BACKHOME_NOT_FIND_RECOMMEND_DORM",
		audio = "ban"
	},
	[7122] = {
		id = 7122,
		desc = "此位置已有宿舍",
		define = "ERROR_BACKHOME_POS_HAD_DORM",
		audio = "ban"
	},
	[9000] = {
		id = 9000,
		desc = "战斗历史ID错误",
		define = "ERROR_BATTLE_HISTORY_ID",
		audio = "ban"
	},
	[10001] = {
		id = 10001,
		desc = "黑区净化星级奖励领取条件不合法（未达到星级或者该星级奖励已经领取)",
		define = "ERROR_BATTLE_MYTHIC_STAR_REWARD_ILLEGAL",
		audio = "ban"
	},
	[10002] = {
		id = 10002,
		desc = "黑区净化新难度提示已读",
		define = "ERROR_BATTLE_MYTHIC_NEW_DIFFICULTY_TIPS_READ",
		audio = "ban"
	},
	[10003] = {
		id = 10003,
		desc = "奖励未领取",
		define = "ERROR_BATTLE_MYTHIC_REWARD_NO_RECEIVED",
		audio = "ban"
	},
	[10004] = {
		id = 10004,
		desc = "黑区净化因为奖励已经领取,难度已经锁定",
		define = "ERROR_BATTLE_MYTHiC_DIFFICULTY_LOCKED",
		audio = "ban"
	},
	[11000] = {
		id = 11000,
		desc = "举报内容不能超过200字",
		define = "ERROR_REPORT_NOTE_CONTENT_OVER_SIZE",
		audio = "ban"
	},
	[12000] = {
		id = 12000,
		desc = "当前不在活动时间",
		define = "ERROR_ACTIVITY_NOT_OPEN",
		audio = "ban"
	},
	[12001] = {
		id = 12001,
		desc = "没有活动",
		define = "ERROR_ACTIVITY_NOT_EXIST",
		audio = "ban"
	},
	[13000] = {
		id = 13000,
		desc = "前置池没有获得核心道具",
		define = "ERROR_INFINITY_POOL_NOT_GET_PRE_POOL_CORE_ITEM",
		audio = "ban"
	},
	[13001] = {
		id = 13001,
		desc = "没有对应的无限池",
		define = "ERROR_INFINITY_POOL_NOT_EXIST",
		audio = "ban"
	},
	[13002] = {
		id = 13002,
		desc = "没有对应的格子",
		define = "ERROR_INFINITY_POOL_BOX_NOT_EXIST",
		audio = "ban"
	},
	[13003] = {
		id = 13003,
		desc = "该格子已经被打开",
		define = "ERROR_INFINITY_POOL_BOX_ALREADY_OPENED",
		audio = "ban"
	},
	[13004] = {
		id = 13004,
		desc = "该无限池不能重置",
		define = "ERROR_INFINITY_POOL_CANT_RESET",
		audio = "ban"
	},
	[14000] = {
		id = 14000,
		desc = "未开放对应试炼",
		define = "ERROR_RACE_TRIAL_NOT_OPEN",
		audio = "ban"
	},
	[14001] = {
		id = 14001,
		desc = "积分奖励未满足领取条件",
		define = "ERROR_RACE_TRIAL_POINT_REWARD_NOT_COMPLETE",
		audio = "ban"
	},
	[14002] = {
		id = 14002,
		desc = "神系试炼初次通关奖励不可领取",
		define = "ERROR_RACE_TRIAL_FIRST_CLEAR_REWARD_CAN_NOT_APPLY",
		audio = "ban"
	},
	[14003] = {
		id = 14003,
		desc = "神系试炼初次通关奖励已经领取",
		define = "ERROR_RACE_TRIAL_FIRST_CLEAR_REWARD_ALREADY_APPLIED",
		audio = "ban"
	},
	[14004] = {
		id = 14004,
		desc = "神系试炼选择的词缀不合法",
		define = "ERROR_RACE_TRIAL_SELECT_AFFIX_NOT_LEGAL",
		audio = "ban"
	},
	[15000] = {
		id = 15000,
		desc = "割草活动积分奖励已经领取",
		define = "ERROR_SLAYER_POINT_REWARD_APPLIED",
		audio = "ban"
	},
	[15001] = {
		id = 15001,
		desc = "割草活动领取奖励所需积分不足",
		define = "ERROR_SLAYER_POINT_NOT_ENOUGH",
		audio = "ban"
	},
	[16000] = {
		id = 16000,
		desc = "首次通关奖励已经领取",
		define = "ERROR_FIRST_CLEAR_REWARD_APPLIED",
		audio = "ban"
	},
	[16001] = {
		id = 16001,
		desc = "首次通关奖励未领取",
		define = "ERROR_FIRST_CLEAR_REWARD_CAN_NOT_APPLY",
		audio = "ban"
	},
	[17000] = {
		id = 17000,
		desc = "活动积分奖励已经领取",
		define = "ERROR_POINT_REWARD_APPLIED",
		audio = "ban"
	},
	[17001] = {
		id = 17001,
		desc = "活动领取奖励所需积分不足",
		define = "ERROR_POINT_NOT_ENOUGH",
		audio = "ban"
	},
	[18000] = {
		id = 18000,
		desc = "格子已经占领",
		define = "ERROR_CLUB_BOSS_MAP_GRID_OCCUPIED",
		audio = "ban"
	},
	[18001] = {
		id = 18001,
		desc = "格子已满",
		define = "ERROR_CLUB_BOSS_MAP_GRID_FULL",
		audio = "ban"
	},
	[18002] = {
		id = 18002,
		desc = "格子未占领",
		define = "ERROR_CLUB_BOSS_MAP_GRID_NOT_OCCUPIED",
		audio = "ban"
	},
	[19000] = {
		id = 19000,
		desc = "非法出行状态",
		define = "ERROR_SKULD_TRAVEL_STATE_ILLEGAL",
		audio = "ban"
	},
	[19001] = {
		id = 19001,
		desc = "结局已经开启过",
		define = "ERROR_SKULD_TRAVEL_ENDING_ALREADY_EXIST",
		audio = "ban"
	},
	[19002] = {
		id = 19002,
		desc = "属性未达标",
		define = "ERROR_SKULD_TRAVEL_ATTRIB_NOT_ACHIEVE",
		audio = "ban"
	},
	[20000] = {
		id = 20000,
		desc = "召回码不存在",
		define = "ERROR_RECALL_CODE_NOT_EXIST",
		audio = "ban"
	},
	[20001] = {
		id = 20001,
		desc = "该召回码使用次数已达上限",
		define = "ERROR_RECALL_CODE_USE_TIME_LIMIT",
		audio = "ban"
	},
	[20002] = {
		id = 20002,
		desc = "请填写其他玩家分享的召回码",
		define = "ERROR_RECALL_CODE_USE_OWN",
		audio = "ban"
	},
	[21000] = {
		id = 21000,
		desc = "该层未解锁",
		define = "ERROR_ABYSS_LAYER_NOT_UNLOCK",
		audio = "ban"
	},
	[21001] = {
		id = 21001,
		desc = "修正者已被锁定",
		define = "ERROR_ABYSS_HERO_LAYER_LOCKED",
		audio = "ban"
	},
	[21002] = {
		id = 21002,
		desc = "修正者已被禁锢",
		define = "ERROR_ABYSS_HERO_BLOCKER",
		audio = "ban"
	},
	[21003] = {
		id = 21003,
		desc = "层重置次数不足",
		define = "ERROR_ABYSS_NO_LAYER_RESET_TIME",
		audio = "ban"
	},
	[21004] = {
		id = 21004,
		desc = "关卡重置次数不足",
		define = "ERROR_ABYSS_NO_STAGE_RESET_TIME",
		audio = "ban"
	},
	[22001] = {
		id = 22001,
		desc = "多维变量选择的信标数量达到上限",
		define = "ERROR_POLYHEDRON_SELECT_BEACON_MAX",
		audio = "ban"
	},
	[22002] = {
		id = 22002,
		desc = "多维变量刷新珍宝奖励的次数不足",
		define = "ERROR_POLYHEDRON_ROLL_ARTIFACT_MAX",
		audio = "ban"
	},
	[22003] = {
		id = 22003,
		desc = "多维变量道具不足",
		define = "ERROR_POLYHEDRON_NOT_ENOUGH_STACKABLE_ITEM",
		audio = "ban"
	},
	[22004] = {
		id = 22004,
		desc = "多维变量商店商品已售罄",
		define = "ERROR_POLYHEDRON_SHOP_GOODS_SOLD_OUT",
		audio = "ban"
	},
	[22005] = {
		id = 22005,
		desc = "多维变量难度未解锁",
		define = "ERROR_POLYHEDRON_DIFFICULTY_LOCK",
		audio = "ban"
	},
	[22006] = {
		id = 22006,
		desc = "多维变量英雄已解锁",
		define = "ERROR_POLYHEDRON_HERO_ALREADY_UNLOCK",
		audio = "ban"
	},
	[22007] = {
		id = 22007,
		desc = "多维变量选择的门不存在",
		define = "ERROR_POLYHEDRON_SELECT_GATE_NO_FIND",
		audio = "ban"
	},
	[22008] = {
		id = 22008,
		desc = "多维变量商店刷新次数已经达到上限",
		define = "ERROR_POLYHEDRON_SHOP_REFRESH_TIMES_MAX",
		audio = "ban"
	},
	[22009] = {
		id = 22009,
		desc = "多维变量商店恢复血量次数已经达到上限",
		define = "ERROR_POLYHEDRON_SHOP_RECOVER_TIMES_MAX",
		audio = "ban"
	},
	[22010] = {
		id = 22010,
		desc = "多维变量终端重置次数已经达到上限",
		define = "ERROR_POLYHEDRON_TERMINAL_RESET_TIMES_MAX",
		audio = "ban"
	},
	[22011] = {
		id = 22011,
		desc = "多维变量信标已经解锁",
		define = "ERROR_POLYHEDRON_BEACON_ALREADY_UNLOCK",
		audio = "ban"
	},
	[50001] = {
		id = 50001,
		desc = "定时刷新失败",
		define = "REFRESH_FAIL_ON_TIME",
		audio = "ban"
	},
	[50002] = {
		id = 50002,
		desc = "商店刷新成功",
		define = "REFRESH_SUCCESS_ON_TIME",
		audio = "success"
	},
	[50004] = {
		id = 50004,
		desc = "未知错误",
		define = "UNDEFINED_ERROR",
		audio = "ban"
	},
	[50005] = {
		id = 50005,
		desc = "断货啦断货啦",
		define = "OUT_OF_STOCK",
		audio = "ban"
	},
	[50006] = {
		id = 50006,
		desc = "货币不足",
		define = "LACK_CURRENCY",
		audio = "ban"
	},
	[50007] = {
		id = 50007,
		desc = "购买成功",
		define = "TRANSACTION_SUCCESS",
		audio = "success"
	},
	[50008] = {
		id = 50008,
		desc = "兑换成功",
		define = "EXCHANGE_SUCCESS",
		audio = "success"
	},
	[60004] = {
		id = 60004,
		desc = "普通",
		define = "HARDLEVEL_EASY",
		audio = "ban"
	},
	[60005] = {
		id = 60005,
		desc = "困难",
		define = "HARDLEVEL_HARD",
		audio = "ban"
	},
	[60006] = {
		id = 60006,
		desc = "奇点",
		define = "HARDLEVEL_SINGULARITY",
		audio = "ban"
	},
	[60025] = {
		id = 60025,
		desc = "",
		define = "BLANK",
		audio = ""
	},
	[60026] = {
		id = 60026,
		desc = "全部",
		define = "ALL",
		audio = "ban"
	},
	[60036] = {
		id = 60036,
		desc = "请选择出战修正者",
		define = "ERROR_HERO_ONE_NOT_IN",
		audio = "ban"
	},
	[60037] = {
		id = 60037,
		desc = "难度",
		define = "HARDLEVEL",
		audio = "ban"
	},
	[60043] = {
		id = 60043,
		desc = "输入内容不能为空",
		define = "INPUT_CHAT_CONTENT",
		audio = "ban"
	},
	[60045] = {
		id = 60045,
		desc = "请勿重复发送",
		define = "CANNOT_SEND_SAME_MESSAGE",
		audio = "ban"
	},
	[60047] = {
		id = 60047,
		desc = "提示",
		define = "PROMPT",
		audio = "ban"
	},
	[60058] = {
		id = 60058,
		desc = "当前展示",
		define = "CURRENT_SHOW",
		audio = "ban"
	},
	[60059] = {
		id = 60059,
		desc = "展示中",
		define = "IS_IN_SHOW",
		audio = "ban"
	},
	[60062] = {
		id = 60062,
		desc = "更名需要消耗<color=#%s>%s %d/1</color>，且30天内不允许再次修改",
		define = "CHANGE_NAME_COST_ITEM",
		audio = "ban"
	},
	[60063] = {
		id = 60063,
		desc = "剩余时间:",
		define = "REMAINING_TIME",
		audio = "success"
	},
	[60064] = {
		id = 60064,
		desc = "没有权限",
		define = "NOT_PERMISSION",
		audio = "ban"
	},
	[60065] = {
		id = 60065,
		desc = "确认放弃此次调查委托？",
		define = "GIVE_UP_COMMISSION",
		audio = "ban"
	},
	[60066] = {
		id = 60066,
		desc = "是否确认退出战斗？",
		define = "GIVE_UP_BATTLE",
		audio = "ban"
	},
	[60070] = {
		id = 60070,
		desc = "请先选择材料",
		define = "PLEASE_SELECT_ITEM",
		audio = "ban"
	},
	[60071] = {
		id = 60071,
		desc = "该刻印正在被<color=#FF9500>%s</color>使用，继续装备将会从原始人物身上卸下。\n是否确认更换？",
		define = "EQUIP_IS_USING",
		audio = "ban"
	},
	[60074] = {
		id = 60074,
		desc = "分",
		define = "TIP_MINUTE",
		audio = "ban"
	},
	[60075] = {
		id = 60075,
		desc = "天",
		define = "DAY",
		audio = "ban"
	},
	[60076] = {
		id = 60076,
		desc = "小时",
		define = "HOUR",
		audio = "ban"
	},
	[60077] = {
		id = 60077,
		desc = "分钟",
		define = "MINUTE",
		audio = "ban"
	},
	[60078] = {
		id = 60078,
		desc = "秒",
		define = "SECOND",
		audio = "ban"
	},
	[60079] = {
		id = 60079,
		desc = "已超时",
		define = "TIME_OUT",
		audio = "ban"
	},
	[60080] = {
		id = 60080,
		desc = "弥弥尔系统进入休眠状态，是否立即重连",
		define = "CANNOT_CONNECT_CHECK",
		audio = "ban"
	},
	[60081] = {
		id = 60081,
		desc = "网络连接失败，请检查网络设置后尝试重新登录",
		define = "CANNOT_CONNECT_QUIT",
		audio = "ban"
	},
	[60082] = {
		id = 60082,
		desc = "客户端数据异常，请重新登录",
		define = "DATA_ERROR_TO_LOGIN",
		audio = "ban"
	},
	[60083] = {
		id = 60083,
		desc = "前",
		define = "BEFORE",
		audio = "ban"
	},
	[60084] = {
		id = 60084,
		desc = "在线",
		define = "ONLINE",
		audio = "ban"
	},
	[60085] = {
		id = 60085,
		desc = "删除好友",
		define = "FRIEND_DELETE",
		audio = "ban"
	},
	[60086] = {
		id = 60086,
		desc = "移动至黑名单",
		define = "FRIEND_MOVE_TO_BLACLIST",
		audio = "ban"
	},
	[60087] = {
		id = 60087,
		desc = "确定要将<color=#FF9500>%s</color>从好友列表中删除？",
		define = "FRIEND_DELETE_QUEST",
		audio = "ban"
	},
	[60088] = {
		id = 60088,
		desc = "已将<color=#FF9500>%s</color>从好友列表中删除",
		define = "FRIEND_DELETE_NOTE",
		audio = "success"
	},
	[60089] = {
		id = 60089,
		desc = "确定要将<color=#FF9500>%s</color>移动至黑名单？",
		define = "FRIEND_MOVE_TO_BLACLIST_QUEST",
		audio = "ban"
	},
	[60090] = {
		id = 60090,
		desc = "已将<color=#FF9500>%s</color>移动至黑名单",
		define = "FRIEND_MOVE_TO_BLACLIST_NOTE",
		audio = "success"
	},
	[60091] = {
		id = 60091,
		desc = "黑名单人数已达上限，无法继续添加",
		define = "FRIEND_MOVE_TO_BLACLIST_NOTE_LIMIT",
		audio = "ban"
	},
	[60092] = {
		id = 60092,
		desc = "在此输入玩家UID",
		define = "NOT_ENTER_NICK_UID",
		audio = "ban"
	},
	[60093] = {
		id = 60093,
		desc = "已忽略该好友申请",
		define = "FRIEND_APPLY_REJECT",
		audio = "success"
	},
	[60094] = {
		id = 60094,
		desc = "已发送好友申请",
		define = "FRIEND_APPLY_SEND",
		audio = "success"
	},
	[60095] = {
		id = 60095,
		desc = "成功添加<color=#FF9500>%s</color>为好友",
		define = "FRIEND_MAKE_SUCCESS",
		audio = "success"
	},
	[60096] = {
		id = 60096,
		desc = "确认将<color=#FF9500>%s</color>从黑名单中移除？",
		define = "BLACKLIST_REMOVE_QUEST",
		audio = "ban"
	},
	[60097] = {
		id = 60097,
		desc = "已将<color=#FF9500>%s</color>从黑名单中移除",
		define = "BLACKLIST_REMOVE_NOTE",
		audio = "success"
	},
	[60098] = {
		id = 60098,
		desc = "账号已在其余地方登录",
		define = "LOGIN_IN_OTHER_PLACE",
		audio = "ban"
	},
	[60099] = {
		id = 60099,
		desc = "与服务器断开连接，请重新登录",
		define = "KICK_BY_SERVER",
		audio = "ban"
	},
	[60100] = {
		id = 60100,
		desc = "重连超时，请检查网络设置后尝试重新登录",
		define = "RECONNECT_TOO_LONG",
		audio = "ban"
	},
	[60101] = {
		id = 60101,
		desc = "与服务器连接异常，请尝试重新登录",
		define = "CONNECT_DATA_ERROR",
		audio = "ban"
	},
	[60102] = {
		id = 60102,
		desc = "与服务器断开连接，请尝试重新登录",
		define = "CS_INDEX_ERROR",
		audio = "ban"
	},
	[60103] = {
		id = 60103,
		desc = "无法连接到聊天服务器",
		define = "CANNOT_CONNECT_CHAT",
		audio = "ban"
	},
	[60104] = {
		id = 60104,
		desc = "该玩家不是你的好友",
		define = "NOT_FRIEND",
		audio = "ban"
	},
	[60106] = {
		id = 60106,
		desc = "无好友",
		define = "NO_FRIEND",
		audio = "ban"
	},
	[60107] = {
		id = 60107,
		desc = "暂无新的好友申请",
		define = "NO_FRIEND_REQUEST",
		audio = "ban"
	},
	[60108] = {
		id = 60108,
		desc = "无黑名单成员",
		define = "NO_BLACKLIST",
		audio = "ban"
	},
	[60109] = {
		id = 60109,
		desc = "<size=30>%d</size><size=30>号位</size>",
		define = "POSITION_TIP",
		audio = "ban"
	},
	[60110] = {
		id = 60110,
		desc = "复制成功",
		define = "COPY_SUCCESS",
		audio = "success"
	},
	[60111] = {
		id = 60111,
		desc = "<b><color=#00acf8>经验</color></b>提升完成",
		define = "HERO_UPGRATE_SUCCESS",
		audio = "success"
	},
	[60112] = {
		id = 60112,
		desc = "<b><color=#00acf8>技能</color></b>等级提升！",
		define = "SKILL_UPGRATE_SUCCESS",
		audio = "success"
	},
	[60113] = {
		id = 60113,
		desc = "<b><color=#00acf8>经验</color></b>提升完成！",
		define = "EQUIP_UPGRATE_SUCCESS",
		audio = "success"
	},
	[60114] = {
		id = 60114,
		desc = "神格溯回成功",
		define = "ASTROLABE_UNLOCK",
		audio = "success"
	},
	[60115] = {
		id = 60115,
		desc = "神格共鸣完成",
		define = "ASTROLABE_BIND",
		audio = "astrolabe_wear"
	},
	[60116] = {
		id = 60116,
		desc = "神格共鸣解除",
		define = "ASTROLABE_UNBIND",
		audio = "success"
	},
	[60117] = {
		id = 60117,
		desc = "<b><color=#00acf8>套装属性</color></b>激活",
		define = "SUIT_ACTIVE",
		audio = "success"
	},
	[60118] = {
		id = 60118,
		desc = "佩戴刻印成功",
		define = "EQUIP_BIND",
		audio = "equip_wear"
	},
	[60119] = {
		id = 60119,
		desc = "卸载刻印成功",
		define = "EQUIP_UNBIND",
		audio = "equip_wear"
	},
	[60120] = {
		id = 60120,
		desc = "今日限购",
		define = "LIMIT_DAY",
		audio = "success"
	},
	[60121] = {
		id = 60121,
		desc = "本周限购",
		define = "LIMIT_WEEK",
		audio = "success"
	},
	[60122] = {
		id = 60122,
		desc = "本月限购",
		define = "LIMIT_MONTH",
		audio = "success"
	},
	[60123] = {
		id = 60123,
		desc = "本次限购",
		define = "LIMIT_ALL",
		audio = "success"
	},
	[60124] = {
		id = 60124,
		desc = "管理员等级达到%d级解锁",
		define = "PLAYER_LEVEL_UNLOCK",
		audio = "ban"
	},
	[60125] = {
		id = 60125,
		desc = "通行证达%d级解锁",
		define = "PASS_LEVEL_UNLOCK",
		audio = "ban"
	},
	[60126] = {
		id = 60126,
		desc = "神识超越完成",
		define = "UPGRADE_STAR_SUCCESS",
		audio = "success"
	},
	[60127] = {
		id = 60127,
		desc = "%s不足",
		define = "CURRENCY_NO_ENOUGH",
		audio = "ban"
	},
	[60129] = {
		id = 60129,
		desc = "全部套装",
		define = "ALL_EQUIP",
		audio = "ban"
	},
	[60130] = {
		id = 60130,
		desc = "全部技能",
		define = "ALL_EQUIP_SKILL",
		audio = "ban"
	},
	[60131] = {
		id = 60131,
		desc = "通关%s剧情关卡%s-%s后开放",
		define = "MISSION_PROGRESS_UNLOCK",
		audio = "ban"
	},
	[60132] = {
		id = 60132,
		desc = "设置已保存",
		define = "SAVE_SYSTEM_SETTING",
		audio = "success"
	},
	[60133] = {
		id = 60133,
		desc = "套装",
		define = "TYPE_EQUIP",
		audio = "ban"
	},
	[60134] = {
		id = 60134,
		desc = "位置",
		define = "TYPE_POSITION",
		audio = "ban"
	},
	[60135] = {
		id = 60135,
		desc = "物品已失效",
		define = "ITEM_INVALID",
		audio = "ban"
	},
	[60136] = {
		id = 60136,
		desc = "当前拥有的刻印数量达到上限，请前往仓库整理",
		define = "EQUIP_NUM_MAX",
		audio = "ban"
	},
	[60137] = {
		id = 60137,
		desc = "刻印突破成功",
		define = "EQUIP_BREAK_SUCCESS",
		audio = "success"
	},
	[60138] = {
		id = 60138,
		desc = "管理员，检测到游戏有最新版数据，请重新打开游戏进行更新！",
		define = "CHECK_UPDATE_NOTE",
		audio = "ban"
	},
	[60139] = {
		id = 60139,
		desc = "溢出的吨吨值已发放至邮箱",
		define = "VITALITY_FULL",
		audio = "success"
	},
	[60140] = {
		id = 60140,
		desc = "超出上限的刻印已发放至邮箱",
		define = "EQUIP_SEND_MAIL",
		audio = "success"
	},
	[60141] = {
		id = 60141,
		desc = "首次掉落",
		define = "FIRST_DROP",
		audio = "ban"
	},
	[60142] = {
		id = 60142,
		desc = "可能掉落",
		define = "MAYBE_DROP",
		audio = "ban"
	},
	[60143] = {
		id = 60143,
		desc = "准备作战",
		define = "READY_BATTLE",
		audio = "ban"
	},
	[60145] = {
		id = 60145,
		desc = "昵称修改成功",
		define = "SUCCESS_CHANGE_NAME",
		audio = "success"
	},
	[60146] = {
		id = 60146,
		desc = "是否清空本地缓存资源",
		define = "DELETE_LOCAL_CACHE",
		audio = "ban"
	},
	[60147] = {
		id = 60147,
		desc = "网络连接异常，点击确定重新登录",
		define = "CANNOT_CONNECT_RE_LOGIN",
		audio = "ban"
	},
	[60148] = {
		id = 60148,
		desc = "无网络连接，请检查网络设置情况",
		define = "CANNOT_CONNECT",
		audio = "ban"
	},
	[60149] = {
		id = 60149,
		desc = "怒气",
		define = "NOTE_ENERGYTYPE_1",
		audio = "ban"
	},
	[60150] = {
		id = 60150,
		desc = "能量",
		define = "NOTE_ENERGYTYPE_2",
		audio = "ban"
	},
	[60151] = {
		id = 60151,
		desc = "印记",
		define = "NOTE_ENERGYTYPE_3",
		audio = "ban"
	},
	[60152] = {
		id = 60152,
		desc = "%s完成后解锁",
		define = "NOTE_TASK_UNLOCK",
		audio = "ban"
	},
	[60153] = {
		id = 60153,
		desc = "神格解锁条件未达成",
		define = "ERROR_ASTROLABE_UNLOCK_CONDITION_NOT_MATCH",
		audio = "ban"
	},
	[60154] = {
		id = 60154,
		desc = "请输入兑换码",
		define = "PLEASE_INPUT_EXCHANGE_CODE",
		audio = "ban"
	},
	[60163] = {
		id = 60163,
		desc = "兑换码使用成功，资源已发送至邮箱，请注意查收",
		define = "SUCCESS_EXCHANGE_CODE",
		audio = "success"
	},
	[60164] = {
		id = 60164,
		desc = "%s级解锁",
		define = "PLAYER_LEVEL_LIMIT",
		audio = "ban"
	},
	[60165] = {
		id = 60165,
		desc = "和服务器断开连接",
		define = "CANNOT_CONNECT_BATTLE",
		audio = "ban"
	},
	[60166] = {
		id = 60166,
		desc = "使用成功",
		define = "EXCHANGE_SUCCESS",
		audio = "success"
	},
	[60167] = {
		id = 60167,
		desc = [[
1.每周四随机出现多个BOSS，每日05:00解锁一个BOSS。
2.通关当前难度即可解锁下一级难度，挑战进度和奖励每周四重置。
3.挑战成功时使用的修正者会被锁定，被锁定的修正者不可用于其他BOSS，锁定修正者每周四重置。
4.挑战失败时不锁定使用的修正者
5.在未领取奖励之前，可以重置挑战过的BOSS的进度，重置后该BOSS已完成的关卡目标将被清空，同时解除该BOSS锁定角色的锁定状态。
6.常规梦境-异相层开启后，在未领取奖励之前，可以更换梦境难度，但会清除当前梦境难度下的全部进度。]],
		define = "BOSS_CHALLENGE_DESC",
		audio = "ban"
	},
	[60168] = {
		id = 60168,
		desc = "重置成功",
		define = "ASTROLABE_RESET",
		audio = "success"
	},
	[60169] = {
		id = 60169,
		desc = "通关%s第%s章后开启",
		define = "NEED_FINISH_PRE_STAGE",
		audio = "ban"
	},
	[60170] = {
		id = 60170,
		desc = "通关全部前置章节后开启",
		define = "NEED_FINISH_PRE_NORMAL_STAGE",
		audio = "ban"
	},
	[60178] = {
		id = 60178,
		desc = "修正者突破等级<color=#ED4040>%d</color>可继续升级",
		define = "NOTE_SKILL_LIMIT",
		audio = "ban"
	},
	[60179] = {
		id = 60179,
		desc = "不可更换出战修正者",
		define = "CAN_NOT_CHANGE_HERO",
		audio = "ban"
	},
	[60180] = {
		id = 60180,
		desc = "1.拥有修正者后会自动开启对应的角色教学关卡。\n2.首次通关教学关卡可以获得一次性奖励。",
		define = "TEACH_STAGE_DESC",
		audio = "ban"
	},
	[60181] = {
		id = 60181,
		desc = "玩法说明",
		define = "STAGE_DESCRIPE",
		audio = "success"
	},
	[60182] = {
		id = 60182,
		desc = "BOSS情报",
		define = "STAGE_BOSS_DESCRIPE",
		audio = "ban"
	},
	[60183] = {
		id = 60183,
		desc = "%s后刷新",
		define = "REFRESH_LOST_TIME",
		audio = "success"
	},
	[60184] = {
		id = 60184,
		desc = "队伍不能有相同的修正者",
		define = "TEAM_REPEAT_HERO",
		audio = "ban"
	},
	[60185] = {
		id = 60185,
		desc = "共鸣上限：%d/%d",
		define = "ASTROLABE_NUM_MAX",
		audio = "ban"
	},
	[60186] = {
		id = 60186,
		desc = "解除共鸣会同时将后置神格解除，是否继续？",
		define = "TIP_ASTROLABE_UNINSTALL",
		audio = "ban"
	},
	[60187] = {
		id = 60187,
		desc = "需要先共鸣「%s」·「%s」",
		define = "TIP_ASTROLABE_FRONT",
		audio = "ban"
	},
	[60188] = {
		id = 60188,
		desc = "神格共鸣已达上限",
		define = "TIP_ASTROLABE_NUM_MAX",
		audio = "ban"
	},
	[60189] = {
		id = 60189,
		desc = [[
1.每一个难度等级各有4个关卡，分为1个核心黑区和3个边缘黑区。
2.核心黑区共有3个通关目标，完成不同个数的通关目标可以兑换不同的奖励。
3.每星期一和星期五都会刷新一次关卡内容和奖励。
4.通关边缘黑区可以解锁玩家有利词缀，每通关一个边缘黑区，解锁一个词缀。
5.系统词缀会对所有关卡里对应所有的敌人以及对应所有的修正者生效，蓝底词缀对修正者生效，红底词缀对敌人生效。
6.在完成所有核心黑区的通关目标后，下一次刷新则会开启下一个难度等级。
7.在未领取奖励之前，可以任意切换难度，但切换不同难度后，会重置黑区关卡状态。]],
		define = "MYTHIC_DESCRIPE",
		audio = "ban"
	},
	[60190] = {
		id = 60190,
		desc = [[
1.每个区域共有10个关卡。
2.所有的关卡的通关奖励只能获得一次。
3.区域会随等级逐渐开放，关卡难度和词缀个数与等级会逐渐上升。
4.每个区域里第5关是精英关卡，第10关是BOSS关卡。]],
		define = "SPAWN_DESCRIPE",
		audio = "ban"
	},
	[60201] = {
		id = 60201,
		desc = "刻印等级达到%d级时开放",
		define = "EQUIP_ENCHANT_OEPN_LEVEL",
		audio = "ban"
	},
	[60202] = {
		id = 60202,
		desc = "%s修正者装备后刻印属性提升20%%",
		define = "EQUIP_RACE_ATTRIBUTE_UP",
		audio = "ban"
	},
	[60203] = {
		id = 60203,
		desc = "无神系效果",
		define = "EQUIP_NO_RACE",
		audio = "ban"
	},
	[60204] = {
		id = 60204,
		desc = "达到%d级解锁",
		define = "EQUIP_SKILL_LOCK_LEVEL",
		audio = "ban"
	},
	[60205] = {
		id = 60205,
		desc = "本次强化将返还以下材料，是否继续强化？",
		define = "EQUIP_STRENGTH_EXP_OVERFLOW",
		audio = "ban"
	},
	[60206] = {
		id = 60206,
		desc = "管理员等级达到<color=#FF9500>%d</color>级",
		define = "UPGRADE_LIMIT_LEVEL",
		audio = "ban"
	},
	[60207] = {
		id = 60207,
		desc = "管理员等级达到<color='#FF0000'>%d</color>级",
		define = "UPGRADE_LIMIT_LEVEL_RED",
		audio = "ban"
	},
	[60208] = {
		id = 60208,
		desc = "返还的材料已发放至仓库",
		define = "EQUIP_STRENGTH_BACK",
		audio = "success"
	},
	[60209] = {
		id = 60209,
		desc = "刻印穿戴失败",
		define = "EQUIP_DRESS_FAIL",
		audio = "ban"
	},
	[60210] = {
		id = 60210,
		desc = "队长",
		define = "IS_CAPTAIN",
		audio = "ban"
	},
	[60211] = {
		id = 60211,
		desc = "队伍中",
		define = "IN_TEAM",
		audio = "ban"
	},
	[60212] = {
		id = 60212,
		desc = "小队战力较低，是否坚持前往战斗？",
		define = "NOT_ENOUGH_POWER",
		audio = "ban"
	},
	[60213] = {
		id = 60213,
		desc = "黑区净化数据已经刷新，请返回重新选择",
		define = "MYTHIC_REFRESH_DATA",
		audio = "ban"
	},
	[60214] = {
		id = 60214,
		desc = "梦境再构已经刷新，请返回重新选择",
		define = "BOSS_REFRESH_DATA",
		audio = "ban"
	},
	[60215] = {
		id = 60215,
		desc = "关卡已刷新",
		define = "STAGE_REFRESH_DATA",
		audio = "success"
	},
	[60216] = {
		id = 60216,
		desc = "消耗材料中包含<color=#FF9500>五星刻印</color>。\n本次强化将返还以下材料，是否继续强化？",
		define = "EQUIP_STRENGTH_EXP_OVERFLOW_AND_RARE",
		audio = "ban"
	},
	[60217] = {
		id = 60217,
		desc = "消耗材料中包含<color=#FF9500>五星刻印</color>，是否继续强化？",
		define = "EQUIP_STRENGTH_COST_RARE",
		audio = "ban"
	},
	[60218] = {
		id = 60218,
		desc = "本次强化将返还以下材料，是否继续强化？",
		define = "WEAPON_STRENGTH_EXP_OVERFLOW",
		audio = "ban"
	},
	[60219] = {
		id = 60219,
		desc = "消耗材料中包含<color=#FF9500>五星钥从</color>。\n本次强化将返还以下材料，是否继续强化？",
		define = "WEAPON_STRENGTH_EXP_OVERFLOW_AND_RARE",
		audio = "ban"
	},
	[60220] = {
		id = 60220,
		desc = "消耗材料中包含<color=#FF9500>五星钥从</color>，是否继续强化？",
		define = "WEAPON_STRENGTH_COST_RARE",
		audio = "ban"
	},
	[60221] = {
		id = 60221,
		desc = "已锁定",
		define = "IS_LOCK",
		audio = "success"
	},
	[60222] = {
		id = 60222,
		desc = "不可移除",
		define = "CAN_NOT_REMOVE",
		audio = "ban"
	},
	[60223] = {
		id = 60223,
		desc = "移出队伍",
		define = "REMOVE_FROM_TEAM",
		audio = "ban"
	},
	[60224] = {
		id = 60224,
		desc = "更换队员",
		define = "CHANGE_MEMBER",
		audio = "ban"
	},
	[60225] = {
		id = 60225,
		desc = "加入队伍",
		define = "JOIN_TEAM",
		audio = "ban"
	},
	[60226] = {
		id = 60226,
		desc = "1.战场清扫关卡每日更新，每次更新会从战场清扫关卡池中进行抽取，作为该日的挑战关卡。\n2.管理员可以选择一个刻印套装进行UP，掉落必是该套装的一个部位。",
		define = "EQUIP_STAGE_DESCRIPE",
		audio = "ban"
	},
	[60227] = {
		id = 60227,
		desc = [[
1.特勤任务拥有S，A，B三种品级(S>A>B)，特勤任务的品级越高，体力消耗越低。
2.同一难度下不同品级的特勤任务奖励相同。
3.界面同时显示三个特勤任务，每成功完成特勤任务并领取奖励，该栏特勤任务将刷新。
4.可通过刷新按钮刷新现有的三个特勤任务。免费刷新次数使用完后，继续刷新将消耗移转之辉。每日刷新次数有上限，刷新次数每天重置。]],
		define = "ENCHANTMENT_DESCRIPE",
		audio = "ban"
	},
	[60228] = {
		id = 60228,
		desc = "<color=#363A42>同时上阵两名相同神系的修正者时，在开始修正模式时可以获得额外的神系效果</color>",
		define = "NO_CORRECTOR_BUFF",
		audio = "ban"
	},
	[60229] = {
		id = 60229,
		desc = "<color=#363A42>同时上阵三名相同神系的修正者时，可以在战斗过程中获得额外加成效果</color>",
		define = "NO_BATTLE_BUFF",
		audio = "ban"
	},
	[60230] = {
		id = 60230,
		desc = "本次升级将返还以下材料，是否继续升级？",
		define = "HERO_STRENGTH_EXP_OVERFLOW",
		audio = "ban"
	},
	[60231] = {
		id = 60231,
		desc = [[
1.多维变量中玩家每周可以操纵不同的修正者进行探索
2.每次探索会遇到随机的关卡和事件
3.可以重复挑战获取奖励
4.初始超越等级为S/A/B级的修正者的多维变量中战斗力都是相近的
5.多维变量事件中修正者的生命值变化将会被保留，并在完成结算后继承至下一次事件中
6.额外的，在完成战斗事件后，所有出战修正者将获得20%基础生命值的生命回复
7.在多维变量内无法更换管理喵]],
		define = "MATRIX_DESCRIPE",
		audio = "ban"
	},
	[60232] = {
		id = 60232,
		desc = "<color=#005FED>蓝锁状态下</color>：拖动摇杆且摇杆方向上有敌方目标时，将会自动切换锁定目标 \n<color=#ED0D00>红锁状态下</color>：将不会自动切换锁定目标",
		define = "LOCK_TYPE_DESC1",
		audio = "ban"
	},
	[60233] = {
		id = 60233,
		desc = "始终锁定最靠近队长角色的敌人",
		define = "LOCK_TYPE_DESC2",
		audio = "ban"
	},
	[60234] = {
		id = 60234,
		desc = "需通过<color=#ED0D00>点击锁定按钮切换目标</color>或<color=#ED0D00>长按锁定按钮取消锁定</color>",
		define = "LOCK_TYPE_DESC3",
		audio = "ban"
	},
	[60235] = {
		id = 60235,
		desc = "多维变量数据已经刷新，请返回重新选择",
		define = "MATRIX_REFRESH_DATA",
		audio = "ban"
	},
	[60236] = {
		id = 60236,
		desc = "是否确定消耗<color=#FF9500>「%s」x%d </color>获得<color=#FF9500>「%s」x%d </color>？",
		define = "CONFIRM_BUY",
		audio = "ban"
	},
	[60237] = {
		id = 60237,
		desc = "当前设备存储空间不足，是否前往语音包管理器以卸载部分语音资源？",
		define = "VOICE_STORAGE_FULL",
		audio = "ban"
	},
	[60238] = {
		id = 60238,
		desc = "已忽略所有好友申请",
		define = "IGNORE_ALL_FRIEND_REQUEST",
		audio = "success"
	},
	[60239] = {
		id = 60239,
		desc = "刷新频率过快，请稍后再试",
		define = "FRIEND_REFRESH_TOO_FAST",
		audio = "ban"
	},
	[60240] = {
		id = 60240,
		desc = "无法添加自己为好友",
		define = "CANNOT_ADD_SELF",
		audio = "ban"
	},
	[60241] = {
		id = 60241,
		desc = "你已将对方加入黑名单，是否将对方移出黑名单并发送好友申请？",
		define = "ADD_BLACKLIST_FRIEND_COMFIRMATION",
		audio = "ban"
	},
	[60242] = {
		id = 60242,
		desc = "确认要删除「%s」语音包？",
		define = "VOICE_DELETE_INFO",
		audio = "ban"
	},
	[60243] = {
		id = 60243,
		desc = "当前无可用经验材料，是否前往资源关卡获取？",
		define = "NO_HERO_EXP_MATERIAL",
		audio = "ban"
	},
	[60244] = {
		id = 60244,
		desc = "当前选择<color=#FA9526>无</color>",
		define = "SELECT_CURRENT",
		audio = "ban"
	},
	[60245] = {
		id = 60245,
		desc = "获得吨吨值<color=#FF9500>%d</color>",
		define = "GET_FATIGUE",
		audio = "ban"
	},
	[60246] = {
		id = 60246,
		desc = "获得艾因索菲币<color=#FF9500>%d</color>",
		define = "GET_GOLD",
		audio = "ban"
	},
	[60247] = {
		id = 60247,
		desc = "是否保存修改？",
		define = "TIP_SETTING_CHANGE",
		audio = "ban"
	},
	[60248] = {
		id = 60248,
		desc = "是否退出当前账号并回到登录界面？",
		define = "TIP_EXIT_GAME",
		audio = "ban"
	},
	[60249] = {
		id = 60249,
		desc = "确定要跳过剧情？",
		define = "TIP_SKIP_PLOT",
		audio = "ban"
	},
	[60250] = {
		id = 60250,
		desc = "后获取%d次刷新次数",
		define = "ENCHANTMENT_STAGE_REFRESH_TIMES",
		audio = "ban"
	},
	[60251] = {
		id = 60251,
		desc = "刷新一次",
		define = "ENCHANTMENT_STAGE_REFRESH_ONCE",
		audio = "ban"
	},
	[60252] = {
		id = 60252,
		desc = "是否退出游戏？",
		define = "TIP_QUIT_GAME",
		audio = "ban"
	},
	[60253] = {
		id = 60253,
		desc = "黑区净化已刷新，不可再次挑战",
		define = "MYTHIC_REFRESH",
		audio = "ban"
	},
	[60254] = {
		id = 60254,
		desc = "是否消耗<color=#FF9500>{0} {1}</color>兑换<color=#FF9500>{2} {3}</color>并进行探测？",
		define = "RECHARGE_DIAMOND_OR_DIAMOND_EXCHANGE_DRAWCARD",
		audio = "ban"
	},
	[60255] = {
		id = 60255,
		desc = "是否消耗<color=#FF9500>{0}移转之花+{1}移转之辉</color>兑换<color=#FF9500>{2} {3}</color>并进行探测？",
		define = "RECHARGE_DIAMOND_AND_DIAMOND_EXCHANGE_DRAWCARD",
		audio = "ban"
	},
	[60256] = {
		id = 60256,
		desc = "<color=#957A36>%s</color>",
		define = "REFRESH_LOST_TIME_WITH_COLOR",
		audio = "ban"
	},
	[60257] = {
		id = 60257,
		desc = "等级",
		define = "LEVEL",
		audio = "ban"
	},
	[60258] = {
		id = 60258,
		desc = "奖励已发放至邮箱，请管理员注意查收",
		define = "WEIBO_REWARD_SENT",
		audio = "success"
	},
	[60259] = {
		id = 60259,
		desc = "再次挑战",
		define = "CHALLENGE_ONCE_MORE",
		audio = "success"
	},
	[60260] = {
		id = 60260,
		desc = "挑战下一关",
		define = "CHALLENGE_NEXT_LEVEL",
		audio = "success"
	},
	[60261] = {
		id = 60261,
		desc = "管理员您是否要校验并清除损坏的下载资源?\n本操作可以解决文件数据下载出错的问题",
		define = "VERIFY_ASSETS_BEFORE_CONFIRM",
		audio = "ban"
	},
	[60262] = {
		id = 60262,
		desc = "资源检测",
		define = "VERIFY_ASSETS_PROCESSING_TITLE",
		audio = "ban"
	},
	[60263] = {
		id = 60263,
		desc = "正在检查客户端资源完整性…",
		define = "VERIFY_ASSETS_PROCESSING_CONTENT",
		audio = "ban"
	},
	[60264] = {
		id = 60264,
		desc = "%d/%d",
		define = "VERIFY_ASSETS_PROCESSING_RATE",
		audio = "ban"
	},
	[60265] = {
		id = 60265,
		desc = "发现损坏文件，已进行清理，请重启游戏！",
		define = "VERIFY_ASSETS_HAS_ERROR",
		audio = "ban"
	},
	[60266] = {
		id = 60266,
		desc = "客户端资源完整，无需修复",
		define = "VERIFY_ASSETS_COMPLETE",
		audio = "success"
	},
	[60267] = {
		id = 60267,
		desc = "未领取的结算奖励已发送至邮箱，请前往领取",
		define = "UNCLAIMED_BONUS_MAIL_TIP",
		audio = "success"
	},
	[60268] = {
		id = 60268,
		desc = "当前邮件已被设为星标邮件，确认要删除吗？",
		define = "MAIL_STAR_DELETE_TIP",
		audio = "ban"
	},
	[60269] = {
		id = 60269,
		desc = "已拥有足够的情报将该角色超越至Ω",
		define = "OMEGA_ENOUGH_TIP",
		audio = "ban"
	},
	[60270] = {
		id = 60270,
		desc = "全部商品",
		define = "ALL_GOODS",
		audio = "ban"
	},
	[60271] = {
		id = 60271,
		desc = "本日售罄",
		define = "DAILY_SOLD_OUT",
		audio = "ban"
	},
	[60272] = {
		id = 60272,
		desc = "本周售罄",
		define = "WEEKLY_SOLD_OUT",
		audio = "ban"
	},
	[60273] = {
		id = 60273,
		desc = "本月售罄",
		define = "MONTHLY_SOLD_OUT",
		audio = "ban"
	},
	[60274] = {
		id = 60274,
		desc = "切换难度后将会重置黑区关卡状态，是否确认切换。",
		define = "MYTHIC_CHANGE_DIFFICULTY",
		audio = "ban"
	},
	[60275] = {
		id = 60275,
		desc = "领取奖励后将不可切换难度",
		define = "MYTHIC_REWARD_LOACK_DIFFICULTY",
		audio = "ban"
	},
	[60276] = {
		id = 60276,
		desc = "一",
		define = "NUM_1",
		audio = "ban"
	},
	[60277] = {
		id = 60277,
		desc = "二",
		define = "NUM_2",
		audio = "ban"
	},
	[60278] = {
		id = 60278,
		desc = "三",
		define = "NUM_3",
		audio = "ban"
	},
	[60279] = {
		id = 60279,
		desc = "四",
		define = "NUM_4",
		audio = "ban"
	},
	[60280] = {
		id = 60280,
		desc = "五",
		define = "NUM_5",
		audio = "ban"
	},
	[60281] = {
		id = 60281,
		desc = "六",
		define = "NUM_6",
		audio = "ban"
	},
	[60282] = {
		id = 60282,
		desc = "七",
		define = "NUM_7",
		audio = "ban"
	},
	[60283] = {
		id = 60283,
		desc = "八",
		define = "NUM_8",
		audio = "ban"
	},
	[60284] = {
		id = 60284,
		desc = "未选择冷却剂",
		define = "TIP_CHOOSE_EMPTY",
		audio = "ban"
	},
	[60285] = {
		id = 60285,
		desc = "受区域影响不可释放探测器",
		define = "ERROR_BOSS_RECOVERY_DETECTOR",
		audio = "ban"
	},
	[60286] = {
		id = 60286,
		desc = "黑区净化刷新成功",
		define = "HAZARD_ZONE_REFRESH",
		audio = "success"
	},
	[60287] = {
		id = 60287,
		desc = "还有%s才能刷新",
		define = "RECOMMEND_FRIEND_CD",
		audio = "ban"
	},
	[60288] = {
		id = 60288,
		desc = "请用移动端分享",
		define = "SHARE_PLATFORM",
		audio = "ban"
	},
	[60289] = {
		id = 60289,
		desc = "账号ID不能为空",
		define = "IF_ACCOUNT_NIL",
		audio = "ban"
	},
	[60290] = {
		id = 60290,
		desc = "神能",
		define = "NOTE_ENERGYTYPE_4",
		audio = "ban"
	},
	[60291] = {
		id = 60291,
		desc = "筛选",
		define = "ROLE_FILTERING",
		audio = "ban"
	},
	[60292] = {
		id = 60292,
		desc = "<size=40><color=#ffffff>￥</color></size><size=76><color=#ffffff>30</color></size>",
		define = "MONTHLY_CARD_PRICE",
		audio = "ban"
	},
	[60293] = {
		id = 60293,
		desc = "<size=26><color=#d4d4d4>购买即可获得</color></size>",
		define = "MONTHLY_CARD_ONCE_GET_1",
		audio = "ban"
	},
	[60294] = {
		id = 60294,
		desc = "<size=26><color=#d4d4d4>连续30日每日获得</color></size>",
		define = "MONTHLY_CARD_DAILY_GET_1",
		audio = "ban"
	},
	[60295] = {
		id = 60295,
		desc = "<size=42><color=#ffffff>移转之花</color></size><size=42><color=#f69500>300</color></size><size=42><color=#ffffff>枚</color></size>",
		define = "MONTHLY_CARD_ONCE_GET_2",
		audio = "ban"
	},
	[60296] = {
		id = 60296,
		desc = "<size=42><color=#ffffff>移转之辉</color></size><size=42><color=#f69500>90</color></size><size=42><color=#ffffff>枚</color></size>",
		define = "MONTHLY_CARD_DAILY_GET_2",
		audio = "ban"
	},
	[60297] = {
		id = 60297,
		desc = "商品售罄",
		define = "ACTIVITY_SOLD_OUT",
		audio = "ban"
	},
	[60298] = {
		id = 60298,
		desc = "%s需要解锁%s才能生效",
		define = "ERROR_MATRIX_NOT_EFFECTIVE",
		audio = "ban"
	},
	[60299] = {
		id = 60299,
		desc = "<size=42><color=#FF9500>高帧率模式（实验性功能）</color></size>\n开启高帧率后，会较大程度加快设备耗电、发热，降低手机续航。是否继续使用高帧率设置？",
		define = "WARN_HIGH_FPS_TIPS",
		audio = "ban"
	},
	[60300] = {
		id = 60300,
		desc = "当前战斗内帧率过低，建议降低帧率设置",
		define = "WARN_HIGH_FPS_BATTLE_TIPS",
		audio = "ban"
	},
	[70000] = {
		id = 70000,
		desc = "操作过于频繁",
		define = "FREQUENT_OPERATION_",
		audio = "ban"
	},
	[70001] = {
		id = 70001,
		desc = "强化成功",
		define = "SUCCESS_STRENGTHEN",
		audio = "success"
	},
	[70002] = {
		id = 70002,
		desc = "等级达到上限",
		define = "LEVEL_MAX",
		audio = "ban"
	},
	[70003] = {
		id = 70003,
		desc = "存在限制词汇",
		define = "SENSITIVE_WORD",
		audio = "ban"
	},
	[70004] = {
		id = 70004,
		desc = "超越",
		define = "PROMOTE",
		audio = "ban"
	},
	[70005] = {
		id = 70005,
		desc = "唤名",
		define = "SERVANT_MERGE",
		audio = "ban"
	},
	[70006] = {
		id = 70006,
		desc = "近战",
		define = "RANGETYPE_CLOSE",
		audio = "ban"
	},
	[70007] = {
		id = 70007,
		desc = "远程",
		define = "RANGETYPE_LONG",
		audio = "ban"
	},
	[70008] = {
		id = 70008,
		desc = "当前选择<color=#FA9526>%s</color>",
		define = "TIP_SELECT",
		audio = "ban"
	},
	[70009] = {
		id = 70009,
		desc = "展示中",
		define = "DISPLAY",
		audio = "ban"
	},
	[70010] = {
		id = 70010,
		desc = "取消展示",
		define = "DISPLAY_CANCEL",
		audio = "ban"
	},
	[70011] = {
		id = 70011,
		desc = "修正者等级上限提升至%d级",
		define = "HERO_LEVEL_LIMIT_UP",
		audio = "ban"
	},
	[70012] = {
		id = 70012,
		desc = "培养",
		define = "TIP_UPGRADE",
		audio = "ban"
	},
	[70013] = {
		id = 70013,
		desc = "星级",
		define = "TIP_RARE",
		audio = "ban"
	},
	[70014] = {
		id = 70014,
		desc = "兑换",
		define = "TIP_EXCHANGE",
		audio = "ban"
	},
	[70015] = {
		id = 70015,
		desc = "推荐",
		define = "TIP_RECOMMEND",
		audio = "ban"
	},
	[70016] = {
		id = 70016,
		desc = "隐藏",
		define = "TIP_HIDE",
		audio = "ban"
	},
	[70017] = {
		id = 70017,
		desc = "详情",
		define = "TIP_DETAIL",
		audio = "ban"
	},
	[70018] = {
		id = 70018,
		desc = "突破",
		define = "TIP_BREAK",
		audio = "ban"
	},
	[70019] = {
		id = 70019,
		desc = "强化",
		define = "TIP_STRENGTH",
		audio = "ban"
	},
	[70020] = {
		id = 70020,
		desc = "装备",
		define = "TIP_EQUIP",
		audio = "ban"
	},
	[70021] = {
		id = 70021,
		desc = "已装备",
		define = "TIP_EQUIPED",
		audio = "ban"
	},
	[70022] = {
		id = 70022,
		desc = "已过期",
		define = "TIP_EXPIRED",
		audio = "ban"
	},
	[70023] = {
		id = 70023,
		desc = "帮助",
		define = "TIP_HELP",
		audio = "ban"
	},
	[70024] = {
		id = 70024,
		desc = "或",
		define = "TIP_OR",
		audio = "ban"
	},
	[70025] = {
		id = 70025,
		desc = "旁白",
		define = "TIP_NARRATOR",
		audio = "ban"
	},
	[70026] = {
		id = 70026,
		desc = "未在开启时间",
		define = "NOT_IN_OPEN_TIME",
		audio = "ban"
	},
	[70027] = {
		id = 70027,
		desc = "系统未开放",
		define = "SYSTEM_LOCK",
		audio = "ban"
	},
	[70028] = {
		id = 70028,
		desc = "加载资源中",
		define = "LOADING",
		audio = "ban"
	},
	[70029] = {
		id = 70029,
		desc = "错误码：",
		define = "ERROR_CODE",
		audio = "ban"
	},
	[70030] = {
		id = 70030,
		desc = "无法连接到服务器，请检查网络",
		define = "ERROR_CONNECT_SERVER",
		audio = "ban"
	},
	[70031] = {
		id = 70031,
		desc = "服务器维护中",
		define = "SERVER_MAINTENANCE",
		audio = "ban"
	},
	[70032] = {
		id = 70032,
		desc = "全部位置",
		define = "ALL_POSITION",
		audio = "ban"
	},
	[70033] = {
		id = 70033,
		desc = "准备开始下载",
		define = "DOWNLOAD_START",
		audio = "ban"
	},
	[70034] = {
		id = 70034,
		desc = "下载完成",
		define = "DOWNLOAD_SUCCESS",
		audio = "ban"
	},
	[70035] = {
		id = 70035,
		desc = "下载失败",
		define = "DOWNLOAD_FAIL",
		audio = "ban"
	},
	[70036] = {
		id = 70036,
		desc = "正在取消下载",
		define = "DOWNLOAD_CANCEL",
		audio = "ban"
	},
	[70037] = {
		id = 70037,
		desc = "取消",
		define = "CANCEL",
		audio = "ban"
	},
	[70038] = {
		id = 70038,
		desc = "确定",
		define = "CONFIRM",
		audio = "ban"
	},
	[70039] = {
		id = 70039,
		desc = "前往论坛",
		define = "OPEN_FORUM",
		audio = "ban"
	},
	[70040] = {
		id = 70040,
		desc = "使用",
		define = "TIP_USE",
		audio = "ban"
	},
	[70041] = {
		id = 70041,
		desc = "使用中",
		define = "TIP_USING",
		audio = "ban"
	},
	[70042] = {
		id = 70042,
		desc = "展示",
		define = "TIP_DISPLAY",
		audio = "ban"
	},
	[70043] = {
		id = 70043,
		desc = "刻印",
		define = "EQUIP",
		audio = "ban"
	},
	[70044] = {
		id = 70044,
		desc = "功能暂时关闭",
		define = "OPERATION_DISABLED",
		audio = "ban"
	},
	[70045] = {
		id = 70045,
		desc = "%s后解锁",
		define = "UNLOCK",
		audio = "ban"
	},
	[70046] = {
		id = 70046,
		desc = "本次登录不再提示",
		define = "LOGIN_MUTE_TIP",
		audio = "ban"
	},
	[70047] = {
		id = 70047,
		desc = "今日不再提示",
		define = "DAILY_MUTE_TIP",
		audio = "ban"
	},
	[70048] = {
		id = 70048,
		desc = "本周不再提示",
		define = "WEEKLY_MUTE_TIP",
		audio = "ban"
	},
	[70049] = {
		id = 70049,
		desc = "本月不再提示",
		define = "MONTYLY_MUTE_TIP",
		audio = "ban"
	},
	[70050] = {
		id = 70050,
		desc = "已下载",
		define = "DOWNLOADED",
		audio = "ban"
	},
	[70051] = {
		id = 70051,
		desc = "未下载",
		define = "NOT_DOWNLOADED",
		audio = "ban"
	},
	[70052] = {
		id = 70052,
		desc = "暂无材料",
		define = "NO_MATERIAL",
		audio = "ban"
	},
	[70053] = {
		id = 70053,
		desc = "暂无情报",
		define = "NO_HERO_PIECE",
		audio = "ban"
	},
	[70054] = {
		id = 70054,
		desc = "暂无钥从",
		define = "NO_SERVANT",
		audio = "ban"
	},
	[70055] = {
		id = 70055,
		desc = "暂无刻印",
		define = "NO_EQUIP",
		audio = "ban"
	},
	[70056] = {
		id = 70056,
		desc = "暂无礼物",
		define = "NO_GIFT",
		audio = "ban"
	},
	[70057] = {
		id = 70057,
		desc = "默认排序",
		define = "DEFAULT_SORT",
		audio = "ban"
	},
	[70058] = {
		id = 70058,
		desc = "最近聊天",
		define = "LAST_CHAT",
		audio = "ban"
	},
	[70059] = {
		id = 70059,
		desc = "最后登录",
		define = "LAST_LOGIN",
		audio = "ban"
	},
	[70060] = {
		id = 70060,
		desc = "昵称",
		define = "USER_NAME",
		audio = "ban"
	},
	[70061] = {
		id = 70061,
		desc = "基础属性提升",
		define = "BASE_PROPERTY_UP",
		audio = "ban"
	},
	[70062] = {
		id = 70062,
		desc = "技能等级提升",
		define = "SKILL_LEVEL_UP",
		audio = "ban"
	},
	[70063] = {
		id = 70063,
		desc = "特殊效果",
		define = "SPECIAL_SKILL",
		audio = "ban"
	},
	[70064] = {
		id = 70064,
		desc = "初始化中…",
		define = "INITING",
		audio = "ban"
	},
	[70065] = {
		id = 70065,
		desc = "请按下按键…",
		define = "PLEASE_INPUT_KEY",
		audio = "ban"
	},
	[70066] = {
		id = 70066,
		desc = "净化成功",
		define = "PURIFY_SUCCESS",
		audio = "ban"
	},
	[70067] = {
		id = 70067,
		desc = "此页无用",
		define = "PAGE_NO_USE",
		audio = "ban"
	},
	[70068] = {
		id = 70068,
		desc = "暂无物品",
		define = "NO_ITEM",
		audio = "ban"
	},
	[70069] = {
		id = 70069,
		desc = "暂无补正变量",
		define = "NO_FIX_ITEM",
		audio = "ban"
	},
	[70070] = {
		id = 70070,
		desc = "空",
		define = "ALL_NULL",
		audio = "ban"
	},
	[70071] = {
		id = 70071,
		desc = "暂无错误参数",
		define = "NO_ERROR_PARAMS",
		audio = "ban"
	},
	[70072] = {
		id = 70072,
		desc = "升级",
		define = "TEXT_UPGRADE",
		audio = "ban"
	},
	[70073] = {
		id = 70073,
		desc = "已满级",
		define = "TEXT_LEVEL_MAX",
		audio = "ban"
	},
	[70074] = {
		id = 70074,
		desc = "前往",
		define = "GO_UP_TO",
		audio = "ban"
	},
	[70076] = {
		id = 70076,
		desc = "无法到达",
		define = "CAN_NOT_TEACH",
		audio = "ban"
	},
	[70077] = {
		id = 70077,
		desc = "回到当前",
		define = "BACK_TO_CURRENT",
		audio = "ban"
	},
	[70078] = {
		id = 70078,
		desc = "拥有状态",
		define = "TIP_UNLOCK_HERO",
		audio = "ban"
	},
	[70079] = {
		id = 70079,
		desc = "品质",
		define = "TIP_HERO_RARE",
		audio = "ban"
	},
	[70080] = {
		id = 70080,
		desc = "已拥有该换装",
		define = "SKIN_HAD_UNLOCKED",
		audio = "ban"
	},
	[70081] = {
		id = 70081,
		desc = "暂无记录",
		define = "NO_RECORD",
		audio = "ban"
	},
	[70082] = {
		id = 70082,
		desc = "更换",
		define = "TIP_CHANGE",
		audio = "ban"
	},
	[70083] = {
		id = 70083,
		desc = "通关%s剧情关卡%s后开放",
		define = "MISSION_PROGRESS_UNLOCK_EX",
		audio = "ban"
	},
	[70084] = {
		id = 70084,
		desc = "本周重置次数：",
		define = "WEEK_RESET_TIME",
		audio = "ban"
	},
	[71000] = {
		id = 71000,
		desc = "删除邮件成功",
		define = "SUCCESS_DELETE_MAIL",
		audio = "success"
	},
	[71001] = {
		id = 71001,
		desc = "没有可以删除的邮件",
		define = "NO_MAIL_CAN_BE_DELETED",
		audio = "ban"
	},
	[71002] = {
		id = 71002,
		desc = "邮件已过期",
		define = "MAIL_EXPIRED",
		audio = "ban"
	},
	[71003] = {
		id = 71003,
		desc = "是否要删除全部已读邮件？\n<size=30><color=#989898>附件未领取的邮件及星标邮件将不会被删除</color></size>",
		define = "MAIL_DELETE_CONFIRM",
		audio = "ban"
	},
	[71004] = {
		id = 71004,
		desc = "%d天后过期",
		define = "EXPIRED_DAY",
		audio = "ban"
	},
	[71005] = {
		id = 71005,
		desc = "%d小时后过期",
		define = "EXPIRED_HOUR",
		audio = "ban"
	},
	[71006] = {
		id = 71006,
		desc = "%d分钟后过期",
		define = "EXPIRED_MINUTE",
		audio = "ban"
	},
	[71007] = {
		id = 71007,
		desc = "%d秒后过期",
		define = "EXPIRED_SECOND",
		audio = "ban"
	},
	[71008] = {
		id = 71008,
		desc = "邮件已过期，无法获取邮件信息",
		define = "TIP_MAIL_EXPIRED",
		audio = "ban"
	},
	[71020] = {
		id = 71020,
		desc = "暂无公告",
		define = "NO_ANNOUNCEMENT",
		audio = "ban"
	},
	[71040] = {
		id = 71040,
		desc = "无可装备的钥从",
		define = "NO_SERVANT_CAN_BE_EQUIPED",
		audio = "ban"
	},
	[71041] = {
		id = 71041,
		desc = "未选择更换钥从",
		define = "NO_SERVANT_BE_SELECTED",
		audio = "ban"
	},
	[71042] = {
		id = 71042,
		desc = "钥从卸下成功",
		define = "SUCCESS_REMOVE_SERVANT",
		audio = "success"
	},
	[71043] = {
		id = 71043,
		desc = "钥从装备成功",
		define = "SUCCESS_EQUIP_SERVANT",
		audio = "success"
	},
	[71044] = {
		id = 71044,
		desc = "请先选择超越消耗",
		define = "CHOOSE_REFINE_COST",
		audio = "ban"
	},
	[71045] = {
		id = 71045,
		desc = "该钥从正在被<color=#FF9500>%s</color>使用，继续装备将会从原始人物身上卸下。\n是否确认更换？",
		define = "SERVANT_IS_USING",
		audio = "ban"
	},
	[71046] = {
		id = 71046,
		desc = "仅%s系修正者可使用",
		define = "EQUIP_RACE",
		audio = "ban"
	},
	[71047] = {
		id = 71047,
		desc = "「%s」已被锁定，继续合成将会取消锁定，是否继续？",
		define = "SERVANT_MATERIAL_LOCKED",
		audio = "ban"
	},
	[71048] = {
		id = 71048,
		desc = "「%s」正在被「%s」使用，继续合成将会从原始人物身上卸下，是否继续？",
		define = "SERVANT_MATERIAL_IS_USING",
		audio = "ban"
	},
	[71049] = {
		id = 71049,
		desc = "当前拥有的钥从数量达到上限",
		define = "SERVANT_NUM_MAX",
		audio = "ban"
	},
	[71050] = {
		id = 71050,
		desc = "将使用超越%s阶的钥从作为超越消耗。是否确认继续？",
		define = "SERVANT_CONSUME_CONFIRM",
		audio = "ban"
	},
	[71051] = {
		id = 71051,
		desc = "超越%d(<color=#FF9500>+%d</color>)阶",
		define = "SERVANT_PROMOTE_LEVEL",
		audio = "ban"
	},
	[71052] = {
		id = 71052,
		desc = "超越%d阶",
		define = "SERVANT_PROMOTE_LEVEL_1",
		audio = "ban"
	},
	[71053] = {
		id = 71053,
		desc = "%s装备中",
		define = "SERVANT_EQUIPED",
		audio = "ban"
	},
	[71054] = {
		id = 71054,
		desc = "%d阶",
		define = "SERVANT_PROMOTE_LEVEL_2",
		audio = "ban"
	},
	[71055] = {
		id = 71055,
		desc = "是否确认唤醒<color=#FF9500>「%s」</color>？",
		define = "SERVANT_MERGE_CONFIRM",
		audio = "ban"
	},
	[71056] = {
		id = 71056,
		desc = "选择的钥从中包含有四星钥从，是否确认分解？",
		define = "SERVANT_RESOLVE_COST_RARE",
		audio = "ban"
	},
	[71057] = {
		id = 71057,
		desc = "选择的钥从中包含有超越过的钥从，是否确认分解？",
		define = "SERVANT_RESOLVE_COST_REFINE",
		audio = "ban"
	},
	[71058] = {
		id = 71058,
		desc = "未拥有该神系的沉睡之子",
		define = "SERVANT_MERGE_MATERIAL_NOT_ENOUGH",
		audio = "ban"
	},
	[71059] = {
		id = 71059,
		desc = "是否确认消耗<color=#FF9500>神识凝晶×%s</color>超越该钥从？",
		define = "SERVANT_TRANSCEND",
		audio = "ban"
	},
	[71060] = {
		id = 71060,
		desc = "是否确认消耗<color=#FF9500>%s×1</color>超越该钥从？",
		define = "SERVANT_TRANSCEND_BY_SERVANT",
		audio = "ban"
	},
	[71061] = {
		id = 71061,
		desc = "（当前持有钥从最高超越至<color=#FF9500>%s</color>阶）",
		define = "SERVANT_TRANSCEND_PROMPT",
		audio = "ban"
	},
	[71100] = {
		id = 71100,
		desc = "请先输入方案名称",
		define = "INPUT_EQUIP_PROPOSAL_NAME",
		audio = "ban"
	},
	[71101] = {
		id = 71101,
		desc = "刻印方案装备成功",
		define = "SUCCESS_EQUIP_PROPOSAL",
		audio = "equip_wear"
	},
	[71102] = {
		id = 71102,
		desc = "刻印方案保存成功",
		define = "SUCCESS_SAVE_EQUIP_PROPOSAL",
		audio = "success"
	},
	[71103] = {
		id = 71103,
		desc = "没有符合条件的刻印",
		define = "NO_MATCH_REC_EQUIP",
		audio = "ban"
	},
	[71120] = {
		id = 71120,
		desc = "请先解除锁定状态",
		define = "REMOVE_LOCK",
		audio = "ban"
	},
	[71121] = {
		id = 71121,
		desc = "%s成长",
		define = "EQUIP_UPGRADE_ATTR_DES",
		audio = "success"
	},
	[71122] = {
		id = 71122,
		desc = "新手推荐",
		define = "EQUIP_RECOMMEND_1",
		audio = "ban"
	},
	[71123] = {
		id = 71123,
		desc = "经济推荐",
		define = "EQUIP_RECOMMEND_2",
		audio = "ban"
	},
	[71124] = {
		id = 71124,
		desc = "后期推荐",
		define = "EQUIP_RECOMMEND_3",
		audio = "ban"
	},
	[71125] = {
		id = 71125,
		desc = "本次分解包含五星刻印，是否继续？",
		define = "EQUIP_RESOLVE_COST_RARE",
		audio = "ban"
	},
	[71126] = {
		id = 71126,
		desc = "%d件套",
		define = "EQUIP_SUIT_NUM",
		audio = "ban"
	},
	[71127] = {
		id = 71127,
		desc = "(最多保留%d次赋能结果)",
		define = "EQUIP_ENCHANT_RESULT_NUM",
		audio = "ban"
	},
	[71128] = {
		id = 71128,
		desc = "可保留的赋能结果数量已达上限",
		define = "EQUIP_ENCHANT_RESULT_NUM_MAX",
		audio = "ban"
	},
	[71129] = {
		id = 71129,
		desc = "锁定后，赋能会消耗更多的高级赋能材料，但是只会生成包含锁定刻印技能的赋能。",
		define = "EQUIP_SKILL_LOCK_DES",
		audio = "ban"
	},
	[71130] = {
		id = 71130,
		desc = "当前未选中修正者",
		define = "EQUIP_HERO_CHOOSE_EMPTY",
		audio = "ban"
	},
	[71131] = {
		id = 71131,
		desc = "%s装备后刻印属性提升40%%",
		define = "EQUIP_HERO_ATTRIBUTE_UP",
		audio = "ban"
	},
	[71132] = {
		id = 71132,
		desc = "需要先激活该刻印的神系重构效果",
		define = "EQUIP_RACE_REBUILD_FIRST",
		audio = "ban"
	},
	[71133] = {
		id = 71133,
		desc = "当前刻印已完成显晰重构，无法再进行重构",
		define = "EQUIP_HERO_HAD_REBUILT",
		audio = "ban"
	},
	[71134] = {
		id = 71134,
		desc = "当前赋能结果不为空，无法锁定",
		define = "EQUIP_SKILL_LOCK_ENCHANT_EMPTY",
		audio = "ban"
	},
	[71135] = {
		id = 71135,
		desc = "当前显晰重构角色为<color=#FF9500>%s</color>\n显晰重构后，刻印将无法再进行重构，是否继续？",
		define = "EQUIP_HERO_REBUILD_WARNING",
		audio = "ban"
	},
	[71136] = {
		id = 71136,
		desc = "是否确认卸载全部刻印？",
		define = "EQUIP_ONE_CLICK_UNINSTALL_WARNING",
		audio = "ban"
	},
	[71137] = {
		id = 71137,
		desc = "(下一级：%s)",
		define = "EQUIP_HERO_SKILL_NEXT_LEVEL",
		audio = "ban"
	},
	[71139] = {
		id = 71139,
		desc = "需要先激活该刻印的显晰重构效果",
		define = "EQUIP_BREAK_LIMITED",
		audio = "ban"
	},
	[71140] = {
		id = 71140,
		desc = "请先解除锁定状态",
		define = "EQUIP_INHERIT_LOCK",
		audio = "ban"
	},
	[71141] = {
		id = 71141,
		desc = "该刻印正在被%s使用，转生完成后该刻印将从原始人物身上卸下，是否确认继续？",
		define = "EQUIP_INHERIT_HERO",
		audio = "ban"
	},
	[71142] = {
		id = 71142,
		desc = "该刻印当前保存在刻印方案中，转生完成后该刻印方案将被删除，是否确认继续？",
		define = "EQUIP_INHERIT_PROPOSAL",
		audio = "ban"
	},
	[71143] = {
		id = 71143,
		desc = "可以选择任意想要融铸成的刻印，融铸完成后当前刻印将变成选择的刻印，但仍然保留自己的星级、位置、等级、赋能得到的刻印技能、显晰重构的专属效果。选择的刻印不同，融铸消耗可能不同。",
		define = "EQUIP_INHERIT_DESC",
		audio = "ban"
	},
	[71148] = {
		id = 71148,
		desc = "融铸成功",
		define = "EQUIP_INHERIT_SUCCESS",
		audio = "success"
	},
	[71149] = {
		id = 71149,
		desc = "请先选择想要融铸成的刻印",
		define = "EQUIP_INHERIT_SELECT",
		audio = "ban"
	},
	[71150] = {
		id = 71150,
		desc = "重构成功，刻印已上锁",
		define = "EQUIP_HERO_SUCCESS",
		audio = "ban"
	},
	[71160] = {
		id = 71160,
		desc = "已上锁",
		define = "ERROR_EQUIP_LOCKED_SUCCESS",
		audio = "ban"
	},
	[71161] = {
		id = 71161,
		desc = "已解锁",
		define = "ERROR_EQUIP_UNLOCKED_SUCCESS",
		audio = "ban"
	},
	[71162] = {
		id = 71162,
		desc = "保存",
		define = "EQUIP_SAVE",
		audio = "ban"
	},
	[71163] = {
		id = 71163,
		desc = "装备",
		define = "EQUIP_ON",
		audio = "ban"
	},
	[71164] = {
		id = 71164,
		desc = [[
刻印：
1.修正者穿戴刻印后可以增加属性和战力
2.每个刻印拥有两条随等级提升的主属性、若干条固定的技能词缀和若干个可以获取赋能技能的赋能位置
3.不同刻印提供的属性不同，星级越高的刻印属性越高
4.根据修正者穿戴合适的刻印，才能使其发挥最大的实力

刻印位置：
1.刻印与刻印位置一一对应，刻印必须装备在对应的刻印装备位

刻印套装：
1.装备同一套刻印达到3件时，可以触发刻印套装效果，提供额外的属性或者效果]],
		define = "EQUIP_EQUIP",
		audio = "ban"
	},
	[71165] = {
		id = 71165,
		desc = [[
强化/突破：
1.强化可以提升刻印等级
2.等级越高，刻印提供的主属性越高
3.刻印等级升至10级、20级、30级、40级、50级时分别需要消耗突破材料突破刻印等级上限
4.刻印等级升至50级、60级时，可解锁角色专属技能栏位

重构：
1.消耗重构秘仪可以对刻印进行重构，提供对应神系额外的属性加成效果
2.对于已经完成神系重构的刻印，可以对刻印进行显析重构，对相应角色提供更多的额外属性加成效果

赋能：
1.刻印达到30级、40级时会分别解锁一个最多能够容纳两个赋能技能的赋能位置
2.消耗赋能材料和艾因索菲币能够对刻印进行赋能，赋能技能将提供额外的属性

跃迁：
1.五星刻印激活角色专属重构后能够最高突破至60级，同时达到50级、60级时会分别解锁一个可装备的角色专属技能槽
2.消耗相应材料后能够解锁技能槽中的技能，由玩家选择装备

融铸：
可以选择任意想要融铸成的刻印，融铸完成后当前刻印将变成选择的刻印，但仍然保留自己的星级、位置、等级、赋能得到的刻印技能、显析重构的专属效果、跃迁技能。选择的刻印不同，融铸消耗可能不同。]],
		define = "EQUIP_CULTIVATE",
		audio = "ban"
	},
	[71166] = {
		id = 71166,
		desc = "确定解锁该跃迁效果吗",
		define = "EQUIP_SKILL_UNLOCK",
		audio = "ban"
	},
	[71167] = {
		id = 71167,
		desc = "属性",
		define = "EQUIP_TYPE_1",
		audio = "ban"
	},
	[71168] = {
		id = 71168,
		desc = "机制",
		define = "EQUIP_TYPE_2",
		audio = "ban"
	},
	[71169] = {
		id = 71169,
		desc = "装备的刻印%s等级达到%d级后生效",
		define = "EQUIP_SKILL_LOCK",
		audio = "ban"
	},
	[71172] = {
		id = 71172,
		desc = "暂无激活的跃迁核心",
		define = "NO_EXCLUSIVE_CORE",
		audio = "ban"
	},
	[71173] = {
		id = 71173,
		desc = "该跃迁核心可装备的跃迁技能数量已达到上限",
		define = "EXCLUSIVE_SKILL_MAX",
		audio = "ban"
	},
	[71174] = {
		id = 71174,
		desc = "跃迁因子数量不足",
		define = "EXCLUSIVE_SKILL_POINT_NOT_ENOUGH",
		audio = "ban"
	},
	[71175] = {
		id = 71175,
		desc = "跃迁技能等级提升！",
		define = "EXCLUSIVE_SKILL_LEVEL_UP",
		audio = "success"
	},
	[71176] = {
		id = 71176,
		desc = "跃迁技能装备成功",
		define = "EXCLUSIVE_SKILL_LOAD",
		audio = "success"
	},
	[71177] = {
		id = 71177,
		desc = "跃迁技能解除成功",
		define = "EXCLUSIVE_SKILL_UNLOAD",
		audio = "success"
	},
	[71178] = {
		id = 71178,
		desc = "跃迁因子数量提升",
		define = "EXCLUSIVE_SKILL_POINT_UP",
		audio = "success"
	},
	[71179] = {
		id = 71179,
		desc = "是否确认提升跃迁因子数量？",
		define = "EXCLUSIVE_SKILL_POINT_UP_CONFIRMATION",
		audio = "ban"
	},
	[71180] = {
		id = 71180,
		desc = "跃迁核心·%s",
		define = "EXCLUSIVE_CORE",
		audio = "ban"
	},
	[71181] = {
		id = 71181,
		desc = [[
1.跃迁系统由6个跃迁核心构成，分别对应刻印的6个位置，当对应位置装备有等级达到40级的刻印时，跃迁核心将被激活。
2.每个跃迁核心会提供若干跃迁技能，但同时只能装备2个跃迁技能。
3.装备/升级跃迁技能均需要消耗当前跃迁核心的跃迁因子数量。
4.消耗「次级权能因子」、「高级权能因子」或「聚合权能晶体」可以提升跃迁核心持有的跃迁因子数量。
5.管理员可以随时重置当前跃迁核心装备的跃迁技能，重置后将返还消耗的跃迁因子。]],
		define = "EXCLUSIVE_DESCRIPE",
		audio = "ban"
	},
	[71151] = {
		id = 71151,
		desc = "管理员，因你本日的在线时长已达上限，弥弥尔系统自动进入了防沉迷保护中，建议你暂时退出游戏，好好休息。",
		define = "ANTIADDICTION_ONLINE_TIME_LIMIT",
		audio = "ban"
	},
	[71201] = {
		id = 71201,
		desc = "暂无可兑换的情报",
		define = "NO_EXCHANGE_HERO_PIECE",
		audio = "ban"
	},
	[71202] = {
		id = 71202,
		desc = "限购",
		define = "PURCHASE_LIMIT",
		audio = "ban"
	},
	[71203] = {
		id = 71203,
		desc = "商品售罄",
		define = "SOLD_OUT",
		audio = "ban"
	},
	[71204] = {
		id = 71204,
		desc = "已购",
		define = "TPURCHASED",
		audio = "ban"
	},
	[71205] = {
		id = 71205,
		desc = "商品已下架",
		define = "GOODS_HAS_BEEN_REMOVED",
		audio = "ban"
	},
	[71206] = {
		id = 71206,
		desc = "商店已过期",
		define = "SHOP_EXPIRED",
		audio = "ban"
	},
	[71207] = {
		id = 71207,
		desc = "是否确认消耗<color=#FF9500>「%s」×%s</color>\n购买<color=#FF9500>「%s」×%s</color>？",
		define = "SHOP_SECONDARY_CONFIRMATION",
		audio = "ban"
	},
	[71208] = {
		id = 71208,
		desc = "是否确认消耗<color=#FF9500>「移转之辉」×%s</color>\n兑换<color=#FF9500>「%s」×%s</color>？",
		define = "PAY_FOR_POWER",
		audio = "ban"
	},
	[71209] = {
		id = 71209,
		desc = "已拥有足够的情报将该角色超越至Ω，是否继续购买？",
		define = "SHOP_OMEGA_CONFIRMATION",
		audio = "ban"
	},
	[71251] = {
		id = 71251,
		desc = "喜欢的礼物",
		define = "HERO_RECORD_GIFT_LIKE",
		audio = "ban"
	},
	[71252] = {
		id = 71252,
		desc = "讨厌的礼物",
		define = "HERO_RECORD_GIFT_HATE",
		audio = "ban"
	},
	[71253] = {
		id = 71253,
		desc = "心链档案%d",
		define = "HERO_RECORD_HEART_CHAIN",
		audio = "ban"
	},
	[71254] = {
		id = 71254,
		desc = "完成「%s」",
		define = "HERO_RECORD_PLOT_UNLOCK_CONDITION",
		audio = "ban"
	},
	[71257] = {
		id = 71257,
		desc = "当前修正者好感度已达上限，本次赠送将无法继续提升好感度。是否继续赠送？",
		define = "HERO_LOVE_LEVEL_MAX_NOTE",
		audio = "ban"
	},
	[71258] = {
		id = 71258,
		desc = "好感度已达上限",
		define = "HERO_LOVE_LEVEL_MAX",
		audio = "success"
	},
	[71259] = {
		id = 71259,
		desc = "好感度增加",
		define = "HERO_LOVE_EXP_UP",
		audio = "success"
	},
	[71271] = {
		id = 71271,
		desc = "亲爱的管理员，由于你的账号存在「%s」行为，现已被弥弥尔系统封停至「%s」，请规范游戏行为。",
		define = "ACCOUNT_VIOLATION",
		audio = "ban"
	},
	[71272] = {
		id = 71272,
		desc = "离开服还有<color=#FF9500>%d</color>天<color=#FF9500>%d</color>小时<color=#FF9500>%d</color>分钟",
		define = "SERVER_OPEN_COUNTDOWN_1",
		audio = "ban"
	},
	[71273] = {
		id = 71273,
		desc = "离开服还有<color=#FF9500>%d</color>小时<color=#FF9500>%d</color>分钟",
		define = "SERVER_OPEN_COUNTDOWN_2",
		audio = "ban"
	},
	[71274] = {
		id = 71274,
		desc = "离开服还有<color=#FF9500>%d</color>分钟",
		define = "SERVER_OPEN_COUNTDOWN_3",
		audio = "ban"
	},
	[71275] = {
		id = 71275,
		desc = "离开服还有<<color=#FF9500>10</color>分钟",
		define = "SERVER_OPEN_COUNTDOWN_4",
		audio = "ban"
	},
	[71301] = {
		id = 71301,
		desc = "今日探测次数达到上限",
		define = "DRAW_NUM_MAX",
		audio = "ban"
	},
	[71302] = {
		id = 71302,
		desc = "凭证购买",
		define = "TREASURE_TICKET_TO_BUY",
		audio = "ban"
	},
	[71303] = {
		id = 71303,
		desc = "是否消耗",
		define = "WHETHER_TO_CONSUME",
		audio = "ban"
	},
	[71304] = {
		id = 71304,
		desc = "进行%d回探测",
		define = "DRAW_TIMES",
		audio = "ban"
	},
	[71305] = {
		id = 71305,
		desc = "出率<color=#FF9300>%s</color>",
		define = "DRAW_PROBABILITY",
		audio = "ban"
	},
	[71306] = {
		id = 71306,
		desc = "（含保底出率<color=#FF9300>%s</color>）",
		define = "DRAW_PROBABILITY_GUARANTEE",
		audio = "ban"
	},
	[71307] = {
		id = 71307,
		desc = "任选一位钥从  <color=#FDE330>%s</color>",
		define = "CHOOSE_SERVANT_COMBINATION",
		audio = "ban"
	},
	[71308] = {
		id = 71308,
		desc = "剩余更换次数:%s",
		define = "DRAW_REMAIN_UP_TIMES",
		audio = "ban"
	},
	[71309] = {
		id = 71309,
		desc = "没有剩余更换次数",
		define = "DRAW_LACK_UP_TIMES",
		audio = "ban"
	},
	[71310] = {
		id = 71310,
		desc = "确定更换概率提升的修正者吗？",
		define = "DRAW_SWITCH_LIMIT_CONFIRM_TIP",
		audio = "ban"
	},
	[71401] = {
		id = 71401,
		desc = "当前正在探索{0}，开启新的探索需要放弃{1}的进度，是否继续？",
		define = "OPEN_NEW_WARCHESS",
		audio = "ban"
	},
	[71402] = {
		id = 71402,
		desc = "暂时不可到达",
		define = "CANNOT_GO",
		audio = "ban"
	},
	[71403] = {
		id = 71403,
		desc = "跳过战斗",
		define = "SKIP_BATTLE_1",
		audio = "ban"
	},
	[71404] = {
		id = 71404,
		desc = "重置前已破解此乱流之隙，可跳过战斗直接获得奖励，是否跳过？<color=#919392><size=30>（跳过的战斗不计入任务和成就奖励）</size></color>",
		define = "SKIP_BATTLE_2",
		audio = "ban"
	},
	[71405] = {
		id = 71405,
		desc = "（再次战斗）",
		define = "SKIP_BATTLE_3",
		audio = "ban"
	},
	[71406] = {
		id = 71406,
		desc = "宝箱已领取",
		define = "ERROR_CHESS_REWARD_HAS_RECEIVED",
		audio = "ban"
	},
	[71407] = {
		id = 71407,
		desc = "只能在船尾回收水下探测器",
		define = "ACTIVITY_WARCHESS_RECOVER",
		audio = "ban"
	},
	[71408] = {
		id = 71408,
		desc = "只能在船尾释放水下探测器",
		define = "ACTIVITY_WARCHESS_RELIEVE",
		audio = "ban"
	},
	[71409] = {
		id = 71409,
		desc = "每个队伍需要至少配置一名队员",
		define = "ERROR_MULTIPLE_BATTLES_REQUIREMENT",
		audio = "ban"
	},
	[71410] = {
		id = 71410,
		desc = "是否确定结束此次探索？",
		define = "CONFIRM_TO_QUIT_CHESS",
		audio = "ban"
	},
	[71411] = {
		id = 71411,
		desc = "所选角色已被队伍%s使用，是否确认将该角色加入当前队伍？",
		define = "CURHERO_USED",
		audio = "ban"
	},
	[71451] = {
		id = 71451,
		desc = "%d次内必得五星刻印。",
		define = "EQUIP_STAGE_INSURE",
		audio = "ban"
	},
	[71452] = {
		id = 71452,
		desc = "当前已存在高价值任务，是否确认刷新？",
		define = "EQUIP_STAGE_REFRESH",
		audio = "ban"
	},
	[71453] = {
		id = 71453,
		desc = "「%s」最终关卡通过后下次刷新时解锁",
		define = "EQUIP_BREAK_THROUGH_MODE_UNLOCK",
		audio = "ban"
	},
	[71454] = {
		id = 71454,
		desc = [[
1.每周一和周五会刷新关卡地图与奖励，以及词缀效果。
2.初始关卡完成后将会锁定阵容，探索期间无法更改阵容。
3.每次战斗胜利后全队会获得随机属性加成，并且当前队伍的生命值会按百分比保留至下次关卡挑战中，生命值为0的角色将无法出战。
4.通过抉择不同的路线可以挑战不同的关卡，或者选择获得生命值恢复或随机增益加成。
5.关卡挑战成功会获得探索度，积累探索度可以领取奖励。
6.重置地图可以重复挑战并保留积累的探索度。
7.完成最终关卡后，如果有可解锁的难度，则会在下次玩法刷新时解锁新的难度。
8.在未领取奖励之前，可以任意切换难度，但切换不同难度后，会重置地图与探索度。]],
		define = "EQUIP_BREAK_THROUGH_INFO",
		audio = "ban"
	},
	[71455] = {
		id = 71455,
		desc = "将会重置关卡进度并保留探索度，是否继续？",
		define = "EQUIP_BREAK_THROUGH_RESET_MAP",
		audio = "ban"
	},
	[71456] = {
		id = 71456,
		desc = "重新选择难度将会重置关卡进度和探索度，是否继续？",
		define = "EQUIP_BREAK_THROUGH_RESET_DIFFICULTY",
		audio = "ban"
	},
	[71457] = {
		id = 71457,
		desc = "领取奖励后将无法切换难度，是否继续？",
		define = "EQUIP_BREAK_THROUGH_REWARD_TIPS",
		audio = "ban"
	},
	[71458] = {
		id = 71458,
		desc = "歧路数据已经刷新，请返回重新选择",
		define = "EQUIP_BREAK_THROUGH_REFRESH_DATA",
		audio = "ban"
	},
	[71459] = {
		id = 71459,
		desc = "放弃会使全队生命恢复%s%%",
		define = "EQUIP_BREAK_THROUGH_BUFF_HEAL",
		audio = "ban"
	},
	[71460] = {
		id = 71460,
		desc = "全队生命恢复%s%%",
		define = "EQUIP_BREAK_THROUGH_TEAM_HEAL",
		audio = "ban"
	},
	[71500] = {
		id = 71500,
		desc = "总览",
		define = "COLLECT_WORD_TYPE_0",
		audio = "ban"
	},
	[71501] = {
		id = 71501,
		desc = "世界观",
		define = "COLLECT_WORD_TYPE_1",
		audio = "ban"
	},
	[71502] = {
		id = 71502,
		desc = "地点",
		define = "COLLECT_WORD_TYPE_2",
		audio = "ban"
	},
	[71503] = {
		id = 71503,
		desc = "势力",
		define = "COLLECT_WORD_TYPE_3",
		audio = "ban"
	},
	[71504] = {
		id = 71504,
		desc = "人物",
		define = "COLLECT_WORD_TYPE_4",
		audio = "ban"
	},
	[71505] = {
		id = 71505,
		desc = "事件",
		define = "COLLECT_WORD_TYPE_5",
		audio = "ban"
	},
	[71506] = {
		id = 71506,
		desc = "概念",
		define = "COLLECT_WORD_TYPE_6",
		audio = "ban"
	},
	[71520] = {
		id = 71520,
		desc = "信息不足，无法获取作战目标情报",
		define = "COLLECT_MANSTER_INFO_UNLOCK_FAILED",
		audio = "ban"
	},
	[71521] = {
		id = 71521,
		desc = "作战目标情报0",
		define = "MONSTER_INFORMATION",
		audio = "ban"
	},
	[71522] = {
		id = 71522,
		desc = "人形",
		define = "RACE_TYPE_6",
		audio = "ban"
	},
	[71523] = {
		id = 71523,
		desc = "视骸",
		define = "RACE_TYPE_7",
		audio = "ban"
	},
	[71524] = {
		id = 71524,
		desc = "智械",
		define = "RACE_TYPE_8",
		audio = "ban"
	},
	[71525] = {
		id = 71525,
		desc = "其他",
		define = "RACE_TYPE_9",
		audio = "ban"
	},
	[71601] = {
		id = 71601,
		desc = "今日任务",
		define = "MISSION_DAILY",
		audio = "ban"
	},
	[71602] = {
		id = 71602,
		desc = "本周任务",
		define = "MISSION_WEEKLY",
		audio = "ban"
	},
	[71603] = {
		id = 71603,
		desc = "挑战任务",
		define = "MISSION_CHALLENGE",
		audio = "ban"
	},
	[71604] = {
		id = 71604,
		desc = "本期剩余：%s",
		define = "BATTLEPASS_REFRESH_TIME",
		audio = "ban"
	},
	[71605] = {
		id = 71605,
		desc = "共%d周",
		define = "WEEKS_IN_TOTAL",
		audio = "ban"
	},
	[71606] = {
		id = 71606,
		desc = "%d级将获得奖励",
		define = "BATTLEPASS_LEVEL_UNLOCK_REWARD",
		audio = "ban"
	},
	[71607] = {
		id = 71607,
		desc = "时间不足20分钟，无法购买",
		define = "NOT_ENOUGH_TIME_TO_BUY",
		audio = "ban"
	},
	[71608] = {
		id = 71608,
		desc = "你已经拥有，无需重复购买",
		define = "BATTLEPASS_BOUGHT",
		audio = "ban"
	},
	[71609] = {
		id = 71609,
		desc = "协定合约已过期",
		define = "BATTLEPASS_EXPIRED",
		audio = "ban"
	},
	[71610] = {
		id = 71610,
		desc = "当前没有开放的协定合约",
		define = "NO_ACTIVE_BATTLEPASS",
		audio = "ban"
	},
	[71611] = {
		id = 71611,
		desc = "剩余:%s",
		define = "PASSPORT_TASK_LAST_TIME",
		audio = "ban"
	},
	[71612] = {
		id = 71612,
		desc = "本周经验已达上限，本次领取中包含的每日和每周任务的奖励将无法增加协定合约的经验值",
		define = "PASSPORT_WEEKLY_EXP_LIMIT_TIP",
		audio = "ban"
	},
	[71701] = {
		id = 71701,
		desc = "签到",
		define = "SIGN",
		audio = "ban"
	},
	[71702] = {
		id = 71702,
		desc = "1月",
		define = "JANUARY",
		audio = "ban"
	},
	[71703] = {
		id = 71703,
		desc = "2月",
		define = "FEBRUARY",
		audio = "ban"
	},
	[71704] = {
		id = 71704,
		desc = "3月",
		define = "MARCH",
		audio = "ban"
	},
	[71705] = {
		id = 71705,
		desc = "4月",
		define = "APRIL",
		audio = "ban"
	},
	[71706] = {
		id = 71706,
		desc = "5月",
		define = "MAY",
		audio = "ban"
	},
	[71707] = {
		id = 71707,
		desc = "6月",
		define = "JUNE",
		audio = "ban"
	},
	[71708] = {
		id = 71708,
		desc = "7月",
		define = "JULY",
		audio = "ban"
	},
	[71709] = {
		id = 71709,
		desc = "8月",
		define = "AUGUST",
		audio = "ban"
	},
	[71710] = {
		id = 71710,
		desc = "9月",
		define = "SEPTEMBER",
		audio = "ban"
	},
	[71711] = {
		id = 71711,
		desc = "10月",
		define = "OCTOBER",
		audio = "ban"
	},
	[71712] = {
		id = 71712,
		desc = "11月",
		define = "NOVEMBER",
		audio = "ban"
	},
	[71713] = {
		id = 71713,
		desc = "12月",
		define = "DESEMBER",
		audio = "ban"
	},
	[71714] = {
		id = 71714,
		desc = "每日签到",
		define = "SIGN_TITLE_DAILY",
		audio = "ban"
	},
	[71715] = {
		id = 71715,
		desc = "恒定观测",
		define = "SIGN_TITLE_MONTHCARD",
		audio = "ban"
	},
	[71716] = {
		id = 71716,
		desc = "开服签到",
		define = "SIGN_TITLE_SEGENDAY",
		audio = "ban"
	},
	[71801] = {
		id = 71801,
		desc = "签名设置完成",
		define = "SUCCESS_CHANGE_SIGNATURE",
		audio = "success"
	},
	[71802] = {
		id = 71802,
		desc = "更换完成",
		define = "SUCCESS_CHANGE",
		audio = "success"
	},
	[71803] = {
		id = 71803,
		desc = "不能与当前管理员昵称相同",
		define = "NAME_CANNOT_SAME_CURRENT",
		audio = "ban"
	},
	[71804] = {
		id = 71804,
		desc = "个性签名最多可显示30个字符",
		define = "PERSONAL_SIGNATURE_MAX",
		audio = "ban"
	},
	[71805] = {
		id = 71805,
		desc = "未知",
		define = "IP_UNKNOWN",
		audio = "ban"
	},
	[71806] = {
		id = 71806,
		desc = "TIP: 本次免费",
		define = "TIPS_REVISENAME_FREE",
		audio = "ban"
	},
	[71807] = {
		id = 71807,
		desc = "TIP: 管理员仅拥有一次修改昵称的权限",
		define = "TIPS_REVISENAME_ONE",
		audio = "ban"
	},
	[71808] = {
		id = 71808,
		desc = "管理员确定要将生日设置为<color=#FE9D42>%s</color>月<color=#FE9D42>%s</color>日吗？\n生日日期设置完成后不可再更改",
		define = "TIPS_SET_BIRTHDAY",
		audio = "ban"
	},
	[71809] = {
		id = 71809,
		desc = "也许某天会有好事发生",
		define = "TIPS_SET_BIRTHDAY_SURE",
		audio = "ban"
	},
	[71810] = {
		id = 71810,
		desc = "%s月%s日",
		define = "OTHER_BIRTHDAY",
		audio = "ban"
	},
	[71811] = {
		id = 71811,
		desc = "尚未设置",
		define = "UNSET_BIRTHDAY",
		audio = "ban"
	},
	[80001] = {
		id = 80001,
		desc = "「移转之花」数量不足\n是否前往充值？",
		define = "ERROR_RECHARGE_DIAMOND_NOT_ENOUGH",
		audio = "ban"
	},
	[80002] = {
		id = 80002,
		desc = "当前还未拥有「%s」，是否确定购买该换装？",
		define = "NOT_HAVE_HERO_SKIN_CONFIRM",
		audio = "ban"
	},
	[80003] = {
		id = 80003,
		desc = "管理员等级Lv.%d解锁",
		define = "PLAYER_LEVEL_UNLOCK_SHOP_GOODS",
		audio = "ban"
	},
	[80004] = {
		id = 80004,
		desc = "累计充值点数 <color=#FFA914>%d</color>",
		define = "PAYMENT_TOTAL_POINT",
		audio = "ban"
	},
	[80005] = {
		id = 80005,
		desc = "换装已下架",
		define = "SKIN_SALE_FINISH",
		audio = "ban"
	},
	[80006] = {
		id = 80006,
		desc = "特别推荐",
		define = "MONTHLYCARD",
		audio = "ban"
	},
	[80007] = {
		id = 80007,
		desc = "组合补给",
		define = "GIFTBOX",
		audio = "ban"
	},
	[80008] = {
		id = 80008,
		desc = "角色换装",
		define = "SKIN",
		audio = "ban"
	},
	[80009] = {
		id = 80009,
		desc = "凭证兑换",
		define = "DRAW_CARD",
		audio = "ban"
	},
	[80010] = {
		id = 80010,
		desc = "移转观测",
		define = "RECHARG",
		audio = "ban"
	},
	[80011] = {
		id = 80011,
		desc = "活动补给",
		define = "ACTIVITY_GIFTBOX",
		audio = "ban"
	},
	[80012] = {
		id = 80012,
		desc = "日常补给",
		define = "NORMAL_GIFTBOX",
		audio = "ban"
	},
	[80013] = {
		id = 80013,
		desc = "「%s」支付成功！",
		define = "PAY_SUCCESS",
		audio = "ban"
	},
	[80014] = {
		id = 80014,
		desc = "充值失败，请重试",
		define = "PAY_FAIL",
		audio = "ban"
	},
	[80015] = {
		id = 80015,
		desc = "购买后将获得「%s」，",
		define = "BUY_SKIN_CHANGE",
		audio = "ban"
	},
	[80016] = {
		id = 80016,
		desc = "是否立即使用「%s」？",
		define = "USE_SKIN_CHANGE",
		audio = "ban"
	},
	[80017] = {
		id = 80017,
		desc = "连续%s天",
		define = "CONSECUTIVE_DAYS",
		audio = "ban"
	},
	[80018] = {
		id = 80018,
		desc = "「移转之花」数量不足",
		define = "ERROR_RECHARGE_DIAMOND_NOT_ENOUGH_NO_BUY",
		audio = "ban"
	},
	[80019] = {
		id = 80019,
		desc = "新手补给",
		define = "NEWBIE_GIFTBOX",
		audio = "ban"
	},
	[80020] = {
		id = 80020,
		desc = "周期补给",
		define = "CYCLE_GIFTBOX",
		audio = "ban"
	},
	[80021] = {
		id = 80021,
		desc = "限时补给",
		define = "LIMIT_TIME_GIFTBOX",
		audio = "ban"
	},
	[80022] = {
		id = 80022,
		desc = "常规补给",
		define = "NORMAL_GIFTBOX",
		audio = "ban"
	},
	[80023] = {
		id = 80023,
		desc = "折",
		define = "LABEL_DISCOUNT",
		audio = "ban"
	},
	[80024] = {
		id = 80024,
		desc = "首充福利",
		define = "RECHARGE_WELFARE",
		audio = "ban"
	},
	[80025] = {
		id = 80025,
		desc = "新增",
		define = "NEW_ADD",
		audio = "ban"
	},
	[80026] = {
		id = 80026,
		desc = "可通过限时补给购买「一周年庆典珍藏」获取「忘川灯影」，是否前往查看",
		define = "BUY_TREASURE_SKIN_TIP",
		audio = "ban"
	},
	[80027] = {
		id = 80027,
		desc = "继续购买",
		define = "CONTINUE_BUY",
		audio = "ban"
	},
	[80101] = {
		id = 80101,
		desc = "1小时内",
		define = "FRIEND_ONLINE_TIME_WITHIN_AN_HOUR",
		audio = "ban"
	},
	[80102] = {
		id = 80102,
		desc = "1天内",
		define = "FRIEND_ONLINE_TIME_IN_ONE_DAY",
		audio = "ban"
	},
	[80103] = {
		id = 80103,
		desc = "%d天前",
		define = "FRIEND_ONLINE_TIME_ONE_DAY_AGO",
		audio = "ban"
	},
	[80104] = {
		id = 80104,
		desc = "该玩家已拉黑，移除黑名单即可查看该玩家信息",
		define = "BLACKLIST_TIP",
		audio = "ban"
	},
	[80201] = {
		id = 80201,
		desc = "兑换礼包已发送至邮箱，请查收。（每种礼包只可被领取一次）",
		define = "EXCHANGE_CODE_ALERT1",
		audio = "ban"
	},
	[80202] = {
		id = 80202,
		desc = "兑换礼包已发送至邮箱，请查收。",
		define = "EXCHANGE_CODE_ALERT2",
		audio = "ban"
	},
	[80301] = {
		id = 80301,
		desc = "%s<color=#2380BF>「%s」</color>的倍率从<color=#ED6117>%s</color>提升至<color=#ED6117>%s</color>",
		define = "WEAPON_MODULE_SKILL_TIP_TEMPLATE_2",
		audio = "ban"
	},
	[80302] = {
		id = 80302,
		desc = "<color=#9eaab5>神格</color><color=#2380BF>「%s·%s」</color><color=#9eaab5>的效果变更为：</color>\n%s",
		define = "WEAPON_MODULE_SKILL_TIP_TEMPLATE_3",
		audio = "ban"
	},
	[80303] = {
		id = 80303,
		desc = "<color=#9eaab5>装备钥从</color><color=#2380BF>「%s」</color><color=#9eaab5>时，钥从权能的效果变更为：</color>\n%s",
		define = "WEAPON_MODULE_SKILL_TIP_TEMPLATE_4",
		audio = "ban"
	},
	[80304] = {
		id = 80304,
		desc = "%s<color=#2380BF>「%s」</color>的倍率从<color=#ED6117>%s</color>提升至<color=#ED6117>%s</color>",
		define = "WEAPON_MODULE_SKILL_TIP_TEMPLATE_5",
		audio = "ban"
	},
	[80305] = {
		id = 80305,
		desc = "权钥同调解锁任务未完成",
		define = "WEAPON_MODULE_UNLOCK_TASK_NOT_COMPLETED",
		audio = "ban"
	},
	[80306] = {
		id = 80306,
		desc = "权钥同调解锁条件未达成",
		define = "WEAPON_MODULE_UNLOCK_CONDITION_NOT_FINISH",
		audio = "ban"
	},
	[80307] = {
		id = 80307,
		desc = "权钥同调解锁材料数量不足",
		define = "WEAPON_MODULE_UNLOCK_NOT_ENOUGH",
		audio = "ban"
	},
	[80308] = {
		id = 80308,
		desc = "暂无可回销的修正者存档",
		define = "WEAPON_MODULE_MATERIAL_NOT_ENOUGH",
		audio = "ban"
	},
	[80309] = {
		id = 80309,
		desc = "请先选择想要回销的修正者存档",
		define = "WEAPON_MODULE_MATERIAL_SELECT",
		audio = "ban"
	},
	[80310] = {
		id = 80310,
		desc = "1.解锁并提升权钥的同调等级，可以大幅提升修正者的能力。\n2.同调解锁需要完成指定的解锁任务并达成解锁条件。\n3.同调升级可能需要达成一定的解锁条件。",
		define = "WEAPON_MODULE_DESCRIPE",
		audio = "ban"
	},
	[100001] = {
		id = 100001,
		desc = "货币",
		define = "ITEM_TYPE_NOTE_1",
		audio = "ban"
	},
	[100002] = {
		id = 100002,
		desc = "角色",
		define = "ITEM_TYPE_NOTE_2",
		audio = "ban"
	},
	[100003] = {
		id = 100003,
		desc = "情报",
		define = "ITEM_TYPE_NOTE_3",
		audio = "ban"
	},
	[100004] = {
		id = 100004,
		desc = "道具",
		define = "ITEM_TYPE_NOTE_4",
		audio = "ban"
	},
	[100005] = {
		id = 100005,
		desc = "礼包",
		define = "ITEM_TYPE_NOTE_5",
		audio = "ban"
	},
	[100006] = {
		id = 100006,
		desc = "材料",
		define = "ITEM_TYPE_NOTE_6",
		audio = "ban"
	},
	[100007] = {
		id = 100007,
		desc = "刻印",
		define = "ITEM_TYPE_NOTE_7",
		audio = "ban"
	},
	[100008] = {
		id = 100008,
		desc = "时装",
		define = "ITEM_TYPE_NOTE_8",
		audio = "ban"
	},
	[100009] = {
		id = 100009,
		desc = "钥从",
		define = "ITEM_TYPE_NOTE_9",
		audio = "ban"
	},
	[110001] = {
		id = 110001,
		desc = "普通",
		define = "MATRIX_ARTIFACT_RARE1",
		audio = "ban"
	},
	[110002] = {
		id = 110002,
		desc = "稀有",
		define = "MATRIX_ARTIFACT_RARE2",
		audio = "ban"
	},
	[110003] = {
		id = 110003,
		desc = "珍贵",
		define = "MATRIX_ARTIFACT_RARE3",
		audio = "ban"
	},
	[110004] = {
		id = 110004,
		desc = "绝品",
		define = "MATRIX_ARTIFACT_RARE4",
		audio = "ban"
	},
	[120001] = {
		id = 120001,
		desc = "管理喵解锁条件未达成",
		define = "CHIP_MANAGER_UNLOCK_FAILED",
		audio = "ban"
	},
	[120002] = {
		id = 120002,
		desc = "管理喵解锁成功",
		define = "CHIP_MANAGER_UNLOCK_SUCCESS",
		audio = "success"
	},
	[120003] = {
		id = 120003,
		desc = "管理喵装备成功",
		define = "CHIP_MANAGER_USE_SUCCESS",
		audio = "success"
	},
	[120004] = {
		id = 120004,
		desc = "管理喵卸载成功",
		define = "CHIP_MANAGER_UNLOAD_SUCCESS",
		audio = "success"
	},
	[120005] = {
		id = 120005,
		desc = "管理喵芯片解锁条件未达成",
		define = "CHIP_UNLOCK_FAILED",
		audio = "ban"
	},
	[120006] = {
		id = 120006,
		desc = "管理喵芯片解锁成功",
		define = "CHIP_UNLOCK_SUCCESS",
		audio = "success"
	},
	[120007] = {
		id = 120007,
		desc = "管理喵芯片装备成功",
		define = "CHIP_USE_SUCCESS",
		audio = "success"
	},
	[120008] = {
		id = 120008,
		desc = "可装备的管理喵芯片数量已达上限",
		define = "CHIP_CNT_MORE_THEN_MAX",
		audio = "ban"
	},
	[120009] = {
		id = 120009,
		desc = "管理喵芯片卸载成功",
		define = "CHIP_UNLOAD_SUCCESS",
		audio = "success"
	},
	[120010] = {
		id = 120010,
		desc = "芯片冲突",
		define = "CHIP_CONFLICT",
		audio = "ban"
	},
	[120011] = {
		id = 120011,
		desc = "保存芯片方案前需先装备芯片",
		define = "SCHEME_IS_NULL",
		audio = "ban"
	},
	[120012] = {
		id = 120012,
		desc = "芯片方案已达存储上限",
		define = "MORE_THEN_MAX_SCHEME_CNT",
		audio = "ban"
	},
	[120013] = {
		id = 120013,
		desc = "芯片方案保存成功",
		define = "SAVE_SCHEME_SUCCESS",
		audio = "success"
	},
	[120014] = {
		id = 120014,
		desc = "芯片方案装备成功",
		define = "USE_SCHEME_SUCCESS",
		audio = "success"
	},
	[120015] = {
		id = 120015,
		desc = "确定要删除芯片方案吗？\n「%s」",
		define = "DELETE_CHIP_SCHEME",
		audio = "ban"
	},
	[120016] = {
		id = 120016,
		desc = "芯片方案删除成功",
		define = "DELETE_CHIP_SCHEME_SUCCESS",
		audio = "success"
	},
	[120017] = {
		id = 120017,
		desc = "通用芯片",
		define = "NORMAL_CHIP",
		audio = "ban"
	},
	[120018] = {
		id = 120018,
		desc = "专属芯片",
		define = "EXCLUSIVE_CHIP",
		audio = "ban"
	},
	[120019] = {
		id = 120019,
		desc = "与%s无法同时使用",
		define = "CHIP_MUTEX_TEXT",
		audio = "ban"
	},
	[120020] = {
		id = 120020,
		desc = "使用",
		define = "CHIP_USE",
		audio = "ban"
	},
	[120021] = {
		id = 120021,
		desc = "卸下",
		define = "CHIP_UNLOAD",
		audio = "ban"
	},
	[120022] = {
		id = 120022,
		desc = "全部",
		define = "ALL",
		audio = "ban"
	},
	[120023] = {
		id = 120023,
		desc = "通用",
		define = "NORMAL",
		audio = "ban"
	},
	[120024] = {
		id = 120024,
		desc = "当前方案",
		define = "CURRENT_SCHEME",
		audio = "ban"
	},
	[120025] = {
		id = 120025,
		desc = "无法更换",
		define = "CANNOT_CHANGE",
		audio = "ban"
	},
	[120026] = {
		id = 120026,
		desc = "不可更换管理喵",
		define = "CANNOT_CHANGE_CHIP",
		audio = "ban"
	},
	[120027] = {
		id = 120027,
		desc = "芯片解锁条件未达成",
		define = "CHIP_HERO_UNLOCK_FAILED",
		audio = "ban"
	},
	[120028] = {
		id = 120028,
		desc = "芯片解锁成功",
		define = "CHIP_HERO_UNLOCK_SUCCESS",
		audio = "success"
	},
	[120029] = {
		id = 120029,
		desc = "芯片装备成功",
		define = "CHIP_HERO_USE_SUCCESS",
		audio = "success"
	},
	[120030] = {
		id = 120030,
		desc = "芯片卸载成功",
		define = "CHIP_HERO_UNLOAD_SUCCESS",
		audio = "success"
	},
	[130001] = {
		id = 130001,
		desc = "不可更换连携奥义",
		define = "CANNOT_CHANGE_COMBO_SKILL",
		audio = "ban"
	},
	[140001] = {
		id = 140001,
		desc = "力量",
		define = "MATRIX_TYPE_NOTE_1",
		audio = "ban"
	},
	[140002] = {
		id = 140002,
		desc = "正义",
		define = "MATRIX_TYPE_NOTE_2",
		audio = "ban"
	},
	[140003] = {
		id = 140003,
		desc = "战车",
		define = "MATRIX_TYPE_NOTE_3",
		audio = "ban"
	},
	[140004] = {
		id = 140004,
		desc = "审判",
		define = "MATRIX_TYPE_NOTE_4",
		audio = "ban"
	},
	[140005] = {
		id = 140005,
		desc = "星星",
		define = "MATRIX_TYPE_NOTE_5",
		audio = "ban"
	},
	[140006] = {
		id = 140006,
		desc = "月亮",
		define = "MATRIX_TYPE_NOTE_6",
		audio = "ban"
	},
	[140007] = {
		id = 140007,
		desc = "隐者",
		define = "MATRIX_TYPE_NOTE_7",
		audio = "ban"
	},
	[140008] = {
		id = 140008,
		desc = "命运之轮",
		define = "MATRIX_TYPE_NOTE_8",
		audio = "ban"
	},
	[140009] = {
		id = 140009,
		desc = "BOSS情报",
		define = "MATRIX_TYPE_NOTE_9",
		audio = "ban"
	},
	[140010] = {
		id = 140010,
		desc = "恶魔",
		define = "MATRIX_TYPE_NOTE_10",
		audio = "ban"
	},
	[150001] = {
		id = 150001,
		desc = "请输入1-10以内的频道号",
		define = "INPUT_CHANNEL_NUM",
		audio = "ban"
	},
	[150002] = {
		id = 150002,
		desc = "发送消息频率过快",
		define = "SEND_MESSAGE_FREQUENTLY",
		audio = "ban"
	},
	[150003] = {
		id = 150003,
		desc = "发送表情过快",
		define = "SEND_STICKER_FREQUENTLY",
		audio = "ban"
	},
	[150004] = {
		id = 150004,
		desc = "没有其他的聊天",
		define = "NO_OTHER_CHAT",
		audio = "ban"
	},
	[150005] = {
		id = 150005,
		desc = "发送失败",
		define = "SEND_MESSAGE_ERROR",
		audio = "ban"
	},
	[150006] = {
		id = 150006,
		desc = "已加入频道%s",
		define = "ENTER_CHAT_CHANNEL",
		audio = "success"
	},
	[150007] = {
		id = 150007,
		desc = "频道切换过快",
		define = "SWITCH_CHANNEL_FREQUENTLY",
		audio = "ban"
	},
	[150008] = {
		id = 150008,
		desc = "你因不活跃已被暂时移出该频道",
		define = "WORLD_CHANNEL_ERROR",
		audio = "ban"
	},
	[150009] = {
		id = 150009,
		desc = "请先加入矩阵公会",
		define = "NEED_JOIN_CLUB",
		audio = "ban"
	},
	[150010] = {
		id = 150010,
		desc = "可添加表情已达上限",
		define = "CHAT_CUSTOM_STICKER_LIMIT_EXCEEDED",
		audio = "ban"
	},
	[150011] = {
		id = 150011,
		desc = "发生变化，是否保存",
		define = "CHAT_CUSTOM_STICKER_CHANGED",
		audio = "ban"
	},
	[151001] = {
		id = 151001,
		desc = "政治敏感",
		define = "REPORT_REASON_POLITICS",
		audio = "ban"
	},
	[151002] = {
		id = 151002,
		desc = "非法广告",
		define = "REPORT_REASON_AD",
		audio = "ban"
	},
	[151003] = {
		id = 151003,
		desc = "恶意辱骂",
		define = "REPORT_REASON_ABUSE",
		audio = "ban"
	},
	[151004] = {
		id = 151004,
		desc = "低俗色情",
		define = "REPORT_REASON_SEX",
		audio = "ban"
	},
	[151005] = {
		id = 151005,
		desc = "其他行为",
		define = "REPORT_REASON_OTHER",
		audio = "ban"
	},
	[151006] = {
		id = 151006,
		desc = "违规昵称",
		define = "REPORT_REASON_NICK",
		audio = "ban"
	},
	[151007] = {
		id = 151007,
		desc = "违规签名",
		define = "REPORT_REASON_SIGNATURE",
		audio = "ban"
	},
	[151008] = {
		id = 151008,
		desc = "请选择一种举报的原因",
		define = "NEED_REPORT_REASON",
		audio = "ban"
	},
	[151009] = {
		id = 151009,
		desc = "举报成功，感谢管理员的反馈~我们将及时跟进处理！",
		define = "REPORT_SUCCESS",
		audio = "ban"
	},
	[151010] = {
		id = 151010,
		desc = "解封时间：",
		define = "MUTE_TIME_TEXT",
		audio = "ban"
	},
	[151011] = {
		id = 151011,
		desc = "<color=#CD3D37>%Y年%m月%d日 %H:%M:%S</color>",
		define = "MUTE_TIME_FORMAT",
		audio = "ban"
	},
	[160001] = {
		id = 160001,
		desc = "多维信标解锁成功",
		define = "MATRIX_BEACON_UNLOCK_SUCCESS",
		audio = "success"
	},
	[160002] = {
		id = 160002,
		desc = "超过限制时间，重新来过吧",
		define = "MATRIX_TIME_LIMIT_EXCEEDED",
		audio = "ban"
	},
	[160003] = {
		id = 160003,
		desc = "多维终端等级达到%d级后解锁",
		define = "MATRIX_TERMINAL_LEVEL_UNLOCK",
		audio = "ban"
	},
	[160004] = {
		id = 160004,
		desc = "通关一次普通难度后解锁",
		define = "MATRIX_CLEARANCE_DIFFICULTY_UNLOCK",
		audio = "ban"
	},
	[160005] = {
		id = 160005,
		desc = "请选择修正者",
		define = "MATRIX_SELECT_HERO_PLZ",
		audio = "ban"
	},
	[160006] = {
		id = 160006,
		desc = "请选中 <size=42><color=#FFAE35>1</color></size> 名修正者作为队长出战",
		define = "MATRIX_SELECT_TEAM_LEADER",
		audio = "ban"
	},
	[160007] = {
		id = 160007,
		desc = "请选择 <size=42><color=#FFAE35>2</color></size> 名修正者作为队友出战",
		define = "MATRIX_SELECT_TEAM",
		audio = "ban"
	},
	[160008] = {
		id = 160008,
		desc = "该类神格已不能再获取",
		define = "MATRIX_NOT_GET_ASTROLABEL",
		audio = "ban"
	},
	[160009] = {
		id = 160009,
		desc = "是否退出商店？",
		define = "MATRIX_SURE_GET_OUT_SHOP",
		audio = "ban"
	},
	[160010] = {
		id = 160010,
		desc = "激活任意相邻天赋后解锁",
		define = "MATRIX_TEAMINL_GIFT_UNLCOK",
		audio = "ban"
	},
	[160011] = {
		id = 160011,
		desc = "积分获取效率提升 <color=#FE972E>%s</color>",
		define = "MATRIX_AFFIX_RATE",
		audio = "ban"
	},
	[160012] = {
		id = 160012,
		desc = "天赋点数不足",
		define = "MATRIX_TERMINAL_GIFT_LACK",
		audio = "ban"
	},
	[160013] = {
		id = 160013,
		desc = "天赋解锁成功",
		define = "MATRIX_TERMINAL_GIFT_UNLOCK_SUCCESS",
		audio = "success"
	},
	[160014] = {
		id = 160014,
		desc = "天赋升级成功",
		define = "MATRIX_TERMINAL_GIFT_UPGRADE_SUCCESS",
		audio = "success"
	},
	[160015] = {
		id = 160015,
		desc = "请先装备多维信标",
		define = "MATRIX_SELECT_BEACON",
		audio = "ban"
	},
	[160016] = {
		id = 160016,
		desc = "多维信标选中已经到达上限",
		define = "MATRIX_SELECT_BEACON_MAX",
		audio = "ban"
	},
	[160017] = {
		id = 160017,
		desc = "确认后将重置所有天赋并返还全部天赋点数，是否继续？",
		define = "MATRIX_RESET_TERMINAL_GIFT",
		audio = "ban"
	},
	[160018] = {
		id = 160018,
		desc = "暂无记录",
		define = "MATRIX_RANK_NO_INFO",
		audio = "ban"
	},
	[160019] = {
		id = 160019,
		desc = "未上榜",
		define = "MATRIX_RANK_NO_RANK",
		audio = "ban"
	},
	[160020] = {
		id = 160020,
		desc = "<color=#363A42>同时上阵两名相同神系的修正者时，可以在战斗过程中获得额外加成效果</color>",
		define = "MATRIX_NO_BATTLE_BUFF",
		audio = "ban"
	},
	[160021] = {
		id = 160021,
		desc = "确定放弃当前进度吗？",
		define = "GIVE_UP_MATRIX",
		audio = "ban"
	},
	[160022] = {
		id = 160022,
		desc = "是否确认购买",
		define = "MATRIX_SHOP_BUY_CONFIRM",
		audio = "ban"
	},
	[160023] = {
		id = 160023,
		desc = "刷新商店",
		define = "MATRIX_SHOP_REFRESH",
		audio = "ban"
	},
	[160024] = {
		id = 160024,
		desc = "多维终端天赋可以被提升，是否前往调整",
		define = "MATRIX_PREPARE_ADJUST_TERMINAL",
		audio = "ban"
	},
	[160025] = {
		id = 160025,
		desc = "开始挑战",
		define = "MATRIX_PREPARE_START_CHALLENGE",
		audio = "ban"
	},
	[160026] = {
		id = 160026,
		desc = "前往调整",
		define = "MATRIX_PREPARE_GO_ADJUST",
		audio = "ban"
	},
	[160027] = {
		id = 160027,
		desc = "获得%d%s",
		define = "MATRIX_GET",
		audio = "ban"
	},
	[160028] = {
		id = 160028,
		desc = "管理员等级达到80级且通关一次困难难度后解锁",
		define = "MATRIX_CLEARANCE_SPECIAL_DIFFICULTY_UNLOCK",
		audio = "ban"
	},
	[160029] = {
		id = 160029,
		desc = "未获得该修正者，无法选择",
		define = "MATRIX_SINGULARITY_HERO_UNLOCK",
		audio = "ban"
	},
	[160030] = {
		id = 160030,
		desc = "修正者等级不足%s级，无法选择",
		define = "MATRIX_SINGULARITY_HERO_LEVEL_UNLOCK",
		audio = "ban"
	},
	[160031] = {
		id = 160031,
		desc = "%s后 任务新增%d条",
		define = "ERROR_MATRIX_SEASON_MISSIONS_TIME",
		audio = "ban"
	},
	[160032] = {
		id = 160032,
		desc = "本周重置次数已消耗，无法重置",
		define = "MATRIX_TERMINAL_NO_REFRESH_TIMES",
		audio = "ban"
	},
	[170000] = {
		id = 170000,
		desc = "请输入预设名",
		define = "INPUT_PRESET_NAME",
		audio = "ban"
	},
	[170001] = {
		id = 170001,
		desc = "存在相同名字的预置",
		define = "EXIST_SAME_NAME",
		audio = "ban"
	},
	[170002] = {
		id = 170002,
		desc = "自定义预置数量已达上限",
		define = "PRESET_MORE_THAN_MAX",
		audio = "ban"
	},
	[170003] = {
		id = 170003,
		desc = "无法删除系统预置",
		define = "CANNOT_DELETE_PRESET",
		audio = "ban"
	},
	[170004] = {
		id = 170004,
		desc = "确定要删除当前的预置吗？",
		define = "DELETE_PRESET",
		audio = "ban"
	},
	[170005] = {
		id = 170005,
		desc = "尚未保存当前表情参数，是否要保存为新预置？",
		define = "SAVE_PRESET_TIPS",
		audio = "ban"
	},
	[170006] = {
		id = 170006,
		desc = "存在相同名字的预置，确定要覆盖吗？",
		define = "REPLACE_SAME_PRESET",
		audio = "ban"
	},
	[170007] = {
		id = 170007,
		desc = "无法覆盖系统预置",
		define = "CANNOT_REPLACE_PRESET",
		audio = "ban"
	},
	[170008] = {
		id = 170008,
		desc = "该动作不支持切换权钥显示状态",
		define = "CANNOT_SWITCH_WEAPON_STATE",
		audio = "ban"
	},
	[170009] = {
		id = 170009,
		desc = "无",
		define = "NONE",
		audio = "ban"
	},
	[170010] = {
		id = 170010,
		desc = "保存为新预置",
		define = "SAVE_NEW_PRESET",
		audio = "ban"
	},
	[170011] = {
		id = 170011,
		desc = "默认",
		define = "DEFAULT_PRESET",
		audio = "ban"
	},
	[170012] = {
		id = 170012,
		desc = "初始化",
		define = "INIT_PRESET",
		audio = "ban"
	},
	[170013] = {
		id = 170013,
		desc = "左上",
		define = "LEFT_TOP",
		audio = "ban"
	},
	[170014] = {
		id = 170014,
		desc = "左下",
		define = "LEFT_BOTTOM",
		audio = "ban"
	},
	[170015] = {
		id = 170015,
		desc = "右上",
		define = "RIGHT_TOP",
		audio = "ban"
	},
	[170016] = {
		id = 170016,
		desc = "右下",
		define = "RIGHT_BOTTOM",
		audio = "ban"
	},
	[180000] = {
		id = 180000,
		desc = "请解锁前置难度",
		define = "NEED_UNLOCK_FRONT_DIFFICULT",
		audio = "ban"
	},
	[180001] = {
		id = 180001,
		desc = "梦呓",
		define = "BOSS_LEVEL_1",
		audio = "ban"
	},
	[180002] = {
		id = 180002,
		desc = "残响",
		define = "BOSS_LEVEL_2",
		audio = "ban"
	},
	[180003] = {
		id = 180003,
		desc = "虚象",
		define = "BOSS_LEVEL_3",
		audio = "ban"
	},
	[180004] = {
		id = 180004,
		desc = "幻噩",
		define = "BOSS_LEVEL_4",
		audio = "ban"
	},
	[180005] = {
		id = 180005,
		desc = "魇渊",
		define = "BOSS_LEVEL_5",
		audio = "ban"
	},
	[180006] = {
		id = 180006,
		desc = "领奖条件未达成",
		define = "DONOT_MEET_CONDITION",
		audio = "ban"
	},
	[180007] = {
		id = 180007,
		desc = "即将重置每周挑战内容，无法进入作战",
		define = "NEARLY_OVER",
		audio = "ban"
	},
	[180008] = {
		id = 180008,
		desc = "【%s】累计最高积分达到%s后，下次刷新时解锁",
		define = "BOSS_CHALLENGE_ADVANCE_UNLOCK_TIPS",
		audio = "ban"
	},
	[180009] = {
		id = 180009,
		desc = "挑战时间不超过%s秒",
		define = "CHALLENGE_TIME",
		audio = "ban"
	},
	[180010] = {
		id = 180010,
		desc = "选择完成后，本周将无法进行更换，是否确认?",
		define = "BOSS_CHALLENGE_COMFIRM",
		audio = "ban"
	},
	[180011] = {
		id = 180011,
		desc = "累计最高积分达到%s",
		define = "CHALLENGE_MAX_POINT",
		audio = "ban"
	},
	[180012] = {
		id = 180012,
		desc = "【%s】完成关卡目标数量达到%s后，下次刷新时解锁",
		define = "BOSS_CHALLENGE_UNLOCK_TIPS",
		audio = "ban"
	},
	[180013] = {
		id = 180013,
		desc = "1.每周四可以选择已解锁的梦境难度。\n2.选择常规梦境后，在未领取奖励之前，可以更换难度。\n3.选择扭曲梦境后，在未领取奖励之前，可以更换难度。",
		define = "BOSS_CHALLENGE_MODE_DESC",
		audio = "ban"
	},
	[180014] = {
		id = 180014,
		desc = [[
1.每周四随机出现多个BOSS，每日05:00解锁一个BOSS。
2.BOSS挑战中每个难度对应不同的积分。
3.挑战BOSS时，可以选择条件增加通关时可获得的积分。
4.BOSS挑战通关时使用的修正者会被锁定，被锁定的修正者无法用于挑战其他BOSS，锁定的修正者每周四重置。
5.每个BOSS只会记录通关时获得的最高积分，挑战的累计积分与奖励每周四重置。
6.在未领取奖励之前，可以更换梦境难度，但会清除当前梦境难度下的全部进度。
7.在未领取奖励之前，可以重置挑战过的BOSS的进度，重置后该BOSS的积分将被清空，同时解除该BOSS锁定角色的锁定状态。]],
		define = "BOSS_CHALLENGE_ADVANCE_DESC",
		audio = "ban"
	},
	[180015] = {
		id = 180015,
		desc = "更换难度后，当前的进度将被全部清空，是否确认继续？",
		define = "BOSS_CHALLENGE_RESET_MODE",
		audio = "ban"
	},
	[180016] = {
		id = 180016,
		desc = "重置后，将解除锁定角色的锁定状态，但该BOSS的积分将被清空，是否确认继续？",
		define = "BOSS_CHALLENGE_RESET",
		audio = "ban"
	},
	[180017] = {
		id = 180017,
		desc = "奖励领取后，本周将无法更换难度或重置关卡，是否确认继续？",
		define = "BOSS_CHALLENGE_REWARD_TIPS",
		audio = "ban"
	},
	[180018] = {
		id = 180018,
		desc = "重置后，将解除锁定角色的锁定状态，但该BOSS已完成的关卡目标将被清空，是否确认继续？",
		define = "BOSS_CHALLENGE_NORMAL_RESET",
		audio = "ban"
	},
	[190000] = {
		id = 190000,
		desc = "矩阵公会创建成功",
		define = "CLUB_FOUNDED_SUCCESS",
		audio = "ban"
	},
	[190001] = {
		id = 190001,
		desc = "当前未加入任何公会无法使用该频道，是否寻找加入一个新的公会",
		define = "SEND_SOCIETY_MESSAGE_ERROR",
		audio = "ban"
	},
	[190002] = {
		id = 190002,
		desc = "请先转让会长",
		define = "TRANSFER_POST",
		audio = "ban"
	},
	[190003] = {
		id = 190003,
		desc = "退出矩阵公会后需要等待24小时才能再次加入公会，本周将无法参与联合攻坚，是否确认退出？",
		define = "EXIT_CLUB",
		audio = "ban"
	},
	[190004] = {
		id = 190004,
		desc = "公会名称不能为空",
		define = "CLUB_NEED_NAME",
		audio = "ban"
	},
	[190005] = {
		id = 190005,
		desc = "公会名称修改成功",
		define = "CLUB_RENANE_SUCCESS",
		audio = "ban"
	},
	[190006] = {
		id = 190006,
		desc = "公会公告修改成功",
		define = "CLUB_CHANGED_NOTICE_SUCCESS",
		audio = "ban"
	},
	[190007] = {
		id = 190007,
		desc = "公会图标修改成功",
		define = "CLUB_CHANGED_ICON_SUCCESS",
		audio = "ban"
	},
	[190008] = {
		id = 190008,
		desc = "你是会长，请先转让会长",
		define = "CLUB_CAPTAIN_CANNT_EXIT",
		audio = "ban"
	},
	[190009] = {
		id = 190009,
		desc = "刷新",
		define = "CLUB_REFRES_TEXT",
		audio = "ban"
	},
	[190010] = {
		id = 190010,
		desc = "申请设置已保存",
		define = "CLUB_SAVE_SETTING",
		audio = "ban"
	},
	[190011] = {
		id = 190011,
		desc = "罢免倒计时:",
		define = "CLUB_IMPEACH_CD",
		audio = "ban"
	},
	[190012] = {
		id = 190012,
		desc = "确认将会长职位移交给「%s」？",
		define = "CLUB_MOBILITY_CAPTAIN",
		audio = "ban"
	},
	[190013] = {
		id = 190013,
		desc = "确认将「%s」任命为副会长？",
		define = "CLUB_MOBILITY_DEPUTY",
		audio = "ban"
	},
	[190014] = {
		id = 190014,
		desc = "确认取消「%s」的副会长职位？",
		define = "CLUB_DISMISS",
		audio = "ban"
	},
	[190015] = {
		id = 190015,
		desc = "购买后，公会内所有正式成员将通过邮件收到奖励。",
		define = "CLUB_SPECIAL_WELFARE",
		audio = "ban"
	},
	[190016] = {
		id = 190016,
		desc = "当前处于退会CD中，%s后可加入矩阵公会",
		define = "CLUB_REQUEST_CD",
		audio = "ban"
	},
	[190017] = {
		id = 190017,
		desc = "新晋成员无法领取矩阵常规补给",
		define = "NEWBIE_CANNOT_GET_WELFARE",
		audio = "ban"
	},
	[190018] = {
		id = 190018,
		desc = "矩阵常规补给开启成功",
		define = "CLUB_WELFARE_OPEN",
		audio = "ban"
	},
	[190019] = {
		id = 190019,
		desc = "购买成功，将通过邮件发放",
		define = "TIP_CLUB_SPECIAL_WELFARE_BUY",
		audio = "ban"
	},
	[190020] = {
		id = 190020,
		desc = "确认将「%s」移出公会？",
		define = "CLUB_REMOVE_MEMBER",
		audio = "ban"
	},
	[190021] = {
		id = 190021,
		desc = "本周购买次数已达上限",
		define = "EXCEED_MAX_CNT",
		audio = "ban"
	},
	[190022] = {
		id = 190022,
		desc = [[
联合攻坚分为：裂隙征兆阶段、裂隙开放阶段。
「裂隙征兆」
开启时间：每周一5：00（1.每日首次挑战可以领取每日首战奖励。2.会长、副会长可在裂隙征兆阶段设置裂隙开放阶段的难度。）
1.在「裂隙征兆」关卡中，会根据玩家通关后的剩余时间获取评分。
2.通关所得评分会转化为修复进度，公会成员进度会叠加进公会总进度。
3.当公会总进度达100%时，全体成员获得在裂隙开放阶段的词缀加成。
挑战次数：每日3次
「裂隙开放」
开启时间：每周六5：00（1.根据所获评分可领取个人奖励。2.当BOSS血量变为75%，50%，25%，0%时，可以领取挑战奖励。）
1.在「裂隙开放」关卡中，会根据玩家对BOSS造成的伤害和通关后的剩余时间获取评分。
2.所获评分会等比转化成伤害削减BOSS的总血量。
挑战次数：无限（只记录最高评分）
「联合攻坚」
1.联合攻坚可以设置助战角色。
2.挑战联合攻坚的关卡可以借用一位公会成员的助战角色。
3.公会成员每次借用你的助战角色，你会获得100艾因索菲币奖励。每周周一5：00对上周的助战次数进行结算（每周最多获得100次助战奖励）。
4.退出公会后重新加入公会，本周将无法参与联合攻坚。]],
		define = "CLUB_BOSS_DESCRIPE",
		audio = "ban"
	},
	[190023] = {
		id = 190023,
		desc = "当前助战",
		define = "CURRENT_ASSISTANT",
		audio = "ban"
	},
	[190024] = {
		id = 190024,
		desc = "更换助战角色",
		define = "CHANGE_ASSISTANT_ROLE",
		audio = "ban"
	},
	[190025] = {
		id = 190025,
		desc = "BOSS血量低于%s可领取",
		define = "CLUB_BOSS_BLOOD_CONDITION_TIP1",
		audio = "ban"
	},
	[190026] = {
		id = 190026,
		desc = "击败BOSS可领取",
		define = "CLUB_BOSS_BLOOD_CONDITION_TIP2",
		audio = "ban"
	},
	[190027] = {
		id = 190027,
		desc = "裂隙征兆",
		define = "CLUB_BOSS_PREPOSE_TIP",
		audio = "ban"
	},
	[190028] = {
		id = 190028,
		desc = "裂隙开放",
		define = "CLUB_BOSS_CHALLENGE_TIP",
		audio = "ban"
	},
	[190029] = {
		id = 190029,
		desc = "下期联合攻坚开启后可参与",
		define = "GUILD_BOSS_CD_TIP",
		audio = "ban"
	},
	[190030] = {
		id = 190030,
		desc = "每次出战只能使用一位助战角色",
		define = "CLUB_BOSS_ASSIST_MORE_THAN_ONE_TIP",
		audio = "ban"
	},
	[190031] = {
		id = 190031,
		desc = "当前难度未解锁",
		define = "CLUB_BOSS_DIFFICULTY_UNLOCK_TIP",
		audio = "ban"
	},
	[190032] = {
		id = 190032,
		desc = "裂隙开放后无法变更难度",
		define = "CLUB_BOSS_DIFFICULTY_EXPIRED_TIP",
		audio = "ban"
	},
	[190033] = {
		id = 190033,
		desc = "已获得该前置关卡buff，是否确认继续挑战？",
		define = "CLUB_BOSS_PREPOSE_FINISH_CONFIRM_TIP",
		audio = "ban"
	},
	[190034] = {
		id = 190034,
		desc = "裂隙还未开启",
		define = "CLUB_BOSS_CHALLENGE_NOT_OPEN_TIP",
		audio = "ban"
	},
	[190035] = {
		id = 190035,
		desc = "裂隙征兆已结束",
		define = "CLUB_BOSS_PREPOSE_FINISH_TIP",
		audio = "ban"
	},
	[190036] = {
		id = 190036,
		desc = "会长或副会长可以变更难度",
		define = "CLUB_BOSS_DIFFICULTY_CANT_TIP",
		audio = "ban"
	},
	[190037] = {
		id = 190037,
		desc = "你已被移除公会",
		define = "CLUB_KICK",
		audio = "ban"
	},
	[190038] = {
		id = 190038,
		desc = "会长",
		define = "CLUB_CHAIR_MAN",
		audio = "ban"
	},
	[190039] = {
		id = 190039,
		desc = "副会长",
		define = "CLUB_VICE_CHAIR_MAN",
		audio = "ban"
	},
	[190040] = {
		id = 190040,
		desc = "正式成员",
		define = "CLUB_MEMBER",
		audio = "ban"
	},
	[190041] = {
		id = 190041,
		desc = "新晋成员",
		define = "CLUB_NOVICIATE",
		audio = "ban"
	},
	[190042] = {
		id = 190042,
		desc = "暂无公会",
		define = "NOT_MEMNER_OF_CLUB",
		audio = "ban"
	},
	[190043] = {
		id = 190043,
		desc = "公会分享冷却中，剩余时间%s",
		define = "CLUB_SHARE_CD_TIPS",
		audio = "ban"
	},
	[190044] = {
		id = 190044,
		desc = "该新晋成员加入未满%s小时，无法移除",
		define = "CLUB_NEWBEE_PROTECT",
		audio = "ban"
	},
	[190045] = {
		id = 190045,
		desc = "今日可移除玩家次数已达到上限",
		define = "CLUB_KICK_TIMES_MAX",
		audio = "ban"
	},
	[190046] = {
		id = 190046,
		desc = "是否对会长发起弹劾？弹劾后48小时内任何成员均可申请会长，若会长未驳回弹劾，会长将自动移交给其他成员",
		define = "CLUB_IMPEACH_TIPS",
		audio = "ban"
	},
	[190047] = {
		id = 190047,
		desc = "是否申请成为会长？弹劾结束后将优先从申请会长的成员中选出新的会长",
		define = "CLUB_APPLY_CAPTAIN_TIPS",
		audio = "ban"
	},
	[190048] = {
		id = 190048,
		desc = "取消副会长",
		define = "ERROR_CLUB_VICE_CHAIRMAN_CANCEL",
		audio = "ban"
	},
	[190049] = {
		id = 190049,
		desc = "任命副会长",
		define = "ERROR_CLUB_VICE_CHAIRMAN_APPOINT",
		audio = "ban"
	},
	[200001] = {
		id = 200001,
		desc = "分享标题",
		define = "SHARE_TITLE",
		audio = "ban"
	},
	[200002] = {
		id = 200002,
		desc = "分享文本",
		define = "SHARE_CONTENT",
		audio = "ban"
	},
	[200003] = {
		id = 200003,
		desc = "",
		define = "SHARE_URL",
		audio = "ban"
	},
	[200004] = {
		id = 200004,
		desc = "分享成功",
		define = "SHARE_SUCCESS",
		audio = "ban"
	},
	[200005] = {
		id = 200005,
		desc = "分享失败",
		define = "SHARE_FAIL",
		audio = "ban"
	},
	[200006] = {
		id = 200006,
		desc = "分享取消",
		define = "SHARE_CANCEL",
		audio = "ban"
	},
	[200007] = {
		id = 200007,
		desc = "保存成功",
		define = "SAVE_PHOTO_SUCCESS",
		audio = "ban"
	},
	[200008] = {
		id = 200008,
		desc = "保存失败",
		define = "SAVE_PHOTO_FAIL",
		audio = "ban"
	},
	[210001] = {
		id = 210001,
		desc = "%s心情值较低，将无法执行工作，是否确认派遣？",
		define = "DORM_HERO_LOW_MOOD",
		audio = "ban"
	},
	[210002] = {
		id = 210002,
		desc = "%s正在其他商店内工作，继续派遣将会结束原来的工作，是否确认派遣？",
		define = "DORM_HERO_AT_WORK",
		audio = "ban"
	},
	[210003] = {
		id = 210003,
		desc = "纪念币不足",
		define = "DORM_GOLD_NOT_ENOUGH",
		audio = "ban"
	},
	[210004] = {
		id = 210004,
		desc = "无法放置家具",
		define = "DORM_FURNITURE_CANNOT_SET",
		audio = "ban"
	},
	[210005] = {
		id = 210005,
		desc = "家具超载",
		define = "DORM_FURNITURE_OVERLOAD",
		audio = "ban"
	},
	[210006] = {
		id = 210006,
		desc = "%s事件流行中，开启新的流行事件将立即结束%s，是否继续？",
		define = "DORM_POPULAR_EVENT_OPEN",
		audio = "ban"
	},
	[210007] = {
		id = 210007,
		desc = "%s发生特殊事件，是否前往处理？",
		define = "DORM_SPECIAL_EVENT_OPEN",
		audio = "ban"
	},
	[210008] = {
		id = 210008,
		desc = "%s级餐厅",
		define = "FESTIVAL_CANTEEN_LEVEL",
		audio = "ban"
	},
	[210009] = {
		id = 210009,
		desc = "食材不足，重新设置菜单或看看委托任务吧~",
		define = "CANTEEN_STOP_TIPS1",
		audio = "ban"
	},
	[210010] = {
		id = 210010,
		desc = "菜单可设置的菜品已达到上限",
		define = "CANTEEN_FOOD_MAX",
		audio = "ban"
	},
	[210011] = {
		id = 210011,
		desc = "无法手动营业，试试重新设置菜单或完成委托任务吧~",
		define = "CANTEEN_CAN_NOT_OPERATE",
		audio = "ban"
	},
	[210012] = {
		id = 210012,
		desc = "看起来真不错!!",
		define = "CANTEEN_CUSTOMER_SERVE_TIPS1",
		audio = "ban"
	},
	[210013] = {
		id = 210013,
		desc = "这就是我要的",
		define = "CANTEEN_CUSTOMER_SERVE_TIPS2",
		audio = "ban"
	},
	[210014] = {
		id = 210014,
		desc = "这是我点的吗？",
		define = "CANTEEN_CUSTOMER_SERVE_TIPS3",
		audio = "ban"
	},
	[210015] = {
		id = 210015,
		desc = "这菜看起来不太对",
		define = "CANTEEN_CUSTOMER_SERVE_TIPS4",
		audio = "ban"
	},
	[210016] = {
		id = 210016,
		desc = "餐厅等级提升可增加人气，人气越高客人也将越多",
		define = "CANTEEN_HOT_DESC",
		audio = "ban"
	},
	[210017] = {
		id = 210017,
		desc = "刷新冷却中，剩余%s",
		define = "CANTEEN_TASK_REFRESH_COOLDOWN",
		audio = "ban"
	},
	[210018] = {
		id = 210018,
		desc = "委托耗时：%s",
		define = "CANTEEN_TASK_TIME",
		audio = "ban"
	},
	[210019] = {
		id = 210019,
		desc = "派遣人数不足，该任务至少派遣%s名修正者",
		define = "CANTEEN_TASK_NOT_CHOOSE",
		audio = "ban"
	},
	[210020] = {
		id = 210020,
		desc = "委托任务已刷新",
		define = "CANTEEN_TASK_REFRESH_SUCCESS",
		audio = "ban"
	},
	[210021] = {
		id = 210021,
		desc = "体力值不足，无法派遣",
		define = "CANTEEN_TASK_FATIGUE_NOT_ENOUGH",
		audio = "ban"
	},
	[210022] = {
		id = 210022,
		desc = "派遣成功",
		define = "CANTEEN_TASK_DISPATCH",
		audio = "success"
	},
	[210023] = {
		id = 210023,
		desc = "无法重复派遣相同修正者",
		define = "CANTEEN_TASK_CANT_CHOOSE",
		audio = "ban"
	},
	[210024] = {
		id = 210024,
		desc = "食材不足，试试重新设置菜单或完成委托任务吧~",
		define = "CANTEEN_CANT_OPERATE_TIPS1",
		audio = "ban"
	},
	[210025] = {
		id = 210025,
		desc = "%s后可领取",
		define = "CANTEEN_MONEY_TIPS1",
		audio = "ban"
	},
	[210026] = {
		id = 210026,
		desc = "可领取",
		define = "CANTEEN_MONEY_TIPS2",
		audio = "ban"
	},
	[210027] = {
		id = 210027,
		desc = "暂无收益",
		define = "CANTEEN_MONEY_TIPS3",
		audio = "ban"
	},
	[210028] = {
		id = 210028,
		desc = "是否要将 %s 从菜单中下架",
		define = "CANTEEN_FOOD_REMOVE",
		audio = "ban"
	},
	[210029] = {
		id = 210029,
		desc = "是否要将 %s 上架到菜单中",
		define = "CANTEEN_FOOD_ADD",
		audio = "ban"
	},
	[210030] = {
		id = 210030,
		desc = "当前菜单中没有足够的食材支持制作菜品",
		define = "CANTEEN_FOOD_NOT_ENOUGH",
		audio = "ban"
	},
	[210031] = {
		id = 210031,
		desc = "未选中需要制作的菜品",
		define = "CANTEEN_FOOD_UNCHOOSE",
		audio = "ban"
	},
	[210032] = {
		id = 210032,
		desc = "未选中需要菜品的口味",
		define = "CANTEEN_INGREDIENTS_UNCHOOSE",
		audio = "ban"
	},
	[210033] = {
		id = 210033,
		desc = "修正者体力值为空，无法派遣",
		define = "CANTEEN_HERO_FATIGUE_NULL",
		audio = "ban"
	},
	[210034] = {
		id = 210034,
		desc = "是否确认取消本次派遣？",
		define = "CANTEEN_TAKS_CANCEL",
		audio = "ban"
	},
	[210035] = {
		id = 210035,
		desc = "暂无可领取的收益",
		define = "CANTEEN_ADMITTED_NULL",
		audio = "ban"
	},
	[210036] = {
		id = 210036,
		desc = "的委托已完成",
		define = "CANTEEN_TASK_FINISH",
		audio = "ban"
	},
	[210037] = {
		id = 210037,
		desc = "餐厅升至%s级，可获得：",
		define = "CANTEEN_LEVEL_PREVIEW",
		audio = "ban"
	},
	[210038] = {
		id = 210038,
		desc = "当前上架的菜品无法满足营业需求，至少需要两种未售罄的菜品",
		define = "CANTEEN_FOOD_NOT_FIT",
		audio = "ban"
	},
	[210039] = {
		id = 210039,
		desc = "消耗：%s",
		define = "CANTEEN_FOOD_COST",
		audio = "ban"
	},
	[210040] = {
		id = 210040,
		desc = "售出%s份",
		define = "CANTEEN_SELL_INFO",
		audio = "ban"
	},
	[210041] = {
		id = 210041,
		desc = "是否确认退出手动营业，直接退出将不会保留经营结果",
		define = "CANTEEN_QUIT_CONFIRM",
		audio = "ban"
	},
	[210042] = {
		id = 210042,
		desc = "是否刷新该委托？",
		define = "CANTEEN_REFRESH_CONFIRM",
		audio = "ban"
	},
	[210043] = {
		id = 210043,
		desc = "是否切换为手动模式经营？",
		define = "CANTEEN_MANNUALLY_OPT",
		audio = "ban"
	},
	[210044] = {
		id = 210044,
		desc = "当前菜单的菜品已经没有食材可以制作，是否提前结算？",
		define = "CANTEEN_MANNUALLY_FOOD_EMPTY",
		audio = "ban"
	},
	[210045] = {
		id = 210045,
		desc = "%s属性增加%s",
		define = "DORM_LEVEL_AWARD_ATTRIB",
		audio = "ban"
	},
	[210046] = {
		id = 210046,
		desc = "档案语音解锁 %s",
		define = "DORM_LEVEL_AWARD_VOICE",
		audio = "ban"
	},
	[210047] = {
		id = 210047,
		desc = "宿舍解锁成功",
		define = "DORM_UNLOCK_TIPS",
		audio = "success"
	},
	[210048] = {
		id = 210048,
		desc = "%s 赠送成功",
		define = "DORM_GIFT_TIPS",
		audio = "success"
	},
	[210049] = {
		id = 210049,
		desc = "暂无好感度达到5级的可入住修正者",
		define = "DORM_HERO_SET_NULL",
		audio = "ban"
	},
	[210050] = {
		id = 210050,
		desc = "%s",
		define = "DORM_AREA_LAYER",
		audio = "ban"
	},
	[210051] = {
		id = 210051,
		desc = "暂无对应家具",
		define = "DORM_FURNITURE_NULL",
		audio = "ban"
	},
	[210052] = {
		id = 210052,
		desc = "模板保存成功",
		define = "DORM_MOULD_SAVE_SUCCESS",
		audio = "success"
	},
	[210053] = {
		id = 210053,
		desc = "宿舍大厅",
		define = "DORM_LOBBY_NAME",
		audio = "ban"
	},
	[210054] = {
		id = 210054,
		desc = "当前已拥有的家具数量不满足预设需求，是否仍使用该预设？",
		define = "DORM_MOULD_NOT_ENOUGH",
		audio = "ban"
	},
	[210055] = {
		id = 210055,
		desc = "当前修正者正在工作中",
		define = "DORM_HERO_WORK_IN_CANTEEN",
		audio = "ban"
	},
	[210056] = {
		id = 210056,
		desc = "房间家具放置数量已达上限",
		define = "DORM_FURNITURE_SET_MAX",
		audio = "ban"
	},
	[210057] = {
		id = 210057,
		desc = "是否覆盖当前模板",
		define = "DORM_MOULD_COVER",
		audio = "ban"
	},
	[210058] = {
		id = 210058,
		desc = "当前模板无法使用",
		define = "DORM_MOULD_CANT_USE",
		audio = "ban"
	},
	[210059] = {
		id = 210059,
		desc = "当前小窝资金不足，无法解锁",
		define = "DORM_UNLOCK_ITEM_NOT_ENOUGH",
		audio = "ban"
	},
	[210060] = {
		id = 210060,
		desc = "是否解锁该宿舍",
		define = "DORM_UNLOCK_CHECK_TIPS",
		audio = "ban"
	},
	[210061] = {
		id = 210061,
		desc = "默认模板%s",
		define = "DORM_MOULD_DEFAULT_NAME",
		audio = "ban"
	},
	[210062] = {
		id = 210062,
		desc = "模板改名成功",
		define = "DORM_MOULD_NAME_CHANGE",
		audio = "success"
	},
	[210063] = {
		id = 210063,
		desc = "%s的宿舍",
		define = "DORM_HERO_ROOM_NAME",
		audio = "ban"
	},
	[210064] = {
		id = 210064,
		desc = "%s的好感度达到5级",
		define = "DORM_ROOM_UNLOCK_TIPS",
		audio = "ban"
	},
	[210065] = {
		id = 210065,
		desc = "%s入住后无法更换，是否确认？",
		define = "DORM_HERO_SET_CHECK",
		audio = "ban"
	},
	[210066] = {
		id = 210066,
		desc = "保存成功",
		define = "DORM_EDIT_SUCCESS",
		audio = "success"
	},
	[210067] = {
		id = 210067,
		desc = "将收纳所有家具重置为初始状态，是否确认？",
		define = "DORM_EDIT_CLEAN",
		audio = "ban"
	},
	[210068] = {
		id = 210068,
		desc = "当前所有的更改将不会生效，是否确认取消？",
		define = "DORM_EDIT_CANCEL",
		audio = "ban"
	},
	[210069] = {
		id = 210069,
		desc = "宿舍达到%d级解锁",
		define = "DORM_VOICE_UNLOCK_TIP",
		audio = "ban"
	},
	[210070] = {
		id = 210070,
		desc = "大厅模板%s",
		define = "DORM_LOBBY_MOULD_DEFAULT_NAME",
		audio = "ban"
	},
	[210071] = {
		id = 210071,
		desc = "委托任务",
		define = "DORM_CANTEEN_TASK_NAME",
		audio = "ban"
	},
	[210072] = {
		id = 210072,
		desc = "食材不足，无法上架",
		define = "DORM_CANTEEN_INGREDIENTS_NOT_ENOUGH",
		audio = "ban"
	},
	[210073] = {
		id = 210073,
		desc = "需要解锁%d/%d间宿舍房间",
		define = "DORM_CANTEEN_TASK_UNLOCK_TIPS",
		audio = "ban"
	},
	[210074] = {
		id = 210074,
		desc = "Lv.%d",
		define = "DORM_CANTEEN_LEVEL",
		audio = "ban"
	},
	[210075] = {
		id = 210075,
		desc = "该修正者暂未入住宿舍",
		define = "DORM_HERO_NOT_SET",
		audio = "ban"
	},
	[210076] = {
		id = 210076,
		desc = "今日已达到用餐上限，无法再获得体力",
		define = "DORM_FEED_MAX",
		audio = "ban"
	},
	[210077] = {
		id = 210077,
		desc = "%0.1f/小时",
		define = "DORM_FATIGUE_PER_HOUR",
		audio = "ban"
	},
	[210078] = {
		id = 210078,
		desc = "是否确认保存本次编辑结果？",
		define = "DORM_EDIT_SAVE",
		audio = "ban"
	},
	[210079] = {
		id = 210079,
		desc = "需要达到%d级解锁",
		define = "DORM_CANTEEN_UNLOCK",
		audio = "ban"
	},
	[210080] = {
		id = 210080,
		desc = "升级条件未满足",
		define = "DORM_CANTEEN_CANT_LEVEL_UP",
		audio = "ban"
	},
	[210081] = {
		id = 210081,
		desc = "升级材料不足",
		define = "DORM_CANTEEN_LEVEL_NOT_ENOUGH",
		audio = "ban"
	},
	[210082] = {
		id = 210082,
		desc = "餐位",
		define = "DORM_CANTEEN_FURNITURE",
		audio = "ban"
	},
	[210083] = {
		id = 210083,
		desc = "厨具",
		define = "DORM_CANTEEN_FURNITURE_KITCHEN",
		audio = "ban"
	},
	[210084] = {
		id = 210084,
		desc = "厨师",
		define = "DORM_CANTEEN_COOK",
		audio = "ban"
	},
	[210085] = {
		id = 210085,
		desc = "侍应",
		define = "DORM_CANTEEN_WAITER",
		audio = "ban"
	},
	[210086] = {
		id = 210086,
		desc = "收银",
		define = "DORM_CANTEEN_CASHIER",
		audio = "ban"
	},
	[210087] = {
		id = 210087,
		desc = "更换成功",
		define = "DORM_CANTEEN_HERO_CHANGE_SUCCESS",
		audio = "success"
	},
	[210088] = {
		id = 210088,
		desc = "等级%d",
		define = "DORM_LEVEL_TIPS",
		audio = "ban"
	},
	[210089] = {
		id = 210089,
		desc = "去做菜",
		define = "DORM_CANTEEN_COOK_DO",
		audio = "ban"
	},
	[210090] = {
		id = 210090,
		desc = "去送菜",
		define = "DORM_CANTEEN_WAITER_DO",
		audio = "ban"
	},
	[210091] = {
		id = 210091,
		desc = "去收银",
		define = "DORM_CANTEEN_CASHIER_DO",
		audio = "ban"
	},
	[210092] = {
		id = 210092,
		desc = "上架成功",
		define = "DORM_FOOD_SET_SUCCESS",
		audio = "success"
	},
	[210093] = {
		id = 210093,
		desc = "上架数量不能为空",
		define = "DORM_FOOD_SET_NULL",
		audio = "ban"
	},
	[210094] = {
		id = 210094,
		desc = "模板名称不能为空",
		define = "DORM_MOULD_NAME_NULL",
		audio = "ban"
	},
	[210095] = {
		id = 210095,
		desc = "餐厅中",
		define = "DORM_HERO_AT_CANTEEN",
		audio = "ban"
	},
	[210096] = {
		id = 210096,
		desc = "大厅中",
		define = "DORM_HERO_AT_LOBBY",
		audio = "ban"
	},
	[210097] = {
		id = 210097,
		desc = "宿舍中",
		define = "DORM_HERO_AT_DORM",
		audio = "ban"
	},
	[210098] = {
		id = 210098,
		desc = "委托中",
		define = "DORM_HERO_AT_TASK",
		audio = "ban"
	},
	[210099] = {
		id = 210099,
		desc = "同名角色在场",
		define = "DORM_HERO_SAME_SET",
		audio = "ban"
	},
	[210100] = {
		id = 210100,
		desc = "放置角色已达上限",
		define = "DORM_LOBBY_SET_MAX",
		audio = "ban"
	},
	[210101] = {
		id = 210101,
		desc = "宿舍等级提升",
		define = "DORM_LEVEL_UP_TIPS",
		audio = "ban"
	},
	[210102] = {
		id = 210102,
		desc = "未放置家具，无法保存",
		define = "DORM_MOULD_CANT_SET",
		audio = "ban"
	},
	[210103] = {
		id = 210103,
		desc = "刷新功能冷却中，请稍后再试",
		define = "DORM_RECOMMEND_CD",
		audio = "ban"
	},
	[210104] = {
		id = 210104,
		desc = "模板名称与原本名称重复",
		define = "DORM_MOULD_NAME_SAME",
		audio = "ban"
	},
	[210105] = {
		id = 210105,
		desc = "岗位%s未设置",
		define = "DORM_AREA_LAYER",
		audio = "ban"
	},
	[210106] = {
		id = 210106,
		desc = "暂无可展示的玩家列表",
		define = "DORM_RECOMMEND_NULL",
		audio = "ban"
	},
	[210107] = {
		id = 210107,
		desc = "%0.1f体力/每小时",
		define = "DORM_FATIGUE_COST",
		audio = "ban"
	},
	[210108] = {
		id = 210108,
		desc = "是否消耗",
		define = "DORM_UNLOCK_COST_TIPS1",
		audio = "ban"
	},
	[210109] = {
		id = 210109,
		desc = "解锁宿舍",
		define = "DORM_UNLOCK_COST_TIPS2",
		audio = "ban"
	},
	[210110] = {
		id = 210110,
		desc = "赠送达到上限",
		define = "DORM_GIFT_MAX_TIPS",
		audio = "ban"
	},
	[210111] = {
		id = 210111,
		desc = "该家具已赠送达到上限",
		define = "DORM_FURNITURE_CANT_GIFT_TIPS",
		audio = "ban"
	},
	[210112] = {
		id = 210112,
		desc = "使用后当前场景配置将被替换，是否确认使用？",
		define = "DORM_MOULD_USE_CHECK",
		audio = "ban"
	},
	[210113] = {
		id = 210113,
		desc = "使用成功",
		define = "DORM_MOULD_USE_SUCCESS",
		audio = "success"
	},
	[210114] = {
		id = 210114,
		desc = "已选择同名修正者",
		define = "DORM_SAME_HERO_CHOOSE",
		audio = "ban"
	},
	[210115] = {
		id = 210115,
		desc = "当前场景已是展示场景",
		define = "DORM_DISPLAY_ALREADY",
		audio = "ban"
	},
	[210116] = {
		id = 210116,
		desc = "展示场景设置成功",
		define = "DORM_DISPLAY_SET_SUCCESS",
		audio = "success"
	},
	[210117] = {
		id = 210117,
		desc = "是否使用该模板，当前家具将会被重置替换为模板预设",
		define = "DORM_MOULD_SET_CHECK",
		audio = "ban"
	},
	[210118] = {
		id = 210118,
		desc = "职业%s未设置",
		define = "DORM_CANTEEN_JOB_NOT_SET",
		audio = "ban"
	},
	[210119] = {
		id = 210119,
		desc = "解锁条件",
		define = "DORM_CANTEEN_UNLOCK_CONDITION",
		audio = "ban"
	},
	[210120] = {
		id = 210120,
		desc = "升级条件",
		define = "DORM_CANTEEN_LEVEL_CONDITION",
		audio = "ban"
	},
	[210121] = {
		id = 210121,
		desc = "消耗%0.1f体力/小时",
		define = "DORM_CANTEEN_FATIGUE_COST",
		audio = "ban"
	},
	[210122] = {
		id = 210122,
		desc = "请输入模板名称",
		define = "DORM_MOULD_NAME_SET_TIPS",
		audio = "ban"
	},
	[210123] = {
		id = 210123,
		desc = "暂无可赠送的家具",
		define = "DORM_GIFT_NULL",
		audio = "ban"
	},
	[210124] = {
		id = 210124,
		desc = "模板使用成功",
		define = "DORM_MOULD_SET_SUCCESS",
		audio = "success"
	},
	[210125] = {
		id = 210125,
		desc = "未选择模板",
		define = "DORM_MOULD_CHOOSE_NULL",
		audio = "ban"
	},
	[210126] = {
		id = 210126,
		desc = "模板数据为空",
		define = "DORM_MOULD_DATA_NULL",
		audio = "ban"
	},
	[210127] = {
		id = 210127,
		desc = "解锁",
		define = "DORM_CANTEEN_LEVEL_UNLOCK",
		audio = "ban"
	},
	[210128] = {
		id = 210128,
		desc = "委托刷新次数",
		define = "DORM_CANTEEN_REFRESH_TIME",
		audio = "ban"
	},
	[210129] = {
		id = 210129,
		desc = "无法找到体力足够派遣的适合修正者",
		define = "DORM_CANTEEN_TASK_CANT_FIT",
		audio = "ban"
	},
	[210130] = {
		id = 210130,
		desc = "暂未开放",
		define = "DORM_AREA_NOT_OPEN",
		audio = "ban"
	},
	[210131] = {
		id = 210131,
		desc = "%s配置",
		define = "CANTEEN_JOB_SET",
		audio = "ban"
	},
	[210132] = {
		id = 210132,
		desc = "%s好感度达到%d级后解锁",
		define = "HERO_FAVORABILITY_UNLOCK",
		audio = "ban"
	},
	[210133] = {
		id = 210133,
		desc = "已派遣修正者",
		define = "CANTEEN_DISPATCHED_HERO",
		audio = "ban"
	},
	[210134] = {
		id = 210134,
		desc = "推荐修正者",
		define = "CANREEN_RECOMEND_HERO",
		audio = "ban"
	},
	[210135] = {
		id = 210135,
		desc = "是否确认删除模板",
		define = "DORM_DELETE_TEMPLATE",
		audio = "ban"
	},
	[210136] = {
		id = 210136,
		desc = "当前修正者正在交互中，无法进行新的交互",
		define = "HERO_CANT_INTERACT",
		audio = "ban"
	},
	[210137] = {
		id = 210137,
		desc = "该家具需要赠送后才能摆放",
		define = "DORM_FUR_NEED_GIFT",
		audio = "ban"
	},
	[220001] = {
		id = 220001,
		desc = "获取前一阶段主要奖励后开启",
		define = "INFINITY_LOCK",
		audio = "ban"
	},
	[220002] = {
		id = 220002,
		desc = "是否确认重置?",
		define = "RESET_INFINITY",
		audio = "ban"
	},
	[220003] = {
		id = 220003,
		desc = "心象碎片不足",
		define = "CURRENCY_SHORTAGE",
		audio = "ban"
	},
	[220004] = {
		id = 220004,
		desc = [[
1.在梦境系统模拟出的神域幻境中战斗，是对修正者而言极为有利的战场。只有娴熟运用战斗技能的成员才能通过所有的挑战！
2.选定挑战神系后，出战队伍原本的神系加成效果将不会生效，而是触发挑战神系的加成效果。
3.进入幻境之前，管理员可以选择词缀来增加挑战的难度，难度越高，管理员将获得的挑战积分越多。
4.可以使用梦境装置提供的试用修正者进行挑战。]],
		define = "ACTIVITY_OSIRIS_TACE_TRIAL_DESCRIPE",
		audio = "ban"
	},
	[220005] = {
		id = 220005,
		desc = "1.在梦境装置中，修正者曾积压的负面情绪也会形成具象，只有击败内心黑暗的强者才能通过试炼。\n2.可以使用梦境装置提供的试用修正者进行挑战。\n3.在极难难度下，只能使用梦境装置提供的试用修正者进行挑战。",
		define = "ACTIVITY_OSIRIS_HEART_DEMON_CHALLENGE_DESCRIPE",
		audio = "ban"
	},
	[220006] = {
		id = 220006,
		desc = [[
1.将心象碎片填入缺口中，可以随机获得一份心象之礼。
2.心象碎片通过完成活动任务获取。
3.前四层的心象房间均存在一个主要奖励，获取主要奖励后，可以主动前往下一层心象房间，当前房间仍然保留。
4.前四层的心象房间无法进行重置，奖励只能够领取一次。
5.第五层的心象房间没有主要奖励，但房间内所有心象之礼领取后，可以对房间进行重置，再次领取该房间的心象之礼。
6.重置没有次数限制。]],
		define = "ACTIVITY_OSIRIS_INFINITY_POOL_DESCRIPE",
		audio = "ban"
	},
	[220007] = {
		id = 220007,
		desc = "完成%s试用关卡",
		define = "COMPLETE_TRAIL_STAGE",
		audio = "ban"
	},
	[220008] = {
		id = 220008,
		desc = "%s后开启",
		define = "OPEN_TIME",
		audio = "ban"
	},
	[220009] = {
		id = 220009,
		desc = "活动已结束",
		define = "TIME_OVER",
		audio = "ban"
	},
	[220010] = {
		id = 220010,
		desc = "通关普通或以上难度",
		define = "CLEAR_NORMAL_DIFFICULTY",
		audio = "ban"
	},
	[220011] = {
		id = 220011,
		desc = "通关困难或以上难度",
		define = "CLEAR_DIFFICULTY",
		audio = "ban"
	},
	[220012] = {
		id = 220012,
		desc = "通关极限难度",
		define = "CLEAR_EXTREME_DIFFICULTY",
		audio = "ban"
	},
	[220013] = {
		id = 220013,
		desc = "积分累计达到",
		define = "ACCUMULATED_POINTS_REACHED",
		audio = "ban"
	},
	[220014] = {
		id = 220014,
		desc = "%s「%s」完成后解锁",
		define = "UNLOCK_CONDITION_ACTIVITY_TIPS",
		audio = "ban"
	},
	[220016] = {
		id = 220016,
		desc = "1.可以使用包含所选试用角色的固定阵容进入指定关卡进行体验，队伍阵容无法修改。\n2.可重复进入同一个关卡进行体验，但奖励只能领取一次。",
		define = "ACTIVITY_HERO_TRIAL_DESCRIPE",
		audio = "ban"
	},
	[220017] = {
		id = 220017,
		desc = "第%s阶段%s开启",
		define = "UNLOCK_INFINITY",
		audio = "ban"
	},
	[220018] = {
		id = 220018,
		desc = "获取所有奖励后可重置",
		define = "UNLOCK_INFINITY_RESET_TIPS",
		audio = "ban"
	},
	[230001] = {
		id = 230001,
		desc = "1.避难地并非彻底的安全之所，视骸仍潜藏在外蠢蠢欲动。在营地守卫玩法中，需要借助修正者海拉的力量，防止视骸的入侵。\n2.营地守卫玩法关卡会随活动时间逐步开放，在关卡中坚守避难区一定时间后获胜，若过多敌人进入防守点则视为失败。\n3.在关卡中会出现对玩家有利的「幻蝶」，请尽可能的保护它们以获取能量增益。",
		define = "ACTIVITY_HELLA_TOWER_DESCRIPE",
		audio = "ban"
	},
	[230002] = {
		id = 230002,
		desc = [[
1.往昔的幻影再度缠绕而上，唯有正视自己，才能摆脱过去的束缚。
2.可以使用往昔幻影玩法提供的试用修正者进行挑战。
3.在挑战「残忆·暗星」的过程中，普通模式与困难模式下仅可使用一名修正者出战；极限模式下，仅可使用固定阵容进行挑战。
4.在挑战「残忆·风行」的过程中，普通模式与困难模式下仅可使用一名修正者出战；极限模式下，仅可使用固定阵容进行挑战。]],
		define = "ACTIVITY_DEMON_CHALLENGE_DESCRIPE_61031",
		audio = "ban"
	},
	[230003] = {
		id = 230003,
		desc = [[
1.骸震发生后，灾区多处出现异常的骸能反应，修正者们要前往异常点清理骸震灾区内出现的视骸。异常区域将会随活动时间逐步开放。
2.灾区清扫关卡中，需要通过清除不断出现的视骸获取积分，根据结算时的最高分领取相应的关卡奖励。
3.在本玩法中，每关都会为修正者提供一定的基础增益。消灭一定数量的视骸会获得一次强化效果，每次获得强化效果都会令下次获得强化效果时产生一层额外增益，直至获得全部增益效果。
4.每关限时150秒，达到时间限制或于关卡内击杀数到达300时，将会进入结算环节。]],
		define = "ACTIVITY_HELLA_SLAYER_DESCRIPE",
		audio = "ban"
	},
	[230004] = {
		id = 230004,
		desc = "1.赫尔墨斯接到居民们的委托，帮忙寻回丢失在骸震中的物品，失物速递关卡会随活动时间逐步开放。\n2.在失物速递关卡中，需要帮助修正者赫尔墨斯在复杂的路况中穿行，躲避障碍的同时以最快速度到达终点就能取得丢失的物品。\n3.在关卡中会出现视骸与能量球：击败视骸可帮助赫尔墨斯积攒印记进入超级加速模式；能量球可以延长超级加速模式的时间。合理运用闪避与攻击，能帮助赫尔墨斯更快地完成关卡。",
		define = "ACTIVITY_HELLA_PARKOUR_DESCRIPE",
		audio = "ban"
	},
	[230005] = {
		id = 230005,
		desc = "限时签到",
		define = "ACTIVITY_HELLA_SIGN_TITLE",
		audio = "ban"
	},
	[230006] = {
		id = 230006,
		desc = [[
1.大国主为了应对特殊「溢散」现象而开发的收集仪器。能够对收集到的数据体进行解析，解析数据得到的神系能量可以用来强化仪器本身。
2.兔兔解析机由一个核心组件和五个神系组件构成。
3.核心组件提供初始加成效果，可以提升所有神系修正者的战斗能力，该效果不可升级。
4.神系组件需要通过解析「溢散立方」来获得并提升对应的加成效果，进而提升对应神系修正者的战斗能力。
5.兔兔解析机的效果仅在葬蝶之墓、灾区清扫、往昔幻影玩法中生效。]],
		define = "ACTIVITY_HELLA_TALENT_DESCRIPE",
		audio = "ban"
	},
	[240001] = {
		id = 240001,
		desc = "%s后开启",
		define = "SLAYER_TIME_TO_START",
		audio = "ban"
	},
	[250001] = {
		id = 250001,
		desc = "探索度达到%s%%后解锁",
		define = "EXPLORE_UNLOCK",
		audio = "ban"
	},
	[250002] = {
		id = 250002,
		desc = "1.隐科组通过拉比提供的塞壬数据而研发的一种仪器，拥有模拟多种作战环境的能力。\n2.在不同的作战环境中，修正者可以获得不同的神力增幅。\n3.完成模拟测试后，可以获得挑战奖励。奖励只能获取一次。",
		define = "ACTIVITY_SUMMER_ARTIFACT_DESCRIPE",
		audio = "ban"
	},
	[250003] = {
		id = 250003,
		desc = [[
1.丝卡蒂调查船训练舱里的全息模拟装置，很多强敌的数据都被收录其中，用于日常挑战和练习，是丝卡蒂自身实力的来源之一。
2.通过调整参数强化敌人，限制自身，面对更困难的挑战。
3.完成挑战时会记录获得的最高分数。逆限模拟的排行榜会在每个小时更新一次。
4.挑战积分由挑战过程中队长受到的伤害值、挑战耗时以及挑战难度共同决定。]],
		define = "ACTIVITY_SUMMER_LIMITED_CALCULATION_DESCRIPE",
		audio = "ban"
	},
	[250004] = {
		id = 250004,
		desc = "队伍一",
		define = "TEAM_1",
		audio = "ban"
	},
	[250005] = {
		id = 250005,
		desc = "队伍二",
		define = "TEAM_2",
		audio = "ban"
	},
	[250006] = {
		id = 250006,
		desc = "队伍三",
		define = "TEAM_3",
		audio = "ban"
	},
	[250007] = {
		id = 250007,
		desc = "今天给该好友赠送的幻鳞已达上限",
		define = "DAILY_GIVE_RARE_FISH_LIMIT_TIP",
		audio = "ban"
	},
	[250008] = {
		id = 250008,
		desc = "好友系统未解锁",
		define = "FRIEND_SYSTEM_NOT_OPEN",
		audio = "ban"
	},
	[250009] = {
		id = 250009,
		desc = "%s后开启幻鳞购买功能",
		define = "PURCHASE_SYSTEM_NOT_OPEN",
		audio = "ban"
	},
	[250010] = {
		id = 250010,
		desc = "活动已结束",
		define = "SOLO_TIME_OVER",
		audio = "ban"
	},
	[250011] = {
		id = 250011,
		desc = "活动未开启",
		define = "SOLO_NOT_OPEN",
		audio = "ban"
	},
	[250012] = {
		id = 250012,
		desc = "%s后开启",
		define = "SOLO_OPEN_TIME",
		audio = "ban"
	},
	[250013] = {
		id = 250013,
		desc = "赠送成功",
		define = "FISHING_GIVE_SUCCESS",
		audio = "ban"
	},
	[250014] = {
		id = 250014,
		desc = "收取成功",
		define = "FISHING_RECEIVE_SUCCESS",
		audio = "ban"
	},
	[250015] = {
		id = 250015,
		desc = "放弃后已经完成的进度将会被清除，是否确认放弃？",
		define = "GIVE_UP_SOLO_CHALLENGE",
		audio = "ban"
	},
	[250016] = {
		id = 250016,
		desc = "请先编辑出战队伍",
		define = "HERO_UNREADY_SOLO_CHALLENGE",
		audio = "ban"
	},
	[250017] = {
		id = 250017,
		desc = "队伍还可携带增幅芯片，是否继续？",
		define = "AFFIX_UNREADY_SOLO_CHALLENGE",
		audio = "ban"
	},
	[250018] = {
		id = 250018,
		desc = "1.选择三位修正者分别对战不同的敌人。\n2.修正者可装备「增幅芯片」以获取不同的战斗增益效果。\n3.通关关卡后该修正者与其装备的「增幅芯片」将会被锁定。",
		define = "ACTIVITY_SOLO_CHALLENGE_DESCRIPE",
		audio = "ban"
	},
	[250019] = {
		id = 250019,
		desc = "增幅芯片可大幅提升修正者的作战能力，请管理员根据队员相性合理配发，帮助隐科组完成数据采集工作。",
		define = "ACTIVITY_SOLO_CHALLENGE_CONTENT",
		audio = "ban"
	},
	[250020] = {
		id = 250020,
		desc = [[
1.通过收集打捞物可以获得水文解析度（每日上限1000）。
2.出海时，捞取七彩气泡可以获得幻鳞（每日上限3条）。
3.水文解析度累积到一定数值可以领取对应奖励。
4.在湛蓝图鉴中可以浏览已获得的幻鳞。
5.活动第五天，开启湛蓝图鉴的兑换功能，可以使用水文解析度兑换幻鳞。
6.收集不同的幻鳞可以组合成多种幻鳞纷染，每种幻鳞纷染都可以兑换一种奖励。
7.每种幻鳞纷染对应的奖励只能兑换一次。
8.好友之间可以互相赠送幻鳞，赠送幻鳞可以完成合约任务。]],
		define = "ACTIVITY_SUMMER_FISH_DESCRIPE",
		audio = "ban"
	},
	[250021] = {
		id = 250021,
		desc = "跌入漩涡的利维坦似乎进入了某种奇怪的梦境，她不得不用泡泡反击从四面八方同时袭来的敌人。",
		define = "ACTIVITY__BUBBLES_CONTENT",
		audio = "ban"
	},
	[250022] = {
		id = 250022,
		desc = "岛屿附近的海面上也有视骸出没，好在斩浪号赋予了丝卡蒂水上作战的能力，对付这些视骸不在话下。",
		define = "ACTIVITY__CROSSWAVE_CONTENT",
		audio = "ban"
	},
	[250023] = {
		id = 250023,
		desc = "积分倍率x%s",
		define = "ACTIVITY_LIMIT_CALCULATION_POINT_RANK",
		audio = "ban"
	},
	[250024] = {
		id = 250024,
		desc = "神力降频组件 等级%s",
		define = "ACTIVITY_LIMIT_CALCULATION_PLAYER_LEVEL",
		audio = "ban"
	},
	[250025] = {
		id = 250025,
		desc = "骸能增幅组件 等级%s",
		define = "ACTIVITY_LIMIT_CALCULATION_ENEMY_LEVEL",
		audio = "ban"
	},
	[250026] = {
		id = 250026,
		desc = "积分达到%s",
		define = "ACTIVITY_LIMIT_CALCULATION_POINT_REACHED",
		audio = "ban"
	},
	[250027] = {
		id = 250027,
		desc = "是否确认退出该局游戏？",
		define = "FISHING_GIVE_UP",
		audio = "ban"
	},
	[250028] = {
		id = 250028,
		desc = "深度解析",
		define = "ACTIVITY_FISHING_BUFF_NAME_1",
		audio = "ban"
	},
	[250029] = {
		id = 250029,
		desc = "电机超载",
		define = "ACTIVITY_FISHING_BUFF_NAME_2",
		audio = "ban"
	},
	[250030] = {
		id = 250030,
		desc = "骸能震荡",
		define = "ACTIVITY_FISHING_BUFF_NAME_3",
		audio = "ban"
	},
	[250031] = {
		id = 250031,
		desc = "获得了额外的信息，20秒内获得的水文解析度翻倍",
		define = "ACTIVITY_FISHING_BUFF_DESC_1",
		audio = "ban"
	},
	[250032] = {
		id = 250032,
		desc = "机械臂超负荷运转，10秒内大幅提高打捞效率",
		define = "ACTIVITY_FISHING_BUFF_DESC_2",
		audio = "ban"
	},
	[250033] = {
		id = 250033,
		desc = "骸能结晶发出震荡波，将附近海域内所有鱼类眩晕20秒",
		define = "ACTIVITY_FISHING_BUFF_DESC_3",
		audio = "ban"
	},
	[250034] = {
		id = 250034,
		desc = "完成全部荒岛迷踪剧情后开启",
		define = "ACTIVITY_FINISH_ALL_SUMMER_STORY",
		audio = "ban"
	},
	[250035] = {
		id = 250035,
		desc = "无名荒岛探索度达到100%后开启",
		define = "ACTIVITY_FINISH_ALL_SUMMER_CHESS",
		audio = "ban"
	},
	[250036] = {
		id = 250036,
		desc = [[
1.操作驾驶着斩浪号的丝卡蒂，在指定时间内到达指定地点即可通关。
2.在到达指定地点的过程中，收集视骸留下的视骸晶核。
3.时间结束后未能到达指定地点，或斩浪号在途中被击毁，则挑战失败。
4.每个关卡共有3个星级，通过关卡后达成挑战条件可以获取对应星级，领取该关卡对应星级的挑战奖励。]],
		define = "ACTIVITY_CROSSWAVE_DESCRIPE",
		audio = "ban"
	},
	[250037] = {
		id = 250037,
		desc = [[
1.利维坦被困于场景中央无法移动，操作她发射泡泡消灭袭来的视骸即可通关。
2.挑战过程中会出现四种颜色的视骸，每种视骸都只能被对应颜色的泡泡消灭，想要发射某种颜色的泡泡，按下对应颜色的按键即可。
3.视骸会分别从四个方向袭来，利用方向键可以控制发射泡泡的方向，从而针对性地消灭视骸。
4.黄色泡泡比较特殊，发射时会消耗利维坦的体力，利维坦体力为空则无法发射，体力被消耗后会缓慢恢复。
5.当视骸触碰到利维坦时，会被利维坦身上溢出的神力消灭，但利维坦也会损失部分生命值。当利维坦生命值为0时，挑战失败。
6.利维坦的奥义值会随着时间不断增加，奥义值满后，利维坦可以使用奥义技能：在一定时间内，按任意颜色键，利维坦都可以发射彩色泡泡，彩色泡泡可以消灭任何颜色的视骸。]],
		define = "ACTIVITY_BUBBLES_DESCRIPE",
		audio = "ban"
	},
	[250038] = {
		id = 250038,
		desc = "活动未解锁",
		define = "ACTIVITY_UNLOCK",
		audio = "ban"
	},
	[250039] = {
		id = 250039,
		desc = "通关关卡后将开放多倍挑战功能",
		define = "ACTIVITY_PT_REPEAT_MULTIPLE_UNLOCK",
		audio = "ban"
	},
	[250040] = {
		id = 250040,
		desc = "非常抱歉，管理员！本次活动已经结束，本次战斗奖励无法结算获得。\n您当前所消耗的道具或吨吨值将原路退回您的账号内。",
		define = "ACTIVITY_LOCK_SETTLEMENT_TIP",
		audio = "ban"
	},
	[250041] = {
		id = 250041,
		desc = "1.不同的水泡秘境中蕴含着不同的神域数据，可以为对应神系的修正者提供一定的伤害加成。\n2.管理员每次通关水泡秘境中任意关卡，将获得一定数量的「异能流体」，可前往异能置换机中兑换所需道具。",
		define = "ACTIVITY_SUMMER_PT_REPEAT_DESCRIPE",
		audio = "ban"
	},
	[250042] = {
		id = 250042,
		desc = "队伍四",
		define = "TEAM_4",
		audio = "ban"
	},
	[250043] = {
		id = 250043,
		desc = "队伍五",
		define = "TEAM_5",
		audio = "ban"
	},
	[260001] = {
		id = 260001,
		desc = [[
1.俄尼里伊偶尔会误入别人的梦，帮助俄尼里伊回忆梦境中的画面。
2.将混乱的梦境碎片放到应在的位置，完成绘卷参加画展。
3.在复原过程中，可以寻求弥芙尔帮助完成绘卷。
4.每个绘卷的完成奖励只能领取一次。]],
		define = "ACTIVITY_PUZZLE_DESCRIPE",
		audio = "ban"
	},
	[260002] = {
		id = 260002,
		desc = "盛典期间，绘画协会举办了以欧莫菲斯历史为主题的画展。",
		define = "ACTIVITY_PUZZLE_CONTENT",
		audio = "ban"
	},
	[260003] = {
		id = 260003,
		desc = "再移动%d次将提供复原帮助",
		define = "PUZZLE_HELP_REMAIN",
		audio = "ban"
	},
	[260004] = {
		id = 260004,
		desc = "寻求弥芙尔的帮助",
		define = "PUZZLE_HELP",
		audio = "ban"
	},
	[260005] = {
		id = 260005,
		desc = "放弃后将失去当前进度，是否确认继续？",
		define = "GIVE_UP_PUZZLE",
		audio = "ban"
	},
	[260006] = {
		id = 260006,
		desc = [[
1.参与虚恒地区特有的秋夕博礼游戏，可以获得天禄贸易的使者-禄良带来的小礼物。
2.每日05:00刷新后登录游戏，可以获得3次博礼机会。
3.每日活跃度达到20/40/60/80/100，将额外获得1次博礼机会。
4.当日未使用的博礼机会，将在次日05:00被清空，管理员记得及时参与~
5.博礼游戏根据六粒骰子的投掷结果组合来决定参与者的奖励，不同组合对应的博礼结果可以查看博礼规则。
6.不同的博礼结果设有不同的奖励，博出对应结果时，将从该结果的剩余奖励中随机获取其中一个奖励。
7.若本次博礼结果对应的奖励已被全部领取，则无法继续领取对应结果的奖励，将获得500艾因索菲币。
8.若本次博礼结果无对应的奖励，将获得500艾因索菲币。
9.若连续3次博礼获得的奖励均为500艾因索菲币，下一次博礼必定为剩余奖励的结果，直至所有博礼奖励全部被领取完毕。]],
		define = "ACTIVITY_MOONCAKE_GAMBLING_DESCRIPE",
		audio = "ban"
	},
	[260007] = {
		id = 260007,
		desc = "博礼次数已用尽",
		define = "ACTIVITY_MOONCAKE_GAMBLING_NUM_ZERO",
		audio = "ban"
	},
	[260008] = {
		id = 260008,
		desc = "秀才",
		define = "ACTIVITY_MOONCAKE_GAMBLING_REWARD_1",
		audio = "ban"
	},
	[260009] = {
		id = 260009,
		desc = "举人",
		define = "ACTIVITY_MOONCAKE_GAMBLING_REWARD_2",
		audio = "ban"
	},
	[260010] = {
		id = 260010,
		desc = "进士",
		define = "ACTIVITY_MOONCAKE_GAMBLING_REWARD_3",
		audio = "ban"
	},
	[260011] = {
		id = 260011,
		desc = "探花",
		define = "ACTIVITY_MOONCAKE_GAMBLING_REWARD_4",
		audio = "ban"
	},
	[260012] = {
		id = 260012,
		desc = "榜眼",
		define = "ACTIVITY_MOONCAKE_GAMBLING_REWARD_5",
		audio = "ban"
	},
	[260013] = {
		id = 260013,
		desc = "状元",
		define = "ACTIVITY_MOONCAKE_GAMBLING_REWARD_6",
		audio = "ban"
	},
	[260014] = {
		id = 260014,
		desc = "%s奖励已被全部领取，本次博礼结果无法领取%s奖励",
		define = "ACTIVITY_MOONCAKE_GAMBLING_REWARD_NONE",
		audio = "ban"
	},
	[260015] = {
		id = 260015,
		desc = "第%s回合",
		define = "ACTIVITY_COWBOY_ROUND",
		audio = "ban"
	},
	[260016] = {
		id = 260016,
		desc = "1.不同的乐章所产生的共鸣，可以为对应战斗方式的修正者提供一定的伤害加成。\n2.管理员每次通关同韵回响中任意关卡，将获得一定数量的「塞勒涅的乐谱」可前往藏品鉴定所中兑换所需道具。",
		define = "ACTIVITY_CHAPTERIII_PT_DESCRIBE",
		audio = "ban"
	},
	[260017] = {
		id = 260017,
		desc = [[
1.战场亦为舞池，修正者们战斗的英姿便是最佳的写生素材，战舞区域将会随活动时间逐步开放。
2.战舞印象关卡中，需要通过清除不断出现的敌人获取积分，根据结算时的最高分领取相应的关卡奖励。
3.在本玩法中，每关都会为修正者提供一定的基础增益。击败一定数量的敌人会获得一次强化效果，每次获得强化效果都会令下次获得强化效果时产生一层额外增益，直至获得全部增益效果。
4.每关限时180秒，达到时间限制或于关卡内击杀数到达300时，将会进入结算环节。]],
		define = "ACTIVITY_VOLUME_SLAYER_DESCRIPE",
		audio = "ban"
	},
	[260018] = {
		id = 260018,
		desc = "获得%d个新的线索！",
		define = "ACTIVITY_VOLUME_MATRIX_CLUE",
		audio = "ban"
	},
	[260019] = {
		id = 260019,
		desc = [[
管理员与薇儿即将前往欧莫菲斯参加阿尔蒂斯盛典，调皮的前鬼坊也想逃避工作偷偷跟去。
为了防止被休抓住，前鬼坊擅自使用隐科组最新研发的兔兔幻象制造器，导致整个深空之眼各处都出现了前鬼坊的幻象分身，严重影响了其他修正者的正常工作。
操控休释放旋风雷电，抓住调皮前鬼坊吧。
积分奖励均只可领取一次。]],
		define = "ACTIVITY_COWBOY_TIPS",
		audio = "ban"
	},
	[260020] = {
		id = 260020,
		desc = "当前所选角色没有共鸣神格，将会极大提高挑战难度，是否继续？",
		define = "ACTIVITY_MATRIX_LACK_ASTROLABE",
		audio = "ban"
	},
	[260021] = {
		id = 260021,
		desc = "当前所选角色没有激活刻印套装，将会极大提高挑战难度，是否继续？",
		define = "ACTIVITY_MATRIX_LACK_EQUIP",
		audio = "ban"
	},
	[260022] = {
		id = 260022,
		desc = "当前所选角色没有共鸣神格和激活刻印套装，将会极大提高挑战难度，是否继续？",
		define = "ACTIVITY_MATRIX_LACK_ALL",
		audio = "ban"
	},
	[260023] = {
		id = 260023,
		desc = [[
1.曾消失多年的白磨坊剧团再度出现。年轻的休将追寻曾经白磨坊的巡演路线，查明多年前的真相。
2.管理员只能选择一名自己拥有的修正者进入剧场。
3.不同的剧场对可进入的修正者的神系存在要求，部分剧场只允许指定神系的修正者进入。
4.进入剧场后，修正者自身的属性将被同步为系统设定值，<color=#FF9500>修正者携带的钥从、刻印和神格效果</color>可以直接带入剧场。
5.在剧场中，每次探索都会遇到随机的关卡和事件。
6.完成任意事件后，修正者当前生命值将会在结算后继承至下一次事件。
7.在成功完成战斗事件后，修正者将获得20%基础生命值的生命回复。
8.首次完成某个剧场的探索后，将随机获得一定数量的线索，线索将收录在线索档案中。]],
		define = "ACTIVITY_MATRIX_DESC",
		audio = "ban"
	},
	[260024] = {
		id = 260024,
		desc = "商店未开启",
		define = "SHOP_NOT_OPEN",
		audio = "ban"
	},
	[260025] = {
		id = 260025,
		desc = "通关%s后开启",
		define = "ACTIVITY_MATRIX_PRECONDITIONS",
		audio = "ban"
	},
	[270001] = {
		id = 270001,
		desc = "切换区域将重置服务器和配置文件。\n点击确定后将关闭游戏，需要重新打开游戏。",
		define = "CHANGE_SERVER",
		audio = "ban"
	},
	[280001] = {
		id = 280001,
		desc = "%s后刷新",
		define = "TIME_DISPLAY_1",
		audio = "ban"
	},
	[280002] = {
		id = 280002,
		desc = "<color=#FFEB1C>%s</color>后获取2次刷新次数",
		define = "TIME_DISPLAY_2",
		audio = "ban"
	},
	[280003] = {
		id = 280003,
		desc = "剩余时间     <size=40>%s</size>",
		define = "TIME_DISPLAY_3",
		audio = "ban"
	},
	[280004] = {
		id = 280004,
		desc = "剩余天数：%s",
		define = "TIME_DISPLAY_4",
		audio = "ban"
	},
	[280005] = {
		id = 280005,
		desc = "%s",
		define = "TIME_DISPLAY_5",
		audio = "ban"
	},
	[280006] = {
		id = 280006,
		desc = "本期剩余：%s",
		define = "TIME_DISPLAY_6",
		audio = "ban"
	},
	[280007] = {
		id = 280007,
		desc = "%s后过期",
		define = "TIME_DISPLAY_7",
		audio = "ban"
	},
	[280008] = {
		id = 280008,
		desc = "自动刷新：%s",
		define = "TIME_DISPLAY_8",
		audio = "ban"
	},
	[280009] = {
		id = 280009,
		desc = "刷新时间：%s",
		define = "TIME_DISPLAY_9",
		audio = "ban"
	},
	[280010] = {
		id = 280010,
		desc = "刷新倒计时：<color=#E9BE04>%s</color>",
		define = "TIME_DISPLAY_10",
		audio = "ban"
	},
	[280011] = {
		id = 280011,
		desc = "重置倒计时：%s",
		define = "TIME_DISPLAY_11",
		audio = "ban"
	},
	[280012] = {
		id = 280012,
		desc = "%s到期",
		define = "TIME_DISPLAY_12",
		audio = "ban"
	},
	[280013] = {
		id = 280013,
		desc = "<color=#E9BE04>活动时间：</color>%s维护",
		define = "TIME_DISPLAY_13",
		audio = "ban"
	},
	[280014] = {
		id = 280014,
		desc = "<color=#E9BE04>剩余时间：</color>%s",
		define = "TIME_DISPLAY_14",
		audio = "ban"
	},
	[280015] = {
		id = 280015,
		desc = "%s  后更新关卡",
		define = "TIME_DISPLAY_15",
		audio = "ban"
	},
	[280016] = {
		id = 280016,
		desc = "最多<size=40><color=#E9BE04>%s</color></size>次必出4星或以上品质钥从",
		define = "SCAN_RULES_1",
		audio = "ban"
	},
	[280017] = {
		id = 280017,
		desc = "最多<size=40><color=#E9BE04>%s</color></size>次必出5星钥从",
		define = "SCAN_RULES_2",
		audio = "ban"
	},
	[280018] = {
		id = 280018,
		desc = "最多<size=40><color=#E9BE04>%s</color></size>次必出A级或以上品质修正者",
		define = "SCAN_RULES_3",
		audio = "ban"
	},
	[280019] = {
		id = 280019,
		desc = "最多<size=40><color=#E9BE04>%s</color></size>次必出S级修正者",
		define = "SCAN_RULES_4",
		audio = "ban"
	},
	[280020] = {
		id = 280020,
		desc = "是否消耗 <size=40><color=#FF9500>%s</color></size>         进行%d回探测",
		define = "WHETHER_TO_DRAW",
		audio = "ban"
	},
	[280021] = {
		id = 280021,
		desc = "是否消耗 <size=40><color=#FF9500>%s</color></size>         刷新商店",
		define = "WHETHER_TO_REFRESH",
		audio = "ban"
	},
	[280023] = {
		id = 280023,
		desc = "确认重置键位及相机灵敏度吗?",
		define = "RESET_CAMERAANDKEYBOARD",
		audio = "ban"
	},
	[280024] = {
		id = 280024,
		desc = "管理员，根据设备检测，推荐您使用<color=#FF9500>超清</color>画质",
		define = "GRAPHIC_RECOMMEND_1",
		audio = "ban"
	},
	[280025] = {
		id = 280025,
		desc = "管理员，根据设备检测，推荐您使用<color=#FF9500>高清</color>画质",
		define = "GRAPHIC_RECOMMEND_2",
		audio = "ban"
	},
	[280026] = {
		id = 280026,
		desc = "管理员，根据设备检测，推荐您使用<color=#FF9500>流畅</color>画质",
		define = "GRAPHIC_RECOMMEND_3",
		audio = "ban"
	},
	[280027] = {
		id = 280027,
		desc = "恭喜你已提升了难度等级",
		define = "HAZARD_ZONE_UPGRADE",
		audio = "ban"
	},
	[280028] = {
		id = 280028,
		desc = "难度",
		define = "HARD_LEVEL",
		audio = "ban"
	},
	[280029] = {
		id = 280029,
		desc = "前往答卷",
		define = "INVESTIGATE_TIPS_1",
		audio = "ban"
	},
	[280030] = {
		id = 280030,
		desc = "已领取",
		define = "INVESTIGATE_TIPS_2",
		audio = "ban"
	},
	[280031] = {
		id = 280031,
		desc = "领取奖励",
		define = "INVESTIGATE_TIPS_3",
		audio = "ban"
	},
	[280032] = {
		id = 280032,
		desc = "继续探索",
		define = "SCAN_TIPS_1",
		audio = "ban"
	},
	[280033] = {
		id = 280033,
		desc = "前往整理",
		define = "SCAN_TIPS_2",
		audio = "ban"
	},
	[280034] = {
		id = 280034,
		desc = "下一级",
		define = "SKILL_NEXT_LEVEL",
		audio = "ban"
	},
	[280035] = {
		id = 280035,
		desc = "裂隙开放倒计时",
		define = "GONGHUIBOSS_LIEXIZHENGZHAO",
		audio = "ban"
	},
	[280036] = {
		id = 280036,
		desc = "裂隙重置倒计时",
		define = "GONGHUIBOSS_LIEXIKAIFANG",
		audio = "ban"
	},
	[280037] = {
		id = 280037,
		desc = "兑换%s",
		define = "EXCHANGE_TIP",
		audio = "ban"
	},
	[280038] = {
		id = 280038,
		desc = "挑战成功简单难度",
		define = "CLUB_BOSS_TIPS_1",
		audio = "ban"
	},
	[280039] = {
		id = 280039,
		desc = "挑战成功普通难度",
		define = "CLUB_BOSS_TIPS_2",
		audio = "ban"
	},
	[280040] = {
		id = 280040,
		desc = "挑战成功困难难度",
		define = "CLUB_BOSS_TIPS_3",
		audio = "ban"
	},
	[280041] = {
		id = 280041,
		desc = "裂隙开放倒计时",
		define = "CLUB_BOSS_OPEN_1",
		audio = "ban"
	},
	[280042] = {
		id = 280042,
		desc = "裂隙重置倒计时",
		define = "CLUB_BOSS_OPEN_2",
		audio = "ban"
	},
	[280043] = {
		id = 280043,
		desc = "裂隙未开启",
		define = "CLUB_BOSS_START_1",
		audio = "ban"
	},
	[280044] = {
		id = 280044,
		desc = "准备作战",
		define = "CLUB_BOSS_START_2",
		audio = "ban"
	},
	[280045] = {
		id = 280045,
		desc = "简单",
		define = "CLUB_BOSS_DIFFICULTY_1",
		audio = "ban"
	},
	[280046] = {
		id = 280046,
		desc = "普通",
		define = "CLUB_BOSS_DIFFICULTY_2",
		audio = "ban"
	},
	[280047] = {
		id = 280047,
		desc = "困难",
		define = "CLUB_BOSS_DIFFICULTY_3",
		audio = "ban"
	},
	[280048] = {
		id = 280048,
		desc = "极限",
		define = "CLUB_BOSS_DIFFICULTY_4",
		audio = "ban"
	},
	[280049] = {
		id = 280049,
		desc = "已加入",
		define = "CLUB_SHARE_TIPS_1",
		audio = "ban"
	},
	[280050] = {
		id = 280050,
		desc = "无法申请",
		define = "CLUB_SHARE_TIPS_2",
		audio = "ban"
	},
	[280051] = {
		id = 280051,
		desc = "申请加入",
		define = "CLUB_SHARE_TIPS_3",
		audio = "ban"
	},
	[280052] = {
		id = 280052,
		desc = "已申请",
		define = "CLUB_SHARE_TIPS_4",
		audio = "ban"
	},
	[285001] = {
		id = 285001,
		desc = [[
1.进入异变黑区后将面对更加强大的敌人，同时将掉落异变黑曜。
2.每星期一和星期五会刷新一次关卡内容和奖励。
3.每次通关时，会根据通关等级以及完成时间解锁更高的怨念等级。
4.根据已通关的最高怨念等级，可以领取不同的奖励。
5.在未领取奖励之前，可以任意切换难度，但切换不同难度后，会重置黑区关卡状态。]],
		define = "MYTHIC_FINAL_DESC",
		audio = "ban"
	},
	[285002] = {
		id = 285002,
		desc = "当前敌人强度%s%%",
		define = "MYTHIC_FINAL_LEVEL_DESC",
		audio = "ban"
	},
	[285003] = {
		id = 285003,
		desc = "通关怨念等级%s或以上等级",
		define = "MYTHIC_FINAL_REWARD_TIPS",
		audio = "ban"
	},
	[285004] = {
		id = 285004,
		desc = "怨念等级%s",
		define = "MYTHIC_FINAL_LEVEL",
		audio = "ban"
	},
	[285005] = {
		id = 285005,
		desc = "当前通关等级：怨念等级%s",
		define = "MYTHIC_FINAL_REWARD_FOLLOW_TIPS",
		audio = "ban"
	},
	[285006] = {
		id = 285006,
		desc = "恭喜你已解锁新的怨念等级",
		define = "MYTHIC_FINAL_LEVEL_UNLOCK",
		audio = "ban"
	},
	[285007] = {
		id = 285007,
		desc = "将以当前队伍重新挑战，是否继续？",
		define = "MYTHIC_FINAL_LEVEL_RETRY",
		audio = "ban"
	},
	[285008] = {
		id = 285008,
		desc = "当前的挑战进度将不会保留，是否继续？",
		define = "MYTHIC_FINAL_GIVEUP",
		audio = "ban"
	},
	[285009] = {
		id = 285009,
		desc = "恭喜你已提升了难度等级",
		define = "MYTHIC_NEW_LEVEL_UNLOCK",
		audio = "ban"
	},
	[285010] = {
		id = 285010,
		desc = "苦难梦魇，异变永黯。",
		define = "MYTHIC_FINAL_TIPS",
		audio = "ban"
	},
	[285011] = {
		id = 285011,
		desc = "将会清除当前的队伍配置，是否继续？",
		define = "MYTHIC_TEAM_RESET",
		audio = "ban"
	},
	[285012] = {
		id = 285012,
		desc = "当前难度尚未完成，刷新后将失去当前进度，是否确认继续？",
		define = "ERROR_MYTHIC_REFRESH",
		audio = "ban"
	},
	[285013] = {
		id = 285013,
		desc = "异变黑区%d级·",
		define = "MYTHIC_FINAL_BASTTLE_TIPS",
		audio = "ban"
	},
	[285014] = {
		id = 285014,
		desc = "是否确定重新开启挑战，放弃原有进度？",
		define = "MYTHIC_PROCESS_RECORD",
		audio = "ban"
	},
	[290001] = {
		id = 290001,
		desc = [[
升阶回廊共包含五个神系回廊，神系回廊只能使用对应神系的角色挑战
每个神系回廊有5个词缀关卡与1个BOSS关卡
「词缀关卡」
1.每次通关词缀关卡可以获得两个词缀和若干「辉煌唱片」
2.「辉煌唱片」可在「强音收束仪」中兑换奖励
3.获得相同词缀时，会提升该词缀的等级（词缀等级上限为5）
4.当可获得的词缀等级均达到上限时，下次通关词缀关卡时将不会获得任何词缀
5.每个神系回廊获得的词缀只能在该回廊中使用
「BOSS关卡」
1.挑战BOSS关卡会根据通关时间和对BOSS造成的伤害获得评分
2.根据BOSS关卡的累积和最高评分，可以领取对应条件的奖励]],
		define = "ACTIVITY_RACE_DESCRIPE",
		audio = "ban"
	},
	[290002] = {
		id = 290002,
		desc = "根据调查在欧莫菲斯源层中发现多处能使神域权限不断扩展的特殊区域，神域能力会在这些区域内产生回响，并不断增强。",
		define = "ACTIVITY_RACE_CONTENT",
		audio = "ban"
	},
	[290003] = {
		id = 290003,
		desc = "通关%s后开启",
		define = "ACTIVITY_RACE_UNLOCK",
		audio = "ban"
	},
	[290004] = {
		id = 290004,
		desc = "1.不同的元素反应可以为对应属性的修正者提供一定的伤害加成。\n2.管理员每次通关元素变奏中任意关卡，将会获得一定数量的「变奏数据块」可前往样品解析站中兑换所需道具。",
		define = "ACTIVITY_CHAPTERIII_DOWN_PT_DESCRIBE",
		audio = "ban"
	},
	[290005] = {
		id = 290005,
		desc = "普通或以上难度获得赏心悦耳评价",
		define = "ACTIVITY_MUSIC_EASY_TASK",
		audio = "ban"
	},
	[290006] = {
		id = 290006,
		desc = "困难难度获得赏心悦耳评价",
		define = "ACTIVITY_MUSIC_DIFFICULT_TASK",
		audio = "ban"
	},
	[290007] = {
		id = 290007,
		desc = "BOSS关累计评分达到%s",
		define = "ACTIVITY_RACE_AMOUNT_REWARD",
		audio = "ban"
	},
	[290008] = {
		id = 290008,
		desc = "BOSS关最高评分达到%s",
		define = "ACTIVITY_RACE_HIGHEST_REWARD",
		audio = "ban"
	},
	[290009] = {
		id = 290009,
		desc = "1.源层深处的镜像因骸能波动而实体化，凝视镜中的自己，只有击败内心黑暗的强者才能通过试炼。\n2.管理员可以使用试用修正者进行挑战。\n3.在极限难度下，只能使用试用修正者进行挑战。",
		define = "ACTIVITY_DEMON_CHALLENGE_DESCRIPE_91031",
		audio = "ban"
	},
	[290010] = {
		id = 290010,
		desc = [[
1.盛典音律共包含八首歌曲，每首歌曲有「普通」和「困难」两种难度。
2.开始演奏后，管理员需要根据音符的类型和下落到判定线的时机，点击或长按对应的判定区。
3.下落的音符分为「点按音符」和「长按音符」。
4.下落的「点按音符」到达判定线时，需要点击对应判定区。
5.下落的「长按音符」到达判定线时，需要长按判定区至该音符结束。
6.点击音符的时机越准确，获得的分数将会越高。]],
		define = "ACTIVITY_MUSIC_DESCRIBE",
		audio = "ban"
	},
	[290011] = {
		id = 290011,
		desc = "普通",
		define = "ACTIVITY_MUSIC_LEVEL_1",
		audio = "ban"
	},
	[290012] = {
		id = 290012,
		desc = "困难",
		define = "ACTIVITY_MUSIC_LEVEL_2",
		audio = "ban"
	},
	[290013] = {
		id = 290013,
		desc = "极难",
		define = "ACTIVITY_MUSIC_LEVEL_3",
		audio = "ban"
	},
	[290014] = {
		id = 290014,
		desc = [[
欧申纳斯的权钥流转之洋能运用水之神力感知周边所有的数据信息。
通过分析流转之洋所得的数据，海姆达尔打算尝试升级多维终端系统，使得使用者能更加清晰的观察多维世界线的变动。
1.管理员将化身「欧申纳斯」经历诸多奇遇与冒险，角色属性为系统设定值。
2.地图探索模式中多分支可供选择，管理员可自由决定前进路线。
3.经历每次事件后「欧申纳斯」的当前生命值将会在结算后继承至下一事件。
4.每次完成战斗事件后「欧申纳斯」将恢复20%基础生命值。]],
		define = "ACTIVITY_STRATEGY_MATRIX_DESCRIBE",
		audio = "ban"
	},
	[290015] = {
		id = 290015,
		desc = "初  涛",
		define = "ACTIVITY_STRATEGY_TITLE_1",
		audio = "ban"
	},
	[290016] = {
		id = 290016,
		desc = "翻  涌",
		define = "ACTIVITY_STRATEGY_TITLE_2",
		audio = "ban"
	},
	[290017] = {
		id = 290017,
		desc = "余  汐",
		define = "ACTIVITY_STRATEGY_TITLE_3",
		audio = "ban"
	},
	[290018] = {
		id = 290018,
		desc = "奔  流",
		define = "ACTIVITY_STRATEGY_TITLE_4",
		audio = "ban"
	},
	[300001] = {
		id = 300001,
		desc = "尚未配置队长角色，保存失败",
		define = "CAPTAIN_ROLE_MISSING",
		audio = "ban"
	},
	[300002] = {
		id = 300002,
		desc = "不可存在相同的编队方案",
		define = "SAME_TEAM_PROHIBITED",
		audio = "ban"
	},
	[300003] = {
		id = 300003,
		desc = "编队方案删除成功",
		define = "FORMATION_PLAN_DELETED",
		audio = "success"
	},
	[300004] = {
		id = 300004,
		desc = "确定要删除编队方案吗？\n「%s」",
		define = "FORMATION_PLAN_DELETE_CONFIRM",
		audio = "ban"
	},
	[300005] = {
		id = 300005,
		desc = "编队方案更换成功",
		define = "FORMATION_PLAN_CHANGED",
		audio = "success"
	},
	[300006] = {
		id = 300006,
		desc = "更换失败",
		define = "FORMATION_PLAN_CHANGE_FAILED",
		audio = "ban"
	},
	[300007] = {
		id = 300007,
		desc = "编队方案保存成功",
		define = "FORMATION_PLAN_SAVED",
		audio = "success"
	},
	[300008] = {
		id = 300008,
		desc = "方案名称修改成功",
		define = "FORMATION_PLAN_NAME_CHANGED",
		audio = "success"
	},
	[300009] = {
		id = 300009,
		desc = "编队",
		define = "TEAM",
		audio = "ban"
	},
	[300010] = {
		id = 300010,
		desc = "方案名称",
		define = "NIL_NAME",
		audio = "ban"
	},
	[300011] = {
		id = 300011,
		desc = "请先加入修正者",
		define = "SKILL_WITHOUT_MEMBER",
		audio = "ban"
	},
	[300012] = {
		id = 300012,
		desc = "请先设置编队方案",
		define = "TEAM_SET_NEEDED",
		audio = "ban"
	},
	[300013] = {
		id = 300013,
		desc = "当前编队中存在试用角色",
		define = "CHARACTOR_ON_TRIAL",
		audio = "ban"
	},
	[300101] = {
		id = 300101,
		desc = "报名成功",
		define = "ACTIVITY_CLUB_REGISTER_SUCCESS",
		audio = "success"
	},
	[300102] = {
		id = 300102,
		desc = "未满足报名需求",
		define = "ACTIVITY_CLUB_REGISTER_CANT_TIP",
		audio = "ban"
	},
	[300103] = {
		id = 300103,
		desc = "已达占领上限",
		define = "ACTIVITY_CLUB_GRID_OCCUPY_MAX",
		audio = "ban"
	},
	[300104] = {
		id = 300104,
		desc = "当前可占领的节点数量已达上限，管理员需要先放弃当前已占领的其他节点",
		define = "ACTIVITY_CLUB_SELF_OCCUPY_MAX",
		audio = "ban"
	},
	[300105] = {
		id = 300105,
		desc = "是否确认放弃？",
		define = "ACTIVITY_CLUB_NORMAL_GRID_GIVEUP_CONFIRM",
		audio = "ban"
	},
	[300106] = {
		id = 300106,
		desc = "放弃攻坚后，将结束对该节点的锁定状态，但攻坚进度仍然保留，是否确认放弃？",
		define = "ACTIVITY_CLUB_ELITE_GRID_GIVEUP_CONFIRM",
		audio = "ban"
	},
	[300107] = {
		id = 300107,
		desc = "放弃战斗结果后，将失去本次关卡进度，同时不会消耗出战修正者的侵蚀抵抗值，是否确认放弃？",
		define = "ACTIVITY_CLUB_ELITE_GRID_ABADON_RESULT_CONFIRM",
		audio = "ban"
	},
	[300108] = {
		id = 300108,
		desc = "中枢节点已被击败",
		define = "BOSS_BE_KILLED_TIP",
		audio = "ban"
	},
	[300109] = {
		id = 300109,
		desc = "击败当前地图的中枢节点并通过中枢节点前往下一层",
		define = "ACTIVITY_CLUB_NEXT_MAP_LOCK_TIP",
		audio = "ban"
	},
	[300110] = {
		id = 300110,
		desc = "攻坚评级达到%s级后解锁",
		define = "ACTIVITY_CLUB_FIGHT_MEMBER_LOCK_TIP",
		audio = "ban"
	},
	[300111] = {
		id = 300111,
		desc = "移出编队后，该修正者的侵蚀抵抗值将被清空，且后续加入队伍的修正者初始侵蚀抵抗值为0，是否确认继续？",
		define = "ACTIVITY_CLUB_REMOVE_TEAM_TIP",
		audio = "ban"
	},
	[300112] = {
		id = 300112,
		desc = "加入编队的修正者初始侵蚀抵抗值为0，且被更换的修正者侵蚀抵抗值也将被清空，是否确认继续？",
		define = "ACTIVITY_CLUB_JOIN_ZERO_VITALITY_TIP",
		audio = "ban"
	},
	[300113] = {
		id = 300113,
		desc = "可出战修正者列表配置未满员，若确认保存，此后再编入的修正者的初始侵蚀抵抗值为0，是否确认继续？",
		define = "ACTIVITY_CLUB_FIGHT_HERO_NOT_FULL_TIP",
		audio = "ban"
	},
	[300114] = {
		id = 300114,
		desc = "修正者侵蚀抵抗值不足无法出战",
		define = "ACTIVITY_CLUB_HERO_VITALITY_NOT_ENOUGH_TIP",
		audio = "ban"
	},
	[300115] = {
		id = 300115,
		desc = "请先配置可出战修正者列表",
		define = "ACTIVITY_CLUB_NO_FIGHT_HERO_TIP",
		audio = "ban"
	},
	[300116] = {
		id = 300116,
		desc = "矩阵远征·侵蚀涡流开启期间，无法移除公会成员",
		define = "ACTIVITY_CLUB_ACTIVITYING_REMOVE_MEMBER_TIP",
		audio = "ban"
	},
	[300117] = {
		id = 300117,
		desc = "矩阵远征·侵蚀涡流开启期间，无法退出公会",
		define = "ACTIVITY_CLUB_ACTIVITYING_EXIT_CLUB_TIP",
		audio = "ban"
	},
	[300118] = {
		id = 300118,
		desc = "可占领节点数量上限为%d",
		define = "CLUB_ACTIVITY_MAX_DOMAIN",
		audio = "ban"
	},
	[300119] = {
		id = 300119,
		desc = "可以出战的修正者数量上限为%d",
		define = "CLUB_ACTIVITY_MAX_HERO",
		audio = "ban"
	},
	[300120] = {
		id = 300120,
		desc = "攻坚评级达到%d级",
		define = "ACTIVITY_CLUB_REWARD",
		audio = "ban"
	},
	[300121] = {
		id = 300121,
		desc = "当前节点危险等级为<color=#F9CF29>%s</color>，攻坚难度降低<color=#F9CF29>%s%%</color>",
		define = "ACTIVITY_CLUB_DANGEROUS_DESC_OLD",
		audio = "ban"
	},
	[300122] = {
		id = 300122,
		desc = "已被<color=#F9CF29>%s</color>人占领，<color=#F9CF29>%s</color>人攻坚中",
		define = "ACTIVITY_CLUB_ATTACK_DESC",
		audio = "ban"
	},
	[300123] = {
		id = 300123,
		desc = [[
1.共包含5个神系的增益模组，只有对应神系的修正者可以获得对应的增益效果。
2.每个神系均有5个增益组件，每个组件均可以通过消耗「涡流之尘」提升组件等级，进而提升增益效果。
3.「涡流之尘」通过占领乱流节点或高能节点一定时间后获得。
4.矩阵增益模组仅在矩阵远征·侵蚀涡流活动中生效。]],
		define = "CLUB_ACTIVITY_AFFIX_DESC",
		audio = "ban"
	},
	[300124] = {
		id = 300124,
		desc = "%s级",
		define = "ACTIVITY_CLUB_DANGEROUS_DESC",
		audio = "ban"
	},
	[300125] = {
		id = 300125,
		desc = "%s/<color=#89899A>小时</color>",
		define = "ACTIVITY_CLUB_VITALITY_RECOVER",
		audio = "ban"
	},
	[300126] = {
		id = 300126,
		desc = "无可出战的修正者",
		define = "ACTIVITY_CLUB_HERO_NOT_ENOUGH",
		audio = "ban"
	},
	[300127] = {
		id = 300127,
		desc = "侵蚀抵抗",
		define = "ACTIVITY_CLUB_QSDK",
		audio = "ban"
	},
	[300128] = {
		id = 300128,
		desc = "未加入远征",
		define = "ACTIVITY_CLUB_NOT_JOIN",
		audio = "ban"
	},
	[300129] = {
		id = 300129,
		desc = "矩阵远征已结束",
		define = "ACTIVITY_CLUB_OVER",
		audio = "ban"
	},
	[310101] = {
		id = 310101,
		desc = "「星锚数据凭证」数量不足",
		define = "NAME_CHANGE_CARD_INSUFFICIENT_TIPS",
		audio = "ban"
	},
	[310102] = {
		id = 310102,
		desc = "是否消耗1张「星锚数据凭证」将昵称改为“%s”？",
		define = "NAME_CHANGE_CARD_WHETHER_TIPS",
		audio = "ban"
	},
	[320001] = {
		id = 320001,
		desc = [[
1.使用「猫的筹码」在牌局中进行兑换，可以随机获得一份奖励。
2.「猫的筹码」通过完成芭丝特的委托获取。
3.前四阶段的牌局均存在一个主要奖励，获取主要奖励后，可以开启下一阶段的牌局，当前阶段的牌局仍然保留。
4.猫的牌局在前四阶段无法进行重置，奖励只能领取一次。
5.第五阶段的牌局没有主要奖励，但牌局中的所有奖励均领取后，可以重置牌局，再次兑换牌局中的奖励。
6.重置没有次数限制。]],
		define = "ACTIVITY_FACTORY_INFINITY_POOL_DESCRIPE",
		audio = "ban"
	},
	[320002] = {
		id = 320002,
		desc = "第一阶段",
		define = "PHASE_1",
		audio = "ban"
	},
	[320003] = {
		id = 320003,
		desc = "第二阶段",
		define = "PHASE_2",
		audio = "ban"
	},
	[320004] = {
		id = 320004,
		desc = "第三阶段",
		define = "PHASE_3",
		audio = "ban"
	},
	[320005] = {
		id = 320005,
		desc = "第四阶段",
		define = "PHASE_4",
		audio = "ban"
	},
	[320006] = {
		id = 320006,
		desc = "第五阶段",
		define = "PHASE_5",
		audio = "ban"
	},
	[320007] = {
		id = 320007,
		desc = [[
1.只能选择关卡指定类型的一名修正者进入挑战。
2.关卡中会不断有敌人来袭，在敌人的进攻下抵御120秒即可胜利。
3.如果存活的敌人数量过多，则敌人会获得强化，否则我方修正者会获得强化。
4.关卡中会随机生成可拾取的增益加成，但是每次只能拾取一个。]],
		define = "ACTIVITY_SOLO_SLAYER_DESC",
		audio = "ban"
	},
	[320008] = {
		id = 320008,
		desc = "存活时间不少于%d秒",
		define = "ACTIVITY_SOLO_SLAYER_REWARD",
		audio = "ban"
	},
	[320009] = {
		id = 320009,
		desc = [[
1.操作马尔杜克参与战斗，阻止敌人走向终点。
2.预设固定点内可以设置无人机防御敌人，每个系列无人机各有两个分支可以选择升级。
3.击败敌人可获得建造点数，建造点数可用来升级无人机，加强无人机能力。
4.敌人走到终点时会扣除终点血量，当终点血量为零时，游戏失败。
5.成功抵御所有波次的敌人，则游戏胜利。]],
		define = "ACTIVITY_TOWER_DEFENSE_DESC",
		audio = "ban"
	},
	[320010] = {
		id = 320010,
		desc = "通关时终点血量不低于%s",
		define = "ACTIVITY_TOWER_DEFENSE_REWARD",
		audio = "ban"
	},
	[320011] = {
		id = 320011,
		desc = "本次坚持时间",
		define = "ACTIVITY_SOLO_SLAYER_FINISH",
		audio = "ban"
	},
	[320012] = {
		id = 320012,
		desc = "增幅芯片可大幅提升修正者的作战能力，请管理员根据队员相性合理配发，帮助隐科组完成数据采集工作。",
		define = "FACTORY_ACTIVITY_SOLO_CHALLENGE_CONTENT",
		audio = "ban"
	},
	[320013] = {
		id = 320013,
		desc = "1.选择三位修正者分别对战不同的敌人。\n2.修正者可装备「增幅芯片」以获取不同的战斗增益效果。\n3.通关关卡后该修正者与其装备的「增幅芯片」将会被锁定。",
		define = "FACTORY_ACTIVITY_SOLO_CHALLENGE_DESCRIPE",
		audio = "ban"
	},
	[320014] = {
		id = 320014,
		desc = "通关%s后解锁",
		define = "ACTIVITY_TOWER_DEFENSE_UNLOCK_DESC",
		audio = "ban"
	},
	[320015] = {
		id = 320015,
		desc = "1.不同的禁区中蕴含着与对应神系同频的能量力场，可以为对应神系的修正者提供一定的增益加成。\n2.管理员每次通关迷失禁区中任意关卡，将获得一定数量的「情报模组」，可前往情报终端中兑换所需道具。",
		define = "ACTIVITY_MARDUK_PT_DESC",
		audio = "ban"
	},
	[320016] = {
		id = 320016,
		desc = [[
1.特训关卡中使用对应类型的修正者可以获得增益加成。
2.每击退一波敌人，则会产生新的敌人，并且可以获得积分与额外的挑战时间。
3.当所有敌人都被击退后则会根据剩余时间获得额外积分。
4.完成挑战时会记录获得的最高积分。速战特训的排行榜会在每个小时更新一次。]],
		define = "MARDUK_SPECIAL_NOTE",
		audio = "ban"
	},
	[320017] = {
		id = 320017,
		desc = "通关积分达到%s",
		define = "FACTORY_ACTIVITY_POINT_REWARD",
		audio = "ban"
	},
	[330001] = {
		id = 330001,
		desc = "已离开房间",
		define = "COOPERATION_LEAVE_ROOM",
		audio = "ban"
	},
	[330002] = {
		id = 330002,
		desc = "将退出当前房间，是否确认退出？",
		define = "COOPERATION_LEAVE_ROOM_CONFIRM",
		audio = "ban"
	},
	[330003] = {
		id = 330003,
		desc = "需要所有玩家就绪后才能开始",
		define = "COOPERATION_SOMEONE_UNREADY",
		audio = "ban"
	},
	[330004] = {
		id = 330004,
		desc = "当前正在调整中，无法就绪",
		define = "COOPERATION_NO_ALLOW_READY_ADJUST",
		audio = "ban"
	},
	[330005] = {
		id = 330005,
		desc = "当前存在重复角色，无法就绪",
		define = "COOPERATION_NO_ALLOW_READY_REPEAT",
		audio = "ban"
	},
	[330006] = {
		id = 330006,
		desc = "已是好友",
		define = "COOPERATION_ALREADY_FRIEND",
		audio = "ban"
	},
	[330007] = {
		id = 330007,
		desc = "添加好友",
		define = "COOPERATION_ADD_FRIEND",
		audio = "ban"
	},
	[330008] = {
		id = 330008,
		desc = "当前房间已满，无法发送邀请",
		define = "COOPERATION_NO_ALLOW_INVITE_FULL",
		audio = "ban"
	},
	[330009] = {
		id = 330009,
		desc = "已被踢出房间",
		define = "COOPERATION_KICK_OUT",
		audio = "ban"
	},
	[330010] = {
		id = 330010,
		desc = "常驻挑战",
		define = "CHAPTER_CHALLENGE_1",
		audio = "ban"
	},
	[330011] = {
		id = 330011,
		desc = "试玩挑战",
		define = "CHAPTER_CHALLENGE_2",
		audio = "ban"
	},
	[330012] = {
		id = 330012,
		desc = "邀请已过期",
		define = "COOPERATION_INVITE_OVERDUE",
		audio = "ban"
	},
	[330013] = {
		id = 330013,
		desc = "未能在其他玩家进入战斗20秒内加入战斗, 已返回",
		define = "COOPERATION_NOT_JOIN_AFTER_OTHERS_READY",
		audio = "ban"
	},
	[303111] = {
		id = 303111,
		desc = "重构成功，刻印已上锁",
		define = "SIGIL_CLARIFYING_RECONSTRUCTOR_SUCCESS",
		audio = "success"
	},
	[340001] = {
		id = 340001,
		desc = "请先编辑出战队伍",
		define = "SEQUENTIAL_BATTLE_TEAM_IS_NULL",
		audio = "ban"
	},
	[340002] = {
		id = 340002,
		desc = "当前的挑战进度将被重置，是否继续",
		define = "SEQUENTIAL_BATTLE_RESET_STAGE",
		audio = "ban"
	},
	[340003] = {
		id = 340003,
		desc = "所选角色已被%s使用，是否确认将该角色加入当前队伍？",
		define = "HERO_IN_OTHER_TEAM",
		audio = "ban"
	},
	[340004] = {
		id = 340004,
		desc = "保存队伍",
		define = "SAVE_TEAM",
		audio = "ban"
	},
	[340005] = {
		id = 340005,
		desc = "本关至少%s个队伍通关",
		define = "AT_LAST_CNT",
		audio = "ban"
	},
	[340006] = {
		id = 340006,
		desc = "本关所有队伍通关",
		define = "PASS_ALL",
		audio = "ban"
	},
	[340007] = {
		id = 340007,
		desc = "词缀总览",
		define = "BUFF_PREVIEW",
		audio = "ban"
	},
	[340008] = {
		id = 340008,
		desc = "1.需要配置四个队伍分别应对不同的挑战，可以通过点击敌人图鉴查看其主要信息。\n2.根据每个队伍配置的修正者的特性可以激活不同的词缀加成。\n3.挑战中每个队伍会连续进行战斗，未完成的关卡不会保留进度。",
		define = "SEQUENTIAL_BATTLE_DESC",
		audio = "ban"
	},
	[340009] = {
		id = 340009,
		desc = "当前的队伍将被重置，是否继续",
		define = "SEQUENTIAL_BATTLE_RESET_TEAM",
		audio = "ban"
	},
	[340010] = {
		id = 340010,
		desc = "当前队伍变更尚未保存，是否确认退出？",
		define = "SEQUENTIAL_BATTLE_SAVE_TEAM",
		audio = "ban"
	},
	[341001] = {
		id = 341001,
		desc = "1.沿着虚线在纸张上进行裁剪，当裁剪线条闭合时，窗花就完成啦~\n2.裁剪窗花需要一口气完成哦~裁剪过程中离开屏幕将会判定裁剪结束。\n3.窗花完成后会得到一个评分，当评分满足条件后即可领取剪纸奖励。",
		define = "ACTIVITY_CUT_DESCRIPE",
		audio = "ban"
	},
	[341002] = {
		id = 341002,
		desc = [[
1.写春联，是虚恒的传统习俗之一。在两张对称的红纸上作精妙的文字游戏，据说将其贴在门侧，有驱除灾邪的功效。
2.深空之眼的修正者们对春联也产出了极大的兴趣，并邀请管理员一起进行春联创作。
3.管理员给出的不同建议将会创作出不同的下联。春联创作完成后不可修改。
4.春联创作完成即可领取奖励。]],
		define = "ACTIVITY_SPRING_FESTIVAL_COUPLETS_DESCRIPE",
		audio = "ban"
	},
	[341003] = {
		id = 341003,
		desc = "1.适逢虚恒佳节，深空之眼也举办了一场猜灯谜的活动。\n2.若管理员猜对灯谜，可以直接领取灯谜奖励，但今日不能再参与灯谜活动。\n3.若管理员猜错灯谜，需要等待1分钟后才能再次参与灯谜活动。",
		define = "ACTIVITY_SPRING_FESTIVAL_RIDDLE_DESCRIPE",
		audio = "ban"
	},
	[341004] = {
		id = 341004,
		desc = "选择错误，%s分钟后可重新选择",
		define = "ACTIVITY_SPRING_FESTIVAL_RIDDLE_ERROR_CD",
		audio = "ban"
	},
	[341005] = {
		id = 341005,
		desc = "%s后可再次参与灯谜活动",
		define = "ACTIVITY_SPRING_FESTIVAL_RIDDLE_CD",
		audio = "ban"
	},
	[341006] = {
		id = 341006,
		desc = "今日已经获得过灯谜奖励，无法再参与灯谜活动",
		define = "ACTIVITY_SPRING_FESTIVAL_RIDDLE_FINISH",
		audio = "ban"
	},
	[341007] = {
		id = 341007,
		desc = "累计答对%s个灯谜",
		define = "ACTIVITY_SPRING_FESTIVAL_RIDDLE_FINISH_CNT",
		audio = "ban"
	},
	[341008] = {
		id = 341008,
		desc = "「%s」评分达到%s",
		define = "ACTIVITY_CUT_POINT_REWARD",
		audio = "ban"
	},
	[341009] = {
		id = 341009,
		desc = "%s的礼物",
		define = "ACTIVITY_HERO_PRESENT",
		audio = "ban"
	},
	[341010] = {
		id = 341010,
		desc = "制作阶段",
		define = "ACTIVITY_FIRE_WORK_PHASE",
		audio = "ban"
	},
	[341011] = {
		id = 341011,
		desc = [[
1.全服玩家共同攻略「夕」，成功通关可以获得一定数量的「暮玉」，可用于在「琳琅商行」兑换奖励。
2.管理员可获得的「暮玉」有数量上限，「暮玉」的总获取上限会随时间提升。
3.「夕」存在期间，每天会刷新不同的增益词缀。
4.全服玩家攻略「夕」至剩余血量到达75%、50%、25%、0%时，可领取对应阶段奖励。
5.玩家每日首次通关可额外获得一定数量的「暮玉」。
6.成功击败「夕」后可以进行追击，完成追击同样可以获得「暮玉」。]],
		define = "ACTIVITY_SPRING_FESTIVAL_MONSTER_DESCRIPE",
		audio = "ban"
	},
	[341012] = {
		id = 341012,
		desc = "暂时无法参与灯谜活动",
		define = "ACTIVITY_SPRING_FESTIVAL_RIDDLE_BAN",
		audio = "ban"
	},
	[345001] = {
		id = 345001,
		desc = "1.隐科组希望针对各原质区的特定战斗数据进行收集，需要各位修正者的帮助。\n2.修正者的机制值（怒气、能量、印记、神能）获取率提升。\n3.管理员每次通关集成研析中任意关卡，将获得一定数量的「数据存储管」，可前往战略储藏室中兑换所需道具。",
		define = "ACTIVITY_INTEGRATE_PT_DESC",
		audio = "ban"
	},
	[345002] = {
		id = 345002,
		desc = [[
1.这是只属于我和诗蔻蒂的，平和宁静的时光。
2.管理员需要为诗蔻蒂安排本次出游的行程，为诗蔻蒂选择出游的地点和本次出游携带的物品。
3.出游结束后，诗蔻蒂会将本次出游发生的故事记录下来。
4.出游会提升诗蔻蒂的见闻。
5.当诗蔻蒂的见闻满足一定条件且收录指定的出游事件后，可以开启珍藏回忆。
6.2022/12/22/05:00-2023/1/12/05:00期间，诗蔻蒂出游后将在05:00返回。此后诗蔻蒂在出游后将会立即返回。]],
		define = "TRAVEL_SKULD_DESCRIPE",
		audio = "ban"
	},
	[345003] = {
		id = 345003,
		desc = "回忆",
		define = "TIP_MEMORY",
		audio = "ban"
	},
	[345004] = {
		id = 345004,
		desc = "好奇",
		define = "TIP_CURIOSITY",
		audio = "ban"
	},
	[345005] = {
		id = 345005,
		desc = "心情",
		define = "TIP_MOOD",
		audio = "ban"
	},
	[345006] = {
		id = 345006,
		desc = "认知",
		define = "TIP_COGNITION",
		audio = "ban"
	},
	[345007] = {
		id = 345007,
		desc = "需要",
		define = "TIP_NEED",
		audio = "ban"
	},
	[345008] = {
		id = 345008,
		desc = "开启%s个珍藏回忆",
		define = "TRAVEL_SKULD_ENDING_OPEN",
		audio = "ban"
	},
	[345009] = {
		id = 345009,
		desc = "收录%s个出游事件",
		define = "TRAVEL_SKULD_STORY_GET",
		audio = "ban"
	},
	[345010] = {
		id = 345010,
		desc = "1.源层深处的镜像因骸能波动而实体化，凝视镜中的自己，只有击败内心黑暗的强者才能通过试炼。\n2.管理员可以使用试用修正者进行挑战。\n3.在极难难度下，只能使用试用修正者进行挑战。",
		define = "ACTIVITY_DEMON_CHALLENGE_DESCRIPE_121031",
		audio = "ban"
	},
	[345011] = {
		id = 345011,
		desc = "静  电",
		define = "THOR_STRATEGY_TITLE_1",
		audio = "ban"
	},
	[345012] = {
		id = 345012,
		desc = "雷  鸣",
		define = "THOR_STRATEGY_TITLE_2",
		audio = "ban"
	},
	[345013] = {
		id = 345013,
		desc = "流  霆",
		define = "THOR_STRATEGY_TITLE_3",
		audio = "ban"
	},
	[345014] = {
		id = 345014,
		desc = "弧  光",
		define = "THOR_STRATEGY_TITLE_4",
		audio = "ban"
	},
	[345015] = {
		id = 345015,
		desc = [[
托尔通过权钥的雷霆之力收集来的源层数据，她把收集来的数据交给海姆达尔进行分析。
艾因索菲今日骸震频发，深空之眼目前所有没外出任务的小队成员都被派出巡逻。而东城区是由雷小队负责。
1.角色属性为系统设定值。
2.地图探索模式中多分支可供选择，管理员可自由决定前进路线。
3.经历每次事件后「托尔」的当前生命值将会在结算后继承至下一事件。
4.每次完成战斗事件后「托尔」将恢复20%基础生命值。]],
		define = "ACTIVITY_THOR_STRATEGY_MATRIX_DESCRIBE",
		audio = "ban"
	},
	[345016] = {
		id = 345016,
		desc = "请先观看前置剧情-「%s」",
		define = "FIRE_WORK_LOCK_STORY",
		audio = "ban"
	},
	[345017] = {
		id = 345017,
		desc = "「出游日记」的全部珍藏回忆收集完成后开启",
		define = "TRAVEL_SKULD_COLLECT_ALL_PHOTO",
		audio = "ban"
	},
	[345018] = {
		id = 345018,
		desc = "通关%s个心魔的普通难度",
		define = "DEMON_CLEAR_NORMAL_DIFFICULTY",
		audio = "ban"
	},
	[345019] = {
		id = 345019,
		desc = "通关%s个心魔的困难难度",
		define = "DEMON_CLEAR_DIFFICULTY",
		audio = "ban"
	},
	[345020] = {
		id = 345020,
		desc = "通关%s个心魔的极限难度",
		define = "DEMON_CLEAR_EXTREME_DIFFICULTY",
		audio = "ban"
	},
	[345021] = {
		id = 345021,
		desc = "1.源层深处的镜像因骸能波动而实体化，凝视镜中的自己，只有击败内心黑暗的强者才能通过试炼。\n2.管理员可以使用试用修正者进行挑战。\n3.在极难难度下，只能使用试用修正者进行挑战。",
		define = "ACTIVITY_DEMON_CHALLENGE_DESCRIPE_121841",
		audio = "ban"
	},
	[345022] = {
		id = 345022,
		desc = "收录事件「%s」",
		define = "TRAVEL_SKULD_STORY_GET_INFINAL",
		audio = "ban"
	},
	[345023] = {
		id = 345023,
		desc = "请先观看前置剧情-「%s」",
		define = "ACTIVITY_WORLD_BOSS_LOCK_STORY",
		audio = "ban"
	},
	[345024] = {
		id = 345024,
		desc = "通关「普通模式」解锁",
		define = "THOR_STRATEGY_UNLOCK",
		audio = "ban"
	},
	[345025] = {
		id = 345025,
		desc = "该出游事件已被收录，是否确认出游？",
		define = "TRAVEL_SKULD_STORY_GETTED",
		audio = "ban"
	},
	[346001] = {
		id = 346001,
		desc = "设置成功",
		define = "SET_CONFIRMED",
		audio = "success"
	},
	[346002] = {
		id = 346002,
		desc = "设置的插图数量超出上限",
		define = "SET_FAILED",
		audio = "ban"
	},
	[346003] = {
		id = 346003,
		desc = "是否恢复默认设置",
		define = "CONFIRM_RESET",
		audio = "ban"
	},
	[346004] = {
		id = 346004,
		desc = "设置“%s”为过场插图，当前过场图%s",
		define = "SET_CONFIRMED_2",
		audio = "ban"
	},
	[346005] = {
		id = 346005,
		desc = "已设置“%s”为过场插图，当前过场图%s",
		define = "REMOVE_CONFIRMED",
		audio = "ban"
	},
	[347001] = {
		id = 347001,
		desc = "请先设置【展示%s】",
		define = "STICKER_SETUP",
		audio = "ban"
	},
	[347101] = {
		id = 347101,
		desc = [[
1.焰境清扫关卡中，需要通过清除不断出现的敌人获取积分，根据结算时的最高分领取相应的关卡奖励。
2.在本玩法中，每关都会为修正者提供一定的基础增益。击败一定数量的敌人会获得一次强化效果，每次获得强化效果都会令下次获得强化效果时产生一层额外增益，直至获得全部增益效果。
3.每关限时180秒，达到时间限制或于关卡内击杀数到达300时，将会进入结算环节。
4.只能选择一名修正者进入挑战。]],
		define = "ACTIVITY_SOLO_SLAYER_DESCRIPE",
		audio = "ban"
	},
	[347102] = {
		id = 347102,
		desc = "1.和修正者一起来参加弥芙尔组织的默契大考验活动吧~\n2.面对弥芙尔的提问，管理员和修正者能否做出相同的选择，就可以知道管理员和修正者的默契程度啦~\n3.完成默契测试即可领取弥芙尔准备的奖励。",
		define = "ACTIVITY_VALENTINE_DESCRIPE",
		audio = "ban"
	},
	[347103] = {
		id = 347103,
		desc = "提问",
		define = "TIP_QUESTION",
		audio = "ban"
	},
	[347104] = {
		id = 347104,
		desc = "感同身受",
		define = "ACTIVITY_VALENTINE_RESULT_TITLE_1",
		audio = "ban"
	},
	[347105] = {
		id = 347105,
		desc = "心心相印",
		define = "ACTIVITY_VALENTINE_RESULT_TITLE_2",
		audio = "ban"
	},
	[347106] = {
		id = 347106,
		desc = "天作之合",
		define = "ACTIVITY_VALENTINE_RESULT_TITLE_3",
		audio = "ban"
	},
	[347107] = {
		id = 347107,
		desc = "选择中",
		define = "TIP_SELECTING",
		audio = "ban"
	},
	[347108] = {
		id = 347108,
		desc = "选择完成",
		define = "TIP_SELECT_OVER",
		audio = "ban"
	},
	[347109] = {
		id = 347109,
		desc = "1.在熊熊烈火焚烧塔列朗家族宅邸之际，承载了有关塔列朗家族历代受他人诅咒的诡秘碎片——炼狱残片亦淹没于火海秘境之中，提尔为了探寻灾祸根源，在令人窒息的簇簇火焰之间穿梭……\n2.不同的秘境中存在不同的秘境效果，可以为对应战斗方式的修正者提供一定的战斗加成。\n3.管理员每次通关咒怨秘辛中任意关卡，将获得一定数量的「炼狱残片」，可前往塔列朗贸易所中兑换所需道具。",
		define = "ACTIVITY_TYR_PT_DESC",
		audio = "ban"
	},
	[347110] = {
		id = 347110,
		desc = "1.可以通过调整系统参数来增强敌人，限制自身，创造高强度训练环境。\n2.完成挑战时会记录获得的最高分数。逆限模拟的排行榜会在每个小时更新一次。\n3.挑战积分由挑战过程中队长受到的伤害值、挑战耗时以及挑战难度共同决定。",
		define = "ACTIVITY_1_7_LIMITED_CALCULATION_DESCRIPE",
		audio = "ban"
	},
	[347111] = {
		id = 347111,
		desc = "和%s一起完成默契测试",
		define = "ACTIVITY_VALENTINE_REWARD_NEED_DESC",
		audio = "ban"
	},
	[347112] = {
		id = 347112,
		desc = [[
1.进行训练挑战时，可以选择不同的条件来增加训练难度，同时也会增加训练完成后可获得的积分。
2.每个训练挑战需要面对的敌人都会存在一个弱点，针对弱点调整出战队伍的配置可以使作战更为顺利。
3.训练完成即可领取首通奖励。
4.每个训练挑战只会记录完成时获得的最高积分，根据全部训练挑战的累计积分可以领取积分奖励。]],
		define = "AFFIX_SELECT_HELP",
		audio = "ban"
	},
	[348001] = {
		id = 348001,
		desc = [[
1.「异象压制」分为「商道清理」、「高危委托」、「若木苦修」。
2.挑战「商道清理」和「高危委托」中的关卡，将获得一定数量的「通达商券」，可前往天禄商号中兑换所需道具。
3.挑战「商道清理」中的关卡需要消耗吨吨值。
4.挑战「高危委托」中的关卡需要消耗若木一念，若木一念可以通过完成活动任务或在天禄商号中购买获得。
5.「高危委托」中的「尘念」关卡，难度相比「俗心」关卡较高，可获得的「通达商券」也更多。
6.在规定时间内通关「高危委托」中的「尘念」关卡，可以解锁「若木苦修」中的「克己」关卡。
7.挑战「克己」关卡会根据通关时间获得评分，完成挑战时会记录获得的最高积分并进行排名。]],
		define = "ACTIVITY_XUHENG_PT_DESCRIBE",
		audio = "ban"
	},
	[348002] = {
		id = 348002,
		desc = "%s秒内通关「%s」解锁",
		define = "ACTIVITY_XUHENG_PT_EXLOCK",
		audio = "ban"
	},
	[348003] = {
		id = 348003,
		desc = [[
1.完成活动任务可以领取「锤炼之证」。
2.每日任务评分达到100时可以领取「锤炼之证」，每日任务评分奖励每天5：00刷新。
3.拥有的「锤炼之证」数量达到要求时，可以领取当前阶段的培养奖励。
4.培养奖励有多个阶段，领取当前阶段的培养奖励后会解锁下一阶段。]],
		define = "CULTIVATE_HERO_DESC",
		audio = "ban"
	},
	[348004] = {
		id = 348004,
		desc = "完成养成任务和达成每日任务评分要求可以获得「锤炼之证」，累计「锤炼之证」可以领取丰厚奖励。",
		define = "CULTIVATE_HERO_CONTENT",
		audio = "ban"
	},
	[348005] = {
		id = 348005,
		desc = "阶段%s",
		define = "CULTIVATE_HERO_REWARD",
		audio = "ban"
	},
	[348006] = {
		id = 348006,
		desc = "第%s张「烛照名帖」已解锁",
		define = "XH1ST_SEAL_UNLOCK_NEXT_TICKET_TIP",
		audio = "ban"
	},
	[348007] = {
		id = 348007,
		desc = "完成第%s张「烛照名帖」后解锁",
		define = "XH1ST_SEAL_NOT_UNLOCK_TIP",
		audio = "ban"
	},
	[348008] = {
		id = 348008,
		desc = "获取主要奖励后可重置",
		define = "XH1ST_SEAL_NOT_MAIN_REWARD_TIP",
		audio = "ban"
	},
	[348009] = {
		id = 348009,
		desc = [[
1.完成活动任务可以获得「百解明玺」。
2.每张「烛照名帖」有9个位置可以盖章，使用「百解明玺」会随机选择1个位置进行盖章。
3.当3个有盖章的位置连成一条直线时，可以获得对应的连线奖励。
4.每张「烛照名帖」有8个连线奖励，其中一个为主要奖励。
5.共有5张「烛照名帖」，获得每张「烛照名帖」的主要奖励时，会解锁下一张「烛照名帖」。
6.当获得第5张「烛照名帖」的主要奖励时，可以对第5张「烛照名帖」的全部奖励进行重置。]],
		define = "XH1ST_SEAL_DESC",
		audio = "ban"
	},
	[348010] = {
		id = 348010,
		desc = "哟？这位客官，何不进来玩上几把？用「百解明玺」在「烛照名帖」上盖章，奖励多多哦！",
		define = "XH1ST_SEAL_CONTENT",
		audio = "ban"
	},
	[348011] = {
		id = 348011,
		desc = "当前「烛照名帖」已完成",
		define = "XH1ST_SEAL_TICKET_FINISH_TIP",
		audio = "ban"
	},
	[348012] = {
		id = 348012,
		desc = "主线",
		define = "MAIN_PLOT_TEXT",
		audio = "ban"
	},
	[348013] = {
		id = 348013,
		desc = "支线",
		define = "SUB_PLOT_TEXT",
		audio = "ban"
	},
	[348014] = {
		id = 348014,
		desc = "1.共有5个活动任务，活动任务的开启时间不同。\n2.每完成一个活动任务可以获得1个「开禧元宝」。\n3.使用4个「开禧元宝」可以兑换修正者「十曜·金乌」。",
		define = "ANNIVERSARY_INFO",
		audio = "ban"
	},
	[348015] = {
		id = 348015,
		desc = "%s后",
		define = "LATER",
		audio = "ban"
	},
	[348016] = {
		id = 348016,
		desc = "1.活动期间完成活动任务，可以获得「蝶落梅」。\n2.前往「玲珑瑰藏」可以使用「蝶落梅」兑换所需道具。",
		define = "DRAW_FEEDBACK_INFO",
		audio = "ban"
	},
	[348017] = {
		id = 348017,
		desc = "通关主线章节「%s」后开启",
		define = "ACTIVITY_XUHENG_PT_LOCK",
		audio = "ban"
	},
	[349001] = {
		id = 349001,
		desc = "该召回码使用次数已达上限",
		define = "RECALLED_CODE_LIMIT",
		audio = "ban"
	},
	[349002] = {
		id = 349002,
		desc = "请填写正确的召回码",
		define = "RECALLED_CODE_ERROR",
		audio = "ban"
	},
	[349003] = {
		id = 349003,
		desc = [[
1.为了激励新人的活跃表现，本大人给你特别开放了私库。不要告诉其他人噢！——弥弥尔。
2.开启条件：35级及以上全体管理员。
3.活动期间，管理员可分享召回码，被召回管理员填写召回码后，双方均可获得奖励。
4.管理员完成召回任务可领取「猫爪币」。
5.成功召回管理员，可领取「移转之辉」和「猫爪币」。
6.「猫爪币」可用于在猫咪黑市兑换奖励。
7.被召回管理员：等级≥35级，且最后一次登录时间距离活动开启时间≥14天的管理员。
8.每位被召回管理员，仅可填写一次召回码，领取一次回归奖励。
9.每枚召回码有效使用次数为10次。]],
		define = "RECALLED_DESC",
		audio = "ban"
	},
	[349004] = {
		id = 349004,
		desc = "邀请%d位",
		define = "RECALLED_INVITE",
		audio = "ban"
	},
	[350001] = {
		id = 350001,
		desc = "货币不足",
		define = "ITEM_NOT_ENOUGH_RETURN_MATERIAL",
		audio = "ban"
	},
	[350002] = {
		id = 350002,
		desc = "累计获得",
		define = "RETURN_MATERIAL_MAX_POINT",
		audio = "ban"
	},
	[350003] = {
		id = 350003,
		desc = "欢迎回家，快来试试转转扭蛋的新福利吧~",
		define = "REGRESSION_GASHAPON_DESCRIPE",
		audio = "ban"
	},
	[350004] = {
		id = 350004,
		desc = "活动当前未开启",
		define = "REGRESSION_JUMP",
		audio = "ban"
	},
	[350005] = {
		id = 350005,
		desc = "完成签到可获得精准探测凭证奖励！",
		define = "REGRESSION_SIGN_DESCRIPE",
		audio = "ban"
	},
	[350006] = {
		id = 350006,
		desc = "抽取%d次",
		define = "REGRESSION_GASHAPON_EXTRACT",
		audio = "ban"
	},
	[350007] = {
		id = 350007,
		desc = [[
<color=#48372b>上次和你相聚的日子是「%s」，你不在的日子里，我们很想念你~</color>

<color=#48372b>啊对了，管理员可以来参加我们今晚
举办的睡衣派对吗？</color>

<color=#48372b>你不在的「%s天」里发生的事情，
好想告诉你！
</color>

<color=#48372b>                                 序小队</color>]],
		define = "REGRESSION_GIFT_DESCRIPE",
		audio = "ban"
	},
	[351001] = {
		id = 351001,
		desc = "已经在进行%d阶层的挑战，无法重置本阶层的区域",
		define = "ABYSS_STAGE_CHALLENGING_RESET_TIP",
		audio = "ban"
	},
	[351002] = {
		id = 351002,
		desc = "是否重置当前区域，区域状态以及锁定或休整中的修正者将被重置，剩余区域重置次数%d/%d",
		define = "ABYSS_STAGE_RESET_TIP",
		audio = "ban"
	},
	[351003] = {
		id = 351003,
		desc = "当前区域已重置",
		define = "ABYSS_RESET_STAGE_FINISH_TIP",
		audio = "ban"
	},
	[351004] = {
		id = 351004,
		desc = "已经在进行%d阶层的挑战，无法重置本阶层的区域",
		define = "ABYSS_LAYER_CHALLENGING_RESET_TIP",
		audio = "ban"
	},
	[351005] = {
		id = 351005,
		desc = "是否重置当前阶层，阶层内所有区域状态以及锁定或休整中的修正者将被重置，剩余阶层重置次数%d/%d",
		define = "ABYSS_LAYER_RESET_TIP",
		audio = "ban"
	},
	[351006] = {
		id = 351006,
		desc = "当前阶层的所有区域已重置",
		define = "ABYSS_RESET_LAYER_FINISH_TIP",
		audio = "ban"
	},
	[351007] = {
		id = 351007,
		desc = "深阱%d阶",
		define = "ABYSS_LAYER_LABEL",
		audio = "ban"
	},
	[351008] = {
		id = 351008,
		desc = [[
1.「失序深阱」每阶深度中包含不同区域关卡，完成所有区域关卡则可以解锁后续阶层。
2.成功挑战区域关卡的修正者会被锁定，锁定的修正者无法再挑战同一阶层内的其他区域关卡。
3.挑战Ω区域关卡时，可以选择是否保留战斗结果，如果保留则目标血量会被记录，并且使用的修正者会进入休整状态。
4.休整状态的修正者无法在后续任意阶层的关卡中使用。
5.如果成功挑战Ω区域关卡，则使用的修正者不会进入休整状态，但会被锁定，无法再挑战同一阶层的其他区域关卡。
6.成功挑战Ω区域关卡时，会根据使用的所有队伍的完成时间之和得出关卡成绩，非Ω区域关卡通关后的成绩为固定值。
7.阶层总成绩为阶层内所有区域成绩总和。
8.「失序深阱」每次刷新后所有阶层均会重置，其中处于锁定或休整状态的修正者也会重置。
9.排行榜中将记录完成的最高阶层以及阶层总成绩，即便进行过阶层重置也只会以最高记录保留。
10.当前挑战的阶层或区域均可以手动进行重置，因该阶层完成而解锁的后续阶层会在该阶层重置后重新锁定，重置具有次数限制，每日05:00重置次数会恢复1次。]],
		define = "ABYSS_DESC",
		audio = "ban"
	},
	[351009] = {
		id = 351009,
		desc = "完成深阱%d阶或以上阶层",
		define = "ABYSS_LAYER_AWARD_TIP",
		audio = "ban"
	},
	[351010] = {
		id = 351010,
		desc = "阶层重置次数不足",
		define = "ABYSS_LAYER_RESET_CLICK_TIP",
		audio = "ban"
	},
	[351011] = {
		id = 351011,
		desc = "关卡重置次数不足",
		define = "ABYSS_STAGE_RESET_CLICK_TIP",
		audio = "ban"
	},
	[351012] = {
		id = 351012,
		desc = "深阱%d阶后的关卡已重置为锁定状态",
		define = "ABYSS_BACK_TIP",
		audio = "ban"
	},
	[351013] = {
		id = 351013,
		desc = "完成深阱%d阶",
		define = "ABYSS_LAYER_MAX_AWARD_TIP",
		audio = "ban"
	},
	[351014] = {
		id = 351014,
		desc = "目标血量",
		define = "ABYSS_BATTLE_FAIL_TIP",
		audio = "ban"
	},
	[352001] = {
		id = 352001,
		desc = "第%d天",
		define = "ACTIVITY_GREENHORN_TASK_STAGE",
		audio = "ban"
	},
	[352002] = {
		id = 352002,
		desc = "完成新手报到后开放",
		define = "ACTIVITY_SIGN_OPEN",
		audio = "ban"
	},
	[352003] = {
		id = 352003,
		desc = "首充福利",
		define = "ACTIVITY_FIRST_CHARGE",
		audio = "ban"
	},
	[352004] = {
		id = 352004,
		desc = "观测赠礼",
		define = "ACTIVITY_FIRST_MONTHLY_CARD",
		audio = "ban"
	},
	[352005] = {
		id = 352005,
		desc = "合约福利",
		define = "ACTIVITY_FIRST_CONTRACT",
		audio = "ban"
	},
	[352006] = {
		id = 352006,
		desc = "该阶段任务将在%d天后开放",
		define = "ACTIVITY_FIRST_UNLOCK_PROMPT",
		audio = "ban"
	},
	[352007] = {
		id = 352007,
		desc = "首充%d元",
		define = "ACTIVITY_FIRST_PRICE",
		audio = "ban"
	},
	[353000] = {
		id = 353000,
		desc = "外勤演练",
		define = "ADVANCED_TASK_BATTLE",
		audio = "ban"
	},
	[353001] = {
		id = 353001,
		desc = "黑区净化",
		define = "ADVANCED_TASK_BATTLE_MYTHIC",
		audio = "ban"
	},
	[353002] = {
		id = 353002,
		desc = "梦境再构",
		define = "ADVANCED_TASK_BATTLE_BOSS",
		audio = "ban"
	},
	[353003] = {
		id = 353003,
		desc = "失序深阱",
		define = "ADVANCED_TASK_BATTLE_ABYSS",
		audio = "ban"
	},
	[353004] = {
		id = 353004,
		desc = "多维变量",
		define = "ADVANCED_TASK_BATTLE_POLYHEDRON",
		audio = "ban"
	},
	[353005] = {
		id = 353005,
		desc = "因果观测",
		define = "ADVANCED_TASK_BATTLE_CHESS",
		audio = "ban"
	},
	[353006] = {
		id = 353006,
		desc = "历战轮回",
		define = "ADVANCED_TASK_BATTLE_TOWER",
		audio = "ban"
	},
	[353007] = {
		id = 353007,
		desc = "联合攻坚",
		define = "ADVANCED_TASK_BATTLE_GUILDBOSS",
		audio = "ban"
	},
	[353100] = {
		id = 353100,
		desc = "协作规划",
		define = "ADVANCED_TASK_CULTURE",
		audio = "ban"
	},
	[353101] = {
		id = 353101,
		desc = "技能提升",
		define = "ADVANCED_TASK_CULTURE_SKILL",
		audio = "ban"
	},
	[353102] = {
		id = 353102,
		desc = "权钥强化",
		define = "ADVANCED_TASK_CULTURE_WEAPON",
		audio = "ban"
	},
	[353103] = {
		id = 353103,
		desc = "刻印强化",
		define = "ADVANCED_TASK_CULTURE_EQUIP",
		audio = "ban"
	},
	[353104] = {
		id = 353104,
		desc = "神格解锁",
		define = "ADVANCED_TASK_CULTURE_ASTROLABE",
		audio = "ban"
	},
	[353105] = {
		id = 353105,
		desc = "跃迁提升",
		define = "ADVANCED_TASK_CULTURE_EXCLUSIVE",
		audio = "ban"
	},
	[354000] = {
		id = 354000,
		desc = "斗争",
		define = "POLYHEDRON_TERMINAL_CLASSIFY_1",
		audio = "ban"
	},
	[354001] = {
		id = 354001,
		desc = "庇护",
		define = "POLYHEDRON_TERMINAL_CLASSIFY_2",
		audio = "ban"
	},
	[354002] = {
		id = 354002,
		desc = "宝物",
		define = "POLYHEDRON_TERMINAL_CLASSIFY_3",
		audio = "ban"
	},
	[354003] = {
		id = 354003,
		desc = "生存根本",
		define = "POLYHEDRON_ARTIFACT_SUB_TYPE_3001",
		audio = "ban"
	},
	[354004] = {
		id = 354004,
		desc = "惑山五本",
		define = "POLYHEDRON_ARTIFACT_SUB_TYPE_3002",
		audio = "ban"
	},
	[354005] = {
		id = 354005,
		desc = "艺术美学",
		define = "POLYHEDRON_ARTIFACT_SUB_TYPE_3003",
		audio = "ban"
	},
	[354006] = {
		id = 354006,
		desc = "迅急速递",
		define = "POLYHEDRON_ARTIFACT_SUB_TYPE_3004",
		audio = "ban"
	},
	[354007] = {
		id = 354007,
		desc = "财富秘钥",
		define = "POLYHEDRON_ARTIFACT_SUB_TYPE_3005",
		audio = "ban"
	},
	[354008] = {
		id = 354008,
		desc = "万象寓于",
		define = "POLYHEDRON_ARTIFACT_SUB_TYPE_3006",
		audio = "ban"
	},
	[354009] = {
		id = 354009,
		desc = "专属记忆珍宝",
		define = "POLYHEDRON_ARTIFACT_SUB_TYPE_3007",
		audio = "ban"
	},
	[354010] = {
		id = 354010,
		desc = "天赋点数不足，无法激活天赋",
		define = "POLYHEDRON_TERMINAL_LACK_POINT",
		audio = "ban"
	},
	[354011] = {
		id = 354011,
		desc = "天赋激活成功",
		define = "POLYHEDRON_TERMINAL_UNLOCK_SUCCESS",
		audio = "success"
	},
	[354012] = {
		id = 354012,
		desc = "多维终端等级达到%d级后解锁",
		define = "POLYHEDRON_TERMINAL_LEVEL_UNLOCK",
		audio = "ban"
	},
	[354013] = {
		id = 354013,
		desc = "激活任意相邻天赋后解锁",
		define = "POLYHEDRON_TERMINAL_GIFT_UNLCOK",
		audio = "ban"
	},
	[354014] = {
		id = 354014,
		desc = "确认后将重置所有天赋并返还全部天赋点数，是否继续？",
		define = "POLYHEDRON_RESET_TERMINAL_GIFT",
		audio = "ban"
	},
	[354015] = {
		id = 354015,
		desc = "天赋点数+%s",
		define = "POLYHEDRON_TERMINAL_LEVEL_POINT",
		audio = "ban"
	},
	[354016] = {
		id = 354016,
		desc = "多维信标解锁成功",
		define = "POLYHEDRON_BEACON_UNLOCK_SUCCESS",
		audio = "success"
	},
	[354017] = {
		id = 354017,
		desc = "是否确认解锁该角色？",
		define = "POLYHEDRON_UNLOCK_HERO_TIP",
		audio = "ban"
	},
	[354018] = {
		id = 354018,
		desc = "解锁成功",
		define = "POLYHEDRON_UNLOCK_HERO_SUCCESS",
		audio = "success"
	},
	[354019] = {
		id = 354019,
		desc = "%s加成%s",
		define = "POLYHEDRON_DIFFICULTY_HERO_ATTRIBUTE_DES",
		audio = "ban"
	},
	[354020] = {
		id = 354020,
		desc = "开始挑战",
		define = "POLYHEDRON_LOBBY_BUTTON_START",
		audio = "ban"
	},
	[354021] = {
		id = 354021,
		desc = "继续挑战",
		define = "POLYHEDRON_LOBBY_BUTTON_CONTINUE",
		audio = "ban"
	},
	[354022] = {
		id = 354022,
		desc = "当前存在尚未结束的战局，是否继续？",
		define = "POLYHEDRON_LOBBY_START_TIP",
		audio = "ban"
	},
	[354023] = {
		id = 354023,
		desc = "退出结算",
		define = "POLYHEDRON_LOBBY_SETTLEMENT",
		audio = "ban"
	},
	[354024] = {
		id = 354024,
		desc = "珍宝选择",
		define = "POLYHEDRON_REWARD_TITLE_ARTIFACT",
		audio = "ban"
	},
	[354025] = {
		id = 354025,
		desc = "珍宝升级选择",
		define = "POLYHEDRON_REWARD_TITLE_ARTIFACT_UP",
		audio = "ban"
	},
	[354026] = {
		id = 354026,
		desc = "金币奖励",
		define = "POLYHEDRON_REWARD_TITLE_COIN",
		audio = "ban"
	},
	[354027] = {
		id = 354027,
		desc = "角色奖励",
		define = "POLYHEDRON_REWARD_TITLE_ROLE",
		audio = "ban"
	},
	[354028] = {
		id = 354028,
		desc = "道具奖励",
		define = "POLYHEDRON_REWARD_TITLE_EFFECT",
		audio = "ban"
	},
	[354029] = {
		id = 354029,
		desc = "道具奖励",
		define = "POLYHEDRON_REWARD_TITLE_BLOOD",
		audio = "ban"
	},
	[354030] = {
		id = 354030,
		desc = "队员已满",
		define = "POLYHEDRON_TEAM_SET_FULL",
		audio = "ban"
	},
	[354031] = {
		id = 354031,
		desc = "队员死亡无法上阵",
		define = "POLYHEDRON_TEAM_SET_DEAD",
		audio = "ban"
	},
	[354032] = {
		id = 354032,
		desc = "专属珍宝",
		define = "POLYHEDRON_ARTIFACT_TITLE_1",
		audio = "ban"
	},
	[354033] = {
		id = 354033,
		desc = "通用珍宝",
		define = "POLYHEDRON_ARTIFACT_TITLE_2",
		audio = "ban"
	},
	[354034] = {
		id = 354034,
		desc = "通过Lv%s难度后解锁",
		define = "POLYHEDRON_DIFFICULTY_UNLOCK",
		audio = "ban"
	},
	[354035] = {
		id = 354035,
		desc = "多维信标选中已经到达上限",
		define = "POLYHEDRON_SELECT_BEACON_MAX",
		audio = "ban"
	},
	[354036] = {
		id = 354036,
		desc = "激活终端<color=#FF9500>资源调度</color>天赋后可携带信标",
		define = "POLYHEDRON_SELECT_BEACON_EMPTY",
		audio = "ban"
	},
	[354037] = {
		id = 354037,
		desc = "眼前的人并不相信你有能力可以深入探索，向对方证明自己。",
		define = "POLYHEDRON_INTERACTIVE_HERO_DES_1",
		audio = "ban"
	},
	[354038] = {
		id = 354038,
		desc = "消耗%s喵喵宝藏币，聘请对方与之同行。",
		define = "POLYHEDRON_INTERACTIVE_HERO_DES_2",
		audio = "ban"
	},
	[354039] = {
		id = 354039,
		desc = "对方的目光很友善，直接邀请对方与你同行。",
		define = "POLYHEDRON_INTERACTIVE_HERO_DES_3",
		audio = "ban"
	},
	[354040] = {
		id = 354040,
		desc = "准备战斗",
		define = "POLYHEDRON_INTERACTIVE_HERO_TITLE_1",
		audio = "ban"
	},
	[354041] = {
		id = 354041,
		desc = "聘请",
		define = "POLYHEDRON_INTERACTIVE_HERO_TITLE_2",
		audio = "ban"
	},
	[354042] = {
		id = 354042,
		desc = "邀请同行",
		define = "POLYHEDRON_INTERACTIVE_HERO_TITLE_3",
		audio = "ban"
	},
	[354043] = {
		id = 354043,
		desc = "你的诚意无法打动对方。",
		define = "POLYHEDRON_INTERACTIVE_HERO_FAIL",
		audio = "ban"
	},
	[354044] = {
		id = 354044,
		desc = "进入商店购买商品",
		define = "POLYHEDRON_INTERACTIVE_SHOP_DES",
		audio = "ban"
	},
	[354045] = {
		id = 354045,
		desc = "前往补给",
		define = "POLYHEDRON_INTERACTIVE_SHOP_TITLE",
		audio = "ban"
	},
	[354046] = {
		id = 354046,
		desc = "获得%s枚喵喵宝藏币",
		define = "POLYHEDRON_SHOP_GIVE_UP",
		audio = "ban"
	},
	[354047] = {
		id = 354047,
		desc = "复活点数+%s",
		define = "POLYHEDRON_RESURRECTION_TIMES",
		audio = "ban"
	},
	[354048] = {
		id = 354048,
		desc = "%s等级+%s",
		define = "POLYHEDRON_TREASURE_LEVEL",
		audio = "ban"
	},
	[354049] = {
		id = 354049,
		desc = "厉攻",
		define = "POLYHEDRON_ATTACK",
		audio = "ban"
	},
	[354050] = {
		id = 354050,
		desc = "敌方单位的攻击力提高",
		define = "POLYHEDRON_ATTACK_DESCRIBE",
		audio = "ban"
	},
	[354051] = {
		id = 354051,
		desc = "扼守",
		define = "POLYHEDRON_DEFENSE",
		audio = "ban"
	},
	[354052] = {
		id = 354052,
		desc = "敌方单位的防御力提高",
		define = "POLYHEDRON_DEFENSE_DESCRIBE",
		audio = "ban"
	},
	[354053] = {
		id = 354053,
		desc = "气盛",
		define = "POLYHEDRON_LIFE",
		audio = "ban"
	},
	[354054] = {
		id = 354054,
		desc = "敌方单位的生命值提高",
		define = "POLYHEDRON_LIFE_DESCRIBE",
		audio = "ban"
	},
	[354055] = {
		id = 354055,
		desc = "全队恢复自身<color=#FF9500>%s</color>的血量。",
		define = "POLYHEDRON_HP_REWARD_TIP",
		audio = "ban"
	},
	get_id_list_by_define = {
		210105,
		80022,
		120022,
		60166,
		TIP_SELECT = 70008,
		ERROR_USER_HAS_JOINED_OTHER_CLUB = 6039,
		NO_RECORD = 70081,
		ERROR_TEAMS_NOT_MATCH = 3506,
		ERROR_FUNCTION_STOP = 17,
		ERROR_DATABASE = 100,
		ERROR_NO_UNLOCK_INBETWEENING = 3201,
		ERROR_CLUB_RECEIVE_REQUEST_MAX = 6002,
		ERROR_LOGIN_SERVER_MAINTAIN = 1004,
		HERO_LEVEL_LIMIT_UP = 70011,
		AUGUST = 71709,
		ACTIVITY_CLUB_ACTIVITYING_REMOVE_MEMBER_TIP = 300116,
		ACTIVITY_HELLA_TOWER_DESCRIPE = 230001,
		DEMON_CLEAR_EXTREME_DIFFICULTY = 345020,
		MATRIX_SELECT_TEAM = 160007,
		ERROR_CLUB_CHAIRMAN_CAN_NOT_QUIT = 6023,
		ERROR_MATRIX_POINT_REWRAD_NO_TEMPLATE = 6518,
		WEEKS_IN_TOTAL = 71605,
		ERROR_ITEM_CURRENCY_OVER_LIMIT = 2108,
		ERROR_FRIEND_RECOMMEND_FRIEND_LIMIT = 2412,
		ERROR_CLUB_REWARD_EXIST = 6025,
		ERROR_ITEM_DRAW_LIMIT = 2119,
		ERROR_BIRTHDAY_ITEM_REPEAT = 2122,
		ERROR_EQUIP_PROPOSAL_ID_NOT_EXIST = 2202,
		ERROR_MATRIX_START_DIFFICULTY_ILLEGAL = 6503,
		EQUIP_UPGRADE_ATTR_DES = 71121,
		TRAVEL_SKULD_STORY_GETTED = 345025,
		THOR_STRATEGY_TITLE_2 = 345012,
		ERROR_EQUIP_STAR_LIMIT = 2209,
		ERROR_EQUIP_ENCHANT_PREVIEW_NO_EXIST = 2210,
		INPUT_CHANNEL_NUM = 150001,
		SERVANT_RESOLVE_COST_REFINE = 71057,
		GIVE_UP_COMMISSION = 60065,
		ERROR_VERSION_INCONSISTENT = 2015,
		DRAW_NUM_MAX = 71301,
		ACTIVITY_FISHING_BUFF_DESC_3 = 250033,
		NEED_UNLOCK_FRONT_DIFFICULT = 180000,
		SUCCESS_CHANGE_SIGNATURE = 71801,
		ERROR_RACE_TRIAL_NOT_OPEN = 14000,
		ERROR_REQUEST_HAS_EXPIRED = 2413,
		SERVANT_MERGE_CONFIRM = 71055,
		SERVER_MAINTENANCE = 70031,
		ERROR_CLUB_COIN_NO_ENOUGH = 6024,
		PHASE_5 = 320006,
		ACTIVITY_UNLOCK = 250038,
		ERROR_CHAT_MNESIA_CANT_ACCESS = 2506,
		MINUTE = 60077,
		ERROR_CHAT_WORD_TOO_FREQUENTLY = 2510,
		SUCCESS_EQUIP_SERVANT = 71043,
		ERROR_BACKHOME_INGREDIENT_NO_EXIST = 7102,
		ERROR_SHOP_GOODS_NOT_FOUND = 2603,
		ACTIVITY_FIRST_MONTHLY_CARD = 352004,
		RANGETYPE_LONG = 70007,
		ERROR_FIRST_CLEAR_REWARD_CAN_NOT_APPLY = 16001,
		ERROR_HERO_LEVEL_LIMIT = 2706,
		ACCOUNT_VIOLATION = 71271,
		ERROR_EQUIP_LEVEL_LIMIT = 2208,
		NUM_5 = 60280,
		ERROR_RACE_TRIAL_POINT_REWARD_NOT_COMPLETE = 14001,
		CLUB_MOBILITY_DEPUTY = 190013,
		EQUIP_SAVE = 71162,
		TIME_DISPLAY_7 = 280007,
		ERROR_FRIEND_NUM_LIMIT_ME = 2405,
		ERROR_HERO_LEVEL_UP_ITEM_ILLEGAL = 2715,
		ERROR_CHAT_ROOM_MSG_TYPE_ILLEGAL = 2502,
		DAILY_MUTE_TIP = 70047,
		ERROR_HERO_PRE_ASTROLABE_NOT_USED = 2720,
		SKIP_BATTLE_1 = 71403,
		ERROR_HERO_ARCHIVES_GITF_TYPE = 6701,
		ACTIVITY_CLUB_NOT_JOIN = 300128,
		ERROR_HERO_BREAK_LEVEL_LIMIT = 2725,
		PROMPT = 60047,
		FISHING_GIVE_SUCCESS = 250013,
		DEFAULT_PRESET = 170011,
		ERROR_ITEM_NOT_ENOUGH_INFO_BADGE_MID = 2113,
		ERROR_CHAT_EMOTION_TOO_FREQUENTLY = 2511,
		ERROR_NO_UNLOCK_SERVANT = 3203,
		ERROR_BATTLE_ALREADY_GET_STARS_REWARD = 3002,
		ERROR_CLUB_NO_SATISFY_REQUEST = 6022,
		ERROR_BATTLE_DAILY_BATTLE_NOT_UNLOCKED = 3004,
		DORM_CANTEEN_FATIGUE_COST = 210121,
		ERROR_BATTLE_DAILY_BATTLE_TIMES_LIMIT = 3005,
		ERROR_BATTLE_BOSS_CHALLENGE_BOSS_LOCK = 3012,
		RECHARGE_DIAMOND_OR_DIAMOND_EXCHANGE_DRAWCARD = 60254,
		EXCHANGE_CODE_ALERT1 = 80201,
		ERROR_BATTLE_HERO_TEACHING_LOCK = 3014,
		SUB_PLOT_TEXT = 348013,
		CLUB_BOSS_DIFFICULTY_EXPIRED_TIP = 190032,
		RANGETYPE_CLOSE = 70006,
		NO_SERVANT_CAN_BE_EQUIPED = 71040,
		ERROR_CHAT_MESSAGE_CONTENT_OVER_SIZE = 2512,
		ERROR_PROC_EXCEPTION = 14,
		ACTIVITY_HELLA_PARKOUR_DESCRIPE = 230004,
		NO_OTHER_CHAT = 150004,
		POLYHEDRON_ARTIFACT_SUB_TYPE_3005 = 354007,
		EQUIP_RACE_ATTRIBUTE_UP = 60202,
		ERROR_SERVANT_STAR_LIMIT = 2300,
		ACTIVITY_LIMIT_CALCULATION_ENEMY_LEVEL = 250025,
		REPORT_REASON_SIGNATURE = 151007,
		ERROR_BACKHOME_FEED_HERO_MAX = 7116,
		ERROR_POLYHEDRON_ROLL_ARTIFACT_MAX = 22002,
		ERROR_CLUB_USER_RECEIVE_INVITES_MAX = 6004,
		ERROR_CLUB_MEMBER_FULL = 6005,
		EQUIP_STRENGTH_EXP_OVERFLOW = 60205,
		ERROR_CLUB_ONLY_LEADERS_CMD = 6007,
		ERROR_BACKHOME_FURNITURE_NO_EXIST = 7109,
		ERROR_PLATFORM_SURVEY_DATA_NOT_EXIST = 6902,
		ERROR_MATRIX_BEACON_ALREADY_UNLOCKED = 6530,
		ERROR_CLUB_CONTRIBUTION_NOT_ENOUGH = 6016,
		TIME_OUT = 60079,
		ERROR_CLUB_USER_ALREADY_HAS_CLUB = 6000,
		ERROR_HERO_ASTROLABE_NOT_USING = 2722,
		TIME_DISPLAY_13 = 280013,
		ERROR_COORDINATOR_READY = 6118,
		ERROR_HERO_EXCLUSIVE_SKILL_NUM_MAX = 2735,
		CURRENT_SCHEME = 120024,
		CLUB_BOSS_TIPS_1 = 280038,
		ACTIVITY_FISHING_BUFF_DESC_1 = 250031,
		ERROR_NOT_SWITCH_DETECTOR = 6612,
		ALL_NULL = 70070,
		ERROR_CHAT_BAN = 2509,
		TIP_EXIT_GAME = 60248,
		LAST_CHAT = 70058,
		TIP_MEMORY = 345003,
		MATRIX_TYPE_NOTE_7 = 140007,
		ERROR_CLUB_NOT_EXIST = 6038,
		ERROR_TIME_OUT = 7,
		MISSION_PROGRESS_UNLOCK_EX = 70083,
		ERROR_ASTROLABE_UNLOCK_CONDITION_NOT_MATCH = 60153,
		TIP_BREAK = 70018,
		TIP_USE = 70040,
		ERROR_CLUB_BOSS_CHALLENGE_SELECT_DIFFICULTY = 6044,
		ERROR_CLUB_BOSS_CHALLENGE_NOT_START = 6045,
		ERROR_CLUB_SHARE_IN_COLD_DOWN = 6047,
		ERROR_COORDINATOR_ROOM_LIMITED = 6101,
		EQUIP_DRESS_FAIL = 60209,
		BOSS_CHALLENGE_NORMAL_RESET = 180018,
		CLUB_BOSS_CHALLENGE_NOT_OPEN_TIP = 190034,
		CANTEEN_HERO_FATIGUE_NULL = 210033,
		OPERATION_DISABLED = 70044,
		ERROR_COORDINATOR_MEMBER_NOT_EXIST = 6116,
		ERROR_COORDINATOR_ALREADY_IN_ROOM = 6117,
		ACTIVITY_VALENTINE_RESULT_TITLE_3 = 347106,
		HARD_LEVEL = 280028,
		ITEM_TYPE_NOTE_2 = 100002,
		POLYHEDRON_BEACON_UNLOCK_SUCCESS = 354016,
		ERROR_COORDINATOR_NOT_OWNER = 6112,
		ERROR_RECHARGE_MONTH_CARD_BUY_TIMES = 6213,
		ERROR_ITEM_NOT_ENOUGH_HERO_PIECE = 2102,
		ADVANCED_TASK_BATTLE = 353000,
		ERROR_ADMIN_SERVER_EXCEPTION = 6300,
		THOR_STRATEGY_TITLE_4 = 345014,
		POLYHEDRON_UNLOCK_HERO_SUCCESS = 354018,
		ACTIVITY_TOWER_DEFENSE_UNLOCK_DESC = 320014,
		ERROR_HERO_STAGE_NOT_CLEAR = 2710,
		DORM_FUR_NEED_GIFT = 210137,
		DORM_CANTEEN_FURNITURE = 210082,
		DISPLAY = 70009,
		SECOND = 60078,
		ENCHANTMENT_STAGE_REFRESH_ONCE = 60251,
		ERROR_HERO_EXCLUSIVE_SKILL_TALENTS_POINTS_LEVEL_MAX = 2734,
		ERROR_SERVER_INTERNAL = 1,
		ERROR_MATRIX_EVENT_ILLEGAL = 6507,
		ERROR_MATRIX_EQUIP_REWARD_MAX = 6512,
		ERROR_ITEM_NO_RESOURCE_TYPE = 2105,
		ERROR_MATRIX_NOT_ENOUGH_POINT = 6519,
		ERROR_MATRIX_SHOP_ITEM_NOT_ENOUGH = 6520,
		ACTIVITY_MOONCAKE_GAMBLING_REWARD_6 = 260013,
		ERROR_PRE_MAP_NOT_CLEAR = 6606,
		ACTIVITY_OSIRIS_HEART_DEMON_CHALLENGE_DESCRIPE = 220005,
		ERROR_MATRIX_TERMINAL_LEVEL_NOT_ENOUGH = 6529,
		BOSS_CHALLENGE_DESC = 60167,
		ACTIVITY_FISHING_BUFF_DESC_2 = 250032,
		CLUB_VICE_CHAIR_MAN = 190039,
		DORM_MOULD_NAME_SAME = 210104,
		SUCCESS_EQUIP_PROPOSAL = 71101,
		ABYSS_STAGE_RESET_CLICK_TIP = 351011,
		DORM_CANTEEN_UNLOCK = 210079,
		TIME_DISPLAY_5 = 280005,
		CLUB_REQUEST_CD = 190016,
		ERROR_CHAT_NOT_IN_ROOM = 2500,
		POLYHEDRON_SELECT_BEACON_EMPTY = 354036,
		ERROR_CLUB_SHARE_POWER_LIMIT = 6048,
		ERROR_HERO_NO_SKILL_UP_MAT = 2724,
		ERROR_POLYHEDRON_SELECT_BEACON_MAX = 22001,
		ACTIVITY_SPRING_FESTIVAL_RIDDLE_DESCRIPE = 341003,
		ERROR_CHIP_LOCK = 6800,
		UNDEFINED_ERROR = 50004,
		CHAT_CUSTOM_STICKER_CHANGED = 150011,
		ERROR_INFINITY_POOL_CANT_RESET = 13004,
		ACTIVITY_MATRIX_PRECONDITIONS = 260025,
		EXCLUSIVE_SKILL_POINT_UP = 71178,
		ERROR_REDEMPTION_CODE_TIME_OUT = 6407,
		TIP_MAIL_EXPIRED = 71008,
		ACTIVITY_PUZZLE_CONTENT = 260002,
		ERROR_PROPOSAL_NO_EXIST = 6801,
		ERROR_CLUB_POPULARITY_NOT_ENOUGH = 6014,
		ERROR_HERO_BAD_MECHANISM_TYPE = 2729,
		TRAVEL_SKULD_DESCRIPE = 345002,
		ERROR_REQUEST_NOT_EXIST = 6032,
		SERVER_OPEN_COUNTDOWN_3 = 71274,
		EQUIP_STRENGTH_COST_RARE = 60217,
		ERROR_SLAYER_POINT_REWARD_APPLIED = 15000,
		SHARE_SUCCESS = 200004,
		EQUIP_ENCHANT_OEPN_LEVEL = 60201,
		MYTHIC_FINAL_REWARD_FOLLOW_TIPS = 285005,
		ERROR_BATTLEPASS_BUY_LEVEL_INVALID = 7005,
		ERROR_HERO_WEAPON_LEVEL_LIMIT = 2728,
		ERROR_BATTLEPASS_HAS_RECEIVE = 7006,
		ERROR_BATTLEPASS_WEEKLY_EXP_LIMIT = 7007,
		POSITION_TIP = 60109,
		ERROR_SHOP_BUY_TIMES_LIMIT = 2602,
		MONTHLY_SOLD_OUT = 60273,
		EQUIP_BREAK_SUCCESS = 60137,
		CLUB_CHAIR_MAN = 190038,
		MYTHIC_PROCESS_RECORD = 285014,
		ERROR_BACKHOME_HERO_FATIGUE_LACKING = 7112,
		ERROR_BACKHOME_TEMPLATE_TYPE_DIFF_FROM_ARCHITECTURE = 7113,
		ERROR_OVERSTEP_THE_BOUNDARY = 6602,
		TIP_USING = 70041,
		ERROR_FRIEND_EXIST_BLACK_TARGET = 2402,
		DORM_CANTEEN_TASK_CANT_FIT = 210129,
		NEARLY_OVER = 180007,
		ERROR_ACTIVITY_NOT_OPEN = 12000,
		SKIN_HAD_UNLOCKED = 70080,
		ERROR_INFINITY_POOL_BOX_NOT_EXIST = 13002,
		ERROR_HERO_ASTROLABE_NUMBER_LIMIT = 2723,
		MYTHIC_FINAL_DESC = 285001,
		FACTORY_ACTIVITY_SOLO_CHALLENGE_CONTENT = 320012,
		TYPE_POSITION = 60134,
		DRAW_CARD = 80009,
		ERROR_RACE_TRIAL_SELECT_AFFIX_NOT_LEGAL = 14004,
		ERROR_BATTLE_MYTHIC_DIFFICULTY_CANT_MATCH = 3008,
		ERROR_BATTLEPASS_HAS_BUY = 7001,
		ERROR_SLAYER_POINT_NOT_ENOUGH = 15001,
		GIVE_UP_BATTLE = 60066,
		FRIEND_DELETE = 60085,
		HERO_STRENGTH_EXP_OVERFLOW = 60230,
		ERROR_CLUB_BOSS_MAP_GRID_FULL = 18001,
		ERROR_CLUB_BOSS_MAP_GRID_NOT_OCCUPIED = 18002,
		ERROR_RACE_TRIAL_FIRST_CLEAR_REWARD_ALREADY_APPLIED = 14003,
		ERROR_MATRIX_TIER_REBORN_ITEM_NO_TEMPLATE = 6525,
		NO_EQUIP = 70055,
		ACTIVITY_PUZZLE_DESCRIPE = 260001,
		SIGN_TITLE_MONTHCARD = 71715,
		ERROR_SERVANT_EXCEED_LIMIT = 2310,
		CULTIVATE_HERO_DESC = 348003,
		EXPIRED_SECOND = 71007,
		ACTIVITY_CHAPTERIII_PT_DESCRIBE = 260016,
		ERROR_POLYHEDRON_SHOP_GOODS_SOLD_OUT = 22004,
		ERROR_BATTLE_TOWER_STAGE_NO_MATCH = 3007,
		SERVANT_IS_USING = 71045,
		EXCLUSIVE_SKILL_MAX = 71173,
		VERIFY_ASSETS_PROCESSING_TITLE = 60262,
		ERROR_SERVANT_NOT_EXIST = 2303,
		EQUIP_HERO_ATTRIBUTE_UP = 71131,
		REFRESH_FAIL_ON_TIME = 50001,
		COLLECT_WORD_TYPE_2 = 71502,
		RECONNECT_TOO_LONG = 60100,
		LIMIT_TIME_GIFTBOX = 80021,
		LEVEL = 60257,
		HERO_LOVE_EXP_UP = 71259,
		ERROR_CHAT_NOT_ACTIVE_CHATER = 2508,
		TEAM_REPEAT_HERO = 60184,
		FRIEND_APPLY_SEND = 60094,
		COOPERATION_LEAVE_ROOM = 330001,
		ERROR_HERO_ONE_NOT_IN = 60036,
		ERROR_NOT_REQUEST_SELF = 2416,
		REGRESSION_GASHAPON_DESCRIPE = 350003,
		CLUB_SHARE_TIPS_2 = 280050,
		TIP_SELECT_OVER = 347108,
		DAY = 60075,
		NO_MATCH_REC_EQUIP = 71103,
		ERROR_CHAT_ROOM_BUSY = 2507,
		FESTIVAL_CANTEEN_LEVEL = 210008,
		NUM_1 = 60276,
		SAVE_NEW_PRESET = 170010,
		ADVANCED_TASK_BATTLE_CHESS = 353005,
		BOSS_CHALLENGE_REWARD_TIPS = 180017,
		ERROR_PROC_BAD_REQUEST = 15,
		ACTIVITY_FISHING_BUFF_NAME_1 = 250028,
		FRIEND_MOVE_TO_BLACLIST = 60086,
		TIPS_REVISENAME_ONE = 71807,
		SUCCESS_STRENGTHEN = 70001,
		ACTIVITY_CLUB_SELF_OCCUPY_MAX = 300104,
		SKILL_NEXT_LEVEL = 280034,
		BLACKLIST_REMOVE_QUEST = 60096,
		ERROR_HERO_PRE_ASTROLABE_NOT_UNLOCKED = 2719,
		SUCCESS = 0,
		CLUB_SPECIAL_WELFARE = 190015,
		CANNOT_CONNECT_CHAT = 60103,
		WHETHER_TO_REFRESH = 280021,
		NOT_FRIEND = 60104,
		WEAPON_MODULE_MATERIAL_SELECT = 80309,
		HERO_UNREADY_SOLO_CHALLENGE = 250016,
		COPY_SUCCESS = 60110,
		SKILL_UPGRATE_SUCCESS = 60112,
		DORM_CANTEEN_CASHIER = 210086,
		LOGIN_IN_OTHER_PLACE = 60098,
		ACTIVITY_LOCK_SETTLEMENT_TIP = 250040,
		BOSS_CHALLENGE_COMFIRM = 180010,
		CANTEEN_FOOD_NOT_FIT = 210038,
		RECHARGE_DIAMOND_AND_DIAMOND_EXCHANGE_DRAWCARD = 60255,
		ERROR_SKULD_TRAVEL_STATE_ILLEGAL = 19000,
		LIMIT_ALL = 60123,
		ERROR_REDEMPTION_CODE_USED = 6403,
		HOUR = 60076,
		FISHING_RECEIVE_SUCCESS = 250014,
		ERROR_FRIEND_EXIST_FRIEND = 2401,
		BLACKLIST_REMOVE_NOTE = 60097,
		ERROR_HERO_ARCHIVES_EXP_LIMIT = 6702,
		ERROR_POLYHEDRON_NOT_ENOUGH_STACKABLE_ITEM = 22003,
		ITEM_NOT_ENOUGH_RETURN_MATERIAL = 350001,
		EQUIP_HERO_SUCCESS = 71150,
		FIRST_DROP = 60141,
		SUCCESS_CHANGE_NAME = 60145,
		ERROR_ITEM_FATIGUE_LIMIT = 2111,
		ERROR_UP_NO_EXIST = 3101,
		ERROR_HERO_WIN_LOW = 2712,
		PLEASE_INPUT_EXCHANGE_CODE = 60154,
		ACTIVITY_GREENHORN_TASK_STAGE = 352001,
		NOTE_ENERGYTYPE_1 = 60149,
		ERROR_RECHARGE_TOTAL_RECHARGE_REWARD_LIMIT = 6215,
		NOTE_TASK_UNLOCK = 60152,
		PURCHASE_LIMIT = 71202,
		ERROR_MATRIX_SELECT_REWARD_ILLEGAL = 6509,
		ACTIVITY_CLUB_GRID_OCCUPY_MAX = 300103,
		TIP_NEED = 345007,
		ASTROLABE_RESET = 60168,
		NEED_FINISH_PRE_NORMAL_STAGE = 60170,
		ERROR_MATRIX_LOSED = 6524,
		POLYHEDRON_UNLOCK_HERO_TIP = 354017,
		REFRESH_LOST_TIME = 60183,
		ERROR_POLYHEDRON_TERMINAL_RESET_TIMES_MAX = 22010,
		ERROR_SERVANT_SAME = 2304,
		DORM_CANTEEN_WAITER = 210085,
		ADVANCED_TASK_BATTLE_POLYHEDRON = 353004,
		SPAWN_DESCRIPE = 60190,
		JOIN_TEAM = 60225,
		ASTROLABE_UNBIND = 60116,
		TIP_ASTROLABE_UNINSTALL = 60186,
		EQUIP_NO_RACE = 60203,
		EQUIP_SKILL_LOCK_LEVEL = 60204,
		FRIEND_MOVE_TO_BLACLIST_NOTE_LIMIT = 60091,
		NUM_6 = 60281,
		EQUIP_STRENGTH_BACK = 60208,
		DORM_FURNITURE_OVERLOAD = 210005,
		BOSS_REFRESH_DATA = 60214,
		SERVANT_CONSUME_CONFIRM = 71050,
		ERROR_FRIEND_REQUEST_NUM_LIMIT = 2411,
		ERROR_SERVER_NOT_EXIST = 6,
		ERROR_NO_CLUB = 6021,
		BOSS_LEVEL_2 = 180002,
		ERROR_BATTLE_BASE_TEACHING_LOCK = 3013,
		EXCLUSIVE_CHIP = 120018,
		WEAPON_STRENGTH_EXP_OVERFLOW = 60218,
		ACTIVITY_MOONCAKE_GAMBLING_REWARD_3 = 260010,
		ERROR_POLYHEDRON_HERO_ALREADY_UNLOCK = 22006,
		ACTIVITY_STRATEGY_TITLE_1 = 290015,
		EXPIRED_HOUR = 71005,
		ACTIVITY_SOLO_CHALLENGE_CONTENT = 250019,
		ERROR_SERVANT_RACE_NO_MATCH = 2305,
		ERROR_MATRIX_GET_REPEATED_ARTIFACT = 6523,
		DORM_UNLOCK_CHECK_TIPS = 210060,
		EQUIP_SKILL_LOCK_DES = 71129,
		DORM_HERO_SET_NULL = 210049,
		ERROR_NO_RETURN = 3300,
		ACTIVITY_MOONCAKE_GAMBLING_DESCRIPE = 260006,
		CHECK_UPDATE_NOTE = 60138,
		FRIEND_REFRESH_TOO_FAST = 60239,
		EXCLUSIVE_SKILL_POINT_UP_CONFIRMATION = 71179,
		NO_FRIEND_REQUEST = 60107,
		ERROR_COORDINATOR_NOT_IN_ROOM = 6102,
		DORM_SPECIAL_EVENT_OPEN = 210007,
		ERROR_CLUB_VICE_CHAIRMAN_NUM_LIMIT = 6011,
		ERROR_MATRIX_CHANCE_REWARD_NOT_TEMPLATE = 6515,
		MYTHIC_REFRESH = 60253,
		BACK_TO_CURRENT = 70077,
		EQUIP_STRENGTH_EXP_OVERFLOW_AND_RARE = 60216,
		PAYMENT_TOTAL_POINT = 80004,
		ERROR_TEAM_LIST_REPEAT = 3504,
		DORM_FEED_MAX = 210076,
		MATRIX_PREPARE_ADJUST_TERMINAL = 160024,
		NONE = 170009,
		ERROR_COORDINATOR_NOT_ALL_READY = 6115,
		VERIFY_ASSETS_PROCESSING_CONTENT = 60263,
		SEPTEMBER = 71710,
		UNCLAIMED_BONUS_MAIL_TIP = 60267,
		ERROR_WEAPON_SERVANT_EQUIP = 2307,
		TIP_DISPLAY = 70042,
		ERROR_ABYSS_HERO_LAYER_LOCKED = 21001,
		MYTHIC_REWARD_LOACK_DIFFICULTY = 60275,
		ENTER_CHAT_CHANNEL = 150006,
		ERROR_HERO_UNLOCKED = 2704,
		FORMATION_PLAN_CHANGE_FAILED = 300006,
		ERROR_CLUB_REWARD_ALREADY_SIGN = 6027,
		EQUIP_HERO_REBUILD_WARNING = 71135,
		NUM_7 = 60282,
		MATRIX_NOT_GET_ASTROLABEL = 160008,
		ERROR_CLUB_REWARD_NO_EXIST = 6026,
		CANNOT_CHANGE_COMBO_SKILL = 130001,
		ACTIVITY_FACTORY_INFINITY_POOL_DESCRIPE = 320001,
		ITEM_TYPE_NOTE_3 = 100003,
		MATRIX_TYPE_NOTE_3 = 140003,
		SUCCESS_CHANGE = 71802,
		CHIP_MANAGER_UNLOCK_FAILED = 120001,
		NORMAL = 120023,
		ANTIADDICTION_ONLINE_TIME_LIMIT = 71151,
		EQUIP_HERO_CHOOSE_EMPTY = 71130,
		GO_UP_TO = 70074,
		ACTIVITY_MUSIC_LEVEL_2 = 290012,
		ERROR_SERVANT_TYPE = 2308,
		DISPLAY_CANCEL = 70010,
		MYTHIC_FINAL_LEVEL = 285004,
		ERROR_LOGIN_REGISTER_LIMIT = 1007,
		TIP_HIDE = 70016,
		RACE_TYPE_9 = 71525,
		TIP_DETAIL = 70017,
		ERROR_NO_ABLE_BGM = 3207,
		EXCLUSIVE_SKILL_POINT_NOT_ENOUGH = 71174,
		ERROR_CLUB_DEBTS_DAYS_LIMIT = 6015,
		ADVANCED_TASK_BATTLE_MYTHIC = 353001,
		DORM_CANTEEN_LEVEL_CONDITION = 210120,
		POLYHEDRON_ARTIFACT_SUB_TYPE_3002 = 354004,
		ADVANCED_TASK_BATTLE_TOWER = 353006,
		GIFTBOX = 80007,
		ERROR_REDEMPTION_CODE_GIFT_RECEIVE_MAX = 6402,
		TIP_HELP = 70023,
		MATRIX_TIME_LIMIT_EXCEEDED = 160002,
		NO_ITEM = 70068,
		EQUIP_SKILL_LOCK_ENCHANT_EMPTY = 71134,
		TIP_OR = 70024,
		ERROR_HERO_STAR_PIECE_LIMIT = 2714,
		SCHEME_IS_NULL = 120011,
		ASTROLABE_NUM_MAX = 60185,
		ERROR_ACTIVITY_NOT_EXIST = 12001,
		EXCLUSIVE_SKILL_LEVEL_UP = 71175,
		ERROR_CODE = 70029,
		ERROR_HERO_EXCLUSIVE_SKILL_SLOT_ID_ILLEGAL = 2731,
		SENSITIVE_WORD = 70003,
		SERVANT_MERGE_MATERIAL_NOT_ENOUGH = 71058,
		ACTIVITY_PT_REPEAT_MULTIPLE_UNLOCK = 250039,
		EQUIP_UNBIND = 60119,
		WEAPON_MODULE_SKILL_TIP_TEMPLATE_2 = 80301,
		NAME_CANNOT_SAME_CURRENT = 71803,
		ERROR_CONNECT_SERVER = 70030,
		ACTIVITY_SOLD_OUT = 60297,
		CANTEEN_TASK_NOT_CHOOSE = 210019,
		EXCHANGE_SUCCESS = 50008,
		MONTHLY_CARD_DAILY_GET_2 = 60296,
		ROLE_FILTERING = 60291,
		IF_ACCOUNT_NIL = 60289,
		NUM_8 = 60283,
		ACTIVITY_MUSIC_DIFFICULT_TASK = 290006,
		DOWNLOAD_CANCEL = 70036,
		ERROR_PROPOSAL_NAME_IS_EMPTY = 6809,
		ERROR_MATRIX_SHOP_REFRESH_OVER_LIMIT = 6532,
		CANCEL = 70037,
		TIP_UNLOCK_HERO = 70078,
		NOT_ENOUGH_TIME_TO_BUY = 71607,
		BUY_SKIN_CHANGE = 80015,
		NUM_2 = 60277,
		SERVER_OPEN_COUNTDOWN_2 = 71273,
		NO_BLACKLIST = 60108,
		PAY_FOR_POWER = 71208,
		ACTIVITY_SUMMER_PT_REPEAT_DESCRIPE = 250041,
		ACTIVITY_CLUB_ELITE_GRID_ABADON_RESULT_CONFIRM = 300107,
		WEAPON_STRENGTH_COST_RARE = 60220,
		OPEN_FORUM = 70039,
		SEQUENTIAL_BATTLE_RESET_STAGE = 340002,
		DORM_CANTEEN_CASHIER_DO = 210091,
		CANTEEN_MANNUALLY_FOOD_EMPTY = 210044,
		ERROR_SHOP_GOODS_CHEAP_OPEN_TIME = 2606,
		FRIEND_SYSTEM_NOT_OPEN = 250008,
		ERROR_COORDINATOR_OWNER = 6113,
		MYTHIC_CHANGE_DIFFICULTY = 60274,
		UNLOCK_CONDITION_ACTIVITY_TIPS = 220014,
		ERROR_BACKHOME_ARCHITECTURE_ALREADY_UNLOCK = 7118,
		NOTE_ENERGYTYPE_3 = 60151,
		VERIFY_ASSETS_PROCESSING_RATE = 60264,
		POLYHEDRON_REWARD_TITLE_ARTIFACT = 354024,
		EQUIP = 70043,
		VERIFY_ASSETS_BEFORE_CONFIRM = 60261,
		MYTHIC_FINAL_LEVEL_UNLOCK = 285006,
		CHALLENGE_NEXT_LEVEL = 60260,
		DORM_MOULD_DEFAULT_NAME = 210061,
		ERROR_CLUB_BOSS_MAP_GRID_OCCUPIED = 18000,
		ERROR_USER_NAME_TOO_SHORT = 2008,
		LOGIN_MUTE_TIP = 70046,
		REFRESH_LOST_TIME_WITH_COLOR = 60256,
		WEEKLY_MUTE_TIP = 70048,
		MONTYLY_MUTE_TIP = 70049,
		ERROR_HERO_UNLOCK_ASTROLABE_LOW = 2708,
		ABYSS_RESET_STAGE_FINISH_TIP = 351003,
		ACTIVITY_CLUB_HERO_VITALITY_NOT_ENOUGH_TIP = 300114,
		ERROR_RECALL_CODE_USE_TIME_LIMIT = 20001,
		ACTIVITY_SIGN_OPEN = 352002,
		ERROR_USER_LV_LIMIT = 2003,
		CANNOT_CHANGE = 120025,
		NO_HERO_PIECE = 70053,
		CANTEEN_TASK_DISPATCH = 210022,
		TIP_QUIT_GAME = 60252,
		BOSS_LEVEL_5 = 180005,
		NAME_CHANGE_CARD_WHETHER_TIPS = 310102,
		ERROR_COORDINATOR_BATTLE_RESULT_ILLEGAL = 6107,
		ERROR_FRIEND_CANT_FIND_BLACK = 2403,
		BATTLEPASS_EXPIRED = 71609,
		ONLINE = 60084,
		TIME_DISPLAY_12 = 280012,
		NO_SERVANT = 70054,
		TIP_SKIP_PLOT = 60249,
		SWITCH_CHANNEL_FREQUENTLY = 150007,
		GET_FATIGUE = 60245,
		ERROR_USER_DEFAULT_NICK = 2010,
		ABYSS_LAYER_LABEL = 351007,
		SAVE_SCHEME_SUCCESS = 120013,
		ERROR_CLUB_NAME_REPEAT = 6035,
		RACE_TYPE_7 = 71523,
		VERIFY_ASSETS_COMPLETE = 60266,
		COLLECT_WORD_TYPE_3 = 71503,
		MATRIX_REFRESH_DATA = 60235,
		ERROR_USER_NOT_EXIST = 2012,
		SOLO_OPEN_TIME = 250012,
		INVESTIGATE_TIPS_2 = 280030,
		CLUB_NEWBEE_PROTECT = 190044,
		LOCK_TYPE_DESC1 = 60232,
		OMEGA_ENOUGH_TIP = 60269,
		DORM_HERO_SET_CHECK = 210065,
		ERROR_CLUB_ONLY_CHAIRMAN = 6012,
		NO_BATTLE_BUFF = 60229,
		NO_CORRECTOR_BUFF = 60228,
		EQUIP_STAGE_DESCRIPE = 60226,
		ACTIVITY_MUSIC_LEVEL_3 = 290013,
		ACTIVITY_SOLO_SLAYER_FINISH = 320011,
		ACTIVITY_OSIRIS_TACE_TRIAL_DESCRIPE = 220004,
		POLYHEDRON_LOBBY_START_TIP = 354022,
		NIL_NAME = 300010,
		TEAM_4 = 250042,
		CHANGE_MEMBER = 60224,
		DORM_LOBBY_MOULD_DEFAULT_NAME = 210070,
		DAILY_SOLD_OUT = 60271,
		SUCCESS_DELETE_MAIL = 71000,
		ERROR_CLUB_BOSS_CHALLENGE_CAN_NOT_JOIN = 6043,
		ERROR_HERO_EXCLUSIVE_SKILL_TALENT_POINTS_NOT_ENOUGH = 2730,
		DRAW_REMAIN_UP_TIMES = 71308,
		POLYHEDRON_REWARD_TITLE_ROLE = 354027,
		CURRENT_SHOW = 60058,
		ERROR_USER_JOIN_COOL_DOWN = 6041,
		SEQUENTIAL_BATTLE_SAVE_TEAM = 340010,
		ERROR_BATTLEPASS_NOT_START = 7000,
		NO_GIFT = 70056,
		ERROR_SELECT_AFFIX_NOT_LEGAL = 2017,
		SERVANT_RESOLVE_COST_RARE = 71056,
		ERROR_ITEM_NOT_ENOUGH_DRAW = 2103,
		CANNOT_CHANGE_CHIP = 120026,
		ABYSS_RESET_LAYER_FINISH_TIP = 351006,
		ERROR_NO_UNLOCK_EQUIP = 3204,
		ERROR_EQUIP_ENCHANT_PREVIEW_EXIST = 2211,
		ERROR_COORDINATOR_HERO_REPEAT = 6121,
		POLYHEDRON_INTERACTIVE_HERO_DES_3 = 354039,
		TIP_EQUIP = 70020,
		FORMATION_PLAN_SAVED = 300007,
		SEQUENTIAL_BATTLE_DESC = 340008,
		STAGE_REFRESH_DATA = 60215,
		DORM_LOBBY_SET_MAX = 210100,
		ADVANCED_TASK_CULTURE_ASTROLABE = 353104,
		SERVANT_NUM_MAX = 71049,
		SLAYER_TIME_TO_START = 240001,
		SCAN_RULES_3 = 280018,
		ERROR_EQUIP_UNLOCKED_SUCCESS = 71161,
		CLUB_BOSS_OPEN_2 = 280042,
		CLUB_SHARE_TIPS_3 = 280051,
		DORM_UNLOCK_ITEM_NOT_ENOUGH = 210059,
		ACTIVITY_SPRING_FESTIVAL_RIDDLE_FINISH_CNT = 341007,
		TIME_DISPLAY_3 = 280003,
		MAIN_PLOT_TEXT = 348012,
		ACTIVITY_OSIRIS_INFINITY_POOL_DESCRIPE = 220006,
		ERROR_BATTLEPASS_EXP = 7004,
		ERROR_EQUIP_PROPOSAL_NUM_LIMIT = 2200,
		CANTEEN_CUSTOMER_SERVE_TIPS2 = 210013,
		ERROR_SHOP_COST_TYPE = 2607,
		DORM_LEVEL_UP_TIPS = 210101,
		ERROR_RECALL_CODE_USE_OWN = 20002,
		ERROR_USER_TYPE_LIMIT = 2004,
		MATRIX_TYPE_NOTE_5 = 140005,
		TIME_DISPLAY_9 = 280009,
		SAVE_TEAM = 340004,
		CLUB_BOSS_CHALLENGE_TIP = 190028,
		POLYHEDRON_LOBBY_BUTTON_START = 354020,
		CURHERO_USED = 71411,
		TIP_ASTROLABE_NUM_MAX = 60188,
		CANTEEN_FOOD_COST = 210039,
		MATRIX_TYPE_NOTE_10 = 140010,
		FREQUENT_OPERATION_ = 70000,
		CLUB_MEMBER = 190040,
		ERROR_FRIEND_EXIST_BLACK_ME = 2408,
		BLANK = 60025,
		WEEK_RESET_TIME = 70084,
		ERROR_CHAT_ROOM_NOT_AVAILABLE = 2505,
		BOSS_BE_KILLED_TIP = 300108,
		EQUIP_INHERIT_PROPOSAL = 71142,
		CHANGE_NAME_COST_ITEM = 60062,
		TRANSACTION_SUCCESS = 50007,
		MATRIX_ARTIFACT_RARE4 = 110004,
		STICKER_SETUP = 347001,
		RESET_INFINITY = 220002,
		ERROR_CHAT_ROOM_ID_ILLEGAL = 2501,
		STAGE_DESCRIPE = 60181,
		TEACH_STAGE_DESC = 60180,
		DORM_RECOMMEND_NULL = 210106,
		ERROR_HERO_DEATH = 6611,
		ERROR_REPORT_NOTE_CONTENT_OVER_SIZE = 11000,
		CANTEEN_DISPATCHED_HERO = 210133,
		EQUIP_EQUIP = 71164,
		CHIP_MANAGER_USE_SUCCESS = 120003,
		FEBRUARY = 71703,
		MATRIX_RANK_NO_RANK = 160019,
		STAGE_BOSS_DESCRIPE = 60182,
		PLAYER_LEVEL_LIMIT = 60164,
		ERROR_REDEMPTION_CODE_RECEIVE_MAX = 6401,
		MONSTER_INFORMATION = 71521,
		SERVANT_PROMOTE_LEVEL_2 = 71054,
		BOSS_CHALLENGE_UNLOCK_TIPS = 180012,
		MYTHIC_FINAL_BASTTLE_TIPS = 285013,
		SKIP_BATTLE_2 = 71404,
		COLLECT_MANSTER_INFO_UNLOCK_FAILED = 71520,
		WHETHER_TO_DRAW = 280020,
		APRIL = 71705,
		ERROR_PROC_NOT_ALIVE = 12,
		ACTIVITY_CLUB_DANGEROUS_DESC = 300124,
		TRAVEL_SKULD_STORY_GET = 345009,
		MATRIX_SURE_GET_OUT_SHOP = 160009,
		TPURCHASED = 71204,
		DORM_MOULD_USE_CHECK = 210112,
		CANNOT_CONNECT = 60148,
		CANNOT_REPLACE_PRESET = 170007,
		ERROR_POINT_REWARD_APPLIED = 17000,
		DORM_HERO_SAME_SET = 210099,
		SHARE_CANCEL = 200006,
		ACTIVITY_VOLUME_SLAYER_DESCRIPE = 260017,
		ACTIVITY_STRATEGY_TITLE_2 = 290016,
		ADVANCED_TASK_BATTLE_GUILDBOSS = 353007,
		DORM_GIFT_NULL = 210123,
		CLUB_BOSS_ASSIST_MORE_THAN_ONE_TIP = 190030,
		ERROR_MATRIX_NOT_CLEAR_BATTLE = 6508,
		TIP_NARRATOR = 70025,
		ERROR_HERO_BREAK_LIMIT = 2727,
		POLYHEDRON_SHOP_GIVE_UP = 354046,
		NO_FRIEND = 60106,
		MATRIX_RESET_TERMINAL_GIFT = 160017,
		ERROR_REDEMPTION_CODE_RECEIVE_THE_SAME_TYPE_1 = 6404,
		PHASE_3 = 320004,
		CONFIRM_TO_QUIT_CHESS = 71410,
		IS_LOCK = 60221,
		ERROR_HERO_ASTROLABE_USING = 2721,
		VITALITY_FULL = 60139,
		DAILY_GIVE_RARE_FISH_LIMIT_TIP = 250007,
		POLYHEDRON_ARTIFACT_SUB_TYPE_3007 = 354009,
		CLUB_ACTIVITY_MAX_HERO = 300119,
		ACTIVITY_CLUB_OVER = 300129,
		MAIL_DELETE_CONFIRM = 71003,
		TIP_CLUB_SPECIAL_WELFARE_BUY = 190019,
		DORM_FURNITURE_CANT_GIFT_TIPS = 210111,
		LAST_LOGIN = 70059,
		DEMON_CLEAR_NORMAL_DIFFICULTY = 345018,
		ERROR_MATRIX_ARTIFACT_REWARD_MAX = 6514,
		INIT_PRESET = 170012,
		DRAW_SWITCH_LIMIT_CONFIRM_TIP = 71310,
		SERVER_OPEN_COUNTDOWN_1 = 71272,
		TYPE_EQUIP = 60133,
		EQUIP_SKILL_UNLOCK = 71166,
		ERROR_BACKHOME_FURNITURE_LACKING = 7110,
		MISSION_PROGRESS_UNLOCK = 60131,
		ALL_EQUIP = 60129,
		PLAYER_LEVEL_UNLOCK = 60124,
		ERROR_MATRIX_CHANCE_ILLEGAL_END_STORY_LINE = 6516,
		ACTIVITY_1_7_LIMITED_CALCULATION_DESCRIPE = 347110,
		AFFIX_SELECT_HELP = 347112,
		POLYHEDRON_RESET_TERMINAL_GIFT = 354014,
		MAIL_EXPIRED = 71002,
		ERROR_FRIEND_IN_BLACK_NOW = 2404,
		MONTHLY_CARD_ONCE_GET_1 = 60293,
		EQUIP_BIND = 60118,
		ERROR_HERO_ASTROLABE_NOT_UNLOCK = 2713,
		ERROR_BATTLE_MYTHIC_DIFFICULTY_NOT_OPEN = 3009,
		ERROR_UP_ERROR = 3100,
		ACTIVITY_FIRST_CONTRACT = 352005,
		REPLACE_SAME_PRESET = 170006,
		CANTEEN_FOOD_ADD = 210029,
		ASTROLABE_BIND = 60115,
		POLYHEDRON_INTERACTIVE_HERO_FAIL = 354043,
		ERROR_NO_AVAILABLE_COORDINATOR = 6100,
		DORM_FURNITURE_CANNOT_SET = 210004,
		EQUIP_BREAK_THROUGH_MODE_UNLOCK = 71453,
		CHARACTOR_ON_TRIAL = 300013,
		EQUIP_BREAK_THROUGH_BUFF_HEAL = 71459,
		PURIFY_SUCCESS = 70066,
		REPORT_SUCCESS = 151009,
		FORMATION_PLAN_DELETE_CONFIRM = 300004,
		ERROR_HERO_SKILL_LEVEL_LIMIT = 2703,
		CANTEEN_CANT_OPERATE_TIPS1 = 210024,
		ERROR_NO_EQUIP = 2203,
		DORM_EDIT_SUCCESS = 210066,
		PASSPORT_WEEKLY_EXP_LIMIT_TIP = 71612,
		MATRIX_TERMINAL_GIFT_LACK = 160012,
		ERROR_COORDINATOR_ROOM_FULL = 6120,
		FRIEND_DELETE_QUEST = 60087,
		ERROR_RACE_TRIAL_FIRST_CLEAR_REWARD_CAN_NOT_APPLY = 14002,
		DORM_MOULD_CHOOSE_NULL = 210125,
		CLUB_BOSS_DIFFICULTY_3 = 280047,
		SHOP_OMEGA_CONFIRMATION = 71209,
		ERROR_FUNCTION_ITEM_TIME_INVALID = 2121,
		ERROR_BAD_TEMPLATE = 4,
		SUCCESS_REMOVE_SERVANT = 71042,
		POLYHEDRON_INTERACTIVE_SHOP_TITLE = 354045,
		CANTEEN_INGREDIENTS_UNCHOOSE = 210032,
		TEAM_1 = 250004,
		NO_ACTIVE_BATTLEPASS = 71610,
		FRIEND_MOVE_TO_BLACLIST_NOTE = 60090,
		ERROR_CLUB_MAX_REQUEST = 6031,
		FRIEND_MOVE_TO_BLACLIST_QUEST = 60089,
		WEAPON_MODULE_UNLOCK_TASK_NOT_COMPLETED = 80305,
		VOICE_STORAGE_FULL = 60237,
		ERROR_BATTLE_MYTHIC_STAR_REWARD_ILLEGAL = 10001,
		CANTEEN_ADMITTED_NULL = 210035,
		ERROR_POINT_NOT_ENOUGH = 17001,
		CANNOT_CONNECT_CHECK = 60080,
		CHOOSE_SERVANT_COMBINATION = 71307,
		TEXT_UPGRADE = 70072,
		CANTEEN_FOOD_REMOVE = 210028,
		ERROR_CLUB_NOT_IN_SAME_CLUB = 6008,
		ERROR_MATRIX_STARTED = 6501,
		CULTIVATE_HERO_CONTENT = 348004,
		FORMATION_PLAN_CHANGED = 300005,
		TIP_UPGRADE = 70012,
		TIME_DISPLAY_11 = 280011,
		ABYSS_LAYER_MAX_AWARD_TIP = 351013,
		TIP_EQUIPED = 70021,
		ERROR_RECEIVED_GIFT = 3301,
		ERROR_FIRST_CLEAR_REWARD_APPLIED = 16000,
		ACTIVITY_CLUB_FIGHT_HERO_NOT_FULL_TIP = 300113,
		TIME_OVER = 220009,
		ERROR_STAGE_NOT_CLEAR = 2011,
		DORM_VOICE_UNLOCK_TIP = 210069,
		TIP_CHANGE = 70082,
		CLUB_CHANGED_ICON_SUCCESS = 190007,
		SAVE_SYSTEM_SETTING = 60132,
		ADVANCED_TASK_CULTURE = 353100,
		DORM_FATIGUE_PER_HOUR = 210077,
		ACTIVITY_VOLUME_MATRIX_CLUE = 260018,
		OPEN_NEW_WARCHESS = 71401,
		SPECIAL_SKILL = 70063,
		EQUIP_IS_USING = 60071,
		MATRIX_PREPARE_GO_ADJUST = 160026,
		COOPERATION_ADD_FRIEND = 330007,
		ADVANCED_TASK_BATTLE_ABYSS = 353003,
		ACTIVITY_MATRIX_LACK_ALL = 260022,
		CS_INDEX_ERROR = 60102,
		ADVANCED_TASK_CULTURE_SKILL = 353101,
		DEFAULT_SORT = 70057,
		ERROR_CLUB_REFUSE_RECRUIT = 6030,
		INVESTIGATE_TIPS_3 = 280031,
		INFINITY_LOCK = 220001,
		ACTIVITY_VALENTINE_DESCRIPE = 347102,
		EQUIP_INHERIT_HERO = 71141,
		JUNE = 71707,
		HARDLEVEL_SINGULARITY = 60006,
		CHAPTER_CHALLENGE_2 = 330011,
		ACTIVITY_DEMON_CHALLENGE_DESCRIPE_61031 = 230002,
		SIGN_TITLE_DAILY = 71714,
		NEED_FINISH_PRE_STAGE = 60169,
		TIME_DISPLAY_15 = 280015,
		ERROR_ITEM_NOT_ENOUGH_DIAMOND = 2101,
		ERROR_NOT_FIND_RECOMMEND_INFO = 2414,
		ERROR_EQUIP_STRENGTH_EQUIP_IN_MAT = 2205,
		FRIEND_ONLINE_TIME_IN_ONE_DAY = 80102,
		CLUB_ACTIVITY_AFFIX_DESC = 300123,
		GIVE_UP_SOLO_CHALLENGE = 250015,
		ERROR_NO_INTERACT = 6603,
		EXCHANGE_CODE_ALERT2 = 80202,
		CANTEEN_STOP_TIPS1 = 210009,
		OUT_OF_STOCK = 50005,
		SYSTEM_LOCK = 70027,
		INITING = 70064,
		DORM_FOOD_SET_NULL = 210093,
		DORM_CANTEEN_JOB_NOT_SET = 210118,
		CLUB_BOSS_PREPOSE_FINISH_TIP = 190035,
		DORM_HERO_AT_WORK = 210002,
		DORM_CANTEEN_INGREDIENTS_NOT_ENOUGH = 210072,
		ACTIVITY_FINISH_ALL_SUMMER_CHESS = 250035,
		CLUB_BOSS_PREPOSE_FINISH_CONFIRM_TIP = 190033,
		XH1ST_SEAL_NOT_UNLOCK_TIP = 348007,
		ERROR_STRING_LENGTH_LIMIT = 2014,
		RACE_TYPE_6 = 71522,
		ERROR_MATRIX_NOT_EFFECTIVE = 60298,
		EQUIP_NUM_MAX = 60136,
		ERROR_POLYHEDRON_SHOP_REFRESH_TIMES_MAX = 22008,
		ERROR_CLUB_REQUEST_JOIN_MEMBER_FULL = 6034,
		POLYHEDRON_DIFFICULTY_HERO_ATTRIBUTE_DES = 354019,
		CHIP_HERO_USE_SUCCESS = 120029,
		CHALLENGE_ONCE_MORE = 60259,
		MARCH = 71704,
		DORM_EDIT_SAVE = 210078,
		CLEAR_EXTREME_DIFFICULTY = 220012,
		COMPLETE_TRAIL_STAGE = 220007,
		ANNIVERSARY_INFO = 348014,
		ERROR_SHOP_GOODS_NOT_IN_ITEM_LIST = 2604,
		EQUIP_RECOMMEND_1 = 71122,
		DORM_MOULD_USE_SUCCESS = 210113,
		ABYSS_DESC = 351008,
		MATRIX_NO_BATTLE_BUFF = 160020,
		ACTIVITY_DEMON_CHALLENGE_DESCRIPE_121031 = 345010,
		ERROR_MATRIX_CLOSED = 6504,
		EQUIP_ONE_CLICK_UNINSTALL_WARNING = 71136,
		DORM_HERO_AT_LOBBY = 210096,
		EXPLORE_UNLOCK = 250001,
		JANUARY = 71702,
		ERROR_CHAT_NODE_NOT_AVAILABLE = 2504,
		ACTIVITY_CLUB_VITALITY_RECOVER = 300125,
		ERROR_HERO_ARCHIVES_LV = 6703,
		ERROR_CLUB_VICE_CHAIRMAN_APPOINT = 190049,
		LOCK_TYPE_DESC3 = 60234,
		NOT_MEMNER_OF_CLUB = 190042,
		EQUIP_BREAK_THROUGH_REFRESH_DATA = 71458,
		ERROR_LOGIN_BEFORE_LOGIN = 1008,
		DRAW_LACK_UP_TIMES = 71309,
		POLYHEDRON_INTERACTIVE_HERO_TITLE_1 = 354040,
		ERROR_REDEMPTION_CODE_NOT_RECEIVE_CONDITION = 6408,
		CANTEEN_TASK_FINISH = 210036,
		REGRESSION_SIGN_DESCRIPE = 350005,
		CLUB_KICK = 190037,
		ERROR_SKULD_TRAVEL_ATTRIB_NOT_ACHIEVE = 19002,
		USER_REQUEST_JOIN_CLUB_SUCCESS = 6040,
		NORMAL_GIFTBOX = 80012,
		EQUIP_UPGRATE_SUCCESS = 60113,
		RECALLED_CODE_ERROR = 349002,
		ERROR_BATTLE_MYTHIC_NEW_DIFFICULTY_TIPS_READ = 10002,
		SCAN_RULES_4 = 280019,
		VOICE_DELETE_INFO = 60242,
		CHIP_CNT_MORE_THEN_MAX = 120008,
		POLYHEDRON_ARTIFACT_SUB_TYPE_3004 = 354006,
		ERROR_TEAMS_NO_EXIST = 3502,
		EXCEED_MAX_CNT = 190021,
		MATRIX_SELECT_HERO_PLZ = 160005,
		CLUB_CHANGED_NOTICE_SUCCESS = 190006,
		TIPS_SET_BIRTHDAY = 71808,
		BOSS_CHALLENGE_ADVANCE_DESC = 180014,
		MATRIX_TYPE_NOTE_9 = 140009,
		ERROR_LOGIN_INVALID_USER_MNESIA = 1006,
		CANTEEN_LEVEL_PREVIEW = 210037,
		SKILL_WITHOUT_MEMBER = 300011,
		SOLD_OUT = 71203,
		DORM_CANTEEN_COOK_DO = 210089,
		ADD_BLACKLIST_FRIEND_COMFIRMATION = 60241,
		COLLECT_WORD_TYPE_4 = 71504,
		DORM_POPULAR_EVENT_OPEN = 210006,
		ACTIVITY_MOONCAKE_GAMBLING_REWARD_5 = 260012,
		POLYHEDRON_REWARD_TITLE_EFFECT = 354028,
		CAN_NOT_CHANGE_HERO = 60179,
		ERROR_POLYHEDRON_SHOP_RECOVER_TIMES_MAX = 22009,
		TEXT_LEVEL_MAX = 70073,
		HERO_LOVE_LEVEL_MAX = 71258,
		CLUB_BOSS_TIPS_2 = 280039,
		SUIT_ACTIVE = 60117,
		CLUB_BOSS_OPEN_1 = 280041,
		EQUIP_BREAK_THROUGH_REWARD_TIPS = 71457,
		ERROR_BATTLE_NOT_RESURRECT = 3015,
		CURRENT_ASSISTANT = 190023,
		ERROR_INFINITY_POOL_BOX_ALREADY_OPENED = 13003,
		CLUB_FOUNDED_SUCCESS = 190000,
		DRAW_PROBABILITY_GUARANTEE = 71306,
		ERROR_CLUB_BOSS_CHALLENGE_FINISHED = 6046,
		ERROR_REDEMPTION_CODE_RECEIVE_THE_SAME_TYPE_2 = 6405,
		FRIEND_ONLINE_TIME_ONE_DAY_AGO = 80103,
		PUZZLE_HELP_REMAIN = 260003,
		ERROR_BATTLE_MYTHiC_DIFFICULTY_LOCKED = 10004,
		ERROR_CLUB_ALLOW_INVITE_SWITCH_OFF = 6010,
		DELETE_CHIP_SCHEME = 120015,
		ERROR_BACKHOME_DORM_NO_EXIST = 7120,
		ERROR_BACKHOME_HERO_NO_EXIST = 7119,
		ERROR_POLYHEDRON_BEACON_ALREADY_UNLOCK = 22011,
		ERROR_USER_LEVEL_LIMIT = 2009,
		ACTIVITY_CLUB_FIGHT_MEMBER_LOCK_TIP = 300110,
		ERROR_NOT_SECONDARY_CHIP = 6808,
		ERROR_WEAPON_SERVANT_NOT_EQUIP = 2306,
		REMOVE_LOCK = 71120,
		ERROR_BACKHOME_TEMPLATE_NO_EXIST = 7117,
		PHASE_1 = 320002,
		ACTIVITY_CLUB_NO_FIGHT_HERO_TIP = 300115,
		RACE_TYPE_8 = 71524,
		ACTIVITY_INTEGRATE_PT_DESC = 345001,
		CANTEEN_TASK_REFRESH_COOLDOWN = 210017,
		NO_MATERIAL = 70052,
		ERROR_HERO_STAR_LOW = 2707,
		ERROR_HERO_ASTROLABE_UNLOCKED = 2702,
		ERROR_BACKHOME_HERO_ALREADY_ENTRUST = 7103,
		ERROR_USED_SECONDARY_CHIP = 6806,
		DORM_UNLOCK_COST_TIPS2 = 210109,
		ITEM_TYPE_NOTE_1 = 100001,
		ERROR_MATRIX_BATTLE_SELECT_HERO_ILLEGAL = 6500,
		ACTIVITY_CUT_DESCRIPE = 341001,
		ERROR_BACKHOME_ARCHITECTURE_LOCK = 7100,
		MATRIX_SINGULARITY_HERO_UNLOCK = 160029,
		ERROR_BACKHOME_CANTEEN_ENTRUST_REFRESH_TIMES_MAX = 7106,
		PHASE_2 = 320003,
		SHARE_FAIL = 200005,
		MYTHIC_TEAM_RESET = 285011,
		ERROR_CHESS_REWARD_HAS_RECEIVED = 71406,
		TIP_CURIOSITY = 345004,
		ERROR_MATRIX_USE_ILLEGAL_WEAPON_SERVANT = 6526,
		DRAW_TIMES = 71304,
		GRAPHIC_RECOMMEND_2 = 280025,
		ABYSS_LAYER_RESET_CLICK_TIP = 351010,
		LIMIT_WEEK = 60121,
		ADVANCED_TASK_CULTURE_EXCLUSIVE = 353105,
		REFRESH_SUCCESS_ON_TIME = 50002,
		ERROR_BATTLEPASS_GOING_TO_STOP = 7003,
		CHIP_MANAGER_UNLOCK_SUCCESS = 120002,
		CLUB_NOVICIATE = 190041,
		LOCK_TYPE_DESC2 = 60233,
		CONSECUTIVE_DAYS = 80017,
		ERROR_NO_MAIL = 2900,
		ERROR_WEIBO_REWARD_COLLECTED = 6903,
		ERROR_MATRIX_START_SELECT_HERO_ILLEGAL = 6502,
		TIPS_SET_BIRTHDAY_SURE = 71809,
		COOPERATION_LEAVE_ROOM_CONFIRM = 330002,
		ENCHANTMENT_STAGE_REFRESH_TIMES = 60250,
		EQUIP_TYPE_2 = 71168,
		ERROR_REDEMPTION_CODE = 6400,
		MATRIX_TEAMINL_GIFT_UNLCOK = 160010,
		TEAM_2 = 250005,
		DRAW_FEEDBACK_INFO = 348016,
		PHASE_4 = 320005,
		SEND_SOCIETY_MESSAGE_ERROR = 190001,
		ALL_GOODS = 60270,
		ERROR_NO_CORRESPONDING_ARTIFACT = 6608,
		CANREEN_RECOMEND_HERO = 210134,
		ABYSS_BACK_TIP = 351012,
		CANNOT_DELETE_PRESET = 170003,
		CONFIRM_BUY = 60236,
		ERROR_USED_SECONDARY_CHIP_MAX = 6807,
		ERROR_MATRIX_WEAPON_REWARD_MAX = 6513,
		ERROR_PROPOSAL_EXIST = 6802,
		NO_HERO_EXP_MATERIAL = 60243,
		HERO_CANT_INTERACT = 210136,
		COOPERATION_NO_ALLOW_INVITE_FULL = 330008,
		ITEM_TYPE_NOTE_9 = 100009,
		UPGRADE_LIMIT_LEVEL_RED = 60207,
		ERROR_COORDINATOR_PLAYER_NOT_ONLINE = 6104,
		FISHING_GIVE_UP = 250027,
		POLYHEDRON_INTERACTIVE_SHOP_DES = 354044,
		ERROR_OVERFLOW_MAIL_NUM_LIMIT = 2901,
		ACTIVITY_CLUB_DANGEROUS_DESC_OLD = 300121,
		ERROR_HERO_ARCHIVES_GIFT_TIMES = 6704,
		SEND_MESSAGE_ERROR = 150005,
		EQUIP_INHERIT_SUCCESS = 71148,
		RECALLED_DESC = 349003,
		DONOT_MEET_CONDITION = 180006,
		CANTEEN_TAKS_CANCEL = 210034,
		CLUB_BOSS_DIFFICULTY_2 = 280046,
		MATRIX_TYPE_NOTE_8 = 140008,
		COOPERATION_INVITE_OVERDUE = 330012,
		ERROR_ALREADY_SWITCH_DETECTOR = 6614,
		DELETE_CHIP_SCHEME_SUCCESS = 120016,
		EQUIP_STAGE_INSURE = 71451,
		ERROR_ABYSS_LAYER_NOT_UNLOCK = 21000,
		POLYHEDRON_TEAM_SET_FULL = 354030,
		ERROR_ITEM_NOT_ENOUGH_INFO_BADGE_LOW = 2114,
		SEND_MESSAGE_FREQUENTLY = 150002,
		POLYHEDRON_ARTIFACT_TITLE_2 = 354033,
		DORM_MOULD_SET_CHECK = 210117,
		COLLECT_WORD_TYPE_5 = 71505,
		ERROR_ITEM_NOT_ENOUGH_GOLD = 2100,
		ERROR_COORDINATOR_CONNECT_BATTLE_SERVER_FAILED = 6110,
		DORM_DELETE_TEMPLATE = 210135,
		ERROR_RETURN_GOING_TO_STOP = 3303,
		EXCLUSIVE_SKILL_UNLOAD = 71177,
		EQUIP_BREAK_THROUGH_RESET_DIFFICULTY = 71456,
		SHARE_PLATFORM = 60288,
		SHOP_NOT_OPEN = 260024,
		ERROR_RETURN_BP_HAS_BUY = 3302,
		INPUT_EQUIP_PROPOSAL_NAME = 71100,
		ERROR_RPC_EXCEPTION = 9,
		HERO_RECORD_GIFT_LIKE = 71251,
		ERROR_NO_EXPLORE = 6600,
		MAIL_STAR_DELETE_TIP = 60268,
		LOADING = 70028,
		ERROR_MATRIX_NOT_ENOUGH_ITEM = 6535,
		ERROR_MATRIX_EVENT_TYPE_ILLEGAL = 6531,
		TEAM = 300009,
		SAVE_PHOTO_SUCCESS = 200007,
		DORM_HERO_NOT_SET = 210075,
		XH1ST_SEAL_CONTENT = 348010,
		CLUB_SAVE_SETTING = 190010,
		CLUB_SHARE_CD_TIPS = 190043,
		ERROR_ITEM_DIAMOND_FATIGUE_TIMES_OVER_LIMIT = 2110,
		CLUB_BOSS_DIFFICULTY_1 = 280045,
		RESET_CAMERAANDKEYBOARD = 280023,
		ITEM_TYPE_NOTE_4 = 100004,
		LABEL_DISCOUNT = 80023,
		SIGN = 71701,
		ACTIVITY_SUMMER_FISH_DESCRIPE = 250020,
		DORM_SAME_HERO_CHOOSE = 210114,
		ACTIVITY_CROSSWAVE_DESCRIPE = 250036,
		MYTHIC_FINAL_TIPS = 285010,
		COLLECT_WORD_TYPE_6 = 71506,
		ERROR_LOGIN_WRONG_PASSWORD = 1001,
		GUILD_BOSS_CD_TIP = 190029,
		ASTROLABE_UNLOCK = 60114,
		CLUB_BOSS_DIFFICULTY_UNLOCK_TIP = 190031,
		ERROR_NO_MOVE = 6604,
		LACK_CURRENCY = 50006,
		ERROR_CLUB_ID = 6029,
		ERROR_RECHARGE_DIAMOND_NOT_ENOUGH = 80001,
		SOLO_TIME_OVER = 250010,
		ERROR_USER_NOT_ACHIEVE_CONDITION = 2005,
		ERROR_PLATFORM_SURVEY_NOT_FINISHED = 6900,
		ERROR_ITEM_NO_RESOURCE_ID_IN_CONFIG = 2106,
		LIMIT_MONTH = 60122,
		NOT_IN_OPEN_TIME = 70026,
		SIGN_TITLE_SEGENDAY = 71716,
		SERVANT_TRANSCEND = 71059,
		WEAPON_MODULE_DESCRIPE = 80310,
		CANTEEN_SELL_INFO = 210040,
		CLUB_BOSS_PREPOSE_TIP = 190027,
		MAY = 71706,
		ACTIVITY_SPRING_FESTIVAL_RIDDLE_FINISH = 341006,
		ALL = 60026,
		MATRIX_SINGULARITY_HERO_LEVEL_UNLOCK = 160030,
		MORE_THEN_MAX_SCHEME_CNT = 120012,
		DORM_FURNITURE_SET_MAX = 210056,
		MATRIX_AFFIX_RATE = 160011,
		SHOP_SECONDARY_CONFIRMATION = 71207,
		ABYSS_STAGE_RESET_TIP = 351002,
		NOT_PERMISSION = 60064,
		CLUB_SHARE_TIPS_1 = 280049,
		DORM_DISPLAY_ALREADY = 210115,
		ABYSS_LAYER_RESET_TIP = 351005,
		CLUB_KICK_TIMES_MAX = 190045,
		WARN_HIGH_FPS_BATTLE_TIPS = 60300,
		ERROR_RECHARGE_TOTAL_RECHARGE_REWARD_HAS_RECEIVE = 6214,
		ERROR_MATRIX_ASTROLABE_REWARD_MAX = 6510,
		DORM_HERO_ROOM_NAME = 210063,
		PAY_SUCCESS = 80013,
		BOSS_CHALLENGE_MODE_DESC = 180013,
		ERROR_CHAT_ROOM_FULL = 2503,
		EQUIP_SUIT_NUM = 71126,
		ERROR_RECHARGE_MONTH_CARD_REWARD_DELIVERED = 6211,
		DORM_MOULD_COVER = 210057,
		TEAM_3 = 250006,
		DELETE_LOCAL_CACHE = 60146,
		SERVANT_EQUIPED = 71053,
		NO_MAIL_CAN_BE_DELETED = 71001,
		COLLECT_WORD_TYPE_0 = 71500,
		ACTIVITY_FISHING_BUFF_NAME_2 = 250029,
		CLEAR_DIFFICULTY = 220011,
		ACTIVITY_SUMMER_ARTIFACT_DESCRIPE = 250002,
		POLYHEDRON_INTERACTIVE_HERO_DES_2 = 354038,
		CHIP_HERO_UNLOAD_SUCCESS = 120030,
		BATTLEPASS_REFRESH_TIME = 71604,
		ERROR_HERO_ARCHIVES_LOCK = 6700,
		MATRIX_ARTIFACT_RARE3 = 110003,
		CLEAR_NORMAL_DIFFICULTY = 220010,
		ERROR_CLUB_USER_NOT_JOIN_CLUB = 6001,
		ACTIVITY_SOLO_SLAYER_DESCRIPE = 347101,
		NEWBIE_CANNOT_GET_WELFARE = 190017,
		ACTIVITY_VALENTINE_REWARD_NEED_DESC = 347111,
		ERROR_EQUIP_POS_LIMIT = 2221,
		SERVANT_PROMOTE_LEVEL_1 = 71052,
		ERROR_SKULD_TRAVEL_ENDING_ALREADY_EXIST = 19001,
		ERROR_COORDINATOR_BATTLE_RESULT_REPEATED = 6108,
		ERROR_COORDINATOR_ROOM_ARG_ILLEGAL = 6103,
		CHALLENGE_TIME = 180009,
		CANTEEN_TASK_FATIGUE_NOT_ENOUGH = 210021,
		CLUB_NEED_NAME = 190004,
		HAZARD_ZONE_REFRESH = 60286,
		POLYHEDRON_INTERACTIVE_HERO_TITLE_2 = 354041,
		NUM_4 = 60279,
		ERROR_COORDINATOR_BATTLE_NO_EXIST = 6106,
		ERROR_NET_DATA_ILLEGAL = 201,
		MATRIX_RANK_NO_INFO = 160018,
		FACTORY_ACTIVITY_POINT_REWARD = 320017,
		PRESET_MORE_THAN_MAX = 170002,
		WARN_HIGH_FPS_TIPS = 60299,
		CANNOT_ADD_SELF = 60240,
		ERROR_RECHARGE_ORDER_APP_ID = 6200,
		ERROR_REDEMPTION_CODE_RECEIVE_THE_SAME_TYPE_3 = 6406,
		ACTIVITY__BUBBLES_CONTENT = 250021,
		ERROR_CLUB_MEMBER_SIGNED_TODAY = 6013,
		CURRENCY_SHORTAGE = 220003,
		SUCCESS_EXCHANGE_CODE = 60163,
		ERROR_COORDINATOR_NOT_SELF_TARGET = 6114,
		TIP_RECOMMEND = 70015,
		IGNORE_ALL_FRIEND_REQUEST = 60238,
		POLYHEDRON_ARTIFACT_SUB_TYPE_3001 = 354003,
		CANTEEN_MONEY_TIPS3 = 210027,
		MATRIX_TERMINAL_NO_REFRESH_TIMES = 160032,
		CHANGE_SERVER = 270001,
		MATRIX_TERMINAL_GIFT_UNLOCK_SUCCESS = 160013,
		ERROR_FUNCTION_NOT_OPEN = 10,
		DORM_MOULD_DATA_NULL = 210126,
		SHOP_EXPIRED = 71206,
		ABYSS_LAYER_CHALLENGING_RESET_TIP = 351004,
		CHANGE_ASSISTANT_ROLE = 190024,
		ERROR_FRIEND_NOT_EXIST_REQUEST = 2409,
		DORM_AREA_NOT_OPEN = 210130,
		DORM_LOBBY_NAME = 210053,
		ERROR_CLUB_NOTICE_LENGTH = 6037,
		ACTIVITY_SOLO_SLAYER_DESC = 320007,
		ERROR_HERO_EXCLUSIVE_SKILL_LEVEL_MAX = 2733,
		NO_SERVANT_BE_SELECTED = 71041,
		ACTIVITY_TOWER_DEFENSE_DESC = 320009,
		POLYHEDRON_TERMINAL_LEVEL_UNLOCK = 354012,
		CLUB_IMPEACH_TIPS = 190046,
		CLUB_WELFARE_OPEN = 190018,
		GIVE_UP_MATRIX = 160021,
		MYTHIC_FINAL_GIVEUP = 285008,
		EQUIP_RECOMMEND_2 = 71123,
		ERROR_CLUB_REQUEST_JOIN_LEVEL_LIMIT = 6033,
		ACTIVITY_XUHENG_PT_EXLOCK = 348002,
		POLYHEDRON_LOBBY_BUTTON_CONTINUE = 354021,
		MATRIX_SELECT_BEACON = 160015,
		ERROR_FRIEND_BLACK_NUM_LIMIT = 2410,
		ERROR_BACKHOME_CANTEEN_LOCK = 7107,
		THOR_STRATEGY_UNLOCK = 345024,
		GRAPHIC_RECOMMEND_1 = 280024,
		ACTIVITY_MUSIC_DESCRIBE = 290010,
		NOTE_SKILL_LIMIT = 60178,
		DOWNLOAD_FAIL = 70035,
		MATRIX_TYPE_NOTE_1 = 140001,
		BOSS_LEVEL_3 = 180003,
		ERROR_HERO_LEVEL_LOW = 2709,
		CHIP_UNLOCK_SUCCESS = 120006,
		NO_ANNOUNCEMENT = 71020,
		ACTIVITY_MOONCAKE_GAMBLING_REWARD_2 = 260009,
		MATRIX_ARTIFACT_RARE2 = 110002,
		DORM_RECOMMEND_CD = 210103,
		ERROR_EQUIP_LOCKED_SUCCESS = 71160,
		ERROR_COORDINATOR_NOT_READY = 6119,
		CHIP_CONFLICT = 120010,
		REPORT_REASON_SEX = 151004,
		ERROR_NO_TEMPLATE = 3,
		DORM_ROOM_UNLOCK_TIPS = 210064,
		CHOOSE_REFINE_COST = 71044,
		NO_ERROR_PARAMS = 70071,
		REPORT_REASON_NICK = 151006,
		ERROR_ALREADY_RECOVERY_DETECTOR = 6615,
		ERROR_CLUB_OVER_SIGN_EXTRA_TIME = 6019,
		CONFIRM_RESET = 346003,
		MONTHLYCARD = 80006,
		MYTHIC_DESCRIPE = 60189,
		SHARE_URL = 200003,
		DORM_FATIGUE_COST = 210107,
		ACTIVITY_CHAPTERIII_DOWN_PT_DESCRIBE = 290004,
		ACTIVITY_MOONCAKE_GAMBLING_REWARD_1 = 260008,
		BUY_TREASURE_SKIN_TIP = 80026,
		REPORT_REASON_OTHER = 151005,
		EQUIP_BREAK_THROUGH_INFO = 71454,
		EQUIP_ON = 71163,
		ERROR_CLUB_NAME_EXIST = 6006,
		CANTEEN_CUSTOMER_SERVE_TIPS3 = 210014,
		POLYHEDRON_DEFENSE_DESCRIBE = 354052,
		CLUB_ACTIVITY_MAX_DOMAIN = 300118,
		CANTEEN_HOT_DESC = 210016,
		EQUIP_ENCHANT_RESULT_NUM = 71127,
		UPGRADE_LIMIT_LEVEL = 60206,
		CANTEEN_TASK_TIME = 210018,
		CLUB_CAPTAIN_CANNT_EXIT = 190008,
		NOT_ENOUGH_POWER = 60212,
		MATRIX_CLEARANCE_SPECIAL_DIFFICULTY_UNLOCK = 160028,
		EXPIRED_MINUTE = 71006,
		ERROR_TEAMS_NUMBER = 3505,
		HAZARD_ZONE_UPGRADE = 280027,
		POLYHEDRON_LIFE = 354053,
		ERROR_HERO_ASTROLABE_ILLEGAL = 2717,
		ACTIVITY_RACE_CONTENT = 290002,
		IN_TEAM = 60211,
		DORM_LEVEL_TIPS = 210088,
		ERROR_MATRIX_TERMIANL_CAN_NOT_UPGRADE = 6521,
		WEAPON_MODULE_SKILL_TIP_TEMPLATE_3 = 80302,
		TIP_HERO_RARE = 70079,
		ERROR_MATRIX_SEASON_MISSIONS_TIME = 160031,
		ERROR_BATTLE_MYTHIC_REWARD_NO_RECEIVED = 10003,
		POLYHEDRON_DEFENSE = 354051,
		IS_IN_SHOW = 60059,
		DORM_MOULD_NAME_NULL = 210094,
		DORM_CANTEEN_FURNITURE_KITCHEN = 210083,
		ERROR_NO_UNLOCK_AFFIX = 3206,
		ERROR_MATRIX_ALREADY_GOT_POINT_REWARD = 6517,
		EXPIRED_DAY = 71004,
		MISSION_DAILY = 71601,
		PAGE_NO_USE = 70067,
		ITEM_TYPE_NOTE_6 = 100006,
		ERROR_NO_UNLOCK_PLOT = 3205,
		ACTIVITY_FIRST_PRICE = 352007,
		CHIP_MANAGER_UNLOAD_SUCCESS = 120004,
		ERROR_BATTLE_HISTORY_ID = 9000,
		EXCLUSIVE_DESCRIPE = 71181,
		POLYHEDRON_ATTACK_DESCRIBE = 354050,
		CLUB_REMOVE_MEMBER = 190020,
		CONNECT_DATA_ERROR = 60101,
		ERROR_BATTLE_CHAPTER_NOT_UNLOCKED = 3000,
		ERROR_NO_DATA = 101,
		ACTIVITY_CLUB_NORMAL_GRID_GIVEUP_CONFIRM = 300105,
		ACTIVITY_CLUB_REGISTER_SUCCESS = 300101,
		SELECT_CURRENT = 60244,
		ERROR_MATRIX_HERO_ILLEGAL = 6506,
		CANTEEN_CUSTOMER_SERVE_TIPS4 = 210015,
		OCTOBER = 71711,
		ACTIVITY_TYR_PT_DESC = 347109,
		POLYHEDRON_ATTACK = 354049,
		NEED_REPORT_REASON = 151008,
		CHIP_UNLOCK_FAILED = 120005,
		EQUIP_HERO_SKILL_NEXT_LEVEL = 71137,
		MYTHIC_NEW_LEVEL_UNLOCK = 285009,
		ERROR_ITEM_NOT_ENOUGH_FATIGUE = 2109,
		PURCHASE_SYSTEM_NOT_OPEN = 250009,
		POLYHEDRON_REWARD_TITLE_COIN = 354026,
		LEFT_TOP = 170013,
		DORM_AREA_LAYER = 210050,
		DORM_FURNITURE_NULL = 210051,
		RIGHT_TOP = 170015,
		EXCLUSIVE_SKILL_LOAD = 71176,
		DOWNLOADED = 70050,
		ACTIVITY_BUBBLES_DESCRIPE = 250037,
		ERROR_LOGIN_SERVER_ID_CHECK_FAIL = 1002,
		COOPERATION_ALREADY_FRIEND = 330006,
		CHIP_HERO_UNLOCK_SUCCESS = 120028,
		POLYHEDRON_TERMINAL_LEVEL_POINT = 354015,
		ERROR_HERO_EXCLUSIVE_SKILL_REPEAT = 2736,
		MATRIX_SELECT_TEAM_LEADER = 160006,
		SERVANT_TRANSCEND_PROMPT = 71061,
		MATRIX_DESCRIPE = 60231,
		CHIP_USE = 120020,
		NEWBIE_GIFTBOX = 80019,
		HERO_RECORD_HEART_CHAIN = 71253,
		ACTIVITY_CLUB_REMOVE_TEAM_TIP = 300111,
		KICK_BY_SERVER = 60099,
		AT_LAST_CNT = 340005,
		WHETHER_TO_CONSUME = 71303,
		SEQUENTIAL_BATTLE_TEAM_IS_NULL = 340001,
		CANTEEN_QUIT_CONFIRM = 210041,
		SERVANT_MERGE = 70005,
		ACTIVITY_TOWER_DEFENSE_REWARD = 320010,
		ACTIVITY_HELLA_TALENT_DESCRIPE = 230006,
		MATRIX_TYPE_NOTE_4 = 140004,
		ACTIVITY_XUHENG_PT_DESCRIBE = 348001,
		ERROR_HERO_SKIN_ILLEGAL = 2718,
		ACTIVITY_FIRE_WORK_PHASE = 341010,
		ERROR_HERO_PIECE_NOT_OVERFLOW = 2716,
		XH1ST_SEAL_NOT_MAIN_REWARD_TIP = 348008,
		ADVANCED_TASK_CULTURE_WEAPON = 353102,
		UNLOCK_INFINITY_RESET_TIPS = 220018,
		DORM_MOULD_NAME_CHANGE = 210062,
		TIME_DISPLAY_4 = 280004,
		SOLO_NOT_OPEN = 250011,
		DORM_CANTEEN_LEVEL = 210074,
		MATRIX_ARTIFACT_RARE1 = 110001,
		POLYHEDRON_REWARD_TITLE_ARTIFACT_UP = 354025,
		ERROR_HERO_SKILL_LEVEL_SUM_LOW = 2711,
		NOTE_ENERGYTYPE_4 = 60290,
		CANTEEN_JOB_SET = 210131,
		FRIEND_ONLINE_TIME_WITHIN_AN_HOUR = 80101,
		CAN_NOT_TEACH = 70076,
		CANTEEN_TASK_CANT_CHOOSE = 210023,
		ERROR_MATRIX_ENTER_ARG_ILLEGAL = 6536,
		ERROR_ITEM_NOT_ENOUGH_RECALL_CHAPTER = 2115,
		MATRIX_TERMINAL_LEVEL_UNLOCK = 160003,
		CANTEEN_MONEY_TIPS2 = 210026,
		ACTIVITY_FIRST_UNLOCK_PROMPT = 352006,
		ERROR_MATRIX_REWRAD_ITEM_BAD_ARGS = 6522,
		PASSPORT_TASK_LAST_TIME = 71611,
		BATTLEPASS_BOUGHT = 71608,
		SAVE_PRESET_TIPS = 170005,
		ITEM_TYPE_NOTE_8 = 100008,
		MONTHLY_CARD_ONCE_GET_2 = 60295,
		ACTIVITY_HERO_PRESENT = 341009,
		INVESTIGATE_TIPS_1 = 280029,
		ERROR_BACKHOME_POS_HAD_DORM = 7122,
		ERROR_BACKHOME_HERO_ALREADY_CAREER = 7104,
		TIP_COGNITION = 345006,
		CANNOT_CONNECT_BATTLE = 60165,
		ABYSS_STAGE_CHALLENGING_RESET_TIP = 351001,
		ERROR_HERO_NO_HERO = 2701,
		ERROR_NET_DATA_INCOMPLETE = 200,
		ERROR_SHOP_GOODS_OPEN_TIME = 2605,
		ERROR_SHOP_PIECE_LIMIT = 2608,
		WEAPON_MODULE_SKILL_TIP_TEMPLATE_4 = 80303,
		TIP_SELECTING = 347107,
		ERROR_RECHARGE_MONTH_CARD_EXPIRED = 6210,
		CULTIVATE_HERO_REWARD = 348005,
		DORM_UNLOCK_COST_TIPS1 = 210108,
		ERROR_CLUB_USER_REQUEST_JOIN_MAX = 6003,
		HERO_RECORD_GIFT_HATE = 71252,
		EXCLUSIVE_CORE = 71180,
		TIME_DISPLAY_6 = 280006,
		ERROR_USER_MAX_LV = 2000,
		POLYHEDRON_DIFFICULTY_UNLOCK = 354034,
		BOSS_CHALLENGE_ADVANCE_UNLOCK_TIPS = 180008,
		EQUIP_RECOMMEND_3 = 71124,
		POLYHEDRON_TREASURE_LEVEL = 354048,
		BOSS_CHALLENGE_RESET_MODE = 180015,
		EQUIP_RACE = 71046,
		TIP_CHOOSE_EMPTY = 60284,
		ERROR_MAP_LOCK = 6605,
		XH1ST_SEAL_DESC = 348009,
		PLAYER_LEVEL_UNLOCK_SHOP_GOODS = 80003,
		ABYSS_BATTLE_FAIL_TIP = 351014,
		SHARE_TITLE = 200001,
		NOT_HAVE_HERO_SKIN_CONFIRM = 80002,
		MATRIX_TERMINAL_GIFT_UPGRADE_SUCCESS = 160014,
		ACTIVITY_MARDUK_PT_DESC = 320015,
		ACTIVITY_MATRIX_LACK_EQUIP = 260021,
		ERROR_TIMESTAMP = 11,
		PASS_ALL = 340006,
		COLLECT_WORD_TYPE_1 = 71501,
		SKIN_SALE_FINISH = 80005,
		WEAPON_MODULE_UNLOCK_NOT_ENOUGH = 80307,
		EQUIP_SEND_MAIL = 60140,
		ERROR_CLUB_MEMBER_JOIN_TIME_IN_PROTECTING = 6050,
		CLUB_APPLY_CAPTAIN_TIPS = 190047,
		CAPTAIN_ROLE_MISSING = 300001,
		ERROR_RECOMMEND_REFRESH_TOO_FAST = 2415,
		TIP_EXCHANGE = 70014,
		DORM_MOULD_SET_SUCCESS = 210124,
		ERROR_ABYSS_NO_STAGE_RESET_TIME = 21004,
		ACTIVITY_THOR_STRATEGY_MATRIX_DESCRIBE = 345015,
		ERROR_BACKHOME_INGREDIENT_LACKING = 7101,
		COOPERATION_NOT_JOIN_AFTER_OTHERS_READY = 330013,
		BASE_PROPERTY_UP = 70061,
		GRAPHIC_RECOMMEND_3 = 280026,
		ERROR_FRIEND_CANT_FIND_FRIEND = 2400,
		EQUIP_INHERIT_LOCK = 71140,
		IP_UNKNOWN = 71805,
		ACTIVITY_XUHENG_PT_LOCK = 348017,
		ERROR_PLATFORM_SURVEY_HAS_RECEIVED = 6901,
		ACTIVITY_CLUB_QSDK = 300127,
		ERROR_MYTHIC_REFRESH = 285012,
		ERROR_NUM_LIMIT = 2016,
		SUCCESS_SAVE_EQUIP_PROPOSAL = 71102,
		ERROR_CLUB_NOT_SIGN_EXTRA_TIME = 6018,
		GONGHUIBOSS_LIEXIZHENGZHAO = 280035,
		ERROR_SERVANT_LOCKED = 2302,
		CHAPTER_CHALLENGE_1 = 330010,
		RECHARG = 80010,
		ERROR_SERVANT_REFINED_MAX_TIMES_LIMIT = 2301,
		ERROR_BATTLE_CAN_NOT_GET_STARS_REWARD = 3001,
		ERROR_EQUIP_SAME_ID = 2220,
		ERROR_LOGIN_BLACKLIST_USER = 1005,
		COOPERATION_NO_ALLOW_READY_REPEAT = 330005,
		ACTIVITY_DEMON_CHALLENGE_DESCRIPE_121841 = 345021,
		ERROR_EQUIP_EXCEED_LIMIT = 2214,
		EQUIP_CULTIVATE = 71165,
		SAVE_PHOTO_FAIL = 200008,
		NEED_JOIN_CLUB = 150009,
		MYTHIC_FINAL_REWARD_TIPS = 285003,
		POLYHEDRON_LIFE_DESCRIBE = 354054,
		CLUB_SHARE_TIPS_4 = 280052,
		ACTIVITY_SPRING_FESTIVAL_COUPLETS_DESCRIPE = 341002,
		ERROR_EQUIP_NO_RESOLVE_USING_EQUIP = 2206,
		WEAPON_MODULE_MATERIAL_NOT_ENOUGH = 80308,
		ACTIVITY_CLUB_ELITE_GRID_GIVEUP_CONFIRM = 300106,
		ERROR_HERO_ULTRA_SKILL_LEVEL_LIMIT = 2726,
		PUZZLE_HELP = 260004,
		POLYHEDRON_TERMINAL_CLASSIFY_3 = 354002,
		DELETE_PRESET = 170004,
		ERROR_NO_CORRESPONDING_KEY = 6607,
		ACTIVITY_FIRST_CHARGE = 352003,
		ERROR_ITEM_TIME_INVALID = 2120,
		DORM_CANTEEN_CANT_LEVEL_UP = 210080,
		CLUB_RENANE_SUCCESS = 190005,
		ACTIVITY_DEMON_CHALLENGE_DESCRIPE_91031 = 290009,
		POLYHEDRON_ARTIFACT_SUB_TYPE_3006 = 354008,
		ACTIVITY_STRATEGY_TITLE_3 = 290017,
		EQUIP_TYPE_1 = 71167,
		EQUIP_INHERIT_SELECT = 71149,
		NO_EXCLUSIVE_CORE = 71172,
		ACTIVITY_RACE_DESCRIPE = 290001,
		CANNOT_SWITCH_WEAPON_STATE = 170008,
		ERROR_INFINITY_POOL_NOT_GET_PRE_POOL_CORE_ITEM = 13000,
		ERROR_NOT_KERNEL_CHIP = 6804,
		CLUB_BOSS_BLOOD_CONDITION_TIP2 = 190026,
		CLUB_REFRES_TEXT = 190009,
		HERO_FAVORABILITY_UNLOCK = 210132,
		ERROR_USER_COMPLETED = 2002,
		SCAN_TIPS_2 = 280033,
		MATRIX_TYPE_NOTE_6 = 140006,
		ERROR_RECALL_CODE_NOT_EXIST = 20000,
		ITEM_TYPE_NOTE_7 = 100007,
		TIP_EXPIRED = 70022,
		ERROR_LOGIN_PLATFORM_REJECT = 1009,
		EXCHANGE_TIP = 280037,
		DORM_FOOD_SET_SUCCESS = 210092,
		ERROR_TEAMS_IN_STAGE = 3507,
		UPGRADE_STAR_SUCCESS = 60126,
		TIP_STRENGTH = 70019,
		ERROR_RECHARGE_DIAMOND_NOT_ENOUGH_NO_BUY = 80018,
		SKIP_BATTLE_3 = 71405,
		DORM_CANTEEN_TASK_NAME = 210071,
		MARDUK_SPECIAL_NOTE = 320016,
		ERROR_FRIEND_NUM_LIMIT_TARGET = 2407,
		ERROR_NOT_INTERNAL_DEPLOY = 16,
		MATRIX_CLEARANCE_DIFFICULTY_UNLOCK = 160004,
		MATRIX_BEACON_UNLOCK_SUCCESS = 160001,
		ERROR_BAD_ARG = 5,
		CHALLENGE_MAX_POINT = 180011,
		ERROR_MATRIX_USE_ILLEGAL_ASTROLABE = 6527,
		HARDLEVEL_EASY = 60004,
		ACTIVITY_HELLA_SLAYER_DESCRIPE = 230003,
		WEAPON_STRENGTH_EXP_OVERFLOW_AND_RARE = 60219,
		ERROR_BACKHOME_DORM_ALREADY_SET_HERO = 7115,
		ERROR_TEAM_NO_EXIST = 3503,
		PAY_FAIL = 80014,
		ACTIVITY_COWBOY_ROUND = 260015,
		ERROR_HERO_STAR_MAX = 2705,
		COOPERATION_SOMEONE_UNREADY = 330003,
		MUTE_TIME_FORMAT = 151011,
		CANNOT_CONNECT_RE_LOGIN = 60147,
		ERROR_MATRIX_NOT_IN_PROGRESS = 6505,
		ERROR_MATRIX_PRE_CONDITION_NOT_CLEAR = 6537,
		ERROR_MULTIPLE_BATTLES_REQUIREMENT = 71409,
		ACTIVITY_CUT_POINT_REWARD = 341008,
		TIP_MINUTE = 60074,
		BOSS_CHALLENGE_RESET = 180016,
		DEMON_CLEAR_DIFFICULTY = 345019,
		DORM_CANTEEN_REFRESH_TIME = 210128,
		REMOVE_CONFIRMED = 346005,
		CHIP_HERO_UNLOCK_FAILED = 120027,
		HERO_LOVE_LEVEL_MAX_NOTE = 71257,
		ERROR_CLUB_ALREADY_SIGN_TWICE = 6020,
		USE_SKIN_CHANGE = 80016,
		ACTIVITY_CLUB_NEXT_MAP_LOCK_TIP = 300109,
		MISSION_CHALLENGE = 71603,
		ERROR_PROPOSALS_MAX = 6803,
		ERROR_EQUIP_LOCK = 2204,
		ERROR_INVALID_OPERATION = 2,
		CLUB_IMPEACH_CD = 190011,
		ERROR_EQUIP_IN_PROPOSAL = 2207,
		GIVE_UP_PUZZLE = 260005,
		HERO_IN_OTHER_TEAM = 340003,
		HERO_UPGRATE_SUCCESS = 60111,
		POLYHEDRON_TERMINAL_UNLOCK_SUCCESS = 354011,
		NEW_ADD = 80025,
		ERROR_MATRIX_ACCOMPLISH_NOT_ENOUGH = 6533,
		POLYHEDRON_HP_REWARD_TIP = 354055,
		SCAN_TIPS_1 = 280032,
		ACTIVITY_SOLO_SLAYER_REWARD = 320008,
		CHIP_MUTEX_TEXT = 120019,
		RECALLED_CODE_LIMIT = 349001,
		REPORT_REASON_ABUSE = 151003,
		CLUB_BOSS_DIFFICULTY_CANT_TIP = 190036,
		TRAVEL_SKULD_ENDING_OPEN = 345008,
		CONFIRM = 70038,
		WORLD_CHANNEL_ERROR = 150008,
		ERROR_ABYSS_HERO_BLOCKER = 21002,
		DORM_LEVEL_AWARD_VOICE = 210046,
		DORM_CANTEEN_LEVEL_UNLOCK = 210127,
		CHAT_CUSTOM_STICKER_LIMIT_EXCEEDED = 150010,
		ERROR_SHOP_REFRESH_TIMES_LIMIT = 2601,
		CHIP_UNLOAD_SUCCESS = 120009,
		ACTIVITY_CLUB_HERO_NOT_ENOUGH = 300126,
		EQUIP_RACE_REBUILD_FIRST = 71132,
		DORM_DISPLAY_SET_SUCCESS = 210116,
		BATTLEPASS_LEVEL_UNLOCK_REWARD = 71606,
		LIMIT_DAY = 60120,
		DORM_CANTEEN_UNLOCK_CONDITION = 210119,
		ACTIVITY_RACE_AMOUNT_REWARD = 290007,
		SHARE_CONTENT = 200002,
		ERROR_MATRIX_BEACON_OVER_LIMIT = 6528,
		VERIFY_ASSETS_HAS_ERROR = 60265,
		WEIBO_REWARD_SENT = 60258,
		ACTIVITY_RACE_UNLOCK = 290003,
		ERROR_SERVANT_COST_NUM = 2309,
		MYTHIC_FINAL_LEVEL_RETRY = 285007,
		MUTE_TIME_TEXT = 151010,
		ERROR_BACKHOME_CANTEEN_FOOD_LOCK = 7108,
		MONTHLY_CARD_DAILY_GET_1 = 60294,
		POLYHEDRON_RESURRECTION_TIMES = 354047,
		ACTIVITY_MUSIC_LEVEL_1 = 290011,
		AFFIX_UNREADY_SOLO_CHALLENGE = 250017,
		SEND_STICKER_FREQUENTLY = 150003,
		DORM_MOULD_CANT_SET = 210102,
		ERROR_COORDINATOR_NOT_BATTLE_SERVER = 6105,
		DORM_CANTEEN_LEVEL_NOT_ENOUGH = 210081,
		MONTHLY_CARD_PRICE = 60292,
		XH1ST_SEAL_TICKET_FINISH_TIP = 348011,
		WEAPON_MODULE_SKILL_TIP_TEMPLATE_5 = 80304,
		POLYHEDRON_TERMINAL_GIFT_UNLCOK = 354013,
		MISSION_WEEKLY = 71602,
		CANTEEN_FOOD_UNCHOOSE = 210031,
		CANTEEN_CAN_NOT_OPERATE = 210011,
		ACTIVITY_GIFTBOX = 80011,
		ERROR_LOGIN_USED_ACCOUNT = 1000,
		DORM_EDIT_CANCEL = 210068,
		ERROR_MATRIX_ASTROLABE_CAN_NOT_REPLACE_PRE = 6511,
		POLYHEDRON_TERMINAL_CLASSIFY_2 = 354001,
		ERROR_SHOP_NOT_FOUND = 2600,
		ERROR_CLUB_INVITER_ID_NOT_EXIST = 6009,
		PASS_LEVEL_UNLOCK = 60125,
		ACTIVITY_SOLO_CHALLENGE_DESCRIPE = 250018,
		ACTIVITY_WARCHESS_RECOVER = 71407,
		ERROR_BATTLE_CHALLENGE_BATTLE_NOT_UNLOCKED = 3006,
		ERROR_NO_UNLOCK_ENEMY = 3202,
		DOWNLOAD_START = 70033,
		DORM_GIFT_TIPS = 210048,
		ACTIVITY_LIMIT_CALCULATION_PLAYER_LEVEL = 250024,
		USER_NAME = 70060,
		ABYSS_LAYER_AWARD_TIP = 351009,
		CLUB_DISMISS = 190014,
		NOVEMBER = 71712,
		REGRESSION_GIFT_DESCRIPE = 350007,
		INPUT_PRESET_NAME = 170000,
		MATRIX_TYPE_NOTE_2 = 140002,
		REPORT_REASON_POLITICS = 151001,
		ALL_EQUIP_SKILL = 60130,
		TRANSFER_POST = 190002,
		PLEASE_INPUT_KEY = 70065,
		INPUT_CHAT_CONTENT = 60043,
		CLUB_BOSS_DIFFICULTY_4 = 280048,
		BOSS_LEVEL_1 = 180001,
		ACTIVITY_VALENTINE_RESULT_TITLE_1 = 347104,
		ERROR_HERO_NO_DEATH = 6609,
		RECHARGE_WELFARE = 80024,
		LEVEL_MAX = 70002,
		ACTIVITY_STRATEGY_MATRIX_DESCRIBE = 290014,
		TIP_SETTING_CHANGE = 60247,
		ERROR_NOT_RECOVERY_DETECTOR = 6613,
		CLUB_BOSS_START_2 = 280044,
		MATRIX_PREPARE_START_CHALLENGE = 160025,
		FORMATION_PLAN_DELETED = 300003,
		POLYHEDRON_TERMINAL_LACK_POINT = 354010,
		ACTIVITY_MOONCAKE_GAMBLING_REWARD_NONE = 260014,
		ACTIVITY_MOONCAKE_GAMBLING_REWARD_4 = 260011,
		REGRESSION_GASHAPON_EXTRACT = 350006,
		TEAM_5 = 250043,
		DORM_HERO_AT_TASK = 210098,
		FORMATION_PLAN_NAME_CHANGED = 300008,
		ERROR_CLUB_NAME_LENGTH = 6036,
		DORM_MOULD_NOT_ENOUGH = 210054,
		ERROR_BATTLEPASS_PREV_HAS_NOT_BUY = 7002,
		EQUIP_INHERIT_DESC = 71143,
		CLUB_BOSS_TIPS_3 = 280040,
		ACTIVITY_CLUB_JOIN_ZERO_VITALITY_TIP = 300112,
		ACTIVITY_HERO_TRIAL_DESCRIPE = 220016,
		OPEN_TIME = 220008,
		ERROR_NO_MAIL_CAN_RECEIVE = 2902,
		CLUB_MOBILITY_CAPTAIN = 190012,
		NAME_CHANGE_CARD_INSUFFICIENT_TIPS = 310101,
		POLYHEDRON_ARTIFACT_SUB_TYPE_3003 = 354005,
		ERROR_POLYHEDRON_DIFFICULTY_LOCK = 22005,
		DRAW_PROBABILITY = 71305,
		ERROR_FRIEND_EXIST_REQUEST = 2406,
		ACTIVITY_MATRIX_DESC = 260023,
		DATA_ERROR_TO_LOGIN = 60082,
		ACTIVITY_COWBOY_TIPS = 260019,
		TIME_DISPLAY_2 = 280002,
		ACTIVITY_SPRING_FESTIVAL_RIDDLE_ERROR_CD = 341004,
		DORM_MOULD_SAVE_SUCCESS = 210052,
		CHIP_UNLOAD = 120021,
		MATRIX_GET = 160027,
		DORM_HERO_AT_CANTEEN = 210095,
		PLEASE_SELECT_ITEM = 60070,
		IS_CAPTAIN = 60210,
		CANTEEN_FOOD_MAX = 210010,
		SERVANT_PROMOTE_LEVEL = 71051,
		CANTEEN_REFRESH_CONFIRM = 210042,
		CANNOT_CONNECT_QUIT = 60081,
		DORM_CANTEEN_TASK_UNLOCK_TIPS = 210073,
		DOWNLOAD_SUCCESS = 70034,
		FRIEND_APPLY_REJECT = 60093,
		ACTIVITY_WARCHESS_RELIEVE = 71408,
		ACTIVITY_LIMIT_CALCULATION_POINT_RANK = 250023,
		DORM_CANTEEN_COOK = 210084,
		TIP_QUESTION = 347103,
		SKILL_LEVEL_UP = 70062,
		ACTIVITY_SPRING_FESTIVAL_MONSTER_DESCRIPE = 341011,
		ENCHANTMENT_DESCRIPE = 60227,
		SERVER_OPEN_COUNTDOWN_4 = 71275,
		ERROR_CLUB_REWARD_ONLY_FORMAT_RECEIVE = 6028,
		ACTIVITY_CLUB_REWARD = 300120,
		DORM_CANTEEN_HERO_CHANGE_SUCCESS = 210087,
		TEAM_SET_NEEDED = 300012,
		EQUIP_BREAK_LIMITED = 71139,
		SET_CONFIRMED_2 = 346004,
		FRIEND_MAKE_SUCCESS = 60095,
		NOTE_ENERGYTYPE_2 = 60150,
		ACTIVITY_MOONCAKE_GAMBLING_NUM_ZERO = 260007,
		ACTIVITY_CLUB_ATTACK_DESC = 300122,
		POLYHEDRON_ARTIFACT_TITLE_1 = 354032,
		ACTIVITY_STRATEGY_TITLE_4 = 290018,
		TIPS_REVISENAME_FREE = 71806,
		UNLOCK = 70045,
		UNSET_BIRTHDAY = 71811,
		SERVANT_MATERIAL_LOCKED = 71047,
		READY_BATTLE = 60143,
		USE_SCHEME_SUCCESS = 120014,
		GONGHUIBOSS_LIEXIKAIFANG = 280036,
		RETURN_MATERIAL_MAX_POINT = 350002,
		ACTIVITY_MUSIC_EASY_TASK = 290005,
		ACTIVITY_CLUB_ACTIVITYING_EXIT_CLUB_TIP = 300117,
		CLUB_BOSS_DESCRIPE = 190022,
		REPORT_REASON_AD = 151002,
		DESEMBER = 71713,
		EXIST_SAME_NAME = 170001,
		BLACKLIST_TIP = 80104,
		ERROR_BATTLE_EQUIP_SUIT_NO_EXIST = 3401,
		UNLOCK_INFINITY = 220017,
		ACCUMULATED_POINTS_REACHED = 220013,
		NO_EXCHANGE_HERO_PIECE = 71201,
		SCAN_RULES_1 = 280016,
		ADVANCED_TASK_BATTLE_BOSS = 353002,
		CANNOT_GO = 71402,
		MAYBE_DROP = 60142,
		ERROR_CLUB_SPECIAL_REWARD_BUY_TIME_LIMIT = 6042,
		REMAINING_TIME = 60063,
		CONTINUE_BUY = 80027,
		ERROR_BACKHOME_CANTEEN_EARNINGS_NO_EXIST = 7105,
		ACTIVITY_HELLA_SIGN_TITLE = 230005,
		TREASURE_TICKET_TO_BUY = 71302,
		ERROR_REFRESH_TOO_FAST = 2018,
		LEFT_BOTTOM = 170014,
		NORMAL_CHIP = 120017,
		POLYHEDRON_LOBBY_SETTLEMENT = 354023,
		ERROR_SERVER_BUSY = 13,
		RECOMMEND_FRIEND_CD = 60287,
		EQUIP_RESOLVE_COST_RARE = 71125,
		CYCLE_GIFTBOX = 80020,
		ACTIVITY_CLUB_REGISTER_CANT_TIP = 300102,
		SERVANT_MATERIAL_IS_USING = 71048,
		SEQUENTIAL_BATTLE_RESET_TEAM = 340009,
		CANNOT_SEND_SAME_MESSAGE = 60045,
		GET_GOLD = 60246,
		POLYHEDRON_TERMINAL_CLASSIFY_1 = 354000,
		DORM_HERO_LOW_MOOD = 210001,
		ERROR_LOGIN_TOKEN_CHK_FAIL = 1003,
		ERROR_SECONDARY_CONFLICT = 6805,
		JULY = 71708,
		ERROR_ITEM_NOT_ENOUGH_CURRENCY = 2104,
		ERROR_HERO_EXCLUSIVE_SKILL_NOT_EXIST = 2732,
		ERROR_COORDINATOR_BATTLE_REWARD_REPEATED = 6109,
		ACTIVITY__CROSSWAVE_CONTENT = 250022,
		ERROR_POOL_UNOPEN = 3102,
		NUM_3 = 60278,
		REGRESSION_JUMP = 350004,
		THOR_STRATEGY_TITLE_1 = 345011,
		BUFF_PREVIEW = 340007,
		FRIEND_DELETE_NOTE = 60088,
		TIME_DISPLAY_8 = 280008,
		FACTORY_ACTIVITY_SOLO_CHALLENGE_DESCRIPE = 320013,
		SERVANT_TRANSCEND_BY_SERVANT = 71060,
		POLYHEDRON_INTERACTIVE_HERO_DES_1 = 354037,
		ACTIVITY_FISHING_BUFF_NAME_3 = 250030,
		DORM_HERO_AT_DORM = 210097,
		ERROR_CLUB_VICE_CHAIRMAN_CANCEL = 190048,
		ERROR_TEAMS_HERO_LIST_NULL = 3501,
		ALL_POSITION = 70032,
		ERROR_ITEM_NO_MATERIAL = 2117,
		ADVANCED_TASK_CULTURE_EQUIP = 353103,
		ERROR_USER_MAX_NUMBER = 2001,
		COOPERATION_KICK_OUT = 330009,
		ERROR_USER_NAME_VER_WORD = 2007,
		ERROR_ABYSS_NO_LAYER_RESET_TIME = 21003,
		ERROR_ITEM_NOT_ENOUGH_INFO_BADGE_TOP = 2112,
		CLUB_BOSS_BLOOD_CONDITION_TIP1 = 190025,
		MYTHIC_REFRESH_DATA = 60213,
		CANTEEN_TASK_REFRESH_SUCCESS = 210020,
		TIME_DISPLAY_14 = 280014,
		ERROR_SHOP_GOODS_COST_INCONSISTENT = 2609,
		ACTIVITY_LIMIT_CALCULATION_POINT_REACHED = 250026,
		ERROR_BOSS_RECOVERY_DETECTOR = 60285,
		SET_FAILED = 346002,
		TRAVEL_SKULD_STORY_GET_INFINAL = 345022,
		TIP_ASTROLABE_FRONT = 60187,
		MATRIX_SHOP_BUY_CONFIRM = 160022,
		SKIN = 80008,
		CURRENCY_NO_ENOUGH = 60127,
		ACTIVITY_VALENTINE_RESULT_TITLE_2 = 347105,
		CLUB_BOSS_START_1 = 280043,
		POLYHEDRON_REWARD_TITLE_BLOOD = 354029,
		ERROR_BACKHOME_NOT_FIND_RECOMMEND_DORM = 7121,
		TIP_MOOD = 345005,
		TRAVEL_SKULD_COLLECT_ALL_PHOTO = 345017,
		THOR_STRATEGY_TITLE_3 = 345013,
		POLYHEDRON_SELECT_BEACON_MAX = 354035,
		SAME_TEAM_PROHIBITED = 300002,
		CANTEEN_MANNUALLY_OPT = 210043,
		ERROR_INFINITY_POOL_NOT_EXIST = 13001,
		ERROR_MAP_INIT_SIZE_DISCREPANCY = 6610,
		ACTIVITY_WORLD_BOSS_LOCK_STORY = 345023,
		EQUIP_SKILL_LOCK = 71169,
		LATER = 348015,
		RIGHT_BOTTOM = 170016,
		HARDLEVEL_HARD = 60005,
		ITEM_INVALID = 60135,
		ERROR_REWARD_ALREADY_RECEIVED = 2013,
		CANTEEN_CUSTOMER_SERVE_TIPS1 = 210012,
		ACTIVITY_FINISH_ALL_SUMMER_STORY = 250034,
		PERSONAL_SIGNATURE_MAX = 71804,
		TIME_DISPLAY_10 = 280010,
		CHIP_USE_SUCCESS = 120007,
		ACTIVITY_SUMMER_LIMITED_CALCULATION_DESCRIPE = 250003,
		EQUIP_BREAK_THROUGH_RESET_MAP = 71455,
		DORM_HERO_WORK_IN_CANTEEN = 210055,
		DORM_MOULD_NAME_SET_TIPS = 210122,
		POLYHEDRON_TEAM_SET_DEAD = 354031,
		ACTIVITY_SPRING_FESTIVAL_RIDDLE_CD = 341005,
		POLYHEDRON_INTERACTIVE_HERO_TITLE_3 = 354042,
		MYTHIC_FINAL_LEVEL_DESC = 285002,
		ERROR_BACKHOME_CANTEEN_SELL_MAX = 7111,
		ERROR_ITEM_NO_ENOUGH_MATERIAL = 2118,
		CANTEEN_FOOD_NOT_ENOUGH = 210030,
		EQUIP_HERO_HAD_REBUILT = 71133,
		RECALLED_INVITE = 349004,
		GOODS_HAS_BEEN_REMOVED = 71205,
		HERO_RECORD_PLOT_UNLOCK_CONDITION = 71254,
		ERROR_EQUIP_PROPOSAL_EXIST = 2201,
		SET_CONFIRMED = 346001,
		TIME_DISPLAY_1 = 280001,
		ITEM_TYPE_NOTE_5 = 100005,
		DORM_GOLD_NOT_ENOUGH = 210003,
		DORM_LEVEL_AWARD_ATTRIB = 210045,
		EQUIP_ENCHANT_RESULT_NUM_MAX = 71128,
		ERROR_NOT_TIME = 8,
		MATRIX_SHOP_REFRESH = 160023,
		PROMOTE = 70004,
		ERROR_EQUIP_RACE_PREVIEW_EXIST = 2213,
		ERROR_CLUB_KICK_TIMES_LIMIT = 6049,
		MATRIX_SELECT_BEACON_MAX = 160016,
		ERROR_NO_ADJACENT = 6601,
		BEFORE = 60083,
		DORM_UNLOCK_TIPS = 210047,
		EXIT_CLUB = 190003,
		ERROR_EQUIP_RACE_PREVIEW_NO_EXIST = 2212,
		HARDLEVEL = 60037,
		SIGIL_CLARIFYING_RECONSTRUCTOR_SUCCESS = 303111,
		ERROR_POLYHEDRON_SELECT_GATE_NO_FIND = 22007,
		WEAPON_MODULE_UNLOCK_CONDITION_NOT_FINISH = 80306,
		OTHER_BIRTHDAY = 71810,
		EQUIP_STAGE_REFRESH = 71452,
		BOSS_LEVEL_4 = 180004,
		NO_FIX_ITEM = 70069,
		ERROR_ITEM_DIAMOND_COIN_TIMES_OVER_LIMIT = 2107,
		NOT_DOWNLOADED = 70051,
		ERROR_ITEM_NOT_ENOUGH_MATERIAL = 2116,
		REMOVE_FROM_TEAM = 60223,
		DORM_CANTEEN_WAITER_DO = 210090,
		CAN_NOT_REMOVE = 60222,
		DORM_MOULD_CANT_USE = 210058,
		ERROR_BATTLE_STARS_REWARD_ID_UNDEFINED = 3003,
		ERROR_HERO_NOT_UNLOCK = 2700,
		TIP_RARE = 70013,
		DORM_EDIT_CLEAN = 210067,
		ACTIVITY_MATRIX_LACK_ASTROLABE = 260020,
		ACTIVITY_SPRING_FESTIVAL_RIDDLE_BAN = 341012,
		EQUIP_BREAK_THROUGH_TEAM_HEAL = 71460,
		ERROR_BACKHOME_DORM_NO_SET_HERO = 7114,
		XH1ST_SEAL_UNLOCK_NEXT_TICKET_TIP = 348006,
		CANTEEN_MONEY_TIPS1 = 210025,
		NOT_ENTER_NICK_UID = 60092,
		SCAN_RULES_2 = 280017,
		ERROR_CLUB_REQUEST_TWICE = 6017,
		ERROR_COORDINATOR_ROOM_INVALID = 6111,
		WEEKLY_SOLD_OUT = 60272,
		FIRE_WORK_LOCK_STORY = 345016,
		ERROR_USER_NAME_EXIST = 2006,
		ACTIVITY_RACE_HIGHEST_REWARD = 290008,
		DORM_GIFT_MAX_TIPS = 210110,
		COOPERATION_NO_ALLOW_READY_ADJUST = 330004
	},
	all = {
		0,
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10,
		11,
		12,
		13,
		14,
		15,
		16,
		17,
		100,
		101,
		200,
		201,
		1000,
		1001,
		1002,
		1003,
		1004,
		1005,
		1006,
		1007,
		1008,
		1009,
		2000,
		2001,
		2002,
		2003,
		2004,
		2005,
		2006,
		2007,
		2008,
		2009,
		2010,
		2011,
		2012,
		2013,
		2014,
		2015,
		2016,
		2017,
		2018,
		2100,
		2101,
		2102,
		2103,
		2104,
		2105,
		2106,
		2107,
		2108,
		2109,
		2110,
		2111,
		2112,
		2113,
		2114,
		2115,
		2116,
		2117,
		2118,
		2119,
		2120,
		2121,
		2122,
		2200,
		2201,
		2202,
		2203,
		2204,
		2205,
		2206,
		2207,
		2208,
		2209,
		2210,
		2211,
		2212,
		2213,
		2214,
		2220,
		2221,
		2300,
		2301,
		2302,
		2303,
		2304,
		2305,
		2306,
		2307,
		2308,
		2309,
		2310,
		2400,
		2401,
		2402,
		2403,
		2404,
		2405,
		2406,
		2407,
		2408,
		2409,
		2410,
		2411,
		2412,
		2413,
		2414,
		2415,
		2416,
		2500,
		2501,
		2502,
		2503,
		2504,
		2505,
		2506,
		2507,
		2508,
		2509,
		2510,
		2511,
		2512,
		2600,
		2601,
		2602,
		2603,
		2604,
		2605,
		2606,
		2607,
		2608,
		2609,
		2700,
		2701,
		2702,
		2703,
		2704,
		2705,
		2706,
		2707,
		2708,
		2709,
		2710,
		2711,
		2712,
		2713,
		2714,
		2715,
		2716,
		2717,
		2718,
		2719,
		2720,
		2721,
		2722,
		2723,
		2724,
		2725,
		2726,
		2727,
		2728,
		2729,
		2730,
		2731,
		2732,
		2733,
		2734,
		2735,
		2736,
		2900,
		2901,
		2902,
		3000,
		3001,
		3002,
		3003,
		3004,
		3005,
		3006,
		3007,
		3008,
		3009,
		3012,
		3013,
		3014,
		3015,
		3100,
		3101,
		3102,
		3201,
		3202,
		3203,
		3204,
		3205,
		3206,
		3207,
		3300,
		3301,
		3302,
		3303,
		3401,
		3501,
		3502,
		3503,
		3504,
		3505,
		3506,
		3507,
		6000,
		6001,
		6002,
		6003,
		6004,
		6005,
		6006,
		6007,
		6008,
		6009,
		6010,
		6011,
		6012,
		6013,
		6014,
		6015,
		6016,
		6017,
		6018,
		6019,
		6020,
		6021,
		6022,
		6023,
		6024,
		6025,
		6026,
		6027,
		6028,
		6029,
		6030,
		6031,
		6032,
		6033,
		6034,
		6035,
		6036,
		6037,
		6038,
		6039,
		6040,
		6041,
		6042,
		6043,
		6044,
		6045,
		6046,
		6047,
		6048,
		6049,
		6050,
		6100,
		6101,
		6102,
		6103,
		6104,
		6105,
		6106,
		6107,
		6108,
		6109,
		6110,
		6111,
		6112,
		6113,
		6114,
		6115,
		6116,
		6117,
		6118,
		6119,
		6120,
		6121,
		6200,
		6210,
		6211,
		6213,
		6214,
		6215,
		6300,
		6400,
		6401,
		6402,
		6403,
		6404,
		6405,
		6406,
		6407,
		6408,
		6500,
		6501,
		6502,
		6503,
		6504,
		6505,
		6506,
		6507,
		6508,
		6509,
		6510,
		6511,
		6512,
		6513,
		6514,
		6515,
		6516,
		6517,
		6518,
		6519,
		6520,
		6521,
		6522,
		6523,
		6524,
		6525,
		6526,
		6527,
		6528,
		6529,
		6530,
		6531,
		6532,
		6533,
		6535,
		6536,
		6537,
		6600,
		6601,
		6602,
		6603,
		6604,
		6605,
		6606,
		6607,
		6608,
		6609,
		6610,
		6611,
		6612,
		6613,
		6614,
		6615,
		6700,
		6701,
		6702,
		6703,
		6704,
		6800,
		6801,
		6802,
		6803,
		6804,
		6805,
		6806,
		6807,
		6808,
		6809,
		6900,
		6901,
		6902,
		6903,
		7000,
		7001,
		7002,
		7003,
		7004,
		7005,
		7006,
		7007,
		7100,
		7101,
		7102,
		7103,
		7104,
		7105,
		7106,
		7107,
		7108,
		7109,
		7110,
		7111,
		7112,
		7113,
		7114,
		7115,
		7116,
		7117,
		7118,
		7119,
		7120,
		7121,
		7122,
		9000,
		10001,
		10002,
		10003,
		10004,
		11000,
		12000,
		12001,
		13000,
		13001,
		13002,
		13003,
		13004,
		14000,
		14001,
		14002,
		14003,
		14004,
		15000,
		15001,
		16000,
		16001,
		17000,
		17001,
		18000,
		18001,
		18002,
		19000,
		19001,
		19002,
		20000,
		20001,
		20002,
		21000,
		21001,
		21002,
		21003,
		21004,
		22001,
		22002,
		22003,
		22004,
		22005,
		22006,
		22007,
		22008,
		22009,
		22010,
		22011,
		50001,
		50002,
		50004,
		50005,
		50006,
		50007,
		50008,
		60004,
		60005,
		60006,
		60025,
		60026,
		60036,
		60037,
		60043,
		60045,
		60047,
		60058,
		60059,
		60062,
		60063,
		60064,
		60065,
		60066,
		60070,
		60071,
		60074,
		60075,
		60076,
		60077,
		60078,
		60079,
		60080,
		60081,
		60082,
		60083,
		60084,
		60085,
		60086,
		60087,
		60088,
		60089,
		60090,
		60091,
		60092,
		60093,
		60094,
		60095,
		60096,
		60097,
		60098,
		60099,
		60100,
		60101,
		60102,
		60103,
		60104,
		60106,
		60107,
		60108,
		60109,
		60110,
		60111,
		60112,
		60113,
		60114,
		60115,
		60116,
		60117,
		60118,
		60119,
		60120,
		60121,
		60122,
		60123,
		60124,
		60125,
		60126,
		60127,
		60129,
		60130,
		60131,
		60132,
		60133,
		60134,
		60135,
		60136,
		60137,
		60138,
		60139,
		60140,
		60141,
		60142,
		60143,
		60145,
		60146,
		60147,
		60148,
		60149,
		60150,
		60151,
		60152,
		60153,
		60154,
		60163,
		60164,
		60165,
		60166,
		60167,
		60168,
		60169,
		60170,
		60178,
		60179,
		60180,
		60181,
		60182,
		60183,
		60184,
		60185,
		60186,
		60187,
		60188,
		60189,
		60190,
		60201,
		60202,
		60203,
		60204,
		60205,
		60206,
		60207,
		60208,
		60209,
		60210,
		60211,
		60212,
		60213,
		60214,
		60215,
		60216,
		60217,
		60218,
		60219,
		60220,
		60221,
		60222,
		60223,
		60224,
		60225,
		60226,
		60227,
		60228,
		60229,
		60230,
		60231,
		60232,
		60233,
		60234,
		60235,
		60236,
		60237,
		60238,
		60239,
		60240,
		60241,
		60242,
		60243,
		60244,
		60245,
		60246,
		60247,
		60248,
		60249,
		60250,
		60251,
		60252,
		60253,
		60254,
		60255,
		60256,
		60257,
		60258,
		60259,
		60260,
		60261,
		60262,
		60263,
		60264,
		60265,
		60266,
		60267,
		60268,
		60269,
		60270,
		60271,
		60272,
		60273,
		60274,
		60275,
		60276,
		60277,
		60278,
		60279,
		60280,
		60281,
		60282,
		60283,
		60284,
		60285,
		60286,
		60287,
		60288,
		60289,
		60290,
		60291,
		60292,
		60293,
		60294,
		60295,
		60296,
		60297,
		60298,
		60299,
		60300,
		70000,
		70001,
		70002,
		70003,
		70004,
		70005,
		70006,
		70007,
		70008,
		70009,
		70010,
		70011,
		70012,
		70013,
		70014,
		70015,
		70016,
		70017,
		70018,
		70019,
		70020,
		70021,
		70022,
		70023,
		70024,
		70025,
		70026,
		70027,
		70028,
		70029,
		70030,
		70031,
		70032,
		70033,
		70034,
		70035,
		70036,
		70037,
		70038,
		70039,
		70040,
		70041,
		70042,
		70043,
		70044,
		70045,
		70046,
		70047,
		70048,
		70049,
		70050,
		70051,
		70052,
		70053,
		70054,
		70055,
		70056,
		70057,
		70058,
		70059,
		70060,
		70061,
		70062,
		70063,
		70064,
		70065,
		70066,
		70067,
		70068,
		70069,
		70070,
		70071,
		70072,
		70073,
		70074,
		70076,
		70077,
		70078,
		70079,
		70080,
		70081,
		70082,
		70083,
		70084,
		71000,
		71001,
		71002,
		71003,
		71004,
		71005,
		71006,
		71007,
		71008,
		71020,
		71040,
		71041,
		71042,
		71043,
		71044,
		71045,
		71046,
		71047,
		71048,
		71049,
		71050,
		71051,
		71052,
		71053,
		71054,
		71055,
		71056,
		71057,
		71058,
		71059,
		71060,
		71061,
		71100,
		71101,
		71102,
		71103,
		71120,
		71121,
		71122,
		71123,
		71124,
		71125,
		71126,
		71127,
		71128,
		71129,
		71130,
		71131,
		71132,
		71133,
		71134,
		71135,
		71136,
		71137,
		71139,
		71140,
		71141,
		71142,
		71143,
		71148,
		71149,
		71150,
		71160,
		71161,
		71162,
		71163,
		71164,
		71165,
		71166,
		71167,
		71168,
		71169,
		71172,
		71173,
		71174,
		71175,
		71176,
		71177,
		71178,
		71179,
		71180,
		71181,
		71151,
		71201,
		71202,
		71203,
		71204,
		71205,
		71206,
		71207,
		71208,
		71209,
		71251,
		71252,
		71253,
		71254,
		71257,
		71258,
		71259,
		71271,
		71272,
		71273,
		71274,
		71275,
		71301,
		71302,
		71303,
		71304,
		71305,
		71306,
		71307,
		71308,
		71309,
		71310,
		71401,
		71402,
		71403,
		71404,
		71405,
		71406,
		71407,
		71408,
		71409,
		71410,
		71411,
		71451,
		71452,
		71453,
		71454,
		71455,
		71456,
		71457,
		71458,
		71459,
		71460,
		71500,
		71501,
		71502,
		71503,
		71504,
		71505,
		71506,
		71520,
		71521,
		71522,
		71523,
		71524,
		71525,
		71601,
		71602,
		71603,
		71604,
		71605,
		71606,
		71607,
		71608,
		71609,
		71610,
		71611,
		71612,
		71701,
		71702,
		71703,
		71704,
		71705,
		71706,
		71707,
		71708,
		71709,
		71710,
		71711,
		71712,
		71713,
		71714,
		71715,
		71716,
		71801,
		71802,
		71803,
		71804,
		71805,
		71806,
		71807,
		71808,
		71809,
		71810,
		71811,
		80001,
		80002,
		80003,
		80004,
		80005,
		80006,
		80007,
		80008,
		80009,
		80010,
		80011,
		80012,
		80013,
		80014,
		80015,
		80016,
		80017,
		80018,
		80019,
		80020,
		80021,
		80022,
		80023,
		80024,
		80025,
		80026,
		80027,
		80101,
		80102,
		80103,
		80104,
		80201,
		80202,
		80301,
		80302,
		80303,
		80304,
		80305,
		80306,
		80307,
		80308,
		80309,
		80310,
		100001,
		100002,
		100003,
		100004,
		100005,
		100006,
		100007,
		100008,
		100009,
		110001,
		110002,
		110003,
		110004,
		120001,
		120002,
		120003,
		120004,
		120005,
		120006,
		120007,
		120008,
		120009,
		120010,
		120011,
		120012,
		120013,
		120014,
		120015,
		120016,
		120017,
		120018,
		120019,
		120020,
		120021,
		120022,
		120023,
		120024,
		120025,
		120026,
		120027,
		120028,
		120029,
		120030,
		130001,
		140001,
		140002,
		140003,
		140004,
		140005,
		140006,
		140007,
		140008,
		140009,
		140010,
		150001,
		150002,
		150003,
		150004,
		150005,
		150006,
		150007,
		150008,
		150009,
		150010,
		150011,
		151001,
		151002,
		151003,
		151004,
		151005,
		151006,
		151007,
		151008,
		151009,
		151010,
		151011,
		160001,
		160002,
		160003,
		160004,
		160005,
		160006,
		160007,
		160008,
		160009,
		160010,
		160011,
		160012,
		160013,
		160014,
		160015,
		160016,
		160017,
		160018,
		160019,
		160020,
		160021,
		160022,
		160023,
		160024,
		160025,
		160026,
		160027,
		160028,
		160029,
		160030,
		160031,
		160032,
		170000,
		170001,
		170002,
		170003,
		170004,
		170005,
		170006,
		170007,
		170008,
		170009,
		170010,
		170011,
		170012,
		170013,
		170014,
		170015,
		170016,
		180000,
		180001,
		180002,
		180003,
		180004,
		180005,
		180006,
		180007,
		180008,
		180009,
		180010,
		180011,
		180012,
		180013,
		180014,
		180015,
		180016,
		180017,
		180018,
		190000,
		190001,
		190002,
		190003,
		190004,
		190005,
		190006,
		190007,
		190008,
		190009,
		190010,
		190011,
		190012,
		190013,
		190014,
		190015,
		190016,
		190017,
		190018,
		190019,
		190020,
		190021,
		190022,
		190023,
		190024,
		190025,
		190026,
		190027,
		190028,
		190029,
		190030,
		190031,
		190032,
		190033,
		190034,
		190035,
		190036,
		190037,
		190038,
		190039,
		190040,
		190041,
		190042,
		190043,
		190044,
		190045,
		190046,
		190047,
		190048,
		190049,
		200001,
		200002,
		200003,
		200004,
		200005,
		200006,
		200007,
		200008,
		210001,
		210002,
		210003,
		210004,
		210005,
		210006,
		210007,
		210008,
		210009,
		210010,
		210011,
		210012,
		210013,
		210014,
		210015,
		210016,
		210017,
		210018,
		210019,
		210020,
		210021,
		210022,
		210023,
		210024,
		210025,
		210026,
		210027,
		210028,
		210029,
		210030,
		210031,
		210032,
		210033,
		210034,
		210035,
		210036,
		210037,
		210038,
		210039,
		210040,
		210041,
		210042,
		210043,
		210044,
		210045,
		210046,
		210047,
		210048,
		210049,
		210050,
		210051,
		210052,
		210053,
		210054,
		210055,
		210056,
		210057,
		210058,
		210059,
		210060,
		210061,
		210062,
		210063,
		210064,
		210065,
		210066,
		210067,
		210068,
		210069,
		210070,
		210071,
		210072,
		210073,
		210074,
		210075,
		210076,
		210077,
		210078,
		210079,
		210080,
		210081,
		210082,
		210083,
		210084,
		210085,
		210086,
		210087,
		210088,
		210089,
		210090,
		210091,
		210092,
		210093,
		210094,
		210095,
		210096,
		210097,
		210098,
		210099,
		210100,
		210101,
		210102,
		210103,
		210104,
		210105,
		210106,
		210107,
		210108,
		210109,
		210110,
		210111,
		210112,
		210113,
		210114,
		210115,
		210116,
		210117,
		210118,
		210119,
		210120,
		210121,
		210122,
		210123,
		210124,
		210125,
		210126,
		210127,
		210128,
		210129,
		210130,
		210131,
		210132,
		210133,
		210134,
		210135,
		210136,
		210137,
		220001,
		220002,
		220003,
		220004,
		220005,
		220006,
		220007,
		220008,
		220009,
		220010,
		220011,
		220012,
		220013,
		220014,
		220016,
		220017,
		220018,
		230001,
		230002,
		230003,
		230004,
		230005,
		230006,
		240001,
		250001,
		250002,
		250003,
		250004,
		250005,
		250006,
		250007,
		250008,
		250009,
		250010,
		250011,
		250012,
		250013,
		250014,
		250015,
		250016,
		250017,
		250018,
		250019,
		250020,
		250021,
		250022,
		250023,
		250024,
		250025,
		250026,
		250027,
		250028,
		250029,
		250030,
		250031,
		250032,
		250033,
		250034,
		250035,
		250036,
		250037,
		250038,
		250039,
		250040,
		250041,
		250042,
		250043,
		260001,
		260002,
		260003,
		260004,
		260005,
		260006,
		260007,
		260008,
		260009,
		260010,
		260011,
		260012,
		260013,
		260014,
		260015,
		260016,
		260017,
		260018,
		260019,
		260020,
		260021,
		260022,
		260023,
		260024,
		260025,
		270001,
		280001,
		280002,
		280003,
		280004,
		280005,
		280006,
		280007,
		280008,
		280009,
		280010,
		280011,
		280012,
		280013,
		280014,
		280015,
		280016,
		280017,
		280018,
		280019,
		280020,
		280021,
		280023,
		280024,
		280025,
		280026,
		280027,
		280028,
		280029,
		280030,
		280031,
		280032,
		280033,
		280034,
		280035,
		280036,
		280037,
		280038,
		280039,
		280040,
		280041,
		280042,
		280043,
		280044,
		280045,
		280046,
		280047,
		280048,
		280049,
		280050,
		280051,
		280052,
		285001,
		285002,
		285003,
		285004,
		285005,
		285006,
		285007,
		285008,
		285009,
		285010,
		285011,
		285012,
		285013,
		285014,
		290001,
		290002,
		290003,
		290004,
		290005,
		290006,
		290007,
		290008,
		290009,
		290010,
		290011,
		290012,
		290013,
		290014,
		290015,
		290016,
		290017,
		290018,
		300001,
		300002,
		300003,
		300004,
		300005,
		300006,
		300007,
		300008,
		300009,
		300010,
		300011,
		300012,
		300013,
		300101,
		300102,
		300103,
		300104,
		300105,
		300106,
		300107,
		300108,
		300109,
		300110,
		300111,
		300112,
		300113,
		300114,
		300115,
		300116,
		300117,
		300118,
		300119,
		300120,
		300121,
		300122,
		300123,
		300124,
		300125,
		300126,
		300127,
		300128,
		300129,
		310101,
		310102,
		320001,
		320002,
		320003,
		320004,
		320005,
		320006,
		320007,
		320008,
		320009,
		320010,
		320011,
		320012,
		320013,
		320014,
		320015,
		320016,
		320017,
		330001,
		330002,
		330003,
		330004,
		330005,
		330006,
		330007,
		330008,
		330009,
		330010,
		330011,
		330012,
		330013,
		303111,
		340001,
		340002,
		340003,
		340004,
		340005,
		340006,
		340007,
		340008,
		340009,
		340010,
		341001,
		341002,
		341003,
		341004,
		341005,
		341006,
		341007,
		341008,
		341009,
		341010,
		341011,
		341012,
		345001,
		345002,
		345003,
		345004,
		345005,
		345006,
		345007,
		345008,
		345009,
		345010,
		345011,
		345012,
		345013,
		345014,
		345015,
		345016,
		345017,
		345018,
		345019,
		345020,
		345021,
		345022,
		345023,
		345024,
		345025,
		346001,
		346002,
		346003,
		346004,
		346005,
		347001,
		347101,
		347102,
		347103,
		347104,
		347105,
		347106,
		347107,
		347108,
		347109,
		347110,
		347111,
		347112,
		348001,
		348002,
		348003,
		348004,
		348005,
		348006,
		348007,
		348008,
		348009,
		348010,
		348011,
		348012,
		348013,
		348014,
		348015,
		348016,
		348017,
		349001,
		349002,
		349003,
		349004,
		350001,
		350002,
		350003,
		350004,
		350005,
		350006,
		350007,
		351001,
		351002,
		351003,
		351004,
		351005,
		351006,
		351007,
		351008,
		351009,
		351010,
		351011,
		351012,
		351013,
		351014,
		352001,
		352002,
		352003,
		352004,
		352005,
		352006,
		352007,
		353000,
		353001,
		353002,
		353003,
		353004,
		353005,
		353006,
		353007,
		353100,
		353101,
		353102,
		353103,
		353104,
		353105,
		354000,
		354001,
		354002,
		354003,
		354004,
		354005,
		354006,
		354007,
		354008,
		354009,
		354010,
		354011,
		354012,
		354013,
		354014,
		354015,
		354016,
		354017,
		354018,
		354019,
		354020,
		354021,
		354022,
		354023,
		354024,
		354025,
		354026,
		354027,
		354028,
		354029,
		354030,
		354031,
		354032,
		354033,
		354034,
		354035,
		354036,
		354037,
		354038,
		354039,
		354040,
		354041,
		354042,
		354043,
		354044,
		354045,
		354046,
		354047,
		354048,
		354049,
		354050,
		354051,
		354052,
		354053,
		354054,
		354055
	}
}
