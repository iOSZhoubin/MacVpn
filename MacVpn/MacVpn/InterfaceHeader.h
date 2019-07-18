//
//  InterfaceHeader.h
//  MacVpn
//
//  Created by jumpapp1 on 2019/6/17.
//  Copyright © 2019年 zb. All rights reserved.
//

#ifndef InterfaceHeader_h
#define InterfaceHeader_h

//注销登录
#define Macvpn_LoginOut @"/jumpvpn/logoff.php"
//修改密码
#define Macvpn_ChangePword @"/jumpvpn/user_setting.php"
//消息中心
#define Macvpn_MessageCenter @"/service/?service=getMeassages"
//IP资源
#define Macvpn_IPresource @"/service/?service=loadIpSource"
//Web资源
#define Macvpn_Webresource @"/jumpvpn/pda_resource_list.php"
//登录
#define Macvpn_LoginIn @"/mobile_login.php?login"
//心跳连接
#define Macvpn_heartJump @"/jumpvpn/pda_conn_hold.php?android_client=ture"
//注册
#define Macvpn_Register @"/mobile_ios_register.php"
//Web资源列表
#define Macvpn_WebList @"/jumpvpn/json_resource_list.php"


#endif /* InterfaceHeader_h */
