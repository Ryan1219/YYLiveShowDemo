//
//  YYLiveListItem.m
//  YYLiveDemo
//
//  Created by Ryan on 2017/6/1.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "YYLiveListItem.h"

@implementation YYLiveListItem

@end


@implementation YYCreatorItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"creatorId":@"id"
             };
}

@end
