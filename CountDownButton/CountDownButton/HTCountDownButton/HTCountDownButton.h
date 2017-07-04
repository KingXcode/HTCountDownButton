//
//  HTcountDownButton.h
//  pangu
//
//  Created by King on 2017/6/27.
//  Copyright © 2017年 zby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTCountDownButton : UIButton


/**
 NSDictionary *info = @{
                        @"hours"         :@(hours),
                        @"minutes"       :@(minutes),
                        @"seconds"       :@(seconds),
                        @"millisecond"   :@(millisecond)
                        };
 
 当时间正在进行倒计时的时候回连续进行调用
 
 info 字典对tim进行了分解  需要就用 不需要就不要理这个参数
 time 这个参数就是剩余的时间秒数

 */
@property (nonatomic, copy) void(^countDownChanging)(HTCountDownButton *,NSTimeInterval time,NSDictionary *info);

/**
 倒计时结束的时候调用
 */
@property (nonatomic, copy) void(^countDownEnd)(HTCountDownButton *);


/**
 结束的时间戳  如果是服务器的时间戳需要除以1000
 */
@property (nonatomic,assign)NSTimeInterval endTime;



@end
