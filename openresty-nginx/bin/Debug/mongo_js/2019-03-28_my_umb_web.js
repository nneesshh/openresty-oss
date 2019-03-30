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
    {'Code': 'User',
    'Icon': "fa fa-link",
    'Name': "用户管理",
    'ParentId': "00000000-0000-0000-0000-000000000000",
    'Remarks': "",
    'SeqNo': 3,
    'Type': 0,
    'Url': "/AdminUser",
    'Hide': 1,
    }
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
    {'UserId': '00000000-0000-0000-0000-000000000000',
    'RoleId': "00000000-0000-0000-0000-000000000000",
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