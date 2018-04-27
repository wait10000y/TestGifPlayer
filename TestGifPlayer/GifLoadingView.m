//
//  GifLoadingView.m
//  TestGifPlayer
//
//  Created by 王士良 on 2018/4/26.
//  Copyright © 2018年 王士良. All rights reserved.
//


#import "GifLoadingView.h"

#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface GifLoadingView()
@property (nonatomic, assign)CGImageSourceRef gif;
@property (nonatomic, strong)NSDictionary *gifDic;
@property (nonatomic, assign)size_t index;
@property (nonatomic, assign)size_t count;

@property(nonatomic) NSData *gifSourceData; // gif 数据.
@property(nonatomic) float timeInterval; // 定时间隔
@property(nonatomic) BOOL loopContinue; // 循环检查 是否继续.

@end
@implementation GifLoadingView
{

}
-(void)setGifData:(NSData *)theData
{
    if (theData == self.gifSourceData) {
        return;
    }
    _loopContinue = NO;
    self.gifSourceData = theData;
    if (!self.gifSourceData) { return; }

    if (_timeInterval <=0) { _timeInterval = 0.1f; }
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (weakSelf.gif != NULL) {
            CFRelease(weakSelf.gif);
        }
        weakSelf.gif = NULL;
        
        weakSelf.index = 0;
        NSDictionary *gifLoopCount = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount];
        weakSelf.gifDic = [NSDictionary dictionaryWithObject:gifLoopCount forKey:(NSString *)kCGImagePropertyGIFDictionary];
        weakSelf.gif = CGImageSourceCreateWithData((CFDataRef)weakSelf.gifSourceData, (CFDictionaryRef)weakSelf.gifDic);
        weakSelf.count = CGImageSourceGetCount(weakSelf.gif);
    });

}

-(void)setTimeInterval:(float)timeInterval
{
    _timeInterval = timeInterval;
}

-(void)startLoading
{
    // 没图片返回.
    if(_loopContinue){return;}
    if (!_gifSourceData) { return; }
    if (_timeInterval <=0) { _timeInterval = 0.1f; }

        // 开启循环.
    _loopContinue = YES;
__weak typeof(self) weakSelf = self;
    dispatchTimer(self, _timeInterval, ^(dispatch_source_t timer) {
        NSLog(@"==== 循环调用中 ====");
        if(weakSelf.loopContinue){
            [weakSelf loopLoadingPartImage];
        }else{
            dispatch_source_cancel(timer);
        }
    });
    
}



// 循环调用.
-(void)loopLoadingPartImage
{
    _index ++;
    _index = _index%_count;
    CGImageRef ref = CGImageSourceCreateImageAtIndex(_gif, _index, (CFDictionaryRef)_gifDic);
    self.layer.contents = (__bridge id)ref;
    CFRelease(ref);
}


-(void)endLoading
{
    _index = 0;
    _loopContinue = NO;
}

- (void)dealloc{
    if (_gif != NULL) {
        CFRelease(_gif);
    }
    _gif = NULL;
}


/**
 // 开启一个定时器
 @param target 定时器持有者
 @param timeInterval 执行间隔时间
 @param handler 重复执行事件

 // 关闭定时器.
 dispatch_source_cancel(timer);
 */
void dispatchTimer(id target, double timeInterval,void (^handler)(dispatch_source_t timer))
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer =dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), (uint64_t)(timeInterval *NSEC_PER_SEC), 0);
        // 设置回调
    __weak __typeof(target) weaktarget  = target;
    dispatch_source_set_event_handler(timer, ^{
        if (!weaktarget)  {
            dispatch_source_cancel(timer);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (handler) handler(timer);
            });
        }
    });
        // 启动定时器
    dispatch_resume(timer);
}







@end
