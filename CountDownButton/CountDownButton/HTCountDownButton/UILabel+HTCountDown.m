//
//  UILabel+HTCountDown.m
//  pangu
//
//  Created by King on 2017/6/29.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "UILabel+HTCountDown.h"
#import <objc/runtime.h>

static const void *HTCountDownChanging = &HTCountDownChanging;
static const void *HTCountDownEnd = &HTCountDownEnd;

static const void *HTMyTimer = &HTMyTimer;
static const void *HTLimit = &HTLimit;
static const void *HTEndTime = &HTEndTime;

@interface UILabel()

@property (strong, nonatomic) NSTimer *myTimer;
@property (nonatomic,assign)  NSTimeInterval limit;

@end

@implementation UILabel (HTCountDown)

+(void)load
{
    Method originalMethod = class_getInstanceMethod([self class], @selector(removeFromSuperview));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(ht_removeFromSuperview));
    
    BOOL didAddMethod =
    class_addMethod([self class],
                    @selector(removeFromSuperview),
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod)
    {
        class_replaceMethod([self class],
                            @selector(ht_removeFromSuperview),
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

-(void)ht_removeFromSuperview
{
    [self releaseTimer];
    [self ht_removeFromSuperview];
}

-(void)releaseTimer
{
    if (self.myTimer!=nil) {
        [self.myTimer invalidate];
        self.myTimer = nil;
    }
}

-(void)dealloc
{
    [self releaseTimer];
}



//启动定时器
-(void)startCountDown
{
    self.limit = self.limit - 0.1;
    __weak typeof(self) __self = self;
    
    if (self.limit>0)
    {
        if (__self.changeBlock)
        {
            __self.changeBlock(__self,__self.limit,[__self getInfo]);
        }
    }
    else
    {
        if (__self.endBlock)
        {
            [__self releaseTimer];
            __self.endBlock(__self);
        }
    }
    
    
}



-(NSDictionary *)getInfo
{
    int seconds = (int)self.limit % 60;
    int minutes = ((int)self.limit / 60) % 60;
    int hours = (int)self.limit / 3600 + self.limit - (int)self.limit;
    double millisecond = [NSString stringWithFormat:@"%.1f",((self.limit - (int)self.limit)*10)].doubleValue;
    
    NSDictionary *info = @{
                           @"hours"         :@(hours).stringValue,
                           @"minutes"       :@(minutes).stringValue,
                           @"seconds"       :@(seconds).stringValue,
                           @"millisecond"   :@(millisecond).stringValue
                           };
    return info;
}




-(NSTimeInterval)limit
{
    return [objc_getAssociatedObject(self, HTLimit) doubleValue];
}
-(void)setLimit:(NSTimeInterval)limit
{
    objc_setAssociatedObject(self, HTLimit, @(limit), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (self.myTimer == nil) {
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(startCountDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.myTimer forMode:NSRunLoopCommonModes];
        [self.myTimer fire];
    }
}

-(NSTimer *)myTimer
{
    return objc_getAssociatedObject(self, HTMyTimer);
}
-(void)setMyTimer:(NSTimer *)myTimer
{
    objc_setAssociatedObject(self, HTMyTimer, myTimer, OBJC_ASSOCIATION_RETAIN);
}

/**
 设置结束的时间戳 的属性
 */
-(NSTimeInterval)endTime
{
    return [objc_getAssociatedObject(self, HTEndTime) doubleValue];
}
-(void)setEndTime:(NSTimeInterval)endTime
{
    objc_setAssociatedObject(self, HTEndTime, @(endTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    NSInteger time =[[NSDate date] timeIntervalSince1970];
    time =  endTime - time;
    self.limit = time;
}

/**
 设置倒计时的block
 */
-(CountDownChanging)changeBlock
{
    return objc_getAssociatedObject(self, HTCountDownChanging);
}
-(void)setChangeBlock:(CountDownChanging)changeBlock
{
    objc_setAssociatedObject(self, HTCountDownChanging, changeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


/**
 设置倒计时结束的block
 */
-(CountDownEnd)endBlock
{
    return objc_getAssociatedObject(self, HTCountDownEnd);
}
-(void)setEndBlock:(CountDownEnd)endBlock
{
    objc_setAssociatedObject(self, HTCountDownEnd, endBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
