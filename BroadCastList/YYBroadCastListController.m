//
//  YYBroadCastListController.m
//  YYLiveDemo
//
//  Created by Ryan on 2017/6/1.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "YYBroadCastListController.h"
#import "YYLiveListCell.h"
#import "YYLiveListItem.h"
#import "YYLiveShowViewController.h"

@interface YYBroadCastListController () <UITableViewDelegate,UITableViewDataSource>

/* <#description#> */
@property (nonatomic,strong) UITableView *tableView;
/* <#description#> */
@property (nonatomic,strong) NSMutableArray *lives;

@end

@implementation YYBroadCastListController

/* <#description#> */
- (NSMutableArray *)lives {
    
    if (_lives == nil) {
        _lives = [NSMutableArray array];
    }
    
    return _lives;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UITableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, Screenheight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = YYColor(0xeeeeee);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.tableView];
    
    [self loadData];
}

- (void)loadData {
    
    // 映客数据url
    NSString *urlStr = @"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1";
    
    // 请求数据
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    [mgr GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        self.lives = [YYLiveListItem mj_objectArrayWithKeyValuesArray:responseObject[@"lives"]];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];

    
}

//MARK:- TableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.lives.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    YYLiveListCell *cell = [YYLiveListCell cellWithTableView:tableView];
    cell.live = self.lives[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 430;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    YYLiveShowViewController *liveCtrl = [[YYLiveShowViewController alloc] init];
    liveCtrl.live = self.lives[indexPath.row];
    [self presentViewController:liveCtrl animated:YES completion:nil];
}


@end







































































