//
//  GiftBoard_iPhone.m
//  BeeFancy
//
//  Created by QFish on 3/26/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "GiftBoard_iPhone.h"

#pragma mark -

@implementation GiftBoard_iPhone

- (void)load
{
	[super load];
    
    [self.menuTitles addObjectsFromArray:@[ @"礼物", @"店铺" ]];
    [self.menus addObject:@[ @"欢喜盒子", @"推荐", @"礼品卡", @"礼品引导" ]];
    [self.menus addObject:@[ @"折扣", @"品牌 & 折扣" ]];
}

- (void)unload
{    
	[super unload];
}

@end
