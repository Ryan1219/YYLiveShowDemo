//
//  YYLiveListItem.h
//  YYLiveDemo
//
//  Created by Ryan on 2017/6/1.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YYCreatorItem;
@interface YYLiveListItem : NSObject

/* 直播流地址 */
@property (nonatomic,copy) NSString *stream_addr;
/* 关注人 */
@property (nonatomic,assign) NSUInteger online_users;
/* 城市 */
@property (nonatomic,copy) NSString *city;
/* 主播 */
@property (nonatomic,strong) YYCreatorItem *creator;

@end


@interface YYCreatorItem : NSObject

/* <#description#> */
@property (nonatomic,copy) NSString *nick;
/* <#description#> */
@property (nonatomic,copy) NSString *portrait;
/* <#description#> */
@property (nonatomic,assign) NSInteger gender;
/* <#description#> */
@property (nonatomic,assign) NSInteger level;
/* <#description#> */
@property (nonatomic,assign) double creatorId;

@end






























