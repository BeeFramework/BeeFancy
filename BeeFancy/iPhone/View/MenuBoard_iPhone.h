//
//  MenuBoard_iPhone.h
//  BeeFancy
//
//  Created by QFish on 3/25/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "Bee_UITableBoard.h"

@interface UserCell_iPhone : BeeUIGridCell
{
    BeeUIImageView  * _avatar;
    BeeUILabel      * _label1;
    BeeUILabel      * _label2;
}

@end

@interface MenuBoard_iPhone : BeeUITableBoard
{
    NSMutableArray * _menuTitles;
    NSMutableArray * _menus;
    NSMutableArray * _notifications;
}

@end
