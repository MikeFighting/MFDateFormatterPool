//
//  MFDateFormatterPool.h
//  BornToTry
//
//  Created by Mike on 27/08/2017.
//  Copyright © 2017 itemei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFDateFormatterPool : NSObject

+ (instancetype)new NS_UNAVAILABLE;

+ (instancetype)sharedInstance;

/**
 Get data formatter by format string and local;
 
 @param format the format string
 @param locale the NSLocale instance
 @return data formatter
 */
- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format andLocale:(NSLocale *)locale;

/**
 Get data formatter by format string and local identifier;
 
 @param format  the format string
 @param localeIdentifier the local identifier
 @return data formatter
 */
- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format andLocaleIdentifier:(NSString *)localeIdentifier;

/**
 Get data formatter by format string, the default local is [NSLocale currentLocale]
 
 @param format Format string
 @return data formatter
 */
- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format;

/*
 typedef NS_ENUM(NSUInteger, NSDateFormatterStyle) {    // date and time format styles
 NSDateFormatterNoStyle = kCFDateFormatterNoStyle,
 NSDateFormatterShortStyle = kCFDateFormatterShortStyle,
 NSDateFormatterMediumStyle = kCFDateFormatterMediumStyle,
 NSDateFormatterLongStyle = kCFDateFormatterLongStyle,
 NSDateFormatterFullStyle = kCFDateFormatterFullStyle
 };
 */

/**
 Get data formatter by date style, time style and local

 @param dateStyle date style
 @param timeStyle time style
 @param locale the NSLocale instance
 @return date formatter
 */
- (NSDateFormatter *)dateFormatterWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle andLocal:(NSLocale *)locale;

/**
 Get data formatter by date style, time style and local
 
 @param dateStyle date style
 @param timeStyle time style
 @param locale the NSLocale identifier
 @return date formatter
 */
- (NSDateFormatter *)dateFormatterWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle andLocalIdentifer:(NSString *)localeIdentifier;

/**
 Get data formatter by date style, time style and  defalut local is [NSLocale currentLocale]
 
 @param dateStyle date style
 @param timeStyle time style
 @return date formatter
 */
- (NSDateFormatter *)dateFormatterWithDateStyle:(NSDateFormatterStyle)dateStyle andTimeStyle:(NSDateFormatterStyle)timeStyle;


@end
