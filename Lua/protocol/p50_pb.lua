slot0 = require("protobuf")

module("p50_pb")

slot1 = slot0.Descriptor()
slot2 = slot0.FieldDescriptor()
slot3 = slot0.FieldDescriptor()
slot4 = slot0.FieldDescriptor()
slot5 = slot0.FieldDescriptor()
slot6 = slot0.FieldDescriptor()
slot7 = slot0.FieldDescriptor()
slot8 = slot0.Descriptor()
slot9 = slot0.FieldDescriptor()
slot10 = slot0.FieldDescriptor()
slot11 = slot0.Descriptor()
slot12 = slot0.FieldDescriptor()
slot13 = slot0.FieldDescriptor()
slot14 = slot0.FieldDescriptor()
slot15 = slot0.Descriptor()
slot16 = slot0.FieldDescriptor()
slot17 = slot0.FieldDescriptor()
slot18 = slot0.Descriptor()
slot19 = slot0.FieldDescriptor()
slot20 = slot0.Descriptor()
slot21 = slot0.FieldDescriptor()
slot22 = slot0.Descriptor()
slot23 = slot0.FieldDescriptor()
slot24 = slot0.Descriptor()
slot25 = slot0.FieldDescriptor()
slot26 = slot0.Descriptor()
slot27 = slot0.FieldDescriptor()
slot28 = slot0.FieldDescriptor()
slot29 = slot0.FieldDescriptor()
slot30 = slot0.Descriptor()
slot31 = slot0.FieldDescriptor()
slot32 = slot0.Descriptor()
slot33 = slot0.FieldDescriptor()
slot34 = slot0.FieldDescriptor()
slot35 = slot0.FieldDescriptor()
slot36 = slot0.Descriptor()
slot37 = slot0.FieldDescriptor()
slot38 = slot0.Descriptor()
slot39 = slot0.FieldDescriptor()
slot40 = slot0.Descriptor()
slot41 = slot0.FieldDescriptor()
slot42 = slot0.Descriptor()
slot43 = slot0.FieldDescriptor()
slot44 = slot0.FieldDescriptor()
slot45 = slot0.Descriptor()
slot46 = slot0.FieldDescriptor()
slot47 = slot0.Descriptor()
slot48 = slot0.FieldDescriptor()
slot49 = slot0.FieldDescriptor()
slot50 = slot0.Descriptor()
slot51 = slot0.FieldDescriptor()
slot52 = slot0.Descriptor()
slot53 = slot0.FieldDescriptor()
slot54 = slot0.Descriptor()
slot55 = slot0.FieldDescriptor()
slot56 = slot0.Descriptor()
slot57 = slot0.FieldDescriptor()
slot58 = slot0.FieldDescriptor()
slot59 = slot0.Descriptor()
slot60 = slot0.FieldDescriptor()
slot2.name = "chip"
slot2.full_name = ".p50.sc_50001.chip"
slot2.number = 1
slot2.index = 0
slot2.label = 2
slot2.has_default_value = false
slot2.default_value = 0
slot2.type = 13
slot2.cpp_type = 3
slot3.name = "unlock_kernel_chip"
slot3.full_name = ".p50.sc_50001.unlock_kernel_chip"
slot3.number = 2
slot3.index = 1
slot3.label = 3
slot3.has_default_value = false
slot3.default_value = {}
slot3.message_type = slot8
slot3.type = 11
slot3.cpp_type = 10
slot4.name = "unlock_secondary_chip"
slot4.full_name = ".p50.sc_50001.unlock_secondary_chip"
slot4.number = 3
slot4.index = 2
slot4.label = 3
slot4.has_default_value = false
slot4.default_value = {}
slot4.type = 13
slot4.cpp_type = 3
slot5.name = "unlock_hero_chip"
slot5.full_name = ".p50.sc_50001.unlock_hero_chip"
slot5.number = 4
slot5.index = 3
slot5.label = 3
slot5.has_default_value = false
slot5.default_value = {}
slot5.type = 13
slot5.cpp_type = 3
slot6.name = "proposals"
slot6.full_name = ".p50.sc_50001.proposals"
slot6.number = 5
slot6.index = 4
slot6.label = 3
slot6.has_default_value = false
slot6.default_value = {}
slot6.message_type = slot11
slot6.type = 11
slot6.cpp_type = 10
slot7.name = "hero_chip_state"
slot7.full_name = ".p50.sc_50001.hero_chip_state"
slot7.number = 6
slot7.index = 5
slot7.label = 3
slot7.has_default_value = false
slot7.default_value = {}
slot7.message_type = slot15
slot7.type = 11
slot7.cpp_type = 10
slot1.name = "sc_50001"
slot1.full_name = ".p50.sc_50001"
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
slot9.name = "id"
slot9.full_name = ".p50.kernel_chip_net_rec.id"
slot9.number = 1
slot9.index = 0
slot9.label = 2
slot9.has_default_value = false
slot9.default_value = 0
slot9.type = 13
slot9.cpp_type = 3
slot10.name = "secondary"
slot10.full_name = ".p50.kernel_chip_net_rec.secondary"
slot10.number = 2
slot10.index = 1
slot10.label = 3
slot10.has_default_value = false
slot10.default_value = {}
slot10.type = 13
slot10.cpp_type = 3
slot8.name = "kernel_chip_net_rec"
slot8.full_name = ".p50.kernel_chip_net_rec"
slot8.nested_types = {}
slot8.enum_types = {}
slot8.fields = {
	slot9,
	slot10
}
slot8.is_extendable = false
slot8.extensions = {}
slot12.name = "id"
slot12.full_name = ".p50.proposal_net_rec.id"
slot12.number = 1
slot12.index = 0
slot12.label = 2
slot12.has_default_value = false
slot12.default_value = 0
slot12.type = 13
slot12.cpp_type = 3
slot13.name = "name"
slot13.full_name = ".p50.proposal_net_rec.name"
slot13.number = 2
slot13.index = 1
slot13.label = 2
slot13.has_default_value = false
slot13.default_value = ""
slot13.type = 9
slot13.cpp_type = 9
slot14.name = "secondary"
slot14.full_name = ".p50.proposal_net_rec.secondary"
slot14.number = 3
slot14.index = 2
slot14.label = 3
slot14.has_default_value = false
slot14.default_value = {}
slot14.type = 13
slot14.cpp_type = 3
slot11.name = "proposal_net_rec"
slot11.full_name = ".p50.proposal_net_rec"
slot11.nested_types = {}
slot11.enum_types = {}
slot11.fields = {
	slot12,
	slot13,
	slot14
}
slot11.is_extendable = false
slot11.extensions = {}
slot16.name = "hero_id"
slot16.full_name = ".p50.hero_chip_state_rec.hero_id"
slot16.number = 1
slot16.index = 0
slot16.label = 2
slot16.has_default_value = false
slot16.default_value = 0
slot16.type = 13
slot16.cpp_type = 3
slot17.name = "secondary"
slot17.full_name = ".p50.hero_chip_state_rec.secondary"
slot17.number = 2
slot17.index = 1
slot17.label = 3
slot17.has_default_value = false
slot17.default_value = {}
slot17.type = 13
slot17.cpp_type = 3
slot15.name = "hero_chip_state_rec"
slot15.full_name = ".p50.hero_chip_state_rec"
slot15.nested_types = {}
slot15.enum_types = {}
slot15.fields = {
	slot16,
	slot17
}
slot15.is_extendable = false
slot15.extensions = {}
slot19.name = "id"
slot19.full_name = ".p50.cs_50002.id"
slot19.number = 1
slot19.index = 0
slot19.label = 2
slot19.has_default_value = false
slot19.default_value = 0
slot19.type = 13
slot19.cpp_type = 3
slot18.name = "cs_50002"
slot18.full_name = ".p50.cs_50002"
slot18.nested_types = {}
slot18.enum_types = {}
slot18.fields = {
	slot19
}
slot18.is_extendable = false
slot18.extensions = {}
slot21.name = "result"
slot21.full_name = ".p50.sc_50003.result"
slot21.number = 1
slot21.index = 0
slot21.label = 2
slot21.has_default_value = false
slot21.default_value = 0
slot21.type = 13
slot21.cpp_type = 3
slot20.name = "sc_50003"
slot20.full_name = ".p50.sc_50003"
slot20.nested_types = {}
slot20.enum_types = {}
slot20.fields = {
	slot21
}
slot20.is_extendable = false
slot20.extensions = {}
slot23.name = "id"
slot23.full_name = ".p50.cs_50004.id"
slot23.number = 1
slot23.index = 0
slot23.label = 2
slot23.has_default_value = false
slot23.default_value = 0
slot23.type = 13
slot23.cpp_type = 3
slot22.name = "cs_50004"
slot22.full_name = ".p50.cs_50004"
slot22.nested_types = {}
slot22.enum_types = {}
slot22.fields = {
	slot23
}
slot22.is_extendable = false
slot22.extensions = {}
slot25.name = "result"
slot25.full_name = ".p50.sc_50005.result"
slot25.number = 1
slot25.index = 0
slot25.label = 2
slot25.has_default_value = false
slot25.default_value = 0
slot25.type = 13
slot25.cpp_type = 3
slot24.name = "sc_50005"
slot24.full_name = ".p50.sc_50005"
slot24.nested_types = {}
slot24.enum_types = {}
slot24.fields = {
	slot25
}
slot24.is_extendable = false
slot24.extensions = {}
slot27.name = "kernel_id"
slot27.full_name = ".p50.cs_50006.kernel_id"
slot27.number = 1
slot27.index = 0
slot27.label = 2
slot27.has_default_value = false
slot27.default_value = 0
slot27.type = 13
slot27.cpp_type = 3
slot28.name = "secondary_id"
slot28.full_name = ".p50.cs_50006.secondary_id"
slot28.number = 2
slot28.index = 1
slot28.label = 2
slot28.has_default_value = false
slot28.default_value = 0
slot28.type = 13
slot28.cpp_type = 3
slot29.name = "oper"
slot29.full_name = ".p50.cs_50006.oper"
slot29.number = 3
slot29.index = 2
slot29.label = 2
slot29.has_default_value = false
slot29.default_value = 0
slot29.type = 13
slot29.cpp_type = 3
slot26.name = "cs_50006"
slot26.full_name = ".p50.cs_50006"
slot26.nested_types = {}
slot26.enum_types = {}
slot26.fields = {
	slot27,
	slot28,
	slot29
}
slot26.is_extendable = false
slot26.extensions = {}
slot31.name = "result"
slot31.full_name = ".p50.sc_50007.result"
slot31.number = 1
slot31.index = 0
slot31.label = 2
slot31.has_default_value = false
slot31.default_value = 0
slot31.type = 13
slot31.cpp_type = 3
slot30.name = "sc_50007"
slot30.full_name = ".p50.sc_50007"
slot30.nested_types = {}
slot30.enum_types = {}
slot30.fields = {
	slot31
}
slot30.is_extendable = false
slot30.extensions = {}
slot33.name = "id"
slot33.full_name = ".p50.cs_50008.id"
slot33.number = 1
slot33.index = 0
slot33.label = 2
slot33.has_default_value = false
slot33.default_value = 0
slot33.type = 13
slot33.cpp_type = 3
slot34.name = "name"
slot34.full_name = ".p50.cs_50008.name"
slot34.number = 2
slot34.index = 1
slot34.label = 2
slot34.has_default_value = false
slot34.default_value = ""
slot34.type = 9
slot34.cpp_type = 9
slot35.name = "secondary"
slot35.full_name = ".p50.cs_50008.secondary"
slot35.number = 3
slot35.index = 2
slot35.label = 3
slot35.has_default_value = false
slot35.default_value = {}
slot35.type = 13
slot35.cpp_type = 3
slot32.name = "cs_50008"
slot32.full_name = ".p50.cs_50008"
slot32.nested_types = {}
slot32.enum_types = {}
slot32.fields = {
	slot33,
	slot34,
	slot35
}
slot32.is_extendable = false
slot32.extensions = {}
slot37.name = "result"
slot37.full_name = ".p50.sc_50009.result"
slot37.number = 1
slot37.index = 0
slot37.label = 2
slot37.has_default_value = false
slot37.default_value = 0
slot37.type = 13
slot37.cpp_type = 3
slot36.name = "sc_50009"
slot36.full_name = ".p50.sc_50009"
slot36.nested_types = {}
slot36.enum_types = {}
slot36.fields = {
	slot37
}
slot36.is_extendable = false
slot36.extensions = {}
slot39.name = "id"
slot39.full_name = ".p50.cs_50010.id"
slot39.number = 1
slot39.index = 0
slot39.label = 2
slot39.has_default_value = false
slot39.default_value = 0
slot39.type = 13
slot39.cpp_type = 3
slot38.name = "cs_50010"
slot38.full_name = ".p50.cs_50010"
slot38.nested_types = {}
slot38.enum_types = {}
slot38.fields = {
	slot39
}
slot38.is_extendable = false
slot38.extensions = {}
slot41.name = "result"
slot41.full_name = ".p50.sc_50011.result"
slot41.number = 1
slot41.index = 0
slot41.label = 2
slot41.has_default_value = false
slot41.default_value = 0
slot41.type = 13
slot41.cpp_type = 3
slot40.name = "sc_50011"
slot40.full_name = ".p50.sc_50011"
slot40.nested_types = {}
slot40.enum_types = {}
slot40.fields = {
	slot41
}
slot40.is_extendable = false
slot40.extensions = {}
slot43.name = "id"
slot43.full_name = ".p50.cs_50012.id"
slot43.number = 1
slot43.index = 0
slot43.label = 2
slot43.has_default_value = false
slot43.default_value = 0
slot43.type = 13
slot43.cpp_type = 3
slot44.name = "name"
slot44.full_name = ".p50.cs_50012.name"
slot44.number = 2
slot44.index = 1
slot44.label = 2
slot44.has_default_value = false
slot44.default_value = ""
slot44.type = 9
slot44.cpp_type = 9
slot42.name = "cs_50012"
slot42.full_name = ".p50.cs_50012"
slot42.nested_types = {}
slot42.enum_types = {}
slot42.fields = {
	slot43,
	slot44
}
slot42.is_extendable = false
slot42.extensions = {}
slot46.name = "result"
slot46.full_name = ".p50.sc_50013.result"
slot46.number = 1
slot46.index = 0
slot46.label = 2
slot46.has_default_value = false
slot46.default_value = 0
slot46.type = 13
slot46.cpp_type = 3
slot45.name = "sc_50013"
slot45.full_name = ".p50.sc_50013"
slot45.nested_types = {}
slot45.enum_types = {}
slot45.fields = {
	slot46
}
slot45.is_extendable = false
slot45.extensions = {}
slot48.name = "kernel_chip_id"
slot48.full_name = ".p50.cs_50014.kernel_chip_id"
slot48.number = 1
slot48.index = 0
slot48.label = 2
slot48.has_default_value = false
slot48.default_value = 0
slot48.type = 13
slot48.cpp_type = 3
slot49.name = "proposal_id"
slot49.full_name = ".p50.cs_50014.proposal_id"
slot49.number = 2
slot49.index = 1
slot49.label = 2
slot49.has_default_value = false
slot49.default_value = 0
slot49.type = 13
slot49.cpp_type = 3
slot47.name = "cs_50014"
slot47.full_name = ".p50.cs_50014"
slot47.nested_types = {}
slot47.enum_types = {}
slot47.fields = {
	slot48,
	slot49
}
slot47.is_extendable = false
slot47.extensions = {}
slot51.name = "result"
slot51.full_name = ".p50.sc_50015.result"
slot51.number = 1
slot51.index = 0
slot51.label = 2
slot51.has_default_value = false
slot51.default_value = 0
slot51.type = 13
slot51.cpp_type = 3
slot50.name = "sc_50015"
slot50.full_name = ".p50.sc_50015"
slot50.nested_types = {}
slot50.enum_types = {}
slot50.fields = {
	slot51
}
slot50.is_extendable = false
slot50.extensions = {}
slot53.name = "kernel_id"
slot53.full_name = ".p50.cs_50016.kernel_id"
slot53.number = 1
slot53.index = 0
slot53.label = 2
slot53.has_default_value = false
slot53.default_value = 0
slot53.type = 13
slot53.cpp_type = 3
slot52.name = "cs_50016"
slot52.full_name = ".p50.cs_50016"
slot52.nested_types = {}
slot52.enum_types = {}
slot52.fields = {
	slot53
}
slot52.is_extendable = false
slot52.extensions = {}
slot55.name = "result"
slot55.full_name = ".p50.sc_50017.result"
slot55.number = 1
slot55.index = 0
slot55.label = 2
slot55.has_default_value = false
slot55.default_value = 0
slot55.type = 13
slot55.cpp_type = 3
slot54.name = "sc_50017"
slot54.full_name = ".p50.sc_50017"
slot54.nested_types = {}
slot54.enum_types = {}
slot54.fields = {
	slot55
}
slot54.is_extendable = false
slot54.extensions = {}
slot57.name = "hero_id"
slot57.full_name = ".p50.cs_50018.hero_id"
slot57.number = 1
slot57.index = 0
slot57.label = 2
slot57.has_default_value = false
slot57.default_value = 0
slot57.type = 13
slot57.cpp_type = 3
slot58.name = "secondary"
slot58.full_name = ".p50.cs_50018.secondary"
slot58.number = 2
slot58.index = 1
slot58.label = 2
slot58.has_default_value = false
slot58.default_value = 0
slot58.type = 13
slot58.cpp_type = 3
slot56.name = "cs_50018"
slot56.full_name = ".p50.cs_50018"
slot56.nested_types = {}
slot56.enum_types = {}
slot56.fields = {
	slot57,
	slot58
}
slot56.is_extendable = false
slot56.extensions = {}
slot60.name = "result"
slot60.full_name = ".p50.sc_50019.result"
slot60.number = 1
slot60.index = 0
slot60.label = 2
slot60.has_default_value = false
slot60.default_value = 0
slot60.type = 13
slot60.cpp_type = 3
slot59.name = "sc_50019"
slot59.full_name = ".p50.sc_50019"
slot59.nested_types = {}
slot59.enum_types = {}
slot59.fields = {
	slot60
}
slot59.is_extendable = false
slot59.extensions = {}
cs_50002 = slot0.Message(slot18)
cs_50004 = slot0.Message(slot22)
cs_50006 = slot0.Message(slot26)
cs_50008 = slot0.Message(slot32)
cs_50010 = slot0.Message(slot38)
cs_50012 = slot0.Message(slot42)
cs_50014 = slot0.Message(slot47)
cs_50016 = slot0.Message(slot52)
cs_50018 = slot0.Message(slot56)
hero_chip_state_rec = slot0.Message(slot15)
kernel_chip_net_rec = slot0.Message(slot8)
proposal_net_rec = slot0.Message(slot11)
sc_50001 = slot0.Message(slot1)
sc_50003 = slot0.Message(slot20)
sc_50005 = slot0.Message(slot24)
sc_50007 = slot0.Message(slot30)
sc_50009 = slot0.Message(slot36)
sc_50011 = slot0.Message(slot40)
sc_50013 = slot0.Message(slot45)
sc_50015 = slot0.Message(slot50)
sc_50017 = slot0.Message(slot54)
sc_50019 = slot0.Message(slot59)