//
//  CategoryBoard_iPhone.m
//  BeeFancy
//
//  Created by QFish on 3/26/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "CategoryBoard_iPhone.h"

#pragma mark -

@implementation CategoryBoard_iPhone

- (void)load
{
	[super load];
    
    _menuTitles = [[NSMutableArray alloc] init];
    _menus = [[NSMutableArray alloc] init];
}

- (void)unload
{
    [_menuTitles removeAllObjects];
    [_menuTitles release];
    
    [_menus removeAllObjects];
    [_menus release];
    
   	[super unload];
}

+ (CGSize)sizeInBound:(CGSize)bound forData:(NSObject *)data
{
    return CGSizeMake( kMenuWidth, bound.height );
}

#pragma mark [B] UISignal

- (void)handleUISignal_BeeUIBoard:(BeeUISignal *)signal
{
	[super handleUISignal:signal];
	
	if ( [signal is:BeeUIBoard.CREATE_VIEWS] )
	{
        [self showNavigationBarAnimated:NO];
        self.tableView.showsVerticalScrollIndicator = NO;
	}
	else if ( [signal is:BeeUIBoard.DELETE_VIEWS] )
	{
	}
	else if ( [signal is:BeeUIBoard.LAYOUT_VIEWS] )
	{
        self.tableView.width = self.view.width;
        self.searchBar.width = self.view.width;
	}
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self postNotification:AppBoard_iPhone.SWITCH_INDEX];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BeeUILabel * label = [[BeeUILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 30)];
    label.hintColor = [UIColor blackColor];
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
    BeeUITableViewCell * cell = [self dequeueWithContentClass:[UITableViewCell class]];
    cell.hintString = [[_menus objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return cell;
}

@end
