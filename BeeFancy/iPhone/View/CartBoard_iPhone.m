//
//  CartBoard_iPhone.m
//  BeeFancy
//
//  Created by QFish on 3/25/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "CartBoard_iPhone.h"

#pragma mark -

@implementation CartBoard_iPhone

- (void)load
{
	[super load];
    
    // TODO
}

- (void)unload
{
    // TODO
    
	[super unload];
}

#pragma mark [B] UISignal

// Other signal goes here
- (void)handleUISignal:(BeeUISignal *)signal
{
	[super handleUISignal:signal];
}

// BeeUIBoard signal goes here
- (void)handleUISignal_BeeUIBoard:(BeeUISignal *)signal
{
	[super handleUISignal:signal];
	
	if ( [signal is:BeeUIBoard.CREATE_VIEWS] )
	{
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.view.hintString = @"购物车是空的哦~";
        
        [self showNavigationBarAnimated:NO];
        [self showBarButton:UINavigationBar.BARBUTTON_LEFT title:@"菜单"];

		// 界面创建
	}
	else if ( [signal is:BeeUIBoard.DELETE_VIEWS] )
	{
		// 界面删除
        // SAFE_RELEASE_SUBVIEW(  );
	}
}

- (void)handleUISignal_UINavigationBar:(BeeUISignal *)signal
{
	if ( [signal is:UINavigationBar.BARBUTTON_LEFT_TOUCHED] )
	{
        [[AppBoard_iPhone sharedInstance] showMenu];
	}
}

@end
