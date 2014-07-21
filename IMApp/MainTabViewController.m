//
//  HomePageViewController.m
//  IMApp
//
//  Created by chen on 14/7/20.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "MainTabViewController.h"

#import "MessagesViewController.h"
#import "ContactsViewController.h"
#import "DynamicViewController.h"
#import "MineViewController.h"

@interface MainTabViewController ()
{
    UITabBarController *_tabC;
}

@end

@implementation MainTabViewController

- (void)viewDidLoad
{
    _tabC = [[UITabBarController alloc] init];
    [_tabC.view setFrame:self.view.frame];
    [self.view addSubview:_tabC.view];
    
    MessagesViewController *f = [[MessagesViewController alloc] init];
    UITabBarItem *fItem = [[UITabBarItem alloc]initWithTitle:@"消息" image:nil tag:1];
    [fItem setImage:[UIImage imageNamed:@"tab_recent_nor.png"]];
    [fItem setSelectedImage:[UIImage imageNamed:@"tab_recent_press.png"]];
    f.tabBarItem = fItem;
    
    ContactsViewController *contactsVC = [[ContactsViewController alloc] init];
    UITabBarItem *sItem = [[UITabBarItem alloc]initWithTitle:@"联系人" image:nil tag:1];
    [sItem setImage:[UIImage imageNamed:@"tab_buddy_nor.png"]];
    [sItem setSelectedImage:[UIImage imageNamed:@"tab_buddy_press.png"]];
    contactsVC.tabBarItem = sItem;
    
    DynamicViewController *t = [[DynamicViewController alloc] init];
    UITabBarItem *tItem = [[UITabBarItem alloc]initWithTitle:@"动态" image:nil tag:1];
    [tItem setImage:[UIImage imageNamed:@"tab_qworld_nor.png"]];
    [tItem setSelectedImage:[UIImage imageNamed:@"tab_qworld_press.png"]];
    t.tabBarItem = tItem;
    
    MineViewController *ff = [[MineViewController alloc] init];
    UITabBarItem *ffItem = [[UITabBarItem alloc]initWithTitle:@"我svip" image:nil tag:1];
    [ffItem setImage:[UIImage imageNamed:@"tab_me_svip_nor.png"]];
    [ffItem setSelectedImage:[UIImage imageNamed:@"tab_me_svip_press.png"]];
    ff.tabBarItem = ffItem;
    
    _tabC.viewControllers = @[f, contactsVC, t, ff];
    
    [_tabC setSelectedIndex:1];
}

@end
