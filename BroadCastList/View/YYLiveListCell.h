//
//  YZLiveCell.h
//  YZLiveApp
//
//  Created by yz on 16/8/29.
//  Copyright © 2016年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYLiveListItem.h"

@interface YYLiveListCell : UITableViewCell
@property (nonatomic, strong) YYLiveListItem *live;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
