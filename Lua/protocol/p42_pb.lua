slot0 = require("protobuf")

module("p42_pb")

slot1 = slot0.Descriptor()
slot2 = slot0.FieldDescriptor()
slot3 = slot0.FieldDescriptor()
slot4 = slot0.FieldDescriptor()
slot5 = slot0.Descriptor()
slot6 = slot0.Descriptor()
slot7 = slot0.FieldDescriptor()
slot8 = slot0.Descriptor()
slot9 = slot0.FieldDescriptor()
slot10 = slot0.Descriptor()
slot11 = slot0.FieldDescriptor()
slot12 = slot0.FieldDescriptor()
slot2.name = "free_refreshed_times"
slot2.full_name = ".p42.sc_42001.free_refreshed_times"
slot2.number = 1
slot2.index = 0
slot2.label = 2
slot2.has_default_value = false
slot2.default_value = 0
slot2.type = 13
slot2.cpp_type = 3
slot3.name = "all_buy_refreshed_times"
slot3.full_name = ".p42.sc_42001.all_buy_refreshed_times"
slot3.number = 2
slot3.index = 1
slot3.label = 2
slot3.has_default_value = false
slot3.default_value = 0
slot3.type = 13
slot3.cpp_type = 3
slot4.name = "enchantment_battle_list"
slot4.full_name = ".p42.sc_42001.enchantment_battle_list"
slot4.number = 3
slot4.index = 2
slot4.label = 3
slot4.has_default_value = false
slot4.default_value = {}
slot4.type = 13
slot4.cpp_type = 3
slot1.name = "sc_42001"
slot1.full_name = ".p42.sc_42001"
slot1.nested_types = {}
slot1.enum_types = {}
slot1.fields = {
	slot2,
	slot3,
	slot4
}
slot1.is_extendable = false
slot1.extensions = {}
slot5.name = "cs_42002"
slot5.full_name = ".p42.cs_42002"
slot5.nested_types = {}
slot5.enum_types = {}
slot5.fields = {}
slot5.is_extendable = false
slot5.extensions = {}
slot7.name = "result"
slot7.full_name = ".p42.sc_42003.result"
slot7.number = 1
slot7.index = 0
slot7.label = 2
slot7.has_default_value = false
slot7.default_value = 0
slot7.type = 13
slot7.cpp_type = 3
slot6.name = "sc_42003"
slot6.full_name = ".p42.sc_42003"
slot6.nested_types = {}
slot6.enum_types = {}
slot6.fields = {
	slot7
}
slot6.is_extendable = false
slot6.extensions = {}
slot9.name = "refresh_type"
slot9.full_name = ".p42.cs_42004.refresh_type"
slot9.number = 1
slot9.index = 0
slot9.label = 2
slot9.has_default_value = false
slot9.default_value = 0
slot9.type = 13
slot9.cpp_type = 3
slot8.name = "cs_42004"
slot8.full_name = ".p42.cs_42004"
slot8.nested_types = {}
slot8.enum_types = {}
slot8.fields = {
	slot9
}
slot8.is_extendable = false
slot8.extensions = {}
slot11.name = "result"
slot11.full_name = ".p42.sc_42005.result"
slot11.number = 1
slot11.index = 0
slot11.label = 2
slot11.has_default_value = false
slot11.default_value = 0
slot11.type = 13
slot11.cpp_type = 3
slot12.name = "enchantment_battle_list"
slot12.full_name = ".p42.sc_42005.enchantment_battle_list"
slot12.number = 2
slot12.index = 1
slot12.label = 3
slot12.has_default_value = false
slot12.default_value = {}
slot12.type = 13
slot12.cpp_type = 3
slot10.name = "sc_42005"
slot10.full_name = ".p42.sc_42005"
slot10.nested_types = {}
slot10.enum_types = {}
slot10.fields = {
	slot11,
	slot12
}
slot10.is_extendable = false
slot10.extensions = {}
cs_42002 = slot0.Message(slot5)
cs_42004 = slot0.Message(slot8)
sc_42001 = slot0.Message(slot1)
sc_42003 = slot0.Message(slot6)
sc_42005 = slot0.Message(slot10)
