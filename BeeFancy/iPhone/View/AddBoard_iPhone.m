//
//  AddBoard_iPhone.m
//  BeeFancy
//
//  Created by QFish on 3/26/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "AddBoard_iPhone.h"

#pragma mark -

@implementation AddBoard_iPhone

- (void)load
{
	[super load];
}

- (void)unload
{
	[super unload];
}

#pragma mark [B] UISignal

- (void)handleUISignal_BeeUIBoard:(BeeUISignal *)signal
{
	[super handleUISignal:signal];
	
	if ( [signal is:BeeUIBoard.CREATE_VIEWS] )
	{
        self.view.backgroundColor = [UIColor whiteColor];
        
        [self showNavigationBarAnimated:NO];
        [self showBarButton:UINavigationBar.BARBUTTON_LEFT title:@"菜单"];
        
        _label = [[BeeUILabel alloc] init];
        _label.hintString = @"添加新物品到Fancy";
        [self.view addSubview:_label];
        
        _button1 = [[BeeUIButton alloc] init];
        _button1.hintString = @"拍照";
        [self.view addSubview:_button1];
        
        _button2 = [[BeeUIButton alloc] init];
        _button2.hintString = @"选择现有照片";
        [self.view addSubview:_button2];
	}
	else if ( [signal is:BeeUIBoard.DELETE_VIEWS] )
	{
        SAFE_RELEASE_SUBVIEW( _label );
        SAFE_RELEASE_SUBVIEW( _button1 );
        SAFE_RELEASE_SUBVIEW( _button2 );
	}
	else if ( [signal is:BeeUIBoard.LAYOUT_VIEWS] )
	{
        int padding = 10;
        
        _label.frame = CGRectMake( padding, padding, self.view.width - padding * 2, 50 );
        _button1.frame = CGRectMake( _label.left, _label.bottom + padding, _label.width, 50 );
        _button2.frame = CGRectMake( _label.left, _button1.bottom + padding, _label.width, 50 );
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
