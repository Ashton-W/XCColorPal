//
//  AWColorPal.h
//  AWColorPal
//
//  Created by Ashton Williams on 11/08/2014.
//  Copyright (c) 2014 Ashton-W. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface AWColorPal : NSObject

+ (instancetype)sharedPlugin;

+ (BOOL)shouldLoadPlugin;

- (void)removeColorListsForIndex:(id)index;
- (void)indexNeedsUpdate:(id)index;

@end