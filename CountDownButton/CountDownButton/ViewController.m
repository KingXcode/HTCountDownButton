//
//  ViewController.m
//  CountDownButton
//
//  Created by King on 2017/6/28.
//  Copyright © 2017年 King. All rights reserved.
//

#import "ViewController.h"
#import "HTCountDownButton.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet HTCountDownButton *Btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.Btn setCountDownChanging:^(HTCountDownButton *b,NSTimeInterval time,NSDictionary *info){
        NSString *t = [NSString stringWithFormat:@"%@小时%@分%@秒%@",info[@"hours"],info[@"minutes"],info[@"seconds"],info[@"millisecond"]];
        [b setTitle:t forState:UIControlStateNormal];
    }];
    
    [self.Btn setCountDownEnd:^(HTCountDownButton *b){
        [b setTitle:@"结束" forState:UIControlStateNormal];
    }];


}
- (IBAction)start:(id)sender {
    
    self.Btn.endTime = [[NSDate date]timeIntervalSince1970]+30;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
