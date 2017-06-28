# HTcountDownButton
倒计时按钮

使用方法

可以代码创建 也可 使用xib创建
和正常的UIButton使用无差异

先创建button
然后给endTime赋值结束的时间戳,内部会自动启动定时器
最后实现countDownChanging和countDownEnd 代码块 
{
countDownChanging: 这个block在倒计时的时期会一直调用
countDownEnd:      倒计时结束的时候回调用
}


@property (weak, nonatomic) IBOutlet HTCountDownButton *Btn;

[self.Btn setCountDownChanging:^(HTCountDownButton *b,NSTimeInterval time,NSDictionary *info)
{
    NSString *t = [NSString stringWithFormat:@"%@小时%@分%@秒%@",info[@"hours"],info[@"minutes"],info[@"seconds"],info[@"millisecond"]];
    [b setTitle:t forState:UIControlStateNormal];
}];

[self.Btn setCountDownEnd:^(HTCountDownButton *b)
{
    [b setTitle:@"结束" forState:UIControlStateNormal];
}];
