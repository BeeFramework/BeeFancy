//
//  AppBoard_iPhone.m
//  BeeFancy
//
//  Created by QFish on 3/22/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "AppBoard_iPhone.h"
#import "LoginBoard_iPhone.h"
#import "IndexBoard_iPhone.h"
#import "CommentBoard_iPhone.h"
#import "AccountBoard_iPhone.h"
#import "FancyBoard_iPhone.h"
#import "MenuBoard_iPhone.h"
#import "AddBoard_iPhone.h"
#import "FriendBoard_iPhone.h"
#import "CartBoard_iPhone.h"
#import "SettingBoard_iPhone.h"

#define kDurationFast 0.35f
#define kDurationSlow 0.85f

#if 0

[_mainStackGroup append:[BeeUIStack stack:@"<#name#>" firstBoardClass:[<#class#> class]]];

#endif

@implementation AppBoard_iPhone

DEF_SINGLETON( AppBoard_iPhone )

DEF_NOTIFICATION( SWITCH_INDEX )
DEF_NOTIFICATION( SWITCH_ACCOUNT )
DEF_NOTIFICATION( SWITCH_BROWSE )
DEF_NOTIFICATION( SWITCH_GIFT )
DEF_NOTIFICATION( SWITCH_ADD )
DEF_NOTIFICATION( SWITCH_NOTIFY )
DEF_NOTIFICATION( SWITCH_CART )

DEF_NOTIFICATION( SWITCH_FRIEND )
DEF_NOTIFICATION( SWITCH_SETTING )
DEF_NOTIFICATION( SWITCH_LOGOUT )

- (void)handleUISignal_BeeUIBoard:(BeeUISignal *)signal
{
	[super handleUISignal:signal];
	
	if ( [signal is:BeeUIBoard.CREATE_VIEWS] )
	{
        [BeeUITipsCenter setDefaultContainerView:self.view];
        [BeeUITipsCenter setDefaultBubble:[UIImage imageNamed:@"alertBox.png"]];
        
        _menuStack = [[BeeUIStack stackWithFirstBoardClass:[MenuBoard_iPhone class]] retain];
        [self.view addSubview:_menuStack.view];

        _mainStackGroup = [[BeeUIStackGroup stackGroup] retain];
        _mainStackGroup.parentBoard = self;
        _mainStackGroup.view.layer.shadowColor = [UIColor blackColor].CGColor;
        _mainStackGroup.view.layer.shadowOpacity = 0.5f;
        _mainStackGroup.view.layer.shadowOffset = CGSizeMake(0, 0);
        _mainStackGroup.view.layer.shadowRadius = 5.0f;
        [self.view addSubview:_mainStackGroup.view];
        
        _mask = [[BeeUIButton alloc] init];
        _mask.hidden = YES;
        [_mask addTarget:self action:@selector(removeMask) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:_mask];
        
        [self addObsevers];
        
        [self presentModalBoard:[[[LoginBoard_iPhone alloc] init] autorelease] animated:NO];
        
        [self postNotification:self.SWITCH_INDEX];
    }
    else if ( [signal is:BeeUIBoard.DELETE_VIEWS] )
	{
        [self unobserveAllNotifications];
        
        SAFE_RELEASE( _menuStack );
        SAFE_RELEASE( _mainStackGroup );
	}
	else if ( [signal is:BeeUIBoard.LAYOUT_VIEWS] )
	{
        CGRect menuStackFrame = self.viewBound;
        menuStackFrame.size.width = [MenuBoard_iPhone sizeInBound:self.viewSize forData:nil].width;
        _menuStack.view.frame = menuStackFrame;
		_mainStackGroup.view.frame = self.viewBound;
        _mask.frame = _mainStackGroup.view.frame;
	}
    else if ( [signal is:BeeUIBoard.DID_APPEAR] )
    {
        _mainStackGroup.view.pannable = YES;
    }
    else if ( [signal is:BeeUIBoard.DID_DISAPPEAR] )
    {
        _mainStackGroup.view.pannable = NO;
    }
}

- (void)handleUISignal_UIView:(BeeUISignal *)signal
{
    if ( [signal is:UIView.PAN_START]  )
    {
        _mainStackGroupFrame = _mainStackGroup.view.frame;

        [self syncPanPosition];
    }
    else if ( [signal is:UIView.PAN_CHANGED]  )
    {   
        [self syncPanPosition];
    }
    else if ( [signal is:UIView.PAN_STOP] || [signal is:UIView.PAN_CANCELLED] )
    {
        [self syncPanPosition];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];

        CGFloat left = _mainStackGroup.view.left;
        if ( left <= (_mainStackGroup.view.width / 2.0f) )
        {
            _mainStackGroup.view.left = 0;
            self.isMenuShown = NO;
        }
        else if ( left > _mainStackGroup.view.width / 2.0f )
        {
            _mainStackGroup.view.left = kMenuWidth;
            self.isMenuShown = YES;
        }
        else
        {
            _mainStackGroup.view.frame = _mainStackGroupFrame;
        }
        
        [UIView commitAnimations];
    }
}

- (void)syncPanPosition
{
    if ( _mainStackGroup.view.left < 0 || ( _mainStackGroup.view.left == 0 && _mainStackGroup.view.panOffset.x < 0 ))
    {
        return;
    }
    else
    {
        _mainStackGroup.view.frame = CGRectOffset( _mainStackGroupFrame, _mainStackGroup.view.panOffset.x, 0 );
    }
}

- (void)addObsevers
{
    [self observeNotification:self.SWITCH_ACCOUNT];
    [self observeNotification:self.SWITCH_INDEX];
    [self observeNotification:self.SWITCH_BROWSE];
    [self observeNotification:self.SWITCH_GIFT];
    [self observeNotification:self.SWITCH_ADD];
    [self observeNotification:self.SWITCH_NOTIFY];
    [self observeNotification:self.SWITCH_CART];
    [self observeNotification:self.SWITCH_FRIEND];
    [self observeNotification:self.SWITCH_SETTING];
    [self observeNotification:self.SWITCH_LOGOUT];
}

- (void)handleNotification:(NSNotification *)notification
{    
    if ( [notification is:self.SWITCH_INDEX] )
    {
        [self showBoard:[IndexBoard_iPhone class]];
    }
    else if ( [notification is:self.SWITCH_ACCOUNT] )
    {
        [self showBoard:[AccountBoard_iPhone class]];
    }
//    else if ( [notification is:self.SWITCH_BROWSE] )
//    {
//       
//    }
    else if ( [notification is:self.SWITCH_GIFT] )
    {
        [self showBoard:[FancyBoard_iPhone class]];
    }
    else if ( [notification is:self.SWITCH_ADD] )
    {
        [self showBoard:[AddBoard_iPhone class]];
    }
    else if ( [notification is:self.SWITCH_NOTIFY] )
    {
        [self showBoard:[BaseBoard_iPhone class]];
    }
    else if ( [notification is:self.SWITCH_CART] )
    {
        [self showBoard:[CartBoard_iPhone class]];
    }
    else if ( [notification is:self.SWITCH_FRIEND] )
    {
        [self showBoard:[FriendBoard_iPhone class]];
    }
    else if ( [notification is:self.SWITCH_SETTING] )
    {
        [self showBoard:[SettingBoard_iPhone class]];
    }
    else if ( [notification is:self.SWITCH_LOGOUT] )
    {
        [self presentModalBoard:[[[LoginBoard_iPhone alloc] init] autorelease] animated:YES];
    }
}

- (void)showBoard:(Class)clazz
{
    BeeUIStack * stack = [_mainStackGroup reflect:[clazz description]];
    
    if ( nil == stack )
    {
        stack = [BeeUIStack stack:[clazz description] firstBoardClass:[clazz class]];
        
        CGRect stackFrame = self.view.frame;
        stackFrame.origin = CGPointZero;
        stack.view.frame = stackFrame;
        
        [_mainStackGroup append:stack];
    }
    else
    {
        [_mainStackGroup present:stack];
    }
    
    if ( _isMenuShown )
    {
        [self showMenu];
    }
}

- (void)showMenu
{    
    [UIView animateWithDuration:kDurationFast animations:^{
        _mainStackGroup.view.left = _isMenuShown ? 0 : kMenuWidth;
    } completion:^(BOOL finished) {
        self.isMenuShown = !_isMenuShown;
    }];
}

- (void)setIsMenuShown:(BOOL)isMenuShown
{
    _isMenuShown = isMenuShown;
    
    _mask.hidden = !_isMenuShown;
    _mask.frame = _mainStackGroup.view.frame;
}

- (void)removeMask
{
    [self showMenu];
}



@end
