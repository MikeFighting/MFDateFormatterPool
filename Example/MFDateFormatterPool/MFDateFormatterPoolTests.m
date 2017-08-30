//
//  MFDateFormatterPoolTests.m
//  BornToTry
//
//  Created by Mike on 27/08/2017.
//  Copyright © 2017 MikeFighting. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MFDateFormatterPool.h"
@interface MFDateFormatterPoolTests : XCTestCase
{

    MFDateFormatterPool *dateFormatter;
    NSString *format;
}
@end

@implementation MFDateFormatterPoolTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    dateFormatter = [MFDateFormatterPool sharedInstance];
    format = @"yyyy:MM:dd HH:mm:ss";
    
}

- (void)testCreatAndReuse {

    XCTAssert(dateFormatter);
    NSDateFormatter *myFormatter = [dateFormatter dateFormatterWithFormat:format];
    NSDateFormatter *mySecondFormatter = [dateFormatter dateFormatterWithFormat:format];
    XCTAssertEqualObjects(myFormatter, mySecondFormatter);
}

- (void)testFormatCreatMethods {

    NSDateFormatter *myFormatter = [dateFormatter dateFormatterWithFormat:format];
    NSDateFormatter *mySecondFormatter = [dateFormatter dateFormatterWithFormat:format andLocale:[NSLocale currentLocale]];
    XCTAssertEqualObjects(myFormatter, mySecondFormatter);
    
    //If we Change the formatter, we will get a new one.
    NSString *secondFormat = @"yyyy:MM:dd HH:MM:ss";
    NSDateFormatter *myThirdFormatter  = [dateFormatter dateFormatterWithFormat:secondFormat andLocale:[NSLocale currentLocale]];
    XCTAssertNotEqualObjects(myFormatter, myThirdFormatter);
}

- (void)testStyleCreatMethods {

    NSDateFormatter *myFormatter = [dateFormatter dateFormatterWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle andLocalIdentifer:@"en_US"];
    NSDateFormatter *mySecondFormatter = [dateFormatter dateFormatterWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle andLocal:[NSLocale currentLocale]];
    XCTAssertEqualObjects(myFormatter, mySecondFormatter);
    
}

- (void)testMultiThreads {
    
    for (int i = 0; i < 20; i ++) {
        
        dispatch_async(dispatch_queue_create("mike.fighting.com", DISPATCH_QUEUE_CONCURRENT), ^{
            
            NSDateFormatter *myFormatter = [dateFormatter dateFormatterWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle andLocalIdentifer:@"en_US"];
            NSDateFormatter *mySecondFormatter = [dateFormatter dateFormatterWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle andLocal:[NSLocale currentLocale]];
            NSLog(@"myFormatter : %@",myFormatter);
            NSLog(@"mySecondFormatter : %@",mySecondFormatter);
            XCTAssertEqualObjects(myFormatter, mySecondFormatter);
        });
    }
    
}

- (void)testMFAddition {

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
