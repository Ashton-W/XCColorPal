//
//  NSColorList_AWColorPalTests.m
//  ColorPal
//
//  Created by Ashton Williams on 13/08/2014.
//  Copyright (c) 2014 Ashton-W. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSColorList+AWColorPal.h"

@interface NSColorList_AWColorPalTests : XCTestCase

@end

@implementation NSColorList_AWColorPalTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testValidFile
{
    NSURL *fileURL = [NSURL fileURLWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"ValidColors" ofType:@"xccolors"]];
    
    NSColorList *colorList = [NSColorList colorListFromJSONFileURL:fileURL];
    
    XCTAssertNotNil([colorList colorWithKey:@"red"], @"color not found");
    XCTAssertNotNil([colorList colorWithKey:@"green"], @"color not found");
    XCTAssertNotNil([colorList colorWithKey:@"blue"], @"color not found");
    XCTAssertNotNil([colorList colorWithKey:@"grey"], @"color not found");
    
    XCTAssertNil([colorList colorWithKey:@"garbage"], @"unknown color found");
}

@end
