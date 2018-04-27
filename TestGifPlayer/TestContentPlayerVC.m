//
//  TestContentPlayerVC.m
//  TestGifPlayer
//
//  Created by 王士良 on 2018/4/26.
//  Copyright © 2018年 王士良. All rights reserved.
//

#import "TestContentPlayerVC.h"

#import "ImageFramePlayerView.h"

@interface TestContentPlayerVC ()

@property(nonatomic) ImageFramePlayerView *playerView;

@end

@implementation TestContentPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self showPlayer];

}


-(void)showPlayer
{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"test1" ofType:@"png"];
    if (!filePath) { // 没有数据.
        NSLog(@"=== 没有图片数据 ===");
        return;
    }
    NSData *gifData = [NSData dataWithContentsOfFile:filePath];
    self.playerView = [ImageFramePlayerView createPlayerWith:[UIImage imageWithData:gifData] withUintSize:CGSizeMake(200, 300) withDuration:0.15f];

    if (self.playerView) {
//        self.playerView.autoresizingMask = UIViewAutoresizingNone;
        self.playerView.frame = CGRectMake(20, 160, 100, 150);
//        self.playerView.center = self.view.center;
        self.playerView.layer.borderWidth = 2;
        [self.view addSubview:self.playerView];
    }

}

-(IBAction)actionStartLoadView:(UIButton *)sender
{
    if (sender.selected) {
        [self.playerView stopPlay];
        sender.selected = NO;
    }else{
        [self.playerView startPlay];
        sender.selected = YES;
    }
}

@end
