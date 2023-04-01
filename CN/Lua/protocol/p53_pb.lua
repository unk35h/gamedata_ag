slot0 = require("protobuf")

module("p53_pb")

slot1 = slot0.Descriptor()
slot2 = slot0.FieldDescriptor()
slot3 = slot0.FieldDescriptor()
slot4 = slot0.Descriptor()
slot5 = slot0.FieldDescriptor()
slot6 = slot0.FieldDescriptor()
slot7 = slot0.FieldDescriptor()
slot8 = slot0.FieldDescriptor()
slot9 = slot0.Descriptor()
slot10 = slot0.FieldDescriptor()
slot11 = slot0.Descriptor()
slot12 = slot0.FieldDescriptor()
slot13 = slot0.Descriptor()
slot14 = slot0.FieldDescriptor()
slot15 = slot0.Descriptor()
slot16 = slot0.FieldDescriptor()
slot17 = slot0.Descriptor()
slot18 = slot0.FieldDescriptor()
slot2.name = "achievement_list"
slot2.full_name = ".p53.sc_53001.achievement_list"
slot2.number = 1
slot2.index = 0
slot2.label = 3
slot2.has_default_value = false
slot2.default_value = {}
slot2.message_type = slot4
slot2.type = 11
slot2.cpp_type = 10
slot3.name = "story_line"
slot3.full_name = ".p53.sc_53001.story_line"
slot3.number = 2
slot3.index = 1
slot3.label = 3
slot3.has_default_value = false
slot3.default_value = {}
slot3.type = 13
slot3.cpp_type = 3
slot1.name = "sc_53001"
slot1.full_name = ".p53.sc_53001"
slot1.nested_types = {}
slot1.enum_types = {}
slot1.fields = {
	slot2,
	slot3
}
slot1.is_extendable = false
slot1.extensions = {}
slot5.name = "id"
slot5.full_name = ".p53.achievement_info.id"
slot5.number = 1
slot5.index = 0
slot5.label = 2
slot5.has_default_value = false
slot5.default_value = 0
slot5.type = 13
slot5.cpp_type = 3
slot6.name = "progress"
slot6.full_name = ".p53.achievement_info.progress"
slot6.number = 2
slot6.index = 1
slot6.label = 2
slot6.has_default_value = false
slot6.default_value = 0
slot6.type = 13
slot6.cpp_type = 3
slot7.name = "achieve_time"
slot7.full_name = ".p53.achievement_info.achieve_time"
slot7.number = 3
slot7.index = 2
slot7.label = 2
slot7.has_default_value = false
slot7.default_value = 0
slot7.type = 13
slot7.cpp_type = 3
slot8.name = "complete_flag"
slot8.full_name = ".p53.achievement_info.complete_flag"
slot8.number = 4
slot8.index = 3
slot8.label = 1
slot8.has_default_value = false
slot8.default_value = 0
slot8.type = 13
slot8.cpp_type = 3
slot4.name = "achievement_info"
slot4.full_name = ".p53.achievement_info"
slot4.nested_types = {}
slot4.enum_types = {}
slot4.fields = {
	slot5,
	slot6,
	slot7,
	slot8
}
slot4.is_extendable = false
slot4.extensions = {}
slot10.name = "achievement_progress"
slot10.full_name = ".p53.sc_53003.achievement_progress"
slot10.number = 1
slot10.index = 0
slot10.label = 3
slot10.has_default_value = false
slot10.default_value = {}
slot10.message_type = slot4
slot10.type = 11
slot10.cpp_type = 10
slot9.name = "sc_53003"
slot9.full_name = ".p53.sc_53003"
slot9.nested_types = {}
slot9.enum_types = {}
slot9.fields = {
	slot10
}
slot9.is_extendable = false
slot9.extensions = {}
slot12.name = "id"
slot12.full_name = ".p53.cs_53004.id"
slot12.number = 1
slot12.index = 0
slot12.label = 2
slot12.has_default_value = false
slot12.default_value = 0
slot12.type = 13
slot12.cpp_type = 3
slot11.name = "cs_53004"
slot11.full_name = ".p53.cs_53004"
slot11.nested_types = {}
slot11.enum_types = {}
slot11.fields = {
	slot12
}
slot11.is_extendable = false
slot11.extensions = {}
slot14.name = "result"
slot14.full_name = ".p53.sc_53005.result"
slot14.number = 1
slot14.index = 0
slot14.label = 2
slot14.has_default_value = false
slot14.default_value = 0
slot14.type = 13
slot14.cpp_type = 3
slot13.name = "sc_53005"
slot13.full_name = ".p53.sc_53005"
slot13.nested_types = {}
slot13.enum_types = {}
slot13.fields = {
	slot14
}
slot13.is_extendable = false
slot13.extensions = {}
slot16.name = "id"
slot16.full_name = ".p53.cs_53006.id"
slot16.number = 1
slot16.index = 0
slot16.label = 2
slot16.has_default_value = false
slot16.default_value = 0
slot16.type = 13
slot16.cpp_type = 3
slot15.name = "cs_53006"
slot15.full_name = ".p53.cs_53006"
slot15.nested_types = {}
slot15.enum_types = {}
slot15.fields = {
	slot16
}
slot15.is_extendable = false
slot15.extensions = {}
slot18.name = "result"
slot18.full_name = ".p53.sc_53007.result"
slot18.number = 1
slot18.index = 0
slot18.label = 2
slot18.has_default_value = false
slot18.default_value = 0
slot18.type = 13
slot18.cpp_type = 3
slot17.name = "sc_53007"
slot17.full_name = ".p53.sc_53007"
slot17.nested_types = {}
slot17.enum_types = {}
slot17.fields = {
	slot18
}
slot17.is_extendable = false
slot17.extensions = {}
achievement_info = slot0.Message(slot4)
cs_53004 = slot0.Message(slot11)
cs_53006 = slot0.Message(slot15)
sc_53001 = slot0.Message(slot1)
sc_53003 = slot0.Message(slot9)
sc_53005 = slot0.Message(slot13)
sc_53007 = slot0.Message(slot17)
