//
//  LoginBoard_iPhone.h
//  BeeFancy
//
//  Created by QFish on 3/22/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

//  App      :   Fancy
//  View     :   Login
//  Index    :   001

#import "Bee_UIBoard.h"

@interface TextInputCell_iPhone : BeeUIGridCell

@property (nonatomic, retain) BeeUILabel      * label;
@property (nonatomic, retain) BeeUITextField  * input;

@end

@interface TextInputPanel_iPhone : BeeUIGridCell

@property (nonatomic, retain) BeeUIButton     * leftBtn;
@property (nonatomic, retain) BeeUIButton     * rightBtn;
@property (nonatomic, retain) BeeUILabel      * title;
@property (nonatomic, retain) BeeUIGridCell   * inputPanel;

AS_SIGNAL( LEFT )
AS_SIGNAL( RIGHT )

@end

@interface SignInCell_iPhone : TextInputPanel_iPhone
{
    TextInputCell_iPhone * _input1, * _input2, * _input3, * _input4;
    BeeUIButton * _photo;
}

@end

@interface LoginCell_iPhone : TextInputPanel_iPhone
{
    TextInputCell_iPhone * _input1, * _input2;
    BeeUILabel * _description;
}

@end

@interface LoginBoard_iPhone : BeeUIBoard
{
    BeeUIGridCell   * _logo;
    BeeUIButton     * _sns1;
    BeeUIButton     * _sns2;
    BeeUIButton     * _sns3;
    BeeUIButton     * _getStarted;
    BeeUIButton     * _signIn;
    
    SignInCell_iPhone * _signCell;
    LoginCell_iPhone  * _loginCell;
}

AS_SIGNAL( SNS1 )
AS_SIGNAL( SNS2 )
AS_SIGNAL( SNS3 )
AS_SIGNAL( GETSTARTED )
AS_SIGNAL( SIGNIN )

@end
