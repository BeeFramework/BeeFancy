//
//  LoginBoard_iPhone.m
//  BeeFancy
//
//  Created by QFish on 3/22/13.
//  Copyright (c) 2013 QFish. All rights reserved.
//

#import "LoginBoard_iPhone.h"

#pragma mark - TextInputCell_iPhone

@implementation TextInputCell_iPhone

- (void)layoutInBound:(CGSize)bound forCell:(BeeUIGridCell *)cell
{
    [super layoutInBound:bound forCell:cell];
    _label.frame = CGRectMake( 0, 0, 60, bound.height );
    _input.frame = CGRectMake( 60, 0, bound.width - 60, bound.height );
}

- (void)load
{
    [super load];
    
    _label = [[BeeUILabel alloc] init];
    _label.hintString = @"Label";
    [self addSubview:_label];
    
    _input = [[BeeUITextField alloc] init];
    _input.hintString = @"Input";
    _input.hintColor = [UIColor blueColor];
    [self addSubview:_input];
}

- (void)unload
{
    
    [super unload];
}

@end


#pragma mark - TextInputPanel_iPhone

@implementation TextInputPanel_iPhone

DEF_SIGNAL( LEFT )
DEF_SIGNAL( RIGHT )

- (void)layoutInBound:(CGSize)bound forCell:(BeeUIGridCell *)cell
{
    _title.frame    = CGRectMake( 63, 9, 161, 26 );
    _leftBtn.frame  = CGRectMake( 10, 9, 42, 26 );
    _rightBtn.frame = CGRectMake( 236, 9, 42, 26 );
}

- (void)load
{
    _leftBtn = [[BeeUIButton alloc] init];
    [self addSubview:_leftBtn];
    
    _rightBtn = [[BeeUIButton alloc] init];
    [self addSubview:_rightBtn];
    
    _title = [[BeeUILabel alloc] init];
    [self addSubview:_title];
    
    _inputPanel = [[BeeUIGridCell alloc] init];
    [self addSubview:_inputPanel];
    
    [_leftBtn addSignal:[TextInputPanel_iPhone LEFT] forControlEvents:UIControlEventTouchUpInside object:[[self class] description]];
    [_rightBtn addSignal:[TextInputPanel_iPhone RIGHT] forControlEvents:UIControlEventTouchUpInside object:[[self class] description]];
}

- (void)unload
{
    SAFE_RELEASE_SUBVIEW( _leftBtn );
    SAFE_RELEASE_SUBVIEW( _rightBtn );
    SAFE_RELEASE_SUBVIEW( _title );
    SAFE_RELEASE_SUBVIEW( _inputPanel );
}

@end

#pragma mark - SignInCell_iPhone

@implementation SignInCell_iPhone

- (void)layoutInBound:(CGSize)bound forCell:(BeeUIGridCell *)cell
{
    [super layoutInBound:bound forCell:cell];
    
    _input1.frame = CGRectMake(0, 0, 280, 46);
    _input2.frame = CGRectMake(0, 50, 280, 46);
    _input3.frame = CGRectMake(0, 104, 280, 46);
    _input4.frame = CGRectMake(0, 160, 280, 46);
    _photo.frame = CGRectMake( 100, 65, 85, 85);
    self.inputPanel.frame = CGRectMake(10, 175, bound.width - 20, 220);
}

- (void)load
{
    [super load];

    _photo = [[BeeUIButton alloc] init];
    _photo.hintString = @"Photo";
    [self addSubview:_photo];
    
    _input1 = [[TextInputCell_iPhone alloc] init];
    [self.inputPanel addSubview:_input1];
    _input2 = [[TextInputCell_iPhone alloc] init];
    [self.inputPanel addSubview:_input2];
    _input3 = [[TextInputCell_iPhone alloc] init];
    [self.inputPanel addSubview:_input3];
    _input4 = [[TextInputCell_iPhone alloc] init];
    [self.inputPanel addSubview:_input4];
    
    _input1.label.hintString = @"用户名";
    _input1.input.hintString = @"需要";
    
    _input2.label.hintString = @"密码";
    _input2.input.hintString = @"需要";
    
    self.rightBtn.hintString = @"提交";
    self.leftBtn.hintString = @"Back";
    self.title.hintString = @"注册";

}

