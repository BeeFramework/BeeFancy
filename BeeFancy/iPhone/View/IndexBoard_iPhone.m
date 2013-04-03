//
//  IndexBoard_iPhone.m
//  BeeFancy
//
//  Created by QFish on 3/22/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "IndexBoard_iPhone.h"
#import "FancyBoard_iPhone.h"
#import "CommentBoard_iPhone.h"
#import "ListBoard_iPhone.h"

#pragma mark - Fancy_iPhone

@implementation Fancy_iPhone

DEF_SIGNAL( TOUCHED )

- (void)layoutInBound:(CGSize)bound forCell:(BeeUIGridCell *)cell
{
    float padding = 5.0f;
    
	CGRect frame  = CGRectMake( padding, padding, bound.width - padding * 2, bound.width - padding * 2 );
	_photo.frame  = frame;
	
	frame.origin.y = CGRectGetMaxY(frame) + padding;
	frame.size.height = 20.0f;
	_title.frame = frame;
    
    frame.origin.y = CGRectGetMaxY(frame) + padding;
    frame.size.width = 20.0f ;
    _label1.frame = frame;
   
    frame.origin.x = CGRectGetMaxX(frame);
    frame.size.width = bound.width - padding * 2 - frame.size.width ;
    _label2.frame = frame;

    frame.origin.x = padding;
    frame.origin.y = CGRectGetMaxY(frame) + padding;
    frame.size.width = bound.width / 3.07;
    _btn1.frame = frame;
    
    frame.origin.x = CGRectGetMaxX(frame) + padding;
    _btn2.frame = frame;
    
    frame.origin.x = CGRectGetMaxX(frame) + padding;
    _btn3.frame = frame;
}

- (void)load
{
    _photo = [[BeeUIImageView alloc] init];
    _photo.hintString = @"photo";
    _photo.tapEnabled = YES;
    _photo.tapSignal = [Fancy_iPhone TOUCHED];
    [self addSubview:_photo];
    
    _title = [[BeeUILabel alloc] init];
    _title.hintString = @"Fancy Title";
    [self addSubview:_title];
    
    _label1 = [[BeeUILabel alloc] init];
    _label1.hintString = @"$1999";
    [self addSubview:_label1];
    
    _label2 = [[BeeUILabel alloc] init];
    _label2.hintString = @" * beeFramework - 888888 其他";
    [self addSubview:_label2];
    
    _btn1 = [[BeeUIButton alloc] init];
    _btn1.hintString = @"喜欢";
    [_btn1 addSignal:[FancyButtons_iPhone LIKE] forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn1];
    
    _btn2 = [[BeeUIButton alloc] init];
    _btn2.hintString = @"加至列表";
    [_btn2 addSignal:[FancyButtons_iPhone ADD] forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn2];
    
    _btn3 = [[BeeUIButton alloc] init];
    _btn3.hintString = @"81";
    [_btn3 addSignal:[FancyButtons_iPhone COMMENT] forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn3];
}

- (void)unload
{
    SAFE_RELEASE_SUBVIEW( _photo );
    SAFE_RELEASE_SUBVIEW( _title );
    SAFE_RELEASE_SUBVIEW( _label1 );
    SAFE_RELEASE_SUBVIEW( _label2 );
    SAFE_RELEASE_SUBVIEW( _btn1 );
    SAFE_RELEASE_SUBVIEW( _btn2 );
    SAFE_RELEASE_SUBVIEW( _btn3 );
}

@end


#pragma mark - IndexBoard

@implementation IndexBoard_iPhone

- (void)load
{
	[super load];
    
    
    _data = [[NSMutableArray alloc] init];
    
    for ( int i = 0; i<50; i++)
    {
        [_data addObject:@(i++)];
    }
    
}

- (void)unload
{
    // TODO
    
    [_data removeAllObjects];
    [_data release];
    
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

        [self showNavigationBarAnimated:NO];
        [self showBarButton:UINavigationBar.BARBUTTON_LEFT title:@"菜单"];
        [self showBarButton:UINavigationBar.BARBUTTON_RIGHT title:@"刷新"];
        self.titleString = @"Fancy";
            
        _scrollView = [[BeeUIScrollView alloc] initWithFrame:CGRectZero];
		_scrollView.dataSource = self;
		[self.view addSubview:_scrollView];
	}
	else if ( [signal is:BeeUIBoard.DELETE_VIEWS] )
	{
        [_scrollView cancelReloadData];
        
        SAFE_RELEASE_SUBVIEW( _scrollView );
	}
	else if ( [signal is:BeeUIBoard.LAYOUT_VIEWS] )
	{
        CGRect scrollFrame;
		scrollFrame = self.view.frame;
		_scrollView.frame = scrollFrame;        
	}
	else if ( [signal is:BeeUIBoard.WILL_APPEAR] )
	{   
		[_scrollView asyncReloadData];
	}
}

#pragma mark - BeeUIScrollView Delegate

- (NSInteger)numberOfLinesInScrollView:(BeeUIScrollView *)scrollView
{
	return 1;
}

- (NSInteger)numberOfViewsInScrollView:(BeeUIScrollView *)scrollView
{    
    return _data.count;
}

- (UIView *)scrollView:(BeeUIScrollView *)scrollView viewForIndex:(NSInteger)index scale:(CGFloat)scale
{
	if ( _scrollView == scrollView )
    {
        Fancy_iPhone * cell = [scrollView dequeueWithContentClass:[Fancy_iPhone class]];
        cell.cellData = [_data objectAtIndex:index];
        return cell;
    }
	
	return nil;
}

- (CGSize)scrollView:(BeeUIScrollView *)scrollView sizeForIndex:(NSInteger)index
{
    return CGSizeMake( _scrollView.bounds.size.width, _scrollView.bounds.size.width + 70 );
}

#pragma mark [B] UISignal

- (void)handleUISignal_UINavigationBar:(BeeUISignal *)signal
{
	if ( [signal is:UINavigationBar.BARBUTTON_LEFT_TOUCHED] )
	{
        [[AppBoard_iPhone sharedInstance] showMenu];
	}
	else if ( [signal is:UINavigationBar.BARBUTTON_RIGHT_TOUCHED] )
	{
        [self presentSuccessTips:@"正在刷新"];
	}
}

- (void)handleUISignal_Fancy_iPhone:(BeeUISignal *)signal
{
    if ( [signal is:[Fancy_iPhone TOUCHED]] )
    {
        FancyBoard_iPhone * board = [[FancyBoard_iPhone alloc] init];
		[self.stack pushBoard:board animated:YES];
        [board release];
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
