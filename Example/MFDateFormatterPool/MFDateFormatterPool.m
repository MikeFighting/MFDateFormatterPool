//
//  MFDateFormatterPool.m
//  BornToTry
//
//  Created by Mike on 27/08/2017.
//  Copyright © 2017 MikeFighting. All rights reserved.
//

#import "MFDateFormatterPool.h"
#define DATAFORMATTER_CACHE_MAX_COUNT 15

@interface MFDateFormatterPool()

@property (nonatomic, strong) NSCache *cachedDateFormatters;

@end

static dispatch_semaphore_t _cachePoolLock;

static void _MFCachePoolInitGlobal(){

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _cachePoolLock = dispatch_semaphore_create(1);
        
    });
}

@implementation MFDateFormatterPool

#pragma mark - Initialize MFDateFormatterPool
+ (instancetype)sharedInstance {

    static MFDateFormatterPool *dataFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        dataFormatter = [[MFDateFormatterPool alloc]init];
        NSCache *dataFormatterCache = [[NSCache alloc]init];
        dataFormatterCache.countLimit = DATAFORMATTER_CACHE_MAX_COUNT;
        dataFormatter.cachedDateFormatters = dataFormatterCache;
    });
    
    return dataFormatter;
}

- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format andLocaleIdentifier:(NSString *)localeIdentifier {

    NSLocale *local = nil;
    if ([localeIdentifier isKindOfClass:[NSString class]] && localeIdentifier.length > 0) {
        
        local = [NSLocale localeWithLocaleIdentifier:localeIdentifier];
        
    }
    return [self dateFormatterWithFormat:format andLocale:local];
}

- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format andLocale:(NSLocale *)locale {

    if (![format isKindOfClass:[NSString class]] || format.length == 0) {
        return nil;
    }
    
    NSAssert(locale, @"MFDateFormatterPool.m: locale == nil. You can use dateFormatterWithFormat:, if you want to use the current local");
    
    NSString *formatterKey = [self p_getCacheKeyWithFormat:format andIdentifier:locale.localeIdentifier];
    
    NSDateFormatter *dateFormatter = [self p_getDateFormatterByKey:formatterKey];
    if (dateFormatter != nil) {
        return dateFormatter;
    }
    
    dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = format;
    dateFormatter.locale = locale ?: [NSLocale currentLocale];
    [self p_storeDateFormatter:dateFormatter forKey:formatterKey];
    return dateFormatter;
}



- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format {

    return [self dateFormatterWithFormat:format andLocale:[NSLocale currentLocale]];
}

- (NSDateFormatter *)dateFormatterWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle andLocalIdentifer:(NSString *)localeIdentifier {
    
    return [self dateFormatterWithDateStyle:dateStyle timeStyle:timeStyle andLocal:[NSLocale localeWithLocaleIdentifier:localeIdentifier]];
}

- (NSDateFormatter *)dateFormatterWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle andLocal:(NSLocale *)locale {

       NSAssert(locale, @"MFDateFormatterPool.m: locale == nil. You can use dateFormatterWithDateStyle:andTimeStyle:, if you want to use the current local");

    
        NSString *formatterKey = [self p_getChaeKeyWithDateStyle:dateStyle timeStyle:timeStyle andLocalIdentifier:locale.localeIdentifier];
        NSDateFormatter *dateFormatter = [self p_getDateFormatterByKey:formatterKey];
        if (dateFormatter != nil) {
            return dateFormatter;
        }
        dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateStyle = dateStyle;
        dateFormatter.timeStyle = timeStyle;
        dateFormatter.locale = locale;
        [self p_storeDateFormatter:dateFormatter forKey:formatterKey];
        return dateFormatter;


}


- (NSDateFormatter *)dateFormatterWithDateStyle:(NSDateFormatterStyle)dateStyle andTimeStyle:(NSDateFormatterStyle)timeStyle {

    return [self dateFormatterWithDateStyle:dateStyle timeStyle:timeStyle andLocal:[NSLocale currentLocale]];
    
}

#pragma mark - private methods
- (NSString *)p_getCacheKeyWithFormat:(NSString *)format andIdentifier:(NSString *)localIdentifier {
    
    return [NSString stringWithFormat:@"%@|%@",format, localIdentifier];
    
}

- (NSString *)p_getChaeKeyWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle andLocalIdentifier:(NSString *)localIdentifier {

    return [NSString stringWithFormat:@"%lu.%lu|%@",dateStyle,timeStyle,localIdentifier];
    
}

- (NSDateFormatter *)p_getDateFormatterByKey:(NSString *)key {
    
    dispatch_semaphore_wait(_cachePoolLock, DISPATCH_TIME_FOREVER);
    NSDateFormatter *dateFormatter = [self.cachedDateFormatters objectForKey:key];
    dispatch_semaphore_signal(_cachePoolLock);
    return  dateFormatter;
}

- (void)p_storeDateFormatter:(NSDateFormatter *)dateFormatter forKey:(NSString *)key {
    
    dispatch_semaphore_wait(_cachePoolLock, DISPATCH_TIME_FOREVER);
    [self.cachedDateFormatters setObject:dateFormatter forKey:key];
    dispatch_semaphore_signal(_cachePoolLock);
}

@end


