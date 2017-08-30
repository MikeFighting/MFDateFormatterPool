//
//  ViewController.m
//  Example
//
//  Created by Mike on 30/08/2017.
//  Copyright © 2017 Mike. All rights reserved.
//

#import "ViewController.h"
#import "MFDateFormatterPool.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    MFDateFormatterPool *dateFormatter = [MFDateFormatterPool sharedInstance];
    NSString *format = @"yyyy:MM:dd HH:mm:ss";
    NSDateFormatter *myFirstFormatter = [dateFormatter dateFormatterWithFormat:format];
    NSDateFormatter *mySecondFormatter = [dateFormatter dateFormatterWithFormat:format];
    NSLog(@"myFirstFormatter:%@",myFirstFormatter);
    NSLog(@"mySecondFormatter:%@",mySecondFormatter);
    
    [self testCreatForamtterEverryTime];
    [self testCreatForamtterOneTime];
    
}

- (void)testCreatForamtterEverryTime {

    NSTimeInterval begin = CACurrentMediaTime();
    NSMutableArray *dateStringArray = [NSMutableArray array];
    
    for (int i = 0; i < 100000; i ++) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateStyle = NSDateFormatterLongStyle;
        dateFormatter.timeStyle = NSDateFormatterMediumStyle;
        dateFormatter.locale = [NSLocale currentLocale];
        [dateStringArray addObject:[dateFormatter stringFromDate:[NSDate date]]];
        
    }
    
    NSTimeInterval end = CACurrentMediaTime();
    
    NSLog(@"testCreatForamtterEverryTime: %lf", end - begin);
}

- (void)testCreatForamtterOneTime {
    
    NSTimeInterval begin = CACurrentMediaTime();
    NSMutableArray *dateStringArray = [NSMutableArray array];
    
    for (int i = 0; i < 100000; i ++) {
        
        NSDateFormatter *dateFormatter = [[MFDateFormatterPool sharedInstance] dateFormatterWithDateStyle:NSDateFormatterLongStyle andTimeStyle:NSDateFormatterMediumStyle];
        [dateStringArray addObject:[dateFormatter stringFromDate:[NSDate date]]];
        
    }
    
    NSTimeInterval end = CACurrentMediaTime();
    
    NSLog(@"testCreatForamtterOneTime: %lf", end - begin);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
