//
//  IDEIndex+KSImageNamed.m
//  KSImageNamed
//
//  Created by Kent Sutherland on 1/23/13.
//
//  Adapted From https://github.com/ksuther/KSImageNamed-Xcode

#import "IDEIndex+AWColorPal.h"
#import "AWColorPal.h"
#import "MethodSwizzle.h"
#import <RSSwizzle/RSSwizzle.h>

@implementation IDEIndex (AWColorPal)

+ (void)load
{
    MethodSwizzle(self, @selector(close), @selector(AWColorPal_close));
}

- (void)AWColorPal_close
{
    [[AWColorPal sharedPlugin] removeColorListsForIndex:self];
    
    [self AWColorPal_close];
}

@end
