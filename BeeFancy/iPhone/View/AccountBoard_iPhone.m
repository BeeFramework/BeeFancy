//
//  AccountBoard_iPhone.m
//  BeeFancy
//
//  Created by QFish on 3/23/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "AccountBoard_iPhone.h"

#pragma mark - Tabs_iPhone

@implementation Tabs_iPhone

DEF_SIGNAL( TAB )

- (void)layoutInBound:(CGSize)bound forCell:(BeeUIGridCell *)cell
{
    [super layoutInBound:bound forCell:cell];
    
    int count = 4;
    
    _tab1.frame = CGRectMake( 0, 0, bound.width/count, bound.height );
    _tab2.frame = CGRectMake( _tab1.right, 0, bound.width/count, bound.height );
    _tab3.frame = CGRectMake( _tab2.right, 0, bound.width/count, bound.height );
    _tab4.frame = CGRectMake( _tab3.right, 0, bound.width/count, bound.height );
}

- (void)load
{
    [super load];
    
    _tab1 = [[BeeUIButton alloc] init];
    _tab1.hintString = @"Tab1";
    _tab1.hintColor = RANDCOLOR;
    [self addSubview:_tab1];
    
    _tab2 = [[BeeUIButton alloc] init];
    _tab2.hintString = @"Tab2";
    _tab2.hintColor = RANDCOLOR;
    [self addSubview:_tab2];
    
    _tab3 = [[BeeUIButton alloc] init];
    _tab3.hintString = @"Tab3";
    _tab3.hintColor = RANDCOLOR;
    [self addSubview:_tab3];
    
    _tab4 = [[BeeUIButton alloc] init];
    _tab4.hintString = @"Tab4";
    _tab4.hintColor = RANDCOLOR;
    [self addSubview:_tab4];
    
    [_tab1 addSignal:[Tabs_iPhone TAB]
    forControlEvents:UIControlEventTouchUpInside object:@(0)];
    [_tab2 addSignal:[Tabs_iPhone TAB]
    forControlEvents:UIControlEventTouchUpInside object:@(1)];
    [_tab3 addSignal:[Tabs_iPhone TAB]
    forControlEvents:UIControlEventTouchUpInside object:@(2)];
    [_tab4 addSignal:[Tabs_iPhone TAB]
    forControlEvents:UIControlEventTouchUpInside object:@(3)];
}

- (void)unload
{
    SAFE_RELEASE_SUBVIEW( _tab1 );
    SAFE_RELEASE_SUBVIEW( _tab2 );
    SAFE_RELEASE_SUBVIEW( _tab3 );
    SAFE_RELEASE_SUBVIEW( _tab4 );
    
    [super unload];
}

@end

#pragma mark - TabViewsCellOne_iPhone

@implementation TabViewsCellOne_iPhone

- (void)layoutInBound:(CGSize)bound forCell:(BeeUIGridCell *)cell
{
    [super layoutInBound:bound forCell:cell];
    
    CGFloat padding = 10.0f;
    _photo.frame = CGRectMake( padding, padding, bound.width - padding * 2, bound.height - padding * 3 );
    _label1.frame = CGRectMake( padding, _photo.bottom, 50, padding * 2 );
    _label2.frame = CGRectMake( _label1.right, _label1.top, _photo.width - _label1.width, _label1.height );
}

- (void)load
{
    [super load];
    _photo = [[BeeUIImageView alloc] init];
    _photo.hintString = @"Photo";
    [self addSubview:_photo];
    
    _label1 = [[BeeUILabel alloc] init];
    _label1.hintString = @"Name";
    [self addSubview:_label1];
    
    _label2 = [[BeeUILabel alloc] init];
    _label2.hintString = @" + 9999";
    [self addSubview:_label2];
}

- (void)unload
{
    SAFE_RELEASE_SUBVIEW( _photo );
    SAFE_RELEASE_SUBVIEW( _label1 );
    SAFE_RELEASE_SUBVIEW( _label2 );
    
    [super unload];
}

