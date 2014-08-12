//
//  NSColorPanel+AWColorPal.m
//  ColorPal
//
//  Created by Ashton Williams on 11/08/2014.
//  Copyright (c) 2014 Ashton-W. All rights reserved.
//

#import "NSColorPanel+AWColorPal.h"
#import "AWColorPal.h"
#import <RSSwizzle/RSSwizzle.h>

@implementation NSColorPanel (AWColorPal)

+ (void)load
{
    if ([AWColorPal shouldLoadPlugin]) {
        [self swizzle];
    }
}

+ (void)swizzle
{
    RSSwizzleClassMethod([NSColorPanel class],
                         @selector(sharedColorPanel),
                         RSSWReturnType(NSColorPanel*),
                         RSSWArguments(),
                         RSSWReplacement({
        NSColorPanel *colorPanel = RSSWCallOriginal();
        [colorPanel attachColorList:[self myColorList]];
        return colorPanel;
    }));
}

+ (NSColorList*)myColorList
{
    NSColorList *colorList = [[NSColorList alloc] initWithName:@"ColorPal"];
    if (colorList) {
        [colorList setColor:[NSColor redColor] forKey:@"redColor"];
    }
    return colorList;
}

@end
