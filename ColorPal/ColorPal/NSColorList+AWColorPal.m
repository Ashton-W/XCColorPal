//
//  NSColorList+AWColorPal.m
//  ColorPal
//
//  Created by Ashton Williams on 12/08/2014.
//  Copyright (c) 2014 Ashton-W. All rights reserved.
//

#import "NSColorList+AWColorPal.h"

@implementation NSColorList (AWColorPal)

+ (instancetype)colorListFromJSONFileURL:(NSURL*)fileURL
{
    NSColorList *colorList;
    
    NSString *name = [fileURL.lastPathComponent stringByDeletingPathExtension];
    NSData *data = [NSData dataWithContentsOfURL:fileURL];
    
    NSError *error;
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if ([json isKindOfClass:[NSDictionary class]]) {
        NSDictionary *colors = (NSDictionary*)json;
        
        colorList = [[NSColorList alloc] initWithName:name];
        [colors enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSColor *color, BOOL *stop) {
            [colorList setColor:color forKey:key];
        }];
    }
    
    return colorList;
}

@end
