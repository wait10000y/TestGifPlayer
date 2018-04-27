//
//  MOOC_CourseHour_ConfUtil_RedPacket.h
//  IECS
//
//  Created by 王士良 on 2018/1/16.
//  Copyright © 2018年 XOR. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 传入的图片是 包含多帧图片拼接的一整张图片;
 显示动画原理是 定时移动显示图片的一个区域,类似播放电影胶片.

 */
@interface ImageFramePlayerView : UIView

+(ImageFramePlayerView *)createPlayerWith:(UIImage *)theFullImage withUintSize:(CGSize)theSize withDuration:(float)duration;

// duration 每帧占用时间, 单位 秒
// theRectArr 区域rect 是比例位置;如:总共横排4张 第二张rect(0.25,0,0.25,1); 全部图片显示rect(0,0,1,1)
-(instancetype)initWithFrame:(CGRect)theFrame withPlayFullImage:(UIImage *)theImage withRectArr:(NSArray *)theRectArr withDuration:(float)theDuration;
-(void)startPlay;
-(void)stopPlay; // 结束播放 必须调用(释放Timer引用)


@end
