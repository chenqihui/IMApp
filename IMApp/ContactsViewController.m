//
//  ContactsViewController.m
//  IMApp
//
//  Created by chen on 14/7/20.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "ContactsViewController.h"

@interface ContactsViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UISegmentedControl *_selectTypeSegment;
    UITableView *_tableV;
    
    NSMutableArray *_arData;
    NSArray *_arKey;
    NSMutableDictionary *_dicData;
    NSMutableDictionary *_dicShowRow;
}

@end

@implementation ContactsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createNavWithTitle:nil createMenuItem:^UIView *(int nIndex)
    {
        if (nIndex == 1)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *i = [UIImage imageNamed:@"group_right_btn.png"];
            [btn setImage:i forState:UIControlStateNormal];
            [btn setFrame:CGRectMake(self.navView.width - i.size.width - 10, (self.navView.height - i.size.height)/2, i.size.width, i.size.height)];
            
            return btn;
        }
        return nil;
    }];
    
    _selectTypeSegment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"分组", @"全部", nil]];
    [_selectTypeSegment setFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 120)/2, 8, 120, 28)];
    [_selectTypeSegment setSelectedSegmentIndex:0];
    [self.navView addSubview:_selectTypeSegment];
    
    _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, self.view.width, self.view.height - self.navView.bottom - self.tabBarController.tabBar.height) style:UITableViewStylePlain];
    _tableV.dataSource = self;
    _tableV.delegate = self;
    [_tableV setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_tableV];
    
    [self initData];
}

- (void)initData
{
    __async_opt__, ^
    {
        _arKey = @[@"我的设备", @"朋友", @"兄弟", @"家人", @"同学", @"同事", @"长辈", @"兼职", @"陌生人", @"黑名单"];
        _dicData = [NSMutableDictionary new];
        _dicShowRow = [NSMutableDictionary new];
        
        [_arKey enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
             NSMutableArray *ar = [NSMutableArray new];
    //         srand((unsigned)time(0));  //不加这句每次产生的随机数不变
             int c = rand() % 10 + 1;
             for (int i = 0; i < c; i++)
             {
                 [ar addObject:[NSString stringWithFormat:@"%d", i]];
             }
             [_dicData setObject:ar forKey:obj];
             [_dicShowRow setObject:[NSNumber numberWithBool:NO] forKey:obj];
        }];
        
        __async_main__, ^
        {
            [_tableV reloadData];
        });
    });
}

#pragma mark - action

- (void)showRow:(UIButton *)btn
{
    NSString *key = [_arKey objectAtIndex:(btn.tag - 1)];
    BOOL b = [[_dicShowRow objectForKey:key] boolValue];
    [_dicShowRow setObject:[NSNumber numberWithBool:!b] forKey:key];
    [_tableV reloadSections:[NSIndexSet indexSetWithIndex:(btn.tag - 1)] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_arKey count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [_arKey objectAtIndex:section];
    BOOL bShowRow = [[_dicShowRow objectForKey:key] boolValue];
    if (bShowRow)
    {
        return [[_dicData objectForKey:[_arKey objectAtIndex:section]] count];
    }
    return 0;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [_arKey objectAtIndex:section];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    NSString *key = [_arKey objectAtIndex:[indexPath section]];
    BOOL bShowRow = [[_dicShowRow objectForKey:key] boolValue];
    if (bShowRow)
        cell.textLabel.text = [[_dicData objectForKey:key] objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    int w = tableView.width/7;
    UIView *headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 44)];
    [headV setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(w, 2, w * 4, 40)];
    [titleL setText:[_arKey objectAtIndex:section]];
    [titleL setFont:[UIFont systemFontOfSize:16]];
    [titleL setUserInteractionEnabled:NO];
    [headV addSubview:titleL];
    
    UIView *lineHV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 0.5)];
    [lineHV setBackgroundColor:[UIColor grayColor]];
    [headV addSubview:lineHV];
    
    NSString *key = [_arKey objectAtIndex:section];
    BOOL bShowRow = [[_dicShowRow objectForKey:key] boolValue];
    if (bShowRow)
    {
        UIView *lineBV = [[UIView alloc] initWithFrame:CGRectMake(0, 44 - 0.5, tableView.width, 0.5)];
        [lineBV setBackgroundColor:[UIColor grayColor]];
        [headV addSubview:lineBV];
    }
    
    UILabel *sumL = [[UILabel alloc] initWithFrame:CGRectMake(w * 5, 2, w * 2 - 5, 40)];
    [sumL setTextColor:[UIColor grayColor]];
    [sumL setText:[NSString stringWithFormat:@"%d/%d", 0, [[_dicData objectForKey:[_arKey objectAtIndex:section]] count]]];
    [sumL setTextAlignment:NSTextAlignmentRight];
    [sumL setFont:[UIFont systemFontOfSize:14]];
    [sumL setUserInteractionEnabled:NO];
    [headV addSubview:sumL];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:headV.bounds];
    btn.tag = section + 1;
    [headV addSubview:btn];
    [btn addTarget:self action:@selector(showRow:) forControlEvents:UIControlEventTouchUpInside];
    
    return headV;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
