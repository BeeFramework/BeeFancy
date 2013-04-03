//
//  FancyBoard_iPhone.h
//  BeeFancy
//
//  Created by QFish on 3/25/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "Bee_UIBoard.h"

@interface FancyButtons_iPhone : BeeUIGridCell
{
    BeeUIButton     * _btn1;
    BeeUIButton     * _btn2;
    BeeUIButton     * _btn3;
}

AS_SIGNAL( LIKE )
AS_SIGNAL( ADD )
AS_SIGNAL( COMMENT )

@end

@interface FancyBoard_iPhone : BeeUIBoard
{
    BeeUIZoomView       * _zoomImage;
    BeeUIButton         * _titleView;
    BeeUILabel          * _label1;
    BeeUILabel          * _label2;
    FancyButtons_iPhone * _buttons;
}

@end