- (void)unload
{
    SAFE_RELEASE_SUBVIEW( _photo );
    SAFE_RELEASE_SUBVIEW( _input1 );
    SAFE_RELEASE_SUBVIEW( _input2 );
    SAFE_RELEASE_SUBVIEW( _input3 );
    SAFE_RELEASE_SUBVIEW( _input4 );

    [super unload];
}

@end

#pragma mark - LoginCell

@implementation LoginCell_iPhone

- (void)layoutInBound:(CGSize)bound forCell:(BeeUIGridCell *)cell
{
    [super layoutInBound:bound forCell:cell];
    
    _input1.frame = CGRectMake(0, 0, 280, 46);
    _input2.frame = CGRectMake(0, 50, 280, 46);
    _description.frame = CGRectMake(0,0,0,0);
    self.inputPanel.frame = CGRectMake(10, 65, bound.width - 20, 100);
}

- (void)load
{
    [super load];
    
    _description = [[BeeUILabel alloc] init];
    _description.hintString = @"注册描述";
    [self addSubview:_description];
    
    _input1 = [[TextInputCell_iPhone alloc] init];
    [self.inputPanel addSubview:_input1];
    _input2 = [[TextInputCell_iPhone alloc] init];
    [self.inputPanel addSubview:_input2];
    
    _input1.label.hintString = @"用户名";
    _input1.input.hintString = @"需要";
    
    _input2.label.hintString = @"密码";
    _input2.input.hintString = @"需要";
    
    self.rightBtn.hintString = @"登录";
    self.leftBtn.hintString = @"Back";
    self.title.hintString = @"Login";
}

- (void)unload
{
    SAFE_RELEASE_SUBVIEW( _description );
    SAFE_RELEASE_SUBVIEW( _input1 );
    SAFE_RELEASE_SUBVIEW( _input2 );
    
    [super unload];
}

@end

#pragma mark - LoginBoard

@implementation LoginBoard_iPhone

DEF_SIGNAL( SNS1 )
DEF_SIGNAL( SNS2 )
DEF_SIGNAL( SNS3 )
DEF_SIGNAL( GETSTARTED )
DEF_SIGNAL( SIGNIN )

#pragma mark [B] UISignal

