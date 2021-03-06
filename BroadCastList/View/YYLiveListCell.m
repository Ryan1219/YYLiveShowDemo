//
//  YZLiveCell.m
//  YZLiveApp
//
//  Created by yz on 16/8/29.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "YYLiveListCell.h"
#import "YYLiveListItem.h"

#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface YYLiveListCell ()
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *liveLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel     *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel     *chaoyangLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bigPicView;
@end

@implementation YYLiveListCell


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *YYLiveListCellIndentifier = @"YYLiveListCellIndentifier";
    YYLiveListCell *cell = [tableView dequeueReusableCellWithIdentifier:YYLiveListCellIndentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    
    return cell;
}

//
- (void)setLive:(YYLiveListItem *)live{
    _live = live;

    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",live.creator.portrait]];
    
    [self.headImageView sd_setImageWithURL:imageUrl placeholderImage:nil options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    
    if (live.city.length == 0) {
        _addressLabel.text = @"难道在火星?";
    }else{
        _addressLabel.text = live.city;
    }

    self.nameLabel.text = live.creator.nick;

    [self.bigPicView sd_setImageWithURL:imageUrl placeholderImage:nil];
  
    // 设置当前观众数量
    NSString *fullChaoyang = [NSString stringWithFormat:@"%zd人在看", live.online_users];
    NSRange range = [fullChaoyang rangeOfString:[NSString stringWithFormat:@"%zd", live.online_users]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:fullChaoyang];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range: range];
    [attr addAttribute:NSForegroundColorAttributeName value:Color(216, 41, 116) range:range];
    self.chaoyangLabel.attributedText = attr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImageView.layer.cornerRadius = 5;
    self.headImageView.layer.masksToBounds = YES;
    
    self.liveLabel.layer.cornerRadius = 5;
    self.liveLabel.layer.masksToBounds = YES;
}

@end
