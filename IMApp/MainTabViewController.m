//
//  HomePageViewController.m
//  IMApp
//
//  Created by chen on 14/7/20.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "MainTabViewController.h"

#import "ContactsViewController.h"

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
    
    
    UIViewController *f = [[UIViewController alloc] init];
    [f.view setBackgroundColor:[UIColor orangeColor]];
    UITabBarItem *fItem = [[UITabBarItem alloc]initWithTitle:@"消息" image:nil tag:1];
    f.tabBarItem = fItem;
    
    ContactsViewController *contactsVC = [[ContactsViewController alloc] init];
    UITabBarItem *sItem = [[UITabBarItem alloc]initWithTitle:@"联系人" image:nil tag:1];
    contactsVC.tabBarItem = sItem;
    
    UIViewController *t = [[UIViewController alloc] init];
    [t.view setBackgroundColor:[UIColor yellowColor]];
    UITabBarItem *tItem = [[UITabBarItem alloc]initWithTitle:@"动态" image:nil tag:1];
    t.tabBarItem = tItem;
    
    UIViewController *ff = [[UIViewController alloc] init];
    [ff.view setBackgroundColor:[UIColor greenColor]];
    UITabBarItem *ffItem = [[UITabBarItem alloc]initWithTitle:@"我" image:nil tag:1];
    ff.tabBarItem = ffItem;
    
    _tabC.viewControllers = @[f, contactsVC, t, ff];
    
    [_tabC setSelectedIndex:1];
}

@end
