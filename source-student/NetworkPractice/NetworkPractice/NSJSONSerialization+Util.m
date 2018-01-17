//
//  NSJSONSerialization+Util.m
//  NetworkDemo
//
//  Created by Vincent on 13/1/25.
//
//

#import "NSJSONSerialization+Util.h"

@implementation NSJSONSerialization (Util)

+(NSString*)stringWithJSONObject:(id)object{
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
+(NSObject*)objectWithJSONString:(NSString*)jsonString{
    return [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
}
@end