@end

#pragma mark - TabViewsCellTwo_iPhone

@implementation TabViewsCellTwo_iPhone

- (void)layoutInBound:(CGSize)bound forCell:(BeeUIGridCell *)cell
{
    [super layoutInBound:bound forCell:cell];
    
    CGFloat padding = 10.0f;
    
    _label1.frame = CGRectMake( padding, padding, bound.width - padding *2, 20 );
    _label2.frame = CGRectMake( padding, _label1.bottom, _label1.width, 20 );
    _horiScroll.frame = CGRectMake( padding, _label2.bottom, _label1.width, bound.height - padding - _label2.bottom );
}

- (void)load
{
    [super load];
    
    _horiScroll = [[BeeUIScrollView alloc] init];
    _horiScroll.horizontal = YES;
    _horiScroll.dataSource = self;
    [self addSubview:_horiScroll];
    
    _label1 = [[BeeUILabel alloc] init];
    _label1.hintString = @"Food";
    [self addSubview:_label1];
    
    _label2 = [[BeeUILabel alloc] init];
    _label2.hintString = @"1件商品";
    [self addSubview:_label2];
}

- (void)unload
{
    SAFE_RELEASE_SUBVIEW( _horiScroll );
    SAFE_RELEASE_SUBVIEW( _label1 );
    SAFE_RELEASE_SUBVIEW( _label2 );
    
    [super unload];
}

- (void)dataDidChanged
{
    _data = _cellData;
    [_horiScroll reloadData];
}

#pragma mark - BeeUIScrollView Delegate

- (NSInteger)numberOfLinesInScrollView:(BeeUIScrollView *)scrollView
{
	if ( _horiScroll == scrollView )
	{
		return 1;
	}
    
	return 1;
}

- (NSInteger)numberOfViewsInScrollView:(BeeUIScrollView *)scrollView
{
	if ( _horiScroll == scrollView )
    {
        return _data.count;
    }
    
	return 0;
}

- (UIView *)scrollView:(BeeUIScrollView *)scrollView viewForIndex:(NSInteger)index scale:(CGFloat)scale
{
	if ( _horiScroll == scrollView )
    {
        static int i = 0;
        BeeUIImageView * cell  = [scrollView dequeueWithContentClass:[BeeUIImageView class]];
        cell.hintString = [NSString stringWithFormat:@"%d", i++];
        cell.hintColor = RANDCOLOR;
        return cell;
    }
	
	return nil;
}

- (CGSize)scrollView:(BeeUIScrollView *)scrollView sizeForIndex:(NSInteger)index
{
	CGSize viewSize;
	viewSize.width = 50.0f;
	viewSize.height = 50.0f;
    
	if ( _horiScroll == scrollView )
	{
		return viewSize;
	}
	
	return CGSizeZero;
}

@end

#pragma mark - TabViewsCellThree_iPhone

@implementation TabViewsCellThree_iPhone

- (void)layoutInBound:(CGSize)bound forCell:(BeeUIGridCell *)cell
{
    [super layoutInBound:bound forCell:cell];
    
    CGFloat padding = 10.0f;
    
    _photo.frame = CGRectMake( padding, padding, 40, 40 );
    _button.frame = CGRectMake( bound.width - padding - 60, padding, 60, _photo.height );
    _label1.frame = CGRectMake( _photo.right + padding, 10, bound.width - padding*4 - _button.width - _photo.width, 20 );
    _label2.frame = CGRectMake( _photo.right + padding, _label1.bottom, _label1.width, _label1.height );
}

- (void)load
{
    [super load];
    
    _photo = [[BeeUIImageView alloc] init];
    _photo.hintString = @"Photo";
    [self addSubview:_photo];
    
    _label1 = [[BeeUILabel alloc] init];
    _label1.hintString = @"Label1";
    [self addSubview:_label1];
    
    _label2 = [[BeeUILabel alloc] init];
    _label2.hintString = @"Label2";
    [self addSubview:_label2];
    
    _button = [[BeeUIButton alloc] init];
    _button.hintString = @"关注";
    [self addSubview:_button];
}

