//
//  AppBoard_iPhone.h
//  BeeFancy
//
//  Created by QFish on 3/22/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#define kMenuWidth    240.0f

@interface AppBoard_iPhone : BeeUIBoard
{
    CGRect                _mainStackGroupFrame;
    BeeUIStack          * _menuStack;
    BeeUIStackGroup     * _mainStackGroup;
    BeeUIButton         * _mask;
}

AS_SINGLETON( AppBoard_iPhone )

AS_NOTIFICATION( SWITCH_INDEX )
AS_NOTIFICATION( SWITCH_ACCOUNT )
AS_NOTIFICATION( SWITCH_BROWSE )
AS_NOTIFICATION( SWITCH_GIFT )
AS_NOTIFICATION( SWITCH_ADD )
AS_NOTIFICATION( SWITCH_NOTIFY )
AS_NOTIFICATION( SWITCH_CART )

AS_NOTIFICATION( SWITCH_FRIEND )
AS_NOTIFICATION( SWITCH_SETTING )
AS_NOTIFICATION( SWITCH_LOGOUT )

@property (nonatomic, assign) BOOL isMenuShown;

- (void)showMenu;

@end
