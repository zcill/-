//
//  Readme.h
//  爱限免
//
//  Created by 朱立焜 on 15/10/12.
//  Copyright (c) 2015年 zcill. All rights reserved.
//

#ifndef ____Readme_h
#define ____Readme_h

// 架构
/**
    1. 工程的创建
       <1>.创建工程
       <2>.导入资源，导入第三方库
       <3>.建立文件分组(Page, Resource, Lib)
 
    2. 应用框架
        <1>.根据页面的特点，架构出五个分组+公用的组
        <2>.创建类 
            a. RootViewController (required)
            b. AppListViewContrller (继承Root，观察工程特点，使用率高)
            c. LimitViewController (继承AppList)
        <3>.设置标签栏 AppDelegate 里面 创建TabBar
    
    3. 实现主页面 (实现ZCAppListViewController)
        mvc模式
        <1>.数据下载    NetInterface.h ---> LimitUrl
                       downloadData ---> AFNetworking
        <2>.创建ZCAppModel，利用ZJModelTool 生成 model 模型
        <3>.创建ZCAppCell，代码定制cell
        <4>.创建tableView，用来显示cell
 
    4. 界面的适配
        通过定义好的宏，ZJScreenAdaptation
 
    5. 限免、降价、免费、热榜  显示不同的数据
        <1>.Applist定制urlString，请求数据加载 self.urlString
        <2>.AppDelegate.m createTabBar 里面设置不同的网址
    
    6. 分类页面
    
 
 */



#endif
