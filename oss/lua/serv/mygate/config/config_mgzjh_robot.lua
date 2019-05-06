local _M = {}

--[[config_mgzjh_robot.xlsx,ConfigRobot]]
local __tmp_tbl__ = {
	[1] = {userid=1,username="testzjh1001",pwd="a123123",nick="我来自金星01",phone="13521943211",imei="xxxximei00001",imsi="yyyyimsi00001",email="zzz@163b.com01",addr="武林银泰01",avatar="av131",gender=1,balance=1000,state=0,channel="ch001",subChannel="sch001"},
	[2] = {userid=2,username="testzjh1002",pwd="a123123",nick="我来自金星02",phone="13521943212",imei="xxxximei00002",imsi="yyyyimsi00002",email="zzz@163b.com02",addr="武林银泰02",avatar="av132",gender=1,balance=1000,state=0,channel="ch002",subChannel="sch002"},
	[3] = {userid=3,username="testzjh1003",pwd="a123123",nick="我来自金星03",phone="13521943213",imei="xxxximei00003",imsi="yyyyimsi00003",email="zzz@163b.com03",addr="武林银泰03",avatar="av133",gender=1,balance=1000,state=0,channel="ch003",subChannel="sch003"},
	[4] = {userid=4,username="testzjh1004",pwd="a123123",nick="我来自金星04",phone="13521943214",imei="xxxximei00004",imsi="yyyyimsi00004",email="zzz@163b.com04",addr="武林银泰04",avatar="av134",gender=1,balance=1000,state=0,channel="ch004",subChannel="sch004"},
	[5] = {userid=5,username="testzjh1005",pwd="a123123",nick="我来自金星05",phone="13521943215",imei="xxxximei00005",imsi="yyyyimsi00005",email="zzz@163b.com05",addr="武林银泰05",avatar="av135",gender=1,balance=1000,state=0,channel="ch005",subChannel="sch005"},
	[6] = {userid=6,username="testzjh1006",pwd="a123123",nick="我来自金星06",phone="13521943216",imei="xxxximei00006",imsi="yyyyimsi00006",email="zzz@163b.com06",addr="武林银泰06",avatar="av136",gender=1,balance=1000,state=0,channel="ch006",subChannel="sch006"},
	[7] = {userid=7,username="testzjh1007",pwd="a123123",nick="我来自金星07",phone="13521943217",imei="xxxximei00007",imsi="yyyyimsi00007",email="zzz@163b.com07",addr="武林银泰07",avatar="av137",gender=1,balance=1000,state=0,channel="ch007",subChannel="sch007"},
	[8] = {userid=8,username="testzjh1008",pwd="a123123",nick="我来自金星08",phone="13521943218",imei="xxxximei00008",imsi="yyyyimsi00008",email="zzz@163b.com08",addr="武林银泰08",avatar="av138",gender=1,balance=1000,state=0,channel="ch008",subChannel="sch008"},
	[9] = {userid=9,username="testzjh1009",pwd="a123123",nick="我来自金星09",phone="13521943219",imei="xxxximei00009",imsi="yyyyimsi00009",email="zzz@163b.com09",addr="武林银泰09",avatar="av139",gender=1,balance=1000,state=0,channel="ch009",subChannel="sch009"},
	[10] = {userid=10,username="testzjh1010",pwd="a123123",nick="我来自金星10",phone="13521943220",imei="xxxximei00010",imsi="yyyyimsi00010",email="zzz@163b.com10",addr="武林银泰10",avatar="av140",gender=1,balance=1000,state=0,channel="ch010",subChannel="sch010"},
	[11] = {userid=11,username="testzjh1011",pwd="a123123",nick="我来自金星11",phone="13521943221",imei="xxxximei00011",imsi="yyyyimsi00011",email="zzz@163b.com11",addr="武林银泰11",avatar="av141",gender=1,balance=1000,state=0,channel="ch011",subChannel="sch011"},
	[12] = {userid=12,username="testzjh1012",pwd="a123123",nick="我来自金星12",phone="13521943222",imei="xxxximei00012",imsi="yyyyimsi00012",email="zzz@163b.com12",addr="武林银泰12",avatar="av142",gender=1,balance=1000,state=0,channel="ch012",subChannel="sch012"},
	[13] = {userid=13,username="testzjh1013",pwd="a123123",nick="我来自金星13",phone="13521943223",imei="xxxximei00013",imsi="yyyyimsi00013",email="zzz@163b.com13",addr="武林银泰13",avatar="av143",gender=1,balance=1000,state=0,channel="ch013",subChannel="sch013"},
	[14] = {userid=14,username="testzjh1014",pwd="a123123",nick="我来自金星14",phone="13521943224",imei="xxxximei00014",imsi="yyyyimsi00014",email="zzz@163b.com14",addr="武林银泰14",avatar="av144",gender=1,balance=1000,state=0,channel="ch014",subChannel="sch014"},
	[15] = {userid=15,username="testzjh1015",pwd="a123123",nick="我来自金星15",phone="13521943225",imei="xxxximei00015",imsi="yyyyimsi00015",email="zzz@163b.com15",addr="武林银泰15",avatar="av145",gender=1,balance=1000,state=0,channel="ch015",subChannel="sch015"},
	[16] = {userid=16,username="testzjh1016",pwd="a123123",nick="我来自金星16",phone="13521943226",imei="xxxximei00016",imsi="yyyyimsi00016",email="zzz@163b.com16",addr="武林银泰16",avatar="av146",gender=1,balance=1000,state=0,channel="ch016",subChannel="sch016"},
	[17] = {userid=17,username="testzjh1017",pwd="a123123",nick="我来自金星17",phone="13521943227",imei="xxxximei00017",imsi="yyyyimsi00017",email="zzz@163b.com17",addr="武林银泰17",avatar="av147",gender=1,balance=1000,state=0,channel="ch017",subChannel="sch017"},
	[18] = {userid=18,username="testzjh1018",pwd="a123123",nick="我来自金星18",phone="13521943228",imei="xxxximei00018",imsi="yyyyimsi00018",email="zzz@163b.com18",addr="武林银泰18",avatar="av148",gender=1,balance=1000,state=0,channel="ch018",subChannel="sch018"},
	[19] = {userid=19,username="testzjh1019",pwd="a123123",nick="我来自金星19",phone="13521943229",imei="xxxximei00019",imsi="yyyyimsi00019",email="zzz@163b.com19",addr="武林银泰19",avatar="av149",gender=1,balance=1000,state=0,channel="ch019",subChannel="sch019"},
	[20] = {userid=20,username="testzjh1020",pwd="a123123",nick="我来自金星20",phone="13521943230",imei="xxxximei00020",imsi="yyyyimsi00020",email="zzz@163b.com20",addr="武林银泰20",avatar="av150",gender=1,balance=1000,state=0,channel="ch020",subChannel="sch020"}
};if not _M.ConfigRobot then _M.ConfigRobot =__tmp_tbl__;else for k,v in pairs(__tmp_tbl__) do _M.ConfigRobot[k]=v end;end;

return _M
