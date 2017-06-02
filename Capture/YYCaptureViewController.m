//
//  YYCaptureViewController.m
//  YYLiveDemo
//
//  Created by Ryan on 2017/6/1.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "YYCaptureViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface YYCaptureViewController () <AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate>
/* <#description#> */
@property (nonatomic,strong) AVCaptureSession *session;
/* <#description#> */
@property (nonatomic,strong) AVCaptureDeviceInput *videoDeviceInput;
/* <#description#> */
@property (nonatomic,strong) AVCaptureDeviceInput *audioDeviceInput;
/* <#description#> */
@property (nonatomic,strong) UIImageView *focusImageView;
/* <#description#> */
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer;
/* 设备连接 */
@property (nonatomic,strong) AVCaptureConnection *videoConnection;
/* <#description#> */
@property (nonatomic,strong) UIButton *changeCamera;


@end

@implementation YYCaptureViewController

- (UIImageView *)focusImageView {
    if (_focusImageView == nil) {
        _focusImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"camera_focus"]];
        [self.view addSubview:_focusImageView];
    }
    return _focusImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configCaptureVideo];
    
    self.changeCamera = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-10-40, 64, 40, 40)];
    [self.changeCamera setImage:[UIImage imageNamed:@"camera_change"] forState:UIControlStateNormal];
    [self.changeCamera addTarget:self action:@selector(changeCapturePosition:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.changeCamera];
}

//MARK:-捕获音视频
- (void)configCaptureVideo {
    //1,创建会话
    self.session = [[AVCaptureSession alloc] init];
    
//    typedef NS_ENUM(NSInteger, AVCaptureDevicePosition) {
//        AVCaptureDevicePositionUnspecified         = 0,
//        AVCaptureDevicePositionBack                = 1,
//        AVCaptureDevicePositionFront               = 2
//    } NS_AVAILABLE(10_7, 4_0) __TVOS_PROHIBITED;
    //2,获取视频（摄像头）设备，默认是后置摄像头
    AVCaptureDevice *videoDevice = [self getVideoDevice:AVCaptureDevicePositionFront];
    
    //3,获取声音设备
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    
    //4,创建对应视频设备输入对象
    self.videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:nil];
    
    //5,创建对应音频设备输入对象
    self.audioDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:nil];
    
    //6,添加音视频
    if ([self.session canAddInput:self.videoDeviceInput]) {
        [self.session addInput:self.videoDeviceInput];
    }
    
    if ([self.session canAddInput:self.audioDeviceInput]) {
        [self.session addInput:self.audioDeviceInput];
    }
    
    //7,创建对应视频数据输出设备
    AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    // 注意：队列必须是串行队列，才能获取到数据，而且不能为空
    dispatch_queue_t videoQueue = dispatch_queue_create("com.ueb.videoqueue", DISPATCH_QUEUE_SERIAL);
    //设置代理，捕获视频样品数据
    [videoOutput setSampleBufferDelegate:self queue:videoQueue];
    if ([self.session canAddOutput:videoOutput]) {
        [self.session addOutput:videoOutput];
    }
    
    //8,创建对应音频数据输出设备
    AVCaptureAudioDataOutput *audioOutput = [[AVCaptureAudioDataOutput alloc] init];
    // 注意：队列必须是串行队列，才能获取到数据，而且不能为空
    dispatch_queue_t audioQueue = dispatch_queue_create("com.ueb.audioqueue", DISPATCH_QUEUE_SERIAL);
    //设置代理，捕获视频样品数据
    [audioOutput setSampleBufferDelegate:self queue:audioQueue];
    if ([self.session canAddOutput:audioOutput]) {
        [self.session addOutput:audioOutput];
    }
    
    //9,获取视频输入与输出连接，用于分辨音视频数据
    self.videoConnection = [videoOutput connectionWithMediaType:AVMediaTypeVideo];
    
    //10,添加预览图层
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.frame = [UIScreen mainScreen].bounds;
    [self.view.layer insertSublayer:self.previewLayer above:0];
    
    //11,启动会话
    [self.session startRunning];
    
}

//MARK:-指定摄像头方向获取摄像头
- (AVCaptureDevice *)getVideoDevice:(AVCaptureDevicePosition)position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];//返回一组输入设备
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {
            return device;
        }
    }
    return nil;
}

//MARK:-AVCaptureVideoDataOutputSampleBufferDelegate
//获取输入设备数据，有可能是音频有可能是视频
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    if (self.videoConnection == connection) {
        //获取到视频
    } else {
        //获取到音频
    }
}


//MARK:-Private Method
//MARK:-切换摄像头
- (void)changeCapturePosition:(UIButton *)sender {
    //当前视频输入设备方向
    AVCaptureDevicePosition currentPosition = self.videoDeviceInput.device.position;
    
    //改变的方向
    AVCaptureDevicePosition changePosition = (currentPosition == AVCaptureDevicePositionFront) ? AVCaptureDevicePositionBack : AVCaptureDevicePositionFront;
    
    //获取改变方向后的视频设备
    AVCaptureDevice *changeDevice = [self getVideoDevice:changePosition];
    
    //获取改变方向后的视频输入设备
    AVCaptureDeviceInput *changeDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:changeDevice error:nil];
    
    //移除之前摄像头输入设备
    [self.session removeInput:self.videoDeviceInput];
    
    //添加新的摄像头输入设备
    [self.session addInput:changeDeviceInput];
    
    self.videoDeviceInput = changeDeviceInput;
    
}

//MARK:-点击屏幕，出现聚焦视图
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //获取点击位置
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    //把当前位置转换为摄像头点上的位置
    CGPoint cameraPoint = [self.previewLayer captureDevicePointOfInterestForPoint:point];
    
    //设置光标位置
    [self setFocusPoint:point];
    
    //设置聚焦
    [self setFocusWithMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose point:cameraPoint];
}

//MARK:-设置光标位置
- (void)setFocusPoint:(CGPoint)point {
    
    self.focusImageView.center = point;
    self.focusImageView.transform = CGAffineTransformMakeScale(3.0, 3.0);
    self.focusImageView.alpha = 1.0;
    [UIView animateWithDuration:1.0 animations:^{
        self.focusImageView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
         self.focusImageView.alpha = 0.0;
    }];
}

//MARK:-设置聚焦
- (void)setFocusWithMode:(AVCaptureFocusMode)focusMode exposureMode:(AVCaptureExposureMode)exposureMode point:(CGPoint)point {
    
    //current device
    AVCaptureDevice *currentDevice = self.videoDeviceInput.device;
    
    //锁定配置
    [currentDevice lockForConfiguration:nil];
    
    //设置聚焦
    if ([currentDevice isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        [currentDevice setFocusMode:AVCaptureFocusModeAutoFocus];
    }
    
    if ([currentDevice isFocusPointOfInterestSupported]) {
        [currentDevice setFocusPointOfInterest:point];
    }
    
    //设置曝光
    if ([currentDevice isExposureModeSupported:AVCaptureExposureModeAutoExpose]) {
        [currentDevice setExposureMode:AVCaptureExposureModeAutoExpose];
    }
    
    if ([currentDevice isExposurePointOfInterestSupported]) {
        [currentDevice setExposurePointOfInterest:point];
    }
    
    //解锁配置
    [currentDevice unlockForConfiguration];
}

@end






