- (void)unload
{
    SAFE_RELEASE_SUBVIEW( _photo );
    SAFE_RELEASE_SUBVIEW( _label1 );
    SAFE_RELEASE_SUBVIEW( _label2 );
    SAFE_RELEASE_SUBVIEW( _button );
    
    [super unload];
}

@end

#pragma mark - TabViewsCellFour_iPhone

@implementation TabViewsCellFour_iPhone

- (void)layoutInBound:(CGSize)bound forCell:(BeeUIGridCell *)cell
{
    [super layoutInBound:bound forCell:cell];
}

- (void)load
{
    [super load];
    
}

- (void)unload
{
    
    [super unload];
}

@end


#pragma mark - TabViews_iPhone

@implementation TabViews_iPhone

- (void)layoutInBound:(CGSize)bound forCell:(BeeUIGridCell *)cell
{
    [super layoutInBound:bound forCell:cell];
    
    _scrollView.frame = CGRectMake( 0, 0, bound.width, bound.height );
}

- (void)load
{
    [super load];
    
    _scrollView = [[BeeUIScrollView alloc] init];
    _scrollView.dataSource = self;
    
    [self addSubview:_scrollView];
}

- (void)unload
{
    [_scrollView cancelReloadData];
    
    SAFE_RELEASE_SUBVIEW( _scrollView );
    
    [super unload];
}

- (void)dataDidChanged
{
    [_data removeAllObjects];
    [_data addObjectsFromArray:_cellData];
    
    if ( 0 == _data.count )
    {
        _data = _cellData;
    }
    [_scrollView syncReloadData];
    [_scrollView setContentOffset:CGPointZero];
}

- (void)reload
{
    [_scrollView syncReloadData];
}

#pragma mark - BeeUIScrollView Delegate

- (NSInteger)numberOfLinesInScrollView:(BeeUIScrollView *)scrollView
{
    if ( _tabViewStyle == TabViewStyleOne )
    {
        return 2;
    }
    
	return 1;
}

- (NSInteger)numberOfViewsInScrollView:(BeeUIScrollView *)scrollView
{
	if ( _scrollView == scrollView )
    {
        return _data.count;
    }
    
	return 0;
}

- (UIView *)scrollView:(BeeUIScrollView *)scrollView viewForIndex:(NSInteger)index scale:(CGFloat)scale
{
    if ( _tabViewStyle == TabViewStyleOne )
    {
        TabViewsCellOne_iPhone * cell = [scrollView dequeueWithContentClass:[TabViewsCellOne_iPhone class]];
        cell.cellData = [_data objectAtIndex:index];
        return cell;
    }
	else if ( _tabViewStyle == TabViewStyleTwo )
    {
        TabViewsCellTwo_iPhone * cell = [scrollView dequeueWithContentClass:[TabViewsCellTwo_iPhone class]];
        
        NSMutableArray * array = [NSMutableArray arrayWithCapacity:10];
        
        for (int i=0; i<10; i++)
        {
                [array addObject:@(1)];
        }
        
        cell.cellData = array;
        
        return cell;
    }
	else if ( _tabViewStyle == TabViewStyleThree )
    {
        TabViewsCellThree_iPhone * cell = [scrollView dequeueWithContentClass:[TabViewsCellThree_iPhone class]];
        cell.cellData = [_data objectAtIndex:index];
        return cell;
    }
	else if ( _tabViewStyle == TabViewStyleFour )
    {
        TabViewsCellThree_iPhone * cell = [scrollView dequeueWithContentClass:[TabViewsCellThree_iPhone class]];
        cell.cellData = [_data objectAtIndex:index];
        return cell;
    }
    
	return nil;
}

