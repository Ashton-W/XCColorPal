//
//  NSColorList+AWColorPal.h
//  ColorPal
//
//  Created by Ashton Williams on 12/08/2014.
//  Copyright (c) 2014 Ashton-W. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSColorList (AWColorPal)

+ (instancetype)colorListFromJSONFileURL:(NSURL*)fileURL;

@end
