slot0 = require("protobuf")

module("p23_pb")

slot1 = slot0.Descriptor()
slot2 = slot0.FieldDescriptor()
slot3 = slot0.FieldDescriptor()
slot4 = slot0.FieldDescriptor()
slot5 = slot0.FieldDescriptor()
slot6 = slot0.FieldDescriptor()
slot7 = slot0.FieldDescriptor()
slot8 = slot0.Descriptor()
slot9 = slot0.FieldDescriptor()
slot10 = slot0.Descriptor()
slot11 = slot0.FieldDescriptor()
slot12 = slot0.Descriptor()
slot13 = slot0.FieldDescriptor()
slot14 = slot0.Descriptor()
slot15 = slot0.FieldDescriptor()
slot16 = slot0.Descriptor()
slot17 = slot0.FieldDescriptor()
slot2.name = "total_exp"
slot2.full_name = ".p23.sc_23009.total_exp"
slot2.number = 1
slot2.index = 0
slot2.label = 2
slot2.has_default_value = false
slot2.default_value = 0
slot2.type = 13
slot2.cpp_type = 3
slot3.name = "nick"
slot3.full_name = ".p23.sc_23009.nick"
slot3.number = 2
slot3.index = 1
slot3.label = 2
slot3.has_default_value = false
slot3.default_value = ""
slot3.type = 9
slot3.cpp_type = 9
slot4.name = "hero_num"
slot4.full_name = ".p23.sc_23009.hero_num"
slot4.number = 3
slot4.index = 2
slot4.label = 2
slot4.has_default_value = false
slot4.default_value = 0
slot4.type = 13
slot4.cpp_type = 3
slot5.name = "plot_progress"
slot5.full_name = ".p23.sc_23009.plot_progress"
slot5.number = 4
slot5.index = 3
slot5.label = 2
slot5.has_default_value = false
slot5.default_value = 0
slot5.type = 13
slot5.cpp_type = 3
slot6.name = "is_changed_nick"
slot6.full_name = ".p23.sc_23009.is_changed_nick"
slot6.number = 5
slot6.index = 4
slot6.label = 1
slot6.has_default_value = false
slot6.default_value = 0
slot6.type = 13
slot6.cpp_type = 3
slot7.name = "system_change_nick_times"
slot7.full_name = ".p23.sc_23009.system_change_nick_times"
slot7.number = 6
slot7.index = 5
slot7.label = 1
slot7.has_default_value = false
slot7.default_value = 0
slot7.type = 13
slot7.cpp_type = 3
slot1.name = "sc_23009"
slot1.full_name = ".p23.sc_23009"
slot1.nested_types = {}
slot1.enum_types = {}
slot1.fields = {
	slot2,
	slot3,
	slot4,
	slot5,
	slot6,
	slot7
}
slot1.is_extendable = false
slot1.extensions = {}
slot9.name = "nothing"
slot9.full_name = ".p23.cs_23010.nothing"
slot9.number = 1
slot9.index = 0
slot9.label = 2
slot9.has_default_value = false
slot9.default_value = 0
slot9.type = 13
slot9.cpp_type = 3
slot8.name = "cs_23010"
slot8.full_name = ".p23.cs_23010"
slot8.nested_types = {}
slot8.enum_types = {}
slot8.fields = {
	slot9
}
slot8.is_extendable = false
slot8.extensions = {}
slot11.name = "result"
slot11.full_name = ".p23.sc_23011.result"
slot11.number = 1
slot11.index = 0
slot11.label = 2
slot11.has_default_value = false
slot11.default_value = 0
slot11.type = 13
slot11.cpp_type = 3
slot10.name = "sc_23011"
slot10.full_name = ".p23.sc_23011"
slot10.nested_types = {}
slot10.enum_types = {}
slot10.fields = {
	slot11
}
slot10.is_extendable = false
slot10.extensions = {}
slot13.name = "nick"
slot13.full_name = ".p23.cs_23012.nick"
slot13.number = 1
slot13.index = 0
slot13.label = 2
slot13.has_default_value = false
slot13.default_value = ""
slot13.type = 9
slot13.cpp_type = 9
slot12.name = "cs_23012"
slot12.full_name = ".p23.cs_23012"
slot12.nested_types = {}
slot12.enum_types = {}
slot12.fields = {
	slot13
}
slot12.is_extendable = false
slot12.extensions = {}
slot15.name = "result"
slot15.full_name = ".p23.sc_23013.result"
slot15.number = 1
slot15.index = 0
slot15.label = 2
slot15.has_default_value = false
slot15.default_value = 0
slot15.type = 13
slot15.cpp_type = 3
slot14.name = "sc_23013"
slot14.full_name = ".p23.sc_23013"
slot14.nested_types = {}
slot14.enum_types = {}
slot14.fields = {
	slot15
}
slot14.is_extendable = false
slot14.extensions = {}
slot17.name = "ip_location"
slot17.full_name = ".p23.sc_23015.ip_location"
slot17.number = 1
slot17.index = 0
slot17.label = 2
slot17.has_default_value = false
slot17.default_value = ""
slot17.type = 9
slot17.cpp_type = 9
slot16.name = "sc_23015"
slot16.full_name = ".p23.sc_23015"
slot16.nested_types = {}
slot16.enum_types = {}
slot16.fields = {
	slot17
}
slot16.is_extendable = false
slot16.extensions = {}
cs_23010 = slot0.Message(slot8)
cs_23012 = slot0.Message(slot12)
sc_23009 = slot0.Message(slot1)
sc_23011 = slot0.Message(slot10)
sc_23013 = slot0.Message(slot14)
sc_23015 = slot0.Message(slot16)
