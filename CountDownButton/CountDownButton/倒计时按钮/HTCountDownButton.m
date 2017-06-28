//
//  HTcountDownButton.m
//  pangu
//
//  Created by King on 2017/6/27.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "HTCountDownButton.h"

@interface HTCountDownButton ()

@property (strong, nonatomic) NSTimer *myTimer;

@property (nonatomic,assign)NSTimeInterval limit;



@end

@implementation HTCountDownButton

-(void)setEndTime:(NSTimeInterval)endTime
{
    _endTime = endTime;
    NSInteger time =[[NSDate date] timeIntervalSince1970];
    time =  _endTime - time;
    self.limit = time;
}

-(void)setLimit:(NSTimeInterval)limit
{
    _limit = limit;
    if (_myTimer == nil) {
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(startCountDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_myTimer forMode:NSRunLoopCommonModes];
        [_myTimer fire];
    }
}

-(void)releaseTimer
{
    if (self.myTimer!=nil) {
        [_myTimer invalidate];
        _myTimer = nil;
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}

-(void)dealloc
{
    [self releaseTimer];
}

-(void)removeFromSuperview
{
    [self releaseTimer];
    [super removeFromSuperview];
}


//启动定时器
-(void)startCountDown
{
    _limit = _limit - 0.1;
    __weak typeof(self) __self = self;

    if (_limit>0)
    {
        if (__self.countDownChanging)
        {
            __self.countDownChanging(__self,__self.endTime,[__self getInfo]);
        }
    }
    else
    {
        if (__self.countDownEnd)
        {
            [__self releaseTimer];
            __self.countDownEnd(__self);
        }
    }
    

}



-(NSDictionary *)getInfo
{
    int seconds = (int)_limit % 60;
    int minutes = ((int)_limit / 60) % 60;
    int hours = (int)_limit / 3600 + _limit - (int)_limit;
    double millisecond = [NSString stringWithFormat:@"%.1f",((_limit - (int)_limit)*10)].doubleValue;
    
    NSDictionary *info = @{
                           @"hours"         :@(hours).stringValue,
                           @"minutes"       :@(minutes).stringValue,
                           @"seconds"       :@(seconds).stringValue,
                           @"millisecond"   :@(millisecond).stringValue
                           };
    return info;
}




@end