- (CGSize)scrollView:(BeeUIScrollView *)scrollView sizeForIndex:(NSInteger)index
{
    if ( _tabViewStyle == TabViewStyleOne )
    {
        return CGSizeMake( self.width / 2, self.height / 2 );
    }
	else if ( _tabViewStyle == TabViewStyleTwo )
    {
        return CGSizeMake( self.width, 150 );
    }
	else if ( _tabViewStyle == TabViewStyleThree )
    {
        return CGSizeMake( self.width, 60 );
    }
	else if ( _tabViewStyle == TabViewStyleFour )
    {
        return CGSizeMake( self.width, 60 );
    }
	return CGSizeZero;
}

@end

#pragma mark - AccountBoard_iPhone

@implementation AccountBoard_iPhone

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
	
    self.view.backgroundColor = [UIColor whiteColor];
    
	if ( [signal is:BeeUIBoard.CREATE_VIEWS] )
	{
        self.view.backgroundColor = [UIColor whiteColor];

        self.titleString = @"Account";
        [self showNavigationBarAnimated:NO];
        [self showBarButton:UINavigationBar.BARBUTTON_LEFT title:@"菜单"];
        [self showBarButton:UINavigationBar.BARBUTTON_RIGHT title:@"设置"];
        
        _photo = [[BeeUIImageView alloc] init];
        _photo.hintString = @"photo";
        [self.view addSubview:_photo];
        
        _label1 = [[BeeUILabel alloc] init];
        _label1.hintString = @"QFish";
        [self.view addSubview:_label1];
        
        _label2 = [[BeeUILabel alloc] init];
        _label2.hintString = @"QFish";
        [self.view addSubview:_label2];
        
        _tabs = [[Tabs_iPhone alloc] init];
        [self.view addSubview:_tabs];
        
        _tabViews = [[TabViews_iPhone alloc] init];
        _tabViews.tabViewStyle = TabViewStyleOne;
        [self.view addSubview:_tabViews];
        
	}
	else if ( [signal is:BeeUIBoard.DELETE_VIEWS] )
	{
        
        
        SAFE_RELEASE_SUBVIEW( _photo );
        SAFE_RELEASE_SUBVIEW( _label1 );
        SAFE_RELEASE_SUBVIEW( _label2 );
        SAFE_RELEASE( _tabs );
        SAFE_RELEASE( _tabViews );
	}
	else if ( [signal is:BeeUIBoard.LAYOUT_VIEWS] )
	{
        CGFloat padding = 10.0f;
		_photo.frame = CGRectMake( padding, padding, 70, 70 );
        _label1.frame = CGRectMake( _photo.right + padding, _photo.top, self.view.width - padding * 3 - _photo.width, 20 );
        _label2.frame = CGRectMake( _label1.left, _label1.bottom + padding, _label1.width, _photo.height - padding - _label1.height );
        _tabs.frame = CGRectMake( 0, _photo.bottom + padding, self.view.width, 50 );
        _tabViews.frame = CGRectMake( 0, _tabs.bottom, self.view.width, self.view.height - _tabs.bottom );
    }
    else if ( [signal is:[BeeUIBoard LOAD_DATAS]] )
    {
        NSMutableArray * array = [NSMutableArray arrayWithCapacity:10];
        for (int i=0; i<10; i++) {
            [array addObject:@(1)];
        }
        _tabViews.cellData = array;
    }
}

- (void)handleUISignal_UINavigationBar:(BeeUISignal *)signal
{
	if ( [signal is:UINavigationBar.BARBUTTON_LEFT_TOUCHED] )
	{
        [[AppBoard_iPhone sharedInstance] showMenu];
	}
	else if ( [signal is:UINavigationBar.BARBUTTON_RIGHT_TOUCHED] )
	{
        [self presentSuccessTips:@"TODO"];
	}
}

- (void)handleUISignal_Tabs_iPhone:(BeeUISignal *)signal
{
    _tabViews.tabViewStyle = ((NSNumber *)signal.object).integerValue;
    [_tabViews reload];
}

@end
