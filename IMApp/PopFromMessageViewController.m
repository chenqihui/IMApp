//
//  popFromMessageViewController.m
//  IMApp
//
//  Created by chen on 14/7/27.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "PopFromMessageViewController.h"

@interface PopFromMessageViewController ()

@end

@implementation PopFromMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *title = [self.arParams count] > 0 ? [self.arParams objectAtIndex:0] : @"未知标题";
    [self createNavWithTitle:title createMenuItem:^UIView *(int nIndex)
    {
        if (nIndex == 0)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *i = [UIImage imageNamed:@"back_normal.png"];
            [btn setImage:i forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"back_press.png"] forState:UIControlStateHighlighted];
            [btn setFrame:CGRectMake(10, (self.navView.height - i.size.height)/2, i.size.width, i.size.height)];
            [btn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *btnBg = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnBg setFrame:CGRectMake(10, (self.navView.height - 40)/2, 80, 40)];
            [btnBg addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
            [btnBg addSubview:btn];
            
            UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(btn.right + 5, btn.top, btnBg.width - btn.right - 5, btn.height)];
            [l setText:@"消息"];
            [btnBg addSubview:l];
            
            return btnBg;
        }
        return nil;
    }];
}

- (void)popBack
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