// BeeUIBoard signal goes here
- (void)handleUISignal_BeeUIBoard:(BeeUISignal *)signal
{
	[super handleUISignal:signal];
	
	if ( [signal is:BeeUIBoard.CREATE_VIEWS] )
	{
        self.view.backgroundColor = [UIColor whiteColor];
        
		_logo = [[BeeUIGridCell alloc] init];
        _logo.hintString = @"Fancy";
        [self.view addSubview:_logo];
        
        _sns1 = [[BeeUIButton alloc] init];
        _sns1.hintString =@"Sign In with Facebook";
        [self.view addSubview:_sns1];
        
        _sns2 = [[BeeUIButton alloc] init];
        _sns2.hintString = @"Twitter";
        [self.view addSubview:_sns2];
        
        _sns3 = [[BeeUIButton alloc] init];
        _sns3.hintString = @"Google";
        [self.view addSubview:_sns3];
        
        _getStarted = [[BeeUIButton alloc] init];
        _getStarted.hintString = @"注册";
        [self.view addSubview:_getStarted];
        
        _signIn = [[BeeUIButton alloc] init];
        _signIn.hintString = @"登录";
        [self.view addSubview:_signIn];
        
        [_sns1 addSignal:[LoginBoard_iPhone SNS1] forControlEvents:UIControlEventTouchUpInside];
        [_sns2 addSignal:[LoginBoard_iPhone SNS2] forControlEvents:UIControlEventTouchUpInside];
        [_sns3 addSignal:[LoginBoard_iPhone SNS3] forControlEvents:UIControlEventTouchUpInside];
        [_getStarted addSignal:[LoginBoard_iPhone GETSTARTED] forControlEvents:UIControlEventTouchUpInside];
        [_signIn addSignal:[LoginBoard_iPhone SIGNIN] forControlEvents:UIControlEventTouchUpInside];
	}
	else if ( [signal is:BeeUIBoard.DELETE_VIEWS] )
	{
        SAFE_RELEASE_SUBVIEW( _logo );
        SAFE_RELEASE_SUBVIEW( _sns1 );
        SAFE_RELEASE_SUBVIEW( _sns2 );
        SAFE_RELEASE_SUBVIEW( _sns3 );
        SAFE_RELEASE_SUBVIEW( _getStarted );
        SAFE_RELEASE_SUBVIEW( _signIn );
	}
	else if ( [signal is:BeeUIBoard.LAYOUT_VIEWS] )
	{
        CGFloat padding = 10.0f;
//        int widthOne = self.view.width - padding * 2;
        int widthTwo = ( self.view.width - padding * 3 ) / 2;
		// 界面重新布局
        _getStarted.frame = CGRectMake(padding, self.view.bottom - 50 - padding, widthTwo, 50);
        _signIn.frame   = CGRectMake(_getStarted.right + padding, _getStarted.top, widthTwo, _getStarted.height );
        _sns2.frame  = CGRectMake(padding, _getStarted.top - padding - 44, widthTwo, 44);
        _sns3.frame  = CGRectMake(_sns2.right + padding, _sns2.top, widthTwo, 44);
        _sns1.frame  = CGRectMake(padding, _sns2.top - padding - 44, _sns3.right - _sns2.left, 44);
        _logo.frame  = CGRectMake(0, 0, self.view.width, _sns1.top -padding);
    }
}

- (void)handleUISignal_LoginBoard_iPhone:(BeeUISignal *)signal
{
    if ( [signal is:[LoginBoard_iPhone SNS1]] )
    {
        [self showLoginView];
    }
    else if ( [signal is:[LoginBoard_iPhone SNS2]] )
    {
        [self showLoginView];
    }
    else if ( [signal is:[LoginBoard_iPhone SNS3]] )
    {
        [self showLoginView];
    }
    else if ( [signal is:[LoginBoard_iPhone GETSTARTED]] )
    {
        [self showSignInView];
    }
    else if ( [signal is:[LoginBoard_iPhone SIGNIN]] )
    {
        [self showLoginView];
    }
    
}

- (void)handleUISignal_TextInputPanel_iPhone:(BeeUISignal *)signal
{
    if ( [signal is:[TextInputPanel_iPhone LEFT]] )
    {
        [self dismissModalViewAnimated:YES];
    }
    else
    {
        if ( [signal.object isEqual:@"SignInCell_iPhone"] )
        {
            [self presentSuccessTips:@"注册成功\n请登录"];
            [self dismissModalViewAnimated:YES];
        }
        
        if ( [signal.object isEqual:@"LoginCell_iPhone"] )
        {
            [self.parentBoard dismissModalBoardAnimated:YES];
        }
    }
}

#pragma mark - Custom Actions

- (void)showSignInView
{
    _signCell = [[[SignInCell_iPhone alloc] initWithFrame:CGRectMake(0, 0, 288, 390)] autorelease];
    _signCell.hintColor = HEX_RGB(0xffffffff);
    _signCell.center = self.view.center;
    [self presentModalView:_signCell animated:YES];
}

- (void)showLoginView
{
    _loginCell = [[[LoginCell_iPhone alloc] initWithFrame:CGRectMake(0, 0, 288, 170)] autorelease];
    _loginCell.hintColor = HEX_RGB(0xffffffff);
    _loginCell.center = self.view.center;
    [self presentModalView:_loginCell animated:YES];
}

@end
