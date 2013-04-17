//
//  MenuBoard_iPhone.m
//  BeeFancy
//
//  Created by QFish on 3/25/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "MenuBoard_iPhone.h"
#import "AccountBoard_iPhone.h"
#import "BrowseBoard_iPhone.h"
#import "GiftBoard_iPhone.h"
#import "AddBoard_iPhone.h"

#pragma mark - UserCell_iPhone

@implementation UserCell_iPhone

- (void)layoutInBound:(CGSize)bound forCell:(BeeUIGridCell *)cell
{
    [super layoutInBound:bound forCell:cell];
    
    _avatar.frame = CGRectMake( 5, 5, 90, 90 );
    _label1.frame = CGRectMake( _avatar.right + 5, 5, bound.width - _avatar.width - 15, 50 );
    _label2.frame = CGRectMake( _avatar.right + 5, _label1.bottom + 5, bound.width - _avatar.width - 15, 35 );
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

#pragma mark - 

@implementation MenuBoard_iPhone

- (void)load
{
	[super load];
    
    _menuTitles = [[NSMutableArray alloc] init];
    [_menuTitles addObjectsFromArray:@[@"User", @"Fancy", @"账户"]];
    
    _menus = [[NSMutableArray alloc] init];
    [_menus addObject:@[ @"User" ]];
    [_menus addObject:@[ @"主页", @"浏览", @"礼物", @"添加", @"通知", @"购物车" ]];
    [_menus addObject:@[ @"找朋友", @"设置", @"登出" ]];
    
    _notifications = [[NSMutableArray alloc] init];
    [_notifications addObject:@[ AppBoard_iPhone.SWITCH_ACCOUNT ]];
    [_notifications addObject:@[ AppBoard_iPhone.SWITCH_INDEX, AppBoard_iPhone.SWITCH_BROWSE, AppBoard_iPhone.SWITCH_GIFT, AppBoard_iPhone.SWITCH_ADD, AppBoard_iPhone.SWITCH_NOTIFY, AppBoard_iPhone.SWITCH_CART ]];
    [_notifications addObject:@[ AppBoard_iPhone.SWITCH_FRIEND, AppBoard_iPhone.SWITCH_SETTING, AppBoard_iPhone.SWITCH_LOGOUT ]];
}

- (void)unload
{
    [_menuTitles removeAllObjects];
    [_menuTitles release];
    
    [_menus removeAllObjects];
    [_menus release];
    
	[super unload];
}

#pragma mark [B] UISignal

+ (CGSize)sizeInBound:(CGSize)bound forData:(NSObject *)data
{
    return CGSizeMake( kMenuWidth, bound.height );
}

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

        self.searchBarStyle = BeeUITableBoard.SEARCHBAR_STYLE_TOP;
        self.searchBar.hidden = NO;
        self.tableView.showsVerticalScrollIndicator = NO;
	}
	else if ( [signal is:BeeUIBoard.DELETE_VIEWS] )
	{
	}
	else if ( [signal is:BeeUIBoard.LAYOUT_VIEWS] )
	{
        self.searchBar.width = self.view.width;
        self.tableView.width = self.view.width;
        self.tableView.top = self.searchBar.bottom;
	}
    else if ( [signal is:BeeUIBoard.WILL_APPEAR] )
    {
        [self hideNavigationBarAnimated:YES];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.section == 1 && indexPath.row == 1) // Browse
    {
        BrowseBoard_iPhone * board = [[[BrowseBoard_iPhone alloc] init] autorelease];
        [self.stack pushBoard:board animated:YES];
    }
    else if ( indexPath.section == 1 && indexPath.row == 2) // Gift
    {
        GiftBoard_iPhone * board = [[[GiftBoard_iPhone alloc] init] autorelease];
        [self.stack pushBoard:board animated:YES];
    }
    else
    {
        [self postNotification:[[_notifications objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( 0 == indexPath.section )
    {
        return 100;
    }
    else
    {
        return 44.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ( 0 == section )
    {
        return 0;
    }
    return 30.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ( 0 == section )
    {
        return nil;
    }

    BeeUILabel * label = [[BeeUILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 30)];
    label.hintColor = [UIColor purpleColor];
    label.hintString = [_menuTitles objectAtIndex:section];
    return label;
}

#pragma mark - UITableView DataSourceDelegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ( 0 == section )
    {
        return nil;
    }
    
    return [_menuTitles objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * array = [_menus objectAtIndex:section];
    return array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return _menus.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( 0 == indexPath.section )
    {
        BeeUITableViewCell * cell = [[BeeUITableViewCell alloc] init];
        UserCell_iPhone * cellContentView = [[UserCell_iPhone alloc] init];
        cellContentView.frame = CGRectMake(0, 0, tableView.width, [self tableView:self.tableView heightForRowAtIndexPath:indexPath]);
        [cell.contentView addSubview:cellContentView];
        return [cell autorelease];
    }
    else
    {
        BeeUITableViewCell * cell = [self dequeueWithContentClass:[UITableViewCell class]];
        cell.hintString = [[_menus objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        return cell;
    }
    
    return nil;
}

@end
