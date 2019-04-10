db.getCollection("departments").insert(
    {'Code': null,
    'ContactNumber': null,
    'CreateBy': null,
    'CreateTime': null,
    'IsDeleted': 0,
    'Manager': null,
    'Name': '程序部',
    'ParentId': '00000000-0000-0000-0000-000000000000',
    'Remarks': null,
    }
);

db.getCollection("gamedburls").insert(
    {'Name': '苹果测试服A',
    'Type': 0,
    'Url': 'Server=192.168.209.129;Port=27017;Database=zjhdb',
    }
);

db.getCollection("memberpreferredsettings").insert(
    {'MemberId': 'test0001@b.com',
    'GameDbUrlId': "fb145d88-39e7-4370-9c8f-7712f814c830",
    'MenuId': '00000000-0000-0000-0000-000000000000',
    }
);

db.getCollection("memberroles").insert(
    {'MemberId': 'test0001@b.com',
    'RoleId': "24ef2930-d755-4efb-b5dc-cde92eb905af",
    }
);

db.getCollection("menus").insert(
    [
        { 
            "_id" : ObjectId("5c9c6a35b552003650898877"), 
            "Code" : "User", 
            "Icon" : "fa fa-link", 
            "Name" : "用户管理", 
            "ParentId" : "00000000-0000-0000-0000-000000000000", 
            "Remarks" : "", 
            "SeqNo" : NumberInt(3), 
            "Type" : NumberInt(0), 
            "Url" : "/AdminUser", 
            "Hide" : NumberInt(1)
        },
        { 
            "_id" : ObjectId("5c9c6a35b552003650898878"), 
            "Code" : "GamePlayer", 
            "Icon" : "fa fa-link", 
            "Name" : "游戏玩家数据查询", 
            "ParentId" : "00000000-0000-0000-0000-000000000000", 
            "Remarks" : "", 
            "SeqNo" : NumberInt(7), 
            "Type" : NumberInt(0), 
            "Url" : "/PlayerCenter", 
            "Hide" : NumberInt(0)
        },
        { 
            "_id" : ObjectId("5c9c6a35b552003650898879"), 
            "Code" : "Role", 
            "Icon" : "fa fa-link", 
            "Name" : "角色管理", 
            "ParentId" : "00000000-0000-0000-0000-000000000000", 
            "Remarks" : "", 
            "SeqNo" : NumberInt(2), 
            "Type" : NumberInt(0), 
            "Url" : "/AdminRole", 
            "Hide" : NumberInt(1)
        },
        { 
            "_id" : ObjectId("5c9c6a35b55200365089887a"), 
            "Code" : "GameQuest", 
            "Icon" : "fa fa-link", 
            "Name" : "任务统计", 
            "ParentId" : "00000000-0000-0000-0000-000000000000", 
            "Remarks" : "", 
            "SeqNo" : NumberInt(13), 
            "Type" : NumberInt(1), 
            "Url" : "/StatsUserQuest", 
            "Hide" : NumberInt(1)
        },
        { 
            "_id" : ObjectId("5c9c6a35b55200365089887b"), 
            "Code" : "Department", 
            "Icon" : "fa fa-link", 
            "Name" : "组织机构管理", 
            "ParentId" : "00000000-0000-0000-0000-000000000000", 
            "Remarks" : "", 
            "SeqNo" : NumberInt(1), 
            "Type" : NumberInt(0), 
            "Url" : "/AdminDepartment", 
            "Hide" : NumberInt(1)
        },
        { 
            "_id" : ObjectId("5c9c6a35b55200365089887c"), 
            "Code" : "Charge", 
            "Icon" : "fa fa-link", 
            "Name" : "充值统计", 
            "ParentId" : "00000000-0000-0000-0000-000000000000", 
            "Remarks" : "", 
            "SeqNo" : NumberInt(12), 
            "Type" : NumberInt(1), 
            "Url" : "/StatsUserCharge", 
            "Hide" : NumberInt(0)
        },
        { 
            "_id" : ObjectId("5c9c6a35b55200365089887d"), 
            "Code" : "Online", 
            "Icon" : "fa fa-link", 
            "Name" : "在线统计", 
            "ParentId" : "00000000-0000-0000-0000-000000000000", 
            "Remarks" : "", 
            "SeqNo" : NumberInt(14), 
            "Type" : NumberInt(1), 
            "Url" : "/StatsUserOnline", 
            "Hide" : NumberInt(0)
        },
        { 
            "_id" : ObjectId("5c9c6a35b55200365089887e"), 
            "Code" : "Diamond", 
            "Icon" : "fa fa-link", 
            "Name" : "钻石消费", 
            "ParentId" : "00000000-0000-0000-0000-000000000000", 
            "Remarks" : null, 
            "SeqNo" : NumberInt(11), 
            "Type" : NumberInt(1), 
            "Url" : "/StatsUserDiamond", 
            "Hide" : NumberInt(0)
        },
        { 
            "_id" : ObjectId("5c9c6a35b55200365089887f"), 
            "Code" : "News", 
            "Icon" : "fa fa-link", 
            "Name" : "更新公告管理", 
            "ParentId" : "00000000-0000-0000-0000-000000000000", 
            "Remarks" : "", 
            "SeqNo" : NumberInt(4), 
            "Type" : NumberInt(0), 
            "Url" : "/AdminNews", 
            "Hide" : NumberInt(0)
        },
        { 
            "_id" : ObjectId("5c9c6a35b552003650898880"), 
            "Code" : "GameAnnouncement", 
            "Icon" : "fa fa-link", 
            "Name" : "GM公告管理", 
            "ParentId" : "00000000-0000-0000-0000-000000000000", 
            "Remarks" : "", 
            "SeqNo" : NumberInt(5), 
            "Type" : NumberInt(0), 
            "Url" : "/AdminGameAnnouncement", 
            "Hide" : NumberInt(0)
        },
        { 
            "_id" : ObjectId("5c9c6a35b552003650898881"), 
            "Code" : "Mail", 
            "Icon" : "fa fa-link", 
            "Name" : "GM邮件管理", 
            "ParentId" : "00000000-0000-0000-0000-000000000000", 
            "Remarks" : "", 
            "SeqNo" : NumberInt(6), 
            "Type" : NumberInt(0), 
            "Url" : "/AdminMail", 
            "Hide" : NumberInt(0)
        },
        { 
            "_id" : ObjectId("5c9c6a35b552003650898882"), 
            "Code" : "OnlineHour", 
            "Icon" : "fa fa-link", 
            "Name" : "小时在线", 
            "ParentId" : "00000000-0000-0000-0000-000000000000", 
            "Remarks" : "", 
            "SeqNo" : NumberInt(15), 
            "Type" : NumberInt(1), 
            "Url" : "/StatsUserOnlineHour", 
            "Hide" : NumberInt(0)
        },
        { 
            "_id" : ObjectId("5c9c6a35b552003650898883"), 
            "Code" : "OnlineSnapshot", 
            "Icon" : "fa fa-link", 
            "Name" : "当前在线", 
            "ParentId" : "00000000-0000-0000-0000-000000000000", 
            "Remarks" : "", 
            "SeqNo" : NumberInt(16), 
            "Type" : NumberInt(1), 
            "Url" : "/StatsUserOnlineSnapshot", 
            "Hide" : NumberInt(0)
        },
        { 
            "_id" : ObjectId("5c9c6a35b552003650898884"), 
            "Code" : "Retention", 
            "Icon" : "fa fa-link", 
            "Name" : "留存率统计", 
            "ParentId" : "00000000-0000-0000-0000-000000000000", 
            "Remarks" : "", 
            "SeqNo" : NumberInt(17), 
            "Type" : NumberInt(1), 
            "Url" : "/StatsUserRetention", 
            "Hide" : NumberInt(0)
        }
        
    ]
);

