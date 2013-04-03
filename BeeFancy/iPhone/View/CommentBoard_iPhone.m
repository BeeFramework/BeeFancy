//
//  CommentBoard_iPhone.m
//  BeeFancy
//
//  Created by QFish on 3/23/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "CommentBoard_iPhone.h"

#pragma mark - HScrollCell_iPhone

@implementation HScrollCell_iPhone

- (void)layoutInBound:(CGSize)bound forCell:(BeeUIGridCell *)cell
{
    [super layoutInBound:bound forCell:cell];
    _avatar.frame = CGRectMake( 0, 4, 26 ,26 );
}

- (void)load
{
    [super load];
    
    _avatar = [[BeeUIImageView alloc] init];
    _avatar.hintString = @"头像";
    [self addSubview:_avatar];
    
}

- (void)unload
{
    SAFE_RELEASE_SUBVIEW( _avatar );

    [super unload];
}

@end


#pragma mark - VScrollCell_iPhone

@implementation VScrollCell_iPhone

- (void)layoutInBound:(CGSize)bound forCell:(BeeUIGridCell *)cell
{
    [super layoutInBound:bound forCell:cell];
    
    _avatar.frame = CGRectMake( 5, 5, 40, 40 );
    _label1.frame = CGRectMake( 50, 5, bound.width - _avatar.width - 15, 20 );
    _label2.frame = CGRectMake( 50, 25, bound.width - _avatar.width - 15, 20 );
}

- (void)load
{
    [super load];
        
    _avatar = [[BeeUIImageView alloc] init];
    _avatar.hintString = @"头像";
    [self addSubview:_avatar];
    
    _label1 = [[BeeUILabel alloc] init];
    _label1.hintString = @"Name";
    [self addSubview:_label1];
    
    _label2 = [[BeeUILabel alloc] init];
    _label2.hintString = @"comment";
    [self addSubview:_label2];
}

- (void)unload
{
    SAFE_RELEASE_SUBVIEW( _avatar );
    SAFE_RELEASE_SUBVIEW( _label1 );
    SAFE_RELEASE_SUBVIEW( _label2 );
    
    [super unload];
}

@end

#pragma mark - CommentInput_iPhone

@implementation CommentInput_iPhone

- (void)layoutInBound:(CGSize)bound forCell:(BeeUIGridCell *)cell
{
    [super layoutInBound:bound forCell:cell];
    
    _textView.frame = CGRectMake(5, 5, (int)( bound.width * 0.8), 35);
    _send.frame = CGRectMake( _textView.right + 5, 5, bound.width  - _textView.width - 15, 35);;
}

- (void)load
{
    [super load];
    
    self.hintColor = HEX_RGB(0xff123fea);
    
    _textView = [[BeeUITextView alloc] init];
    _textView.hintString = @"添加评论";
    [self addSubview:_textView];
    
    _send = [[BeeUIButton alloc] init];
    _send.hintString = @"发送";
    [self addSubview:_send];
}

- (void)unload
{
    SAFE_RELEASE_SUBVIEW( _textView );
    SAFE_RELEASE_SUBVIEW( _send );
    
    [super unload];
}

@end



#pragma mark - CommentBoard_iPhone

@implementation CommentBoard_iPhone

- (void)load
{
	[super load];
    
    _data = [[NSMutableArray alloc] init];
    _data2 = [[NSMutableArray alloc] init];
    
    for ( int i = 0; i<50; i++)
    {
        [_data addObject:@(i)];
        [_data2 addObject:@(i++)];
    }
    
}

