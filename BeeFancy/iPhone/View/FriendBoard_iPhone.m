//
//  FriendBoard_iPhone.m
//  BeeFancy
//
//  Created by QFish on 3/26/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "FriendBoard_iPhone.h"
#import "AccountBoard_iPhone.h"

#pragma mark -

@implementation FriendBoard_iPhone

- (void)load
{
	[super load];
    
    _titles = [[NSMutableArray alloc] init];
    [_titles addObjectsFromArray:@[@"Add", @"A", @"B"]];
    
    _data = [[NSMutableArray alloc] init];
    [_data addObject:@[ @"联系人", @"Facebook", @"Twitter", @"Google+" ]];
    
    NSMutableArray * array = [[NSMutableArray alloc] init];
    int i = 0;
    for (;;)
    {
        [array addObject:@(1)];
        if ( i++>10 )
            break;
    }
    [_data addObject:array];
    [array release];
    
    [_data addObject:@[ @"选项 - 1", @"选项 - 2" ]];
}

- (void)unload
{
    // TODO
    
    [_data removeAllObjects];
    [_data release];
    
    [_titles removeAllObjects];
    [_titles release];
    
	[super unload];
}

#pragma mark [B] UISignal

- (void)handleUISignal_BeeUIBoard:(BeeUISignal *)signal
{
	[super handleUISignal:signal];
	
	if ( [signal is:BeeUIBoard.CREATE_VIEWS] )
	{
        self.titleString = @"Friends";
        self.view.backgroundColor = [UIColor whiteColor];
        self.searchBarStyle = BeeUITableBoard.SEARCHBAR_STYLE_TOP;
        self.searchBar.hidden = NO;
        self.tableView.showsVerticalScrollIndicator = NO;
        
        [self showNavigationBarAnimated:NO];
        [self showBarButton:UINavigationBar.BARBUTTON_LEFT title:@"菜单"];
	}
}

- (void)handleUISignal_UINavigationBar:(BeeUISignal *)signal
{
	if ( [signal is:UINavigationBar.BARBUTTON_LEFT_TOUCHED] )
	{
        [[AppBoard_iPhone sharedInstance] showMenu];
	}
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( 1 == indexPath.section )
    {
        return 50;
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
    return 20.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ( 0 == section )
    {
        return nil;
    }
    
    BeeUILabel * label = [[BeeUILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 30)];
    label.hintColor = [UIColor blackColor];
    label.hintString = [_titles objectAtIndex:section];
    return label;
}

#pragma mark - UITableView DataSourceDelegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ( 0 == section )
    {
        return nil;
    }
    
    return [_titles objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_data objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( 0 == indexPath.section )
    {
        BeeUITableViewCell * cell = [[BeeUITableViewCell alloc] init];
        cell.hintString = [[_data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        return [cell autorelease];
    }
    else if ( 1 == indexPath.section )
    {
        BeeUITableViewCell * cell = [self dequeueWithContentClass:[TabViewsCellThree_iPhone class]];
        return cell;
    }
    else if ( 2 == indexPath.section )
    {
        BeeUITableViewCell * cell = [self dequeueWithContentClass:[BeeUITableViewCell class]];
        cell.hintString = [[_data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        return cell;
    }
    
    return nil;
}

@end
