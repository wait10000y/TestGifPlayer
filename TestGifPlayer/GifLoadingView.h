//
//  GifLoadingView.h
//  TestGifPlayer
//
//  Created by 王士良 on 2018/4/26.
//  Copyright © 2018年 王士良. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 传入的是 gif图片.
 显示原理

 */
@interface GifLoadingView : UIView

-(void)setGifData:(NSData *)thedata;
-(void)setTimeInterval:(float)timeInterval;

-(void)startLoading;
-(void)endLoading;

@end
