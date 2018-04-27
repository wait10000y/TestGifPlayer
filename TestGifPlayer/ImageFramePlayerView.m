//
//  MOOC_CourseHour_ConfUtil_RedPacket.m
//  IECS
//
//  Created by 王士良 on 2018/1/16.
//  Copyright © 2018年 XOR. All rights reserved.
//

#import "ImageFramePlayerView.h"

@implementation ImageFramePlayerView
{
    NSArray *rectArray; // 位移数组
    float duration; // 每一帧 播放时间

    BOOL playStatus; // 1:进行中
    int playingIndex; // 播放了多少张
    NSTimer *playerTimer;
}

+(ImageFramePlayerView *)createPlayerWith:(UIImage *)theFullImage withUintSize:(CGSize)theSize withDuration:(float)duration
{
    NSMutableArray *rectArray;
    if (theFullImage && (theSize.width>0 && theSize.height>0)) {
// 检查 rect生成方向(先左右,后上下), 生成rect区域数组.
        CGSize fullSize = theFullImage.size;
        int hNum = ceilf(fullSize.width/theSize.width);
        int vNum = ceilf(fullSize.height/theSize.height);
            // 转换成比例坐标
        float tempWidth = theSize.width/fullSize.width;
        float tempHeight = theSize.height/fullSize.height;
        rectArray = [[NSMutableArray alloc] initWithCapacity:hNum*vNum];
        for (int it=0; it<vNum; it++) {
            for (int it2=0; it2<hNum; it2++) {
                CGRect tempRect = CGRectMake(it2*tempWidth, it*tempHeight, tempWidth, tempHeight);
                [rectArray addObject:[NSValue valueWithCGRect:tempRect]];
            }
        }
    }

    ImageFramePlayerView *redPacket = [[ImageFramePlayerView alloc] initWithFrame:CGRectMake(0, 0, theSize.width, theSize.height)
                                                                                            withPlayFullImage:theFullImage
                                                                                                  withRectArr:rectArray
                                                                                                 withDuration:duration];

    return redPacket;

}


-(instancetype)initWithFrame:(CGRect)theFrame withPlayFullImage:(UIImage *)theImage withRectArr:(NSArray *)theRectArr withDuration:(float)theDuration
{
    if (!theImage || theRectArr.count==0 || CGSizeEqualToSize(CGSizeZero, theFrame.size)) {
        return nil;
    }
    self = [super initWithFrame:theFrame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.contentsGravity = kCAGravityResizeAspect;
        self.layer.contentsScale = [UIScreen mainScreen].scale;
        self.layer.masksToBounds = YES;
        playStatus = NO;

        if (theImage) {
            self.layer.contents = (__bridge id)(theImage.CGImage);
            rectArray = theRectArr;
            duration = (theDuration<=0)?0.1f:theDuration;
            NSValue *rectValue = [rectArray firstObject];
            if (rectValue) {
                self.layer.contentsRect = [rectValue CGRectValue];
            }
        }
    }
    return self;
}

-(void)startPlay
{
    if (!playStatus && rectArray.count >1 && duration >0) {
        playStatus = YES;
        playerTimer = [NSTimer timerWithTimeInterval:duration target:self selector:@selector(timerMethod:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:playerTimer forMode:NSDefaultRunLoopMode];
    }
}

-(void)stopPlay
{
    playStatus = NO;
    if ([playerTimer isValid]) {
        [playerTimer invalidate];
    }
    playerTimer = nil;
}

-(void)timerMethod:(NSTimer*)sender
{
    NSValue *rectValue = [rectArray objectAtIndex:playingIndex++%rectArray.count];
    if (rectValue) {
        self.layer.contentsRect = [rectValue CGRectValue];
    }

}

-(void)dealloc
{
    [self stopPlay];
    rectArray = nil;
//    NSLog(@"=== redPacket 垃圾回收 ===");
}


@end
