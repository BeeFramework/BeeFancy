//
//  IndexBoard_iPhone.h
//  BeeFancy
//
//  Created by QFish on 3/22/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "Bee_UIBoard.h"

@interface Fancy_iPhone : BeeUIGridCell
{
    BeeUIImageView  * _photo;
    BeeUILabel      * _title;
    BeeUILabel      * _label1;
    BeeUILabel      * _label2;
    BeeUIButton     * _btn1;
    BeeUIButton     * _btn2;
    BeeUIButton     * _btn3;
}

AS_SIGNAL( TOUCHED )

@end

@interface IndexBoard_iPhone : BeeUIBoard
{
    BeeUIScrollView * _scrollView;
    NSMutableArray  * _data;
}

@end
