//
//  BrowseBoard_iPhone.m
//  BeeFancy
//
//  Created by QFish on 3/26/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "BrowseBoard_iPhone.h"

#pragma mark -

@implementation BrowseBoard_iPhone

- (void)load
{
	[super load];
    
    [self.menuTitles addObjectsFromArray:@[@"分类"]];
    [self.menus addObject:@[ @"全部", @"男士", @"女士", @"孩童", @"宠物", @"主页", @"其他" ]];
}

- (void)unload
{    
	[super unload];
}

#pragma mark [B] UISignal

@end
