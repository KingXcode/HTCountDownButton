//
//  UILabel+HTCountDown.h
//  pangu
//
//  Created by King on 2017/6/29.
//  Copyright © 2017年 zby. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CountDownChanging)(UILabel *,NSTimeInterval time,NSDictionary *info);

typedef void(^CountDownEnd)(UILabel *);

@interface UILabel (HTCountDown)

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
@property (nonatomic, copy) CountDownChanging changeBlock;

/**
 倒计时结束的时候调用
 */
@property (nonatomic, copy) CountDownEnd endBlock;


/**
 结束的时间戳  如果是服务器的时间戳需要除以1000
 */
@property (nonatomic,assign)NSTimeInterval endTime;

@end
