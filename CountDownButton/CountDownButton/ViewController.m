//
//  ViewController.m
//  CountDownButton
//
//  Created by King on 2017/6/28.
//  Copyright © 2017年 King. All rights reserved.
//

#import "ViewController.h"
#import "HTCountDownButton.h"
#import "UILabel+HTCountDown.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet HTCountDownButton *Btn;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.Btn setCountDownChanging:^(HTCountDownButton *b,NSTimeInterval time,NSDictionary *info){
//        NSString *t = [NSString stringWithFormat:@"%@小时%@分%@秒%@",info[@"hours"],info[@"minutes"],info[@"seconds"],info[@"millisecond"]];
        [b setTitle:[NSString stringWithFormat:@"%.1f",time] forState:UIControlStateNormal];
    }];
    
    [self.Btn setCountDownEnd:^(HTCountDownButton *b){
        [b setTitle:@"结束" forState:UIControlStateNormal];
    }];
    
    
    [self.label setChangeBlock:^(UILabel *l,NSTimeInterval time,NSDictionary *info){
        NSString *t = [NSString stringWithFormat:@"%@小时%@分%@秒%@",info[@"hours"],info[@"minutes"],info[@"seconds"],info[@"millisecond"]];

        l.text = t;
     }];
    
    [self.label setEndBlock:^(UILabel *l){
        l.text = @"结束";
    }];
    
    __weak typeof(self) __self = self;
    [self.button.titleLabel setChangeBlock:^(UILabel *l,NSTimeInterval time,NSDictionary *info){
        NSString *t = [NSString stringWithFormat:@"%@小时%@分%@秒",info[@"hours"],info[@"minutes"],info[@"seconds"]];
        
        [__self.button setTitle:t forState:UIControlStateNormal];
    }];
    
    [self.button.titleLabel setEndBlock:^(UILabel *l){
        [__self.button setTitle:@"结束" forState:UIControlStateNormal];
    }];
    
    
    
    


}


- (IBAction)start:(id)sender {
    
    self.Btn.endTime = [[NSDate date]timeIntervalSince1970]+30;
    self.label.endTime = [[NSDate date]timeIntervalSince1970]+30;
    self.button.titleLabel.endTime = [[NSDate date]timeIntervalSince1970]+30;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
