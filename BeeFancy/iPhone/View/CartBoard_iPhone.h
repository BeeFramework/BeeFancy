//
//  CartBoard_iPhone.h
//  BeeFancy
//
//  Created by QFish on 3/25/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "Bee_UITableBoard.h"

@interface CartDetail_Part1_iPhone : BeeUIGridCell
{
    BeeUILabel      * _title;
    BeeUIImageView  * _photo;
    BeeUILabel      * _label1;
    BeeUILabel      * _label2;
    BeeUILabel      * _label3;
    BeeUILabel      * _label4;
    BeeUILabel      * _label5;
    BeeUIButton     * _button;
}

@end

@interface CartDetail_Part2_Cell_iPhone : BeeUIGridCell
{
    BeeUILabel      * _label;
    BeeUIButton     * _button;
}

@end

@interface CartDetail_Part2_iPhone : BeeUIGridCell
{
    BeeUILabel      * _title;
    BeeUILabel      * _subTitle;
    CartDetail_Part2_Cell_iPhone * _cell1;
    CartDetail_Part2_Cell_iPhone * _cell2;
}

@end

@interface CartDetail_Part3_Cell_iPhone : BeeUIGridCell
{
    BeeUILabel      * _title;
    BeeUILabel      * _content;
}

@end

@interface CartDetail_Part3_iPhone : BeeUIGridCell
{
    BeeUILabel      * _title;
    BeeUILabel      * _subTitle;
    CartDetail_Part3_Cell_iPhone * cell1;
    CartDetail_Part3_Cell_iPhone * cell2;
    CartDetail_Part3_Cell_iPhone * cell3;
    BeeUILabel      * _label1;
    BeeUILabel      * _label2;
    BeeUIButton     * _button;
}

@end

@interface CartBoard_iPhone : BeeUITableBoard
{
    
}

@end
