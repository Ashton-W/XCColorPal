//
//  IDEWorkspace+KSImageNamed.m
//  KSImageNamed
//
//  Created by Kent Sutherland on 1/23/13.
//
//  From https://github.com/ksuther/KSImageNamed-Xcode

#import "IDEWorkspace+AWColorPal.h"
#import "MethodSwizzle.h"
#import "AWColorPal.h"

@implementation IDEWorkspace (AWColorPal)

+ (void)load
{
    MethodSwizzle(self, @selector(_updateIndexableFiles:), @selector(AWColorPal__updateIndexableFiles:));
}

- (void)AWColorPal__updateIndexableFiles:(id)arg1
{
    [self AWColorPal__updateIndexableFiles:arg1];
    
    //[[AWColorPal sharedPlugin] indexNeedsUpdate:[self index]];
}

@end
