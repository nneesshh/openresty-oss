local _M = {}

--[[config_mgzjh_robot.xlsx,ConfigRobot]]
local __tmp_tbl__ = {
	[1] = {userid=1,username="mgzjh1001",pwd="a123123",nick="我来自火星01",phone="12345678901",imei="imei00001",imsi="imsi00001",email="a@b.com01",addr="西溪银泰01",avatar="av124",gender=1,balance=1000,state=0,channel="ch001",subChannel="sch001"},
	[2] = {userid=2,username="mgzjh1002",pwd="a123123",nick="我来自火星02",phone="12345678902",imei="imei00002",imsi="imsi00002",email="a@b.com02",addr="西溪银泰02",avatar="av124",gender=1,balance=1000,state=0,channel="ch002",subChannel="sch002"},
	[3] = {userid=3,username="mgzjh1003",pwd="a123123",nick="我来自火星03",phone="12345678903",imei="imei00003",imsi="imsi00003",email="a@b.com03",addr="西溪银泰03",avatar="av124",gender=1,balance=1000,state=0,channel="ch003",subChannel="sch003"},
	[4] = {userid=4,username="mgzjh1004",pwd="a123123",nick="我来自火星04",phone="12345678904",imei="imei00004",imsi="imsi00004",email="a@b.com04",addr="西溪银泰04",avatar="av124",gender=1,balance=1000,state=0,channel="ch004",subChannel="sch004"},
	[5] = {userid=5,username="mgzjh1005",pwd="a123123",nick="我来自火星05",phone="12345678905",imei="imei00005",imsi="imsi00005",email="a@b.com05",addr="西溪银泰05",avatar="av124",gender=1,balance=1000,state=0,channel="ch005",subChannel="sch005"},
	[6] = {userid=6,username="mgzjh1006",pwd="a123123",nick="我来自火星06",phone="12345678906",imei="imei00006",imsi="imsi00006",email="a@b.com06",addr="西溪银泰06",avatar="av124",gender=1,balance=1000,state=0,channel="ch006",subChannel="sch006"},
	[7] = {userid=7,username="mgzjh1007",pwd="a123123",nick="我来自火星07",phone="12345678907",imei="imei00007",imsi="imsi00007",email="a@b.com07",addr="西溪银泰07",avatar="av124",gender=1,balance=1000,state=0,channel="ch007",subChannel="sch007"},
	[8] = {userid=8,username="mgzjh1008",pwd="a123123",nick="我来自火星08",phone="12345678908",imei="imei00008",imsi="imsi00008",email="a@b.com08",addr="西溪银泰08",avatar="av124",gender=1,balance=1000,state=0,channel="ch008",subChannel="sch008"},
	[9] = {userid=9,username="mgzjh1009",pwd="a123123",nick="我来自火星09",phone="12345678909",imei="imei00009",imsi="imsi00009",email="a@b.com09",addr="西溪银泰09",avatar="av124",gender=1,balance=1000,state=0,channel="ch009",subChannel="sch009"},
	[10] = {userid=10,username="mgzjh1010",pwd="a123123",nick="我来自火星10",phone="12345678910",imei="imei00010",imsi="imsi00010",email="a@b.com10",addr="西溪银泰10",avatar="av124",gender=1,balance=1000,state=0,channel="ch010",subChannel="sch010"},
	[11] = {userid=11,username="mgzjh1011",pwd="a123123",nick="我来自火星11",phone="12345678911",imei="imei00011",imsi="imsi00011",email="a@b.com11",addr="西溪银泰11",avatar="av124",gender=1,balance=1000,state=0,channel="ch011",subChannel="sch011"},
	[12] = {userid=12,username="mgzjh1012",pwd="a123123",nick="我来自火星12",phone="12345678912",imei="imei00012",imsi="imsi00012",email="a@b.com12",addr="西溪银泰12",avatar="av124",gender=1,balance=1000,state=0,channel="ch012",subChannel="sch012"},
	[13] = {userid=13,username="mgzjh1013",pwd="a123123",nick="我来自火星13",phone="12345678913",imei="imei00013",imsi="imsi00013",email="a@b.com13",addr="西溪银泰13",avatar="av124",gender=1,balance=1000,state=0,channel="ch013",subChannel="sch013"},
	[14] = {userid=14,username="mgzjh1014",pwd="a123123",nick="我来自火星14",phone="12345678914",imei="imei00014",imsi="imsi00014",email="a@b.com14",addr="西溪银泰14",avatar="av124",gender=1,balance=1000,state=0,channel="ch014",subChannel="sch014"},
	[15] = {userid=15,username="mgzjh1015",pwd="a123123",nick="我来自火星15",phone="12345678915",imei="imei00015",imsi="imsi00015",email="a@b.com15",addr="西溪银泰15",avatar="av124",gender=1,balance=1000,state=0,channel="ch015",subChannel="sch015"},
	[16] = {userid=16,username="mgzjh1016",pwd="a123123",nick="我来自火星16",phone="12345678916",imei="imei00016",imsi="imsi00016",email="a@b.com16",addr="西溪银泰16",avatar="av124",gender=1,balance=1000,state=0,channel="ch016",subChannel="sch016"},
	[17] = {userid=17,username="mgzjh1017",pwd="a123123",nick="我来自火星17",phone="12345678917",imei="imei00017",imsi="imsi00017",email="a@b.com17",addr="西溪银泰17",avatar="av124",gender=1,balance=1000,state=0,channel="ch017",subChannel="sch017"},
	[18] = {userid=18,username="mgzjh1018",pwd="a123123",nick="我来自火星18",phone="12345678918",imei="imei00018",imsi="imsi00018",email="a@b.com18",addr="西溪银泰18",avatar="av124",gender=1,balance=1000,state=0,channel="ch018",subChannel="sch018"},
	[19] = {userid=19,username="mgzjh1019",pwd="a123123",nick="我来自火星19",phone="12345678919",imei="imei00019",imsi="imsi00019",email="a@b.com19",addr="西溪银泰19",avatar="av124",gender=1,balance=1000,state=0,channel="ch019",subChannel="sch019"},
	[20] = {userid=20,username="mgzjh1020",pwd="a123123",nick="我来自火星20",phone="12345678920",imei="imei00020",imsi="imsi00020",email="a@b.com20",addr="西溪银泰20",avatar="av124",gender=1,balance=1000,state=0,channel="ch020",subChannel="sch020"}
};if not _M.ConfigRobot then _M.ConfigRobot =__tmp_tbl__;else for k,v in pairs(__tmp_tbl__) do _M.ConfigRobot[k]=v end;end;

return _M
