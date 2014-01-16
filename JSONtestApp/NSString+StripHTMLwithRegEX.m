//
//  NSString+StripHTMLwithRegEX.m
//  JSONtestApp
//
//  Created by Lasse Wingreen on 16/01/14.
//  Copyright (c) 2014 Agro52 Aps. All rights reserved.
//

#import "NSString+StripHTMLwithRegEX.h"

@implementation NSString (stripHTMLwithRegEX)

-(NSString *) stripHTMLwithRegEX {
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    
    
    
    return s;
}


@end
