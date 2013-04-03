//
//  AppBoard_iPad.m
//  BeeFancy
//
//  Created by QFish on 3/22/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "AppBoard_iPad.h"

@implementation AppBoard_iPad

DEF_SINGLETON( AppBoard_iPad )

// BeeUIBoard signal goes here
- (void)handleUISignal_BeeUIBoard:(BeeUISignal *)signal
{
	[super handleUISignal:signal];
	
	if ( [signal is:BeeUIBoard.CREATE_VIEWS] )
	{
		// 界面创建
        self.view.hintString = @"Hello Bee, iPad!";
	}
	else if ( [signal is:BeeUIBoard.DELETE_VIEWS] )
	{
		// 界面删除
        // SAFE_RELEASE_SUBVIEW(  );
	}
	else if ( [signal is:BeeUIBoard.LAYOUT_VIEWS] )
	{
		// 界面重新布局
	}
	else if ( [signal is:BeeUIBoard.LOAD_DATAS] )
	{
		// 数据加载
	}
	else if ( [signal is:BeeUIBoard.FREE_DATAS] )
	{
		// 数据释放
	}
	else if ( [signal is:BeeUIBoard.WILL_APPEAR] )
	{
		// 将要显示
	}
	else if ( [signal is:BeeUIBoard.DID_APPEAR] )
	{
		// 已经显示
	}
	else if ( [signal is:BeeUIBoard.WILL_DISAPPEAR] )
	{
		// 将要隐藏
	}
	else if ( [signal is:BeeUIBoard.DID_DISAPPEAR] )
	{
		// 已经隐藏
	}
}

@end
