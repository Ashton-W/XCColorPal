//
//  AWColorListItem.h
//  ColorPal
//
//  Created by Ashton Williams on 12/08/2014.
//  Copyright (c) 2014 Ashton-W. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AWColorListItem : NSObject

@property (nonatomic, copy) NSURL *fileURL;
@property (nonatomic, strong) NSColorList *colorList;

- (instancetype)initWithFileURL:(NSURL*)fileURL;

@end
