//
//  ViewController.m
//  clock
//
//  Created by 倉島亮一 on 2014/11/23.
//  Copyright (c) 2014年 ryokura. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
// 文字盤
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
// 短針
@property (weak, nonatomic) IBOutlet UIImageView *hand1;
// 長針
@property (weak, nonatomic) IBOutlet UIImageView *hand2;
// 秒針
@property (weak, nonatomic) IBOutlet UIImageView *hand3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 繰り返し呼び出す関数の定義
    [NSTimer
     scheduledTimerWithTimeInterval:0.1     // 秒
     target:self
     selector:@selector(update)
     userInfo:nil
     repeats:YES];
}

// 更新処理
- (void)update {
    NSDate *now = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH:mm:ss"];
    
    // デジタル時計
    self.timeLabel.text = [df stringFromDate:now];
    
    // アナログ時計パート
    [df setDateFormat:@"ss"];
    float s = [[df stringFromDate:now] intValue];
    [df setDateFormat:@"mm"];
    float m = [[df stringFromDate:now] intValue];
    [df setDateFormat:@"HH"];
    // 2時半の時に、2.5を指せるように、m / 60 を足す
    float h = [[df stringFromDate:now] intValue] + (m / 60);

    // 針を滑らかに動かす（設定）
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];

    // 各種針の動き
    self.hand1.transform = CGAffineTransformMakeRotation(M_PI * 2 * h / 12);
    self.hand2.transform = CGAffineTransformMakeRotation(M_PI * 2 * m / 60);
    self.hand3.transform = CGAffineTransformMakeRotation(M_PI * 2 * s / 60);
    
    // 針を滑らかに動かす（コミット）
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
