//
//  FancyBoard_iPhone.m
//  BeeFancy
//
//  Created by QFish on 3/25/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "FancyBoard_iPhone.h"
#import "CommentBoard_iPhone.h"
#import "ListBoard_iPhone.h"

#pragma mark - FancyButtons_iPhone

@implementation FancyButtons_iPhone

DEF_SIGNAL( LIKE )
DEF_SIGNAL( ADD )
DEF_SIGNAL( COMMENT )

- (void)layoutInBound:(CGSize)bound forCell:(BeeUIGridCell *)cell
{
    [super layoutInBound:bound forCell:cell];
    
    CGFloat paddingx = 10.0f, paddingy = 5.0f;

    _btn1.frame = CGRectMake( paddingx, paddingy, bound.width / 3.1, bound.height - paddingy * 2 );
    _btn2.frame = CGRectMake( _btn1.right + paddingx, _btn1.top, bound.width / 3.1, _btn1.height );
    _btn3.frame = CGRectMake( _btn2.right + paddingx, _btn1.top, bound.width / 3.2, _btn1.height );
}

- (void)load
{
    [super load];
    
    _btn1 = [[BeeUIButton alloc] init];
    _btn1.hintString = @"喜欢";
    [self addSubview:_btn1];
    
    _btn2 = [[BeeUIButton alloc] init];
    _btn2.hintString = @"加至列表";
    [self addSubview:_btn2];
    
    _btn3 = [[BeeUIButton alloc] init];
    _btn3.hintString = @"评论81";
    [self addSubview:_btn3];
    
    [_btn1 addSignal:[FancyButtons_iPhone LIKE]
    forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addSignal:[FancyButtons_iPhone ADD]
    forControlEvents:UIControlEventTouchUpInside];
    [_btn3 addSignal:[FancyButtons_iPhone COMMENT]
    forControlEvents:UIControlEventTouchUpInside];
}

- (void)unload
{
    SAFE_RELEASE_SUBVIEW( _btn1 );
    SAFE_RELEASE_SUBVIEW( _btn2 );
    SAFE_RELEASE_SUBVIEW( _btn3 );
    
    [super unload];
}

@end


#pragma mark - FancyBoard_iPhone

@implementation FancyBoard_iPhone

- (void)load
{
	[super load];
}

- (void)unload
{    
	[super unload];
}

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
        [self showBarButton:UINavigationBar.BARBUTTON_RIGHT title:@"分享"];
        
        _zoomImage = [[BeeUIZoomView alloc] init];
        _zoomImage.hintString = @"ZoomImage";
        [self.view addSubview:_zoomImage];
        
        _titleView = [[BeeUIButton alloc] init];
        _titleView.hintString = @"购买";
        [self.view addSubview:_titleView];
        
        _label1 = [[BeeUILabel alloc] init];
        _label1.hintString = @"Title";
        [self.view addSubview:_label1];
        
        _label2 = [[BeeUILabel alloc] init];
        _label2.hintString = @"descripiton";
        [self.view addSubview:_label2];
        
        _buttons = [[FancyButtons_iPhone alloc] init];
        _buttons.hintColor = [UIColor redColor];
        [self.view addSubview:_buttons];
        
        self.titleView = _titleView;
	}
	else if ( [signal is:BeeUIBoard.DELETE_VIEWS] )
	{
        
        SAFE_RELEASE_SUBVIEW( _zoomImage );
        SAFE_RELEASE_SUBVIEW( _titleView );
        SAFE_RELEASE_SUBVIEW( _buttons );
        SAFE_RELEASE_SUBVIEW( _label1 );
        SAFE_RELEASE_SUBVIEW( _label2 );
	}
	else if ( [signal is:BeeUIBoard.LAYOUT_VIEWS] )
	{
        _zoomImage.frame = self.view.bounds;
        _titleView.frame = CGRectMake( 130, 2, 60, 40 );
        _buttons.frame = CGRectMake( 0, self.view.frame.size.height - 40, self.view.frame.size.width, 40 );
        _label1.frame = CGRectMake( 0, _buttons.top - 50, self.view.frame.size.width, 30 );
        _label2.frame = CGRectMake( 0, _label1.bottom, self.view.frame.size.width, 20 );
	}
}

- (void)handleUISignal_UINavigationBar:(BeeUISignal *)signal
{
	if ( [signal is:UINavigationBar.BARBUTTON_RIGHT_TOUCHED] )
	{
        [self presentSuccessTips:@"TODO"];
	}
}

- (void)handleUISignal_FancyButtons_iPhone:(BeeUISignal *)signal
{
    if ( [signal is:[FancyButtons_iPhone LIKE]] )
    {
        BeeUIButton * button = signal.source;
        button.hintString = @"喜欢+1";
    }
    else if ( [signal is:[FancyButtons_iPhone ADD]] )
    {
        ListBoard_iPhone * board = [[[ListBoard_iPhone alloc] init] autorelease];
        
        [self.stack pushBoard:board
                     animated:YES];
    }
    else if ( [signal is:[FancyButtons_iPhone COMMENT]] )
    {
        CommentBoard_iPhone * board = [[[CommentBoard_iPhone alloc] init] autorelease];
        
        [self.stack pushBoard:board
                     animated:YES];
    }
}

@end
