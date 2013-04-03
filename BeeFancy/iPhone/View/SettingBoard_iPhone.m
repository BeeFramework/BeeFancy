//
//  SettingBoard_iPhone.m
//  BeeFancy
//
//  Created by QFish on 3/26/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "SettingBoard_iPhone.h"

#pragma mark -

@implementation SettingBoard_iPhone

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
        self.view.hintString = @"Setting Todo";
        [self showNavigationBarAnimated:NO];
        [self showBarButton:UINavigationBar.BARBUTTON_LEFT title:@"菜单"];
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
