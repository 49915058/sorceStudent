//
//  NSJSONSerialization+Util.h
//  NetworkDemo
//
//  Created by Vincent on 13/1/25.
//
//

#import <Foundation/Foundation.h>

@interface NSJSONSerialization (Util)
+(NSString*)stringWithJSONObject:(id)object;
+(NSObject*)objectWithJSONString:(NSString*)jsonString;
@end