db.getCollection("rolemenus").insert(
    {'RoleId': '00000000-0000-0000-0000-000000000000',
    'MenuId': "00000000-0000-0000-0000-000000000000",
    }
);

db.getCollection("roles").insert(
    {'Code': 'any',
    'CreateBy': "00000000-0000-0000-0000-000000000000",
    'CreateTime': 0,
    'Name': "DefaultRole",
    'Remarks': "缺省角色",
    }
);

db.getCollection("userroles").insert(
    {'UserId': 'admin',
    'RoleId': 'any',
    }
);

db.getCollection("users").insert(
{ 
    "_id" : ObjectId("5c9c6da1b5520036508988b7"), 
    "CreateBy" : null, 
    "CreateTime" : ISODate("2019-03-28T06:47:22.730+0000"), 
    "DepartmentId" : "5120cd33-33ff-4cc7-b0d8-36d52e5ace86", 
    "EMail" : null, 
    "IsDeleted" : NumberInt(0), 
    "LastLoginTime" : ISODate("0001-01-01T00:00:00.000+0000"), 
    "LoginTimes" : NumberInt(0), 
    "MobileNumber" : null, 
    "Name" : "超级管理员", 
    "Password" : "123123", 
    "Remarks" : "", 
    "UserName" : "admin"
}
);