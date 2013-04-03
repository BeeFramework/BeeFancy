//
//  ListBoard_iPhone.m
//  BeeFancy
//
//  Created by QFish on 3/26/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "ListBoard_iPhone.h"

#pragma mark -

@implementation ListBoard_iPhone

- (void)load
{
	[super load];
}

- (void)unload
{    
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
        [self showNavigationBarAnimated:NO];
        
        self.view.hintString = @"分类列表";
        self.view.backgroundColor = [UIColor whiteColor];
        
        [self showBarButton:UINavigationBar.BARBUTTON_LEFT title:@"保存"];
        [self showBarButton:UINavigationBar.BARBUTTON_RIGHT title:@"取消"];
	}
	else if ( [signal is:BeeUIBoard.DELETE_VIEWS] )
	{
	}
	else if ( [signal is:BeeUIBoard.LAYOUT_VIEWS] )
	{
	}
}


- (void)handleUISignal_UINavigationBar:(BeeUISignal *)signal
{
	if ( [signal is:UINavigationBar.BARBUTTON_LEFT_TOUCHED] )
	{
        [self presentSuccessTips:@"保存成功"];
        [self.stack popBoardAnimated:YES];
	}
	else if ( [signal is:UINavigationBar.BARBUTTON_RIGHT_TOUCHED] )
	{
        [self.stack popBoardAnimated:YES];
	}
}

@end
