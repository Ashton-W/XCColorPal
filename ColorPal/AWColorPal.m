//
//  AWColorPal.m
//  AWColorPal
//
//  Created by Ashton Williams on 11/08/2014.
//    Copyright (c) 2014 Ashton-W. All rights reserved.
//

#import "AWColorPal.h"
#import "NSColorPanel+AWColorPal.h"
#import "XcodeMisc.h"
#import "AWColorListItem.h"

static AWColorPal *_sharedPlugin;

@interface AWColorPal () {
    NSTimer *_updateTimer;
}

@property (nonatomic, strong) NSBundle *bundle;
@property (nonatomic, strong) NSMutableSet *indexesToUpdate;
@property (nonatomic, strong) NSMutableDictionary *colorLists;

@end


@implementation AWColorPal

+ (instancetype)sharedPlugin
{
    return _sharedPlugin;
}

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    if ([self shouldLoadPlugin]) {
        dispatch_once(&onceToken, ^{
            _sharedPlugin = [[self alloc] initWithBundle:plugin];
        });
    }
}

+ (BOOL)shouldLoadPlugin
{
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    return [currentApplicationName isEqual:@"Xcode"];
}

- (instancetype)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource acccess
        self.bundle = plugin;
        self.indexesToUpdate = [NSMutableSet set];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.indexesToUpdate = nil;
    self.colorLists = nil;
}

#pragma mark - 

- (void)indexNeedsUpdate:(id)index
{
    //Coalesce completion rebuilds to avoid hangs when Xcode rebuilds an index one file a time
    [[self indexesToUpdate] addObject:index];
    
    [_updateTimer invalidate];
    _updateTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(_rebuildColorListsTimerFired:) userInfo:nil repeats:NO];
}

- (void)removeColorListsForIndex:(id)index
{
    NSString *workspaceName = [index workspaceName];
    
    if (workspaceName && [self.colorLists objectForKey:workspaceName]) {
        [self.colorLists removeObjectForKey:workspaceName];
    }
}

- (void)_rebuildColorListsTimerFired:(NSTimer *)timer
{
    for (id nextIndex in [self indexesToUpdate]) {
        [self _rebuildColorListsForIndex:nextIndex];
    }
    
    [[self indexesToUpdate] removeAllObjects];
    
    _updateTimer = nil;
}

- (NSArray *)_rebuildColorListsForIndex:(id)index
{
    NSString *workspaceName = [index workspaceName];
    NSArray *colorLists = nil;
    
    if (workspaceName) {
        if ([self.colorLists objectForKey:workspaceName]) {
            [self.colorLists removeObjectForKey:workspaceName];
        }
        
        colorLists = [self _colorListsForIndex:index];
        
        if (colorLists) {
            [self.colorLists setObject:colorLists forKey:workspaceName];
        }
    }
    
    return colorLists;
}

- (NSArray *)_colorListsForIndex:(id)index
{
    id result = [index filesContaining:@"" anchorStart:NO anchorEnd:NO subsequence:NO ignoreCase:YES cancelWhen:nil];
    
    NSMutableArray *colorListItems = [NSMutableArray array];
    NSMutableDictionary *colorListItemFiles = [NSMutableDictionary dictionary];
    
    result = [result uniqueObjects];
    
    for (id nextResult in result) {
        NSString *fileName = [nextResult fileName];
        
        if (![colorListItemFiles objectForKey:fileName]) {
            {
                NSString *ext = [fileName pathExtension];
                
                if ([ext length] && [ext isEqualToString:@"clrj"]) {
                    AWColorListItem *item = [[AWColorListItem alloc] initWithFileURL:[nextResult fileReferenceURL]];
                    [colorListItems addObject:item];
                    [colorListItemFiles setObject:item forKey:fileName];
                }
            }
        }
    }
    
    return colorListItems;
}

@end
