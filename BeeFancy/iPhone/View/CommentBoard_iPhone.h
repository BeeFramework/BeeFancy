//
//  CommentBoard_iPhone.h
//  BeeFancy
//
//  Created by QFish on 3/23/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "Bee_UIBoard.h"

@interface HScrollCell_iPhone : BeeUIGridCell
{
    BeeUIImageView  * _avatar;
}

@end

@interface VScrollCell_iPhone : BeeUIGridCell
{
    BeeUIImageView  * _avatar;
    BeeUILabel      * _label1;
    BeeUILabel      * _label2;
}

@end

@interface CommentInput_iPhone : BeeUIGridCell
{
    BeeUITextView   * _textView;
    BeeUIButton     * _send;
}

@end

@interface CommentBoard_iPhone : BeeUIBoard
{
    BeeUILabel      * _label;
    BeeUIScrollView * _horiScroll;
    BeeUIScrollView * _vertScroll;
    CommentInput_iPhone * _input;
    NSMutableArray * _data;
    NSMutableArray * _data2;
}

@end
