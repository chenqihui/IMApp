//
//  QHBasicViewController.h
//  helloworld
//
//  Created by chen on 14/6/30.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QHBasicViewController : UIViewController

@property (nonatomic, strong) UIView *navView;
@property (nonatomic, assign, readonly) int nMutiple;
@property (nonatomic, strong) NSArray *arParams;

- (id)initWithFrame:(CGRect)frame param:(NSArray *)arParams;

- (void)createNavWithTitle:(NSString *)szTitle createMenuItem:(UIView *(^)(int nIndex))menuItem;

@end
