//
//  BaseBoard_iPhone.m
//  BeeFancy
//
//  Created by QFish on 3/26/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "BaseBoard_iPhone.h"

#pragma mark -

@implementation BaseBoard_iPhone

#pragma mark [B] UISignal

- (void)handleUISignal:(BeeUISignal *)signal
{
	[super handleUISignal:signal];
}

- (void)handleUISignal_BeeUIBoard:(BeeUISignal *)signal
{
	[super handleUISignal:signal];
	
	if ( [signal is:BeeUIBoard.CREATE_VIEWS] )
	{
        self.view.backgroundColor = [UIColor whiteColor];
        [self showNavigationBarAnimated:NO];
        [self showBarButton:UINavigationBar.BARBUTTON_LEFT title:@"菜单"];
        self.view.hintString = @"购物车是空的哦~";
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
