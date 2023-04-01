slot0 = require("protobuf")

module("p43_pb")

slot1 = slot0.Descriptor()
slot2 = slot0.FieldDescriptor()
slot3 = slot0.FieldDescriptor()
slot4 = slot0.FieldDescriptor()
slot5 = slot0.FieldDescriptor()
slot6 = slot0.Descriptor()
slot7 = slot0.FieldDescriptor()
slot8 = slot0.FieldDescriptor()
slot9 = slot0.Descriptor()
slot10 = slot0.Descriptor()
slot11 = slot0.FieldDescriptor()
slot12 = slot0.Descriptor()
slot13 = slot0.FieldDescriptor()
slot14 = slot0.Descriptor()
slot15 = slot0.FieldDescriptor()
slot2.name = "stage_base_id"
slot2.full_name = ".p43.sc_43001.stage_base_id"
slot2.number = 1
slot2.index = 0
slot2.label = 2
slot2.has_default_value = false
slot2.default_value = 0
slot2.type = 13
slot2.cpp_type = 3
slot3.name = "equip_suit_id"
slot3.full_name = ".p43.sc_43001.equip_suit_id"
slot3.number = 2
slot3.index = 1
slot3.label = 2
slot3.has_default_value = false
slot3.default_value = 0
slot3.type = 13
slot3.cpp_type = 3
slot4.name = "next_refresh_time"
slot4.full_name = ".p43.sc_43001.next_refresh_time"
slot4.number = 3
slot4.index = 2
slot4.label = 2
slot4.has_default_value = false
slot4.default_value = 0
slot4.type = 13
slot4.cpp_type = 3
slot5.name = "insure_list"
slot5.full_name = ".p43.sc_43001.insure_list"
slot5.number = 4
slot5.index = 3
slot5.label = 3
slot5.has_default_value = false
slot5.default_value = {}
slot5.message_type = slot6
slot5.type = 11
slot5.cpp_type = 10
slot1.name = "sc_43001"
slot1.full_name = ".p43.sc_43001"
slot1.nested_types = {}
slot1.enum_types = {}
slot1.fields = {
	slot2,
	slot3,
	slot4,
	slot5
}
slot1.is_extendable = false
slot1.extensions = {}
slot7.name = "difficulty"
slot7.full_name = ".p43.insure_net_rec.difficulty"
slot7.number = 1
slot7.index = 0
slot7.label = 2
slot7.has_default_value = false
slot7.default_value = 0
slot7.type = 13
slot7.cpp_type = 3
slot8.name = "insure_times"
slot8.full_name = ".p43.insure_net_rec.insure_times"
slot8.number = 2
slot8.index = 1
slot8.label = 2
slot8.has_default_value = false
slot8.default_value = 0
slot8.type = 13
slot8.cpp_type = 3
slot6.name = "insure_net_rec"
slot6.full_name = ".p43.insure_net_rec"
slot6.nested_types = {}
slot6.enum_types = {}
slot6.fields = {
	slot7,
	slot8
}
slot6.is_extendable = false
slot6.extensions = {}
slot9.name = "cs_43002"
slot9.full_name = ".p43.cs_43002"
slot9.nested_types = {}
slot9.enum_types = {}
slot9.fields = {}
slot9.is_extendable = false
slot9.extensions = {}
slot11.name = "result"
slot11.full_name = ".p43.sc_43003.result"
slot11.number = 1
slot11.index = 0
slot11.label = 2
slot11.has_default_value = false
slot11.default_value = 0
slot11.type = 13
slot11.cpp_type = 3
slot10.name = "sc_43003"
slot10.full_name = ".p43.sc_43003"
slot10.nested_types = {}
slot10.enum_types = {}
slot10.fields = {
	slot11
}
slot10.is_extendable = false
slot10.extensions = {}
slot13.name = "equip_suit_id"
slot13.full_name = ".p43.cs_43004.equip_suit_id"
slot13.number = 1
slot13.index = 0
slot13.label = 2
slot13.has_default_value = false
slot13.default_value = 0
slot13.type = 13
slot13.cpp_type = 3
slot12.name = "cs_43004"
slot12.full_name = ".p43.cs_43004"
slot12.nested_types = {}
slot12.enum_types = {}
slot12.fields = {
	slot13
}
slot12.is_extendable = false
slot12.extensions = {}
slot15.name = "result"
slot15.full_name = ".p43.sc_43005.result"
slot15.number = 1
slot15.index = 0
slot15.label = 2
slot15.has_default_value = false
slot15.default_value = 0
slot15.type = 13
slot15.cpp_type = 3
slot14.name = "sc_43005"
slot14.full_name = ".p43.sc_43005"
slot14.nested_types = {}
slot14.enum_types = {}
slot14.fields = {
	slot15
}
slot14.is_extendable = false
slot14.extensions = {}
cs_43002 = slot0.Message(slot9)
cs_43004 = slot0.Message(slot12)
insure_net_rec = slot0.Message(slot6)
sc_43001 = slot0.Message(slot1)
sc_43003 = slot0.Message(slot10)
sc_43005 = slot0.Message(slot14)
