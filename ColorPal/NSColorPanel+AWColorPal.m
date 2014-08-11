//
//  NSColorPanel+AWColorPal.m
//  ColorPal
//
//  Created by Ashton Williams on 11/08/2014.
//  Copyright (c) 2014 Ashton-W. All rights reserved.
//

#import "NSColorPanel+AWColorPal.h"
#import <JRSwizzle/JRSwizzle.h>

@implementation NSColorPanel (AWColorPal)

+ (void)load
{
    [self jr_swizzleClassMethod:@selector(AWColorPal_original_sharedColorPanel) withClassMethod:@selector(sharedColorPanel) error:NULL];
    [self jr_swizzleClassMethod:@selector(sharedColorPanel) withClassMethod:@selector(AWColorPal_sharedColorPanel) error:NULL];
}

+ (instancetype)AWColorPal_sharedColorPanel
{
    NSColorPanel *sharedColorPanel = [self AWColorPal_original_sharedColorPanel];
    [sharedColorPanel attachColorList:[self myColorList]];
    return sharedColorPanel;
}

+ (instancetype)AWColorPal_original_sharedColorPanel
{
    return nil;
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
