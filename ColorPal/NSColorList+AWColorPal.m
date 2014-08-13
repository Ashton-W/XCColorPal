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
        NSArray *colorNames = [[colors allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString *a, NSString *b) {
            return [a caseInsensitiveCompare:b];
        }];
        
        colorList = [[NSColorList alloc] initWithName:name];
        [colorNames enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
            [colorList setColor:colors[key] forKey:key];
        }];
    }
    
    return colorList;
}

@end
