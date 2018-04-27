//
//  TestImageViewPlayerVC.m
//  TestGifPlayer
//
//  Created by 王士良 on 2018/4/26.
//  Copyright © 2018年 王士良. All rights reserved.
//

#import "TestImageViewPlayerVC.h"

#import "GifLoadingView.h"

@interface TestImageViewPlayerVC ()

@property(nonatomic) GifLoadingView *gifView;

@end

@implementation TestImageViewPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self showPlayer];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

-(void)showNormalPlayer
{
    UIImageView *gifImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    gifImageView.center = self.view.center;
    gifImageView.layer.borderWidth = 2;
    [self.view addSubview:gifImageView];

    NSMutableArray *images = [NSMutableArray array];
    for (int i=0; i < 10; i++) {
        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"image%d",i]]];
    }
    gifImageView.animationImages = images;
    gifImageView.animationDuration = 5.0;
    gifImageView.animationRepeatCount = NSUIntegerMax;
    [gifImageView startAnimating];

}

-(void)showPlayer
{

    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"test4" ofType:@"gif"];
    if (!filePath) { // 没有数据.
        NSLog(@"=== 没有图片数据 ===");
        return;
    }
    NSData *gifData = [NSData dataWithContentsOfFile:filePath];
    if (!gifData) {
        return;
    }

    GifLoadingView *loadingView = [[GifLoadingView alloc] initWithFrame:CGRectMake(20, 160, 80, 80)];
    [loadingView setGifData:gifData];
    [loadingView setTimeInterval:0.2f];
    loadingView.layer.borderWidth = 2;

    [self.view addSubview:loadingView];
    _gifView = loadingView;

}

-(IBAction)actionStartLoadView:(UIButton *)sender
{
    if (sender.selected) {
        [_gifView endLoading];
        sender.selected = NO;
    }else{
        [_gifView startLoading];
        sender.selected = YES;
    }
}

@end
