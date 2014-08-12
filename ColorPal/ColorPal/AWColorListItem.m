//
//  AWColorListItem.m
//  ColorPal
//
//  Created by Ashton Williams on 12/08/2014.
//  Copyright (c) 2014 Ashton-W. All rights reserved.
//

#import "AWColorListItem.h"
#import "NSColorList+AWColorPal.h"

@implementation AWColorListItem

- (instancetype)initWithFileURL:(NSURL*)fileURL
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _fileURL = fileURL;
    _colorList = [NSColorList colorListFromJSONFileURL:_fileURL];
    
    return self;
}

@end
