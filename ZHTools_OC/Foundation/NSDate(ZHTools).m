//
//  NSDate(ZHTools).m
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/12/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import "NSDate(ZHTools).h"

@implementation NSDate(ZHTools)

+ (NSCalendar *)sharedCalendar {
    static id sharedCalendar = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    });
    
    return sharedCalendar;
}

+ (NSCalendarUnit)calendarUnit {
    return (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);
}

- (NSInteger)zh_year {
    NSDateComponents *components = [[NSDate sharedCalendar] components:[NSDate calendarUnit] fromDate:self];
    return components.year;
}

- (NSInteger)zh_month {
    NSDateComponents *components = [[NSDate sharedCalendar] components:[NSDate calendarUnit] fromDate:self];
    return components.month;
}

- (NSInteger)zh_day {
    NSDateComponents *components = [[NSDate sharedCalendar] components:[NSDate calendarUnit] fromDate:self];
    return components.day;
}

- (NSInteger)zh_hour {
    NSDateComponents *components = [[NSDate sharedCalendar] components:[NSDate calendarUnit] fromDate:self];
    return components.hour;
}

- (NSInteger)zh_minute {
    NSDateComponents *components = [[NSDate sharedCalendar] components:[NSDate calendarUnit] fromDate:self];
    return components.minute;
}

- (NSInteger)zh_second {
    NSDateComponents *components = [[NSDate sharedCalendar] components:[NSDate calendarUnit] fromDate:self];
    return components.second;
}

-(NSInteger)zh_weekday {
    NSDateComponents *components = [[NSDate sharedCalendar] components:[NSDate calendarUnit] fromDate:self];
    return components.weekday;
}

- (BOOL)zh_isEarlierThanDate:(NSDate *)aDate {
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)zh_isLaterThanDate:(NSDate *)aDate {
    return ([self compare:aDate] == NSOrderedDescending);
}

- (BOOL)zh_isLeapYear {
    NSUInteger year = [self zh_year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSUInteger)zh_daysInYear {
    return [self zh_isLeapYear] ? 366 : 365;
}

- (NSUInteger)zh_daysInMonth {
    switch (self.zh_month) {
            
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
            
        case 2:
            return [self zh_isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSDate *)zh_beginningOfDay {
    NSCalendar *clendar = [NSDate sharedCalendar];
    NSDateComponents *components = [clendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    return [clendar dateFromComponents:components];
}

- (NSDate *)zh_endOfDay {
    NSCalendar *calendar = [NSDate sharedCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:1];
    
    return [[calendar dateByAddingComponents:components toDate:[self zh_beginningOfDay] options:0] dateByAddingTimeInterval:-1];
}

- (NSDate *)zh_beginningOfWeek {
    NSCalendar *calendar = [NSDate sharedCalendar];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay) fromDate:self];
    
    NSUInteger offset = ([components weekday] == [calendar firstWeekday]) ? 6 : [components weekday] - 2;
    [components setDay:[components day] - offset];
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)zh_endOfWeek {
    NSCalendar *calendar = [NSDate sharedCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfMonth:1];
    
    return [[calendar dateByAddingComponents:components toDate:[self zh_beginningOfWeek] options:0] dateByAddingTimeInterval:-1];
}

- (NSDate *)zh_beginningOfMonth {
    NSCalendar *clendar = [NSDate sharedCalendar];
    NSDateComponents *components = [clendar components:(NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:self];
    return [clendar dateFromComponents:components];
}

- (NSDate *)zh_endOfMonth {
    NSCalendar *calendar = [NSDate sharedCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:1];
    
    return [[calendar dateByAddingComponents:components toDate:[self zh_beginningOfMonth] options:0] dateByAddingTimeInterval:-1];
}

- (NSDate *)zh_beginningOfYear {
    NSCalendar *calendar = [NSDate sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:self];
    return [calendar dateFromComponents:components];
}

- (NSDate *)zh_endOfYear {
    NSCalendar *calendar = [NSDate sharedCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:1];
    
    return [[calendar dateByAddingComponents:components toDate:[self zh_beginningOfYear] options:0] dateByAddingTimeInterval:-1];
}

#pragma mark -  NSDate & NSString
+ (NSDateFormatter *)zh_sharedDateFormatter {
    static id sharedDateFormatter = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedDateFormatter = [[NSDateFormatter alloc] init];
        
        [sharedDateFormatter setLocale:[NSLocale currentLocale]];
    });
    
    return sharedDateFormatter;
}

+ (NSDate *)zh_dateFromString:(NSString *)string dateFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [NSDate zh_sharedDateFormatter];
    
    dateFormatter.dateFormat = dateFormat;
    
    return [dateFormatter dateFromString:string];
}

- (NSString *)zh_stringWithDateFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [NSDate zh_sharedDateFormatter];
    
    dateFormatter.dateFormat = dateFormat;
    
    return [dateFormatter stringFromDate:self];
}

+ (NSDate *)zh_dateFromISO8601String:(NSString *)string {
    if (!string) return nil;
    
    struct tm tm;
    time_t t;
    
    strptime([string cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%dT%H:%M:%S%z", &tm);
    tm.tm_isdst = -1;
    t = mktime(&tm);
    
    return [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];
}

@end