- (void)unload
{
    [_data removeAllObjects];
    [_data release];
    
    [_data2 removeAllObjects];
    [_data2 release];
    
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

        self.titleString = @"回复";
        [self showNavigationBarAnimated:NO];
        
        _label = [[BeeUILabel alloc] init];
        _label.hintString = @"title";
        [self.view addSubview:_label];
        
        _horiScroll = [[BeeUIScrollView alloc] init];
//        _horiScroll.hintString = @"vscroll";
        _horiScroll.dataSource = self;
        _horiScroll.horizontal = YES;
        [self.view addSubview:_horiScroll];
        
        _vertScroll = [[BeeUIScrollView alloc] init];
//        _vertScroll.hintString = @"vscroll";
        _vertScroll.dataSource = self;
        [self.view addSubview:_vertScroll];
        
        _input = [[CommentInput_iPhone alloc] init];
        [self.view addSubview:_input];
        
        [self observeNotification:BeeUIKeyboard.SHOWN];
        [self observeNotification:BeeUIKeyboard.HIDDEN];
        [self observeNotification:BeeUIKeyboard.HEIGHT_CHANGED];
        
	}
	else if ( [signal is:BeeUIBoard.DELETE_VIEWS] )
	{
        [_horiScroll cancelReloadData];
        [_vertScroll cancelReloadData];
        
        [self unobserveAllNotifications];
        
        SAFE_RELEASE_SUBVIEW( _label );
        SAFE_RELEASE_SUBVIEW( _horiScroll );
        SAFE_RELEASE_SUBVIEW( _vertScroll );
        SAFE_RELEASE_SUBVIEW( _input );
    }
	else if ( [signal is:BeeUIBoard.LAYOUT_VIEWS] )
	{
        _label.frame = CGRectMake( 5, 5, self.view.width - 10, 20 );
        _input.frame = CGRectMake( 0, self.view.bottom - 45, self.view.width, 45 );
        _horiScroll.frame = CGRectMake( 5, _label.bottom, _label.width, 30 );
        _vertScroll.frame = CGRectMake( 0, _horiScroll.bottom + 5, self.view.width, _input.top - _horiScroll.bottom - 5 );
    }
}

- (void)handleNotification:(NSNotification *)notification
{
    [super handleNotification:notification];
    
    if ( [notification is:BeeUIKeyboard.SHOWN] )
    {
        [[BeeUIKeyboard sharedInstance] showAccessor:_input animated:YES];
                
        [self showBarButton:UINavigationBar.BARBUTTON_RIGHT title:@"取消"];
        
    }
    else if ( [notification is:BeeUIKeyboard.HIDDEN] )
    {
        [[BeeUIKeyboard sharedInstance] hideAccessor:_input animated:YES];
        
        [self hideBarButton:UINavigationBar.BARBUTTON_RIGHT];
    }
}

- (void)handleUISignal_UINavigationBar:(BeeUISignal *)signal
{
	if ( [signal is:UINavigationBar.BARBUTTON_RIGHT_TOUCHED] )
	{
        [self.view endEditing:YES];
	}
}

#pragma mark - BeeUIScrollView Delegate

- (NSInteger)numberOfLinesInScrollView:(BeeUIScrollView *)scrollView
{
	return 1;
}

- (NSInteger)numberOfViewsInScrollView:(BeeUIScrollView *)scrollView
{
	if ( _horiScroll == scrollView )
	{
		return _data.count;
	}
    else if ( _vertScroll == scrollView )
	{
		return _data2.count;
	}
    
	return 0;
}

- (UIView *)scrollView:(BeeUIScrollView *)scrollView viewForIndex:(NSInteger)index scale:(CGFloat)scale
{
	if ( _horiScroll == scrollView )
	{
        HScrollCell_iPhone * cell = [scrollView dequeueWithContentClass:[HScrollCell_iPhone class]];
        cell.cellData = [_data objectAtIndex:index];
        return cell;
	}
    else if ( _vertScroll == scrollView )
	{
        VScrollCell_iPhone * cell = [scrollView dequeueWithContentClass:[VScrollCell_iPhone class]];
        cell.cellData = [_data objectAtIndex:index];
        return cell;
	}
	
	return nil;
}

- (CGSize)scrollView:(BeeUIScrollView *)scrollView sizeForIndex:(NSInteger)index
{
    if ( _horiScroll == scrollView )
	{
		return CGSizeMake( 30, 30 );
	}
    else if ( _vertScroll == scrollView )
	{
		return CGSizeMake( _vertScroll.bounds.size.width, 50 );
	}
	
	return CGSizeZero;
}

@end
