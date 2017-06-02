//
//  YYMainViewController.m
//  YYLiveDemo
//
//  Created by Ryan on 2017/6/2.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "YYMainViewController.h"
#import "YYCaptureViewController.h"
#import "YYBroadCastListController.h"

@interface YYMainViewController () <UITableViewDelegate,UITableViewDataSource>

/* <#description#> */
@property (nonatomic,strong) UITableView *tableView;
/* <#description#> */
@property (nonatomic,strong) NSArray *titleArr;

@end

@implementation YYMainViewController

- (NSArray *)titleArr {
    if (_titleArr == nil) {
        _titleArr = [[NSArray alloc] initWithObjects:@"视频采集",@"直播列表", nil];
    }
    return _titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect aRect = CGRectMake(0, 0, ScreenWidth, Screenheight);
    self.tableView = [[UITableView alloc] initWithFrame:aRect];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    
}

//MARK:- TableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *mainCellIndentifier = @"mainCellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainCellIndentifier];
    }
    
    cell.textLabel.text = self.titleArr[indexPath.section];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, ScreenWidth, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:lineView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    switch (indexPath.section) {
        case 0: {
            YYCaptureViewController *captureCtrl = [[YYCaptureViewController alloc] init];
            captureCtrl.title = @"视频采集";
            [self.navigationController pushViewController:captureCtrl animated:true];
        }
            break;
        case 1: {
            YYBroadCastListController *captureCtrl = [[YYBroadCastListController alloc] init];
            captureCtrl.title = @"直播列表";
            [self.navigationController pushViewController:captureCtrl animated:true];
        }
            break;
        default:
            break;
    }
}


@end




















































