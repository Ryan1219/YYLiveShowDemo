//
//  YYLiveShowViewController.m
//  YYLiveDemo
//
//  Created by Ryan on 2017/6/1.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "YYLiveShowViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "YYLiveListItem.h"


@interface YYLiveShowViewController ()

/* <#description#> */
@property (nonatomic,strong) UIImageView *backImageView;
/* <#description#> */
@property (nonatomic,strong) IJKFFMoviePlayerController *player;
/* <#description#> */
@property (nonatomic,strong) UIButton *backBtn;

@end

@implementation YYLiveShowViewController


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.player pause];
    [self.player stop];
    [self.player shutdown];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    CGRect aRect = CGRectMake(0, 0, ScreenWidth, Screenheight);
    self.backImageView = [[UIImageView alloc] initWithFrame:aRect];
    self.backImageView.userInteractionEnabled = true;
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:self.live.creator.portrait] placeholderImage:nil];
    [self.view addSubview:self.backImageView];
    
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(0, 20, 50, 44); //必须设置尺寸大小
    [self.backBtn setImage:[UIImage imageNamed:@"main_black_back"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];
    
    //拉流地址
    NSURL *url = [NSURL URLWithString:self.live.stream_addr];
    
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:nil];
    self.player.view.frame = aRect;
    [self.player prepareToPlay];
    [self.player play];
    [self.view insertSubview:self.player.view atIndex:1];
    
    
}

- (void)back {
    
    [self dismissViewControllerAnimated:true completion:nil];
}


@end

































