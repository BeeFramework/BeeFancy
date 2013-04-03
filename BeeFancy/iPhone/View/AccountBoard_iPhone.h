//
//  AccountBoard_iPhone.h
//  BeeFancy
//
//  Created by QFish on 3/23/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "Bee_UIBoard.h"

@interface Tabs_iPhone : BeeUIGridCell
{
    BeeUIButton * _tab1;
    BeeUIButton * _tab2;
    BeeUIButton * _tab3;
    BeeUIButton * _tab4;
}

AS_SIGNAL( TAB )

@end

@interface TabViewsCellOne_iPhone : BeeUIGridCell
{
    BeeUIImageView  * _photo;
    BeeUILabel * _label1;
    BeeUILabel * _label2;
}

@end

@interface TabViewsCellTwo_iPhone : BeeUIGridCell
{
    BeeUIScrollView * _horiScroll;
    BeeUILabel * _label1;
    BeeUILabel * _label2;
    NSMutableArray * _data;
}

@end

@interface TabViewsCellThree_iPhone : BeeUIGridCell
{
    BeeUIImageView  * _photo;
    BeeUILabel * _label1;
    BeeUILabel * _label2;
    BeeUIButton * _button;
}

@end

@interface TabViewsCellFour_iPhone : TabViewsCellThree_iPhone
{
}

@end

typedef NS_ENUM(NSInteger, TabViewStyle) {
    TabViewStyleOne = 0,
    TabViewStyleTwo = 1,
    TabViewStyleThree = 2,
    TabViewStyleFour = 3
};

@interface TabViews_iPhone : BeeUIGridCell
{
    BeeUIScrollView * _scrollView;
    NSMutableArray *  _data;
}

@property (nonatomic, assign) TabViewStyle tabViewStyle;

- (void)reload;

@end

@interface AccountBoard_iPhone : BeeUIBoard
{
    BeeUIImageView  * _photo;
    BeeUILabel      * _label1;
    BeeUILabel      * _label2;
    Tabs_iPhone     * _tabs;
    TabViews_iPhone * _tabViews;
}

@end
