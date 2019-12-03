//
//  TourStepper.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "TourStepper.h"

@interface TourStepper()<UITextFieldDelegate>

@property (copy , nonatomic) void (^valueChanged)(double value);
@property (strong , nonatomic) UIButton *leftButton;
@property (strong , nonatomic) UIButton *rightButton;
@property (strong , nonatomic) UIView *rightPlaceView;
@property(nonatomic,strong)UITextField *labelTextField;


@end

@implementation TourStepper

+ (instancetype)stepper
{
    return [[[self class] alloc] init];
}

- (instancetype)init
{
    if(self = [super init])
    {
        self.minimumValue = 0;
        self.maximumValue = 100000;
        self.stepValue = 1;
        self.value = 0;
        self.tintColor = [UIColor lightGrayColor];
        
        //加载UI
        [self initInterfacce];
    }
    
    return self;
}

+ (instancetype)stepperWithValueChanged:(void (^)(double))valueChanged
{
    return [[[self class] alloc] initWithValueChange:valueChanged];
}

- (instancetype)initWithValueChange:(void (^)(double))valueChanged
{
    if(self = [super init])
    {
        self.minimumValue = 0;
        self.maximumValue = 100000;
        self.stepValue = 1;
        self.value = 0;
        self.tintColor = [UIColor lightGrayColor];
        //响应
        self.valueChanged = ^(double value){
//            OBJC_BLOCK_EXEC(valueChanged, value);
            if (valueChanged)
            {
                valueChanged(value);
            }
        };
        
        //加载UI
        [self initInterfacce];
    }
    
    return self;
}

- (void)stepValueChanged:(void (^)(double))valueChanged
{
    self.valueChanged = ^(double value){
        if (valueChanged)
        {
            valueChanged(value);
        }
    };
}


- (UIButton *)leftButton
{
    if(!_leftButton)
    {
        _leftButton = [[UIButton alloc] init];
        [_leftButton setTitle:@"-" forState:UIControlStateNormal];
        [_leftButton setTitleColor:[LYTourscoolAPPStyleManager ly_C7D0D9Color] forState:UIControlStateNormal];
        _leftButton.backgroundColor = [LYTourscoolAPPStyleManager ly_F1F1F1Color];
        [_leftButton addTarget:self action:@selector(subb:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _leftButton;
}

- (UIButton *)rightButton
{
    if(!_rightButton)
    {
        _rightButton = [[UIButton alloc] init];
        [_rightButton setTitle:@"+" forState:UIControlStateNormal];
        [_rightButton setTitleColor:[LYTourscoolAPPStyleManager ly_19A8C7Color] forState:UIControlStateNormal];
        _rightButton.backgroundColor = [LYTourscoolAPPStyleManager ly_F1F1F1Color];
        [_rightButton addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _rightButton;
}

- (UIView *)rightPlaceView
{
    if (!_rightPlaceView)
    {
        _rightPlaceView = [[UIView alloc] init];
        _rightPlaceView.backgroundColor = [LYTourscoolAPPStyleManager ly_C7D0D9Color];
        _rightPlaceView.layer.borderColor = [LYTourscoolAPPStyleManager ly_C7D0D9Color].CGColor;
        _rightPlaceView.layer.borderWidth = 1.f;
        _rightPlaceView.layer.cornerRadius = 4.f;
        _rightPlaceView.layer.masksToBounds = YES;
    }
    return _rightPlaceView;
}


- (UITextField *)labelTextField
{
    if (!_labelTextField)
    {
        _labelTextField = [[UITextField alloc]init];
        _labelTextField.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
        _labelTextField.textAlignment = NSTextAlignmentCenter;
        _labelTextField.backgroundColor = [UIColor whiteColor];
        _labelTextField.borderStyle = UITextBorderStyleNone;
        _labelTextField.returnKeyType = UIReturnKeyDone;
        _labelTextField.keyboardType = UIKeyboardTypeNumberPad;
        _labelTextField.text = [NSString stringWithFormat:@"%lg",self.value];
    }
    return _labelTextField;

}

- (void)setIsUserInterRect:(BOOL)isUserInterRect
{
    _isUserInterRect = isUserInterRect;
    self.labelTextField.userInteractionEnabled = isUserInterRect;

}



- (void)layoutSubviews
{
    [super layoutSubviews];
    //布局
    CGSize size = self.frame.size;
    
    self.labelTextField.frame = CGRectMake(0, 0, size.width * 0.5, size.height);
    self.rightPlaceView.frame = CGRectMake(size.width * 0.5, 0, size.width * 0.5, size.height);
    self.leftButton.frame = CGRectMake(0, 0, self.rightPlaceView.width * 0.5 - 0.5, self.rightPlaceView.height);
    self.rightButton.frame = CGRectMake(self.rightPlaceView.width * 0.5 + 0.5, 0, self.rightPlaceView.width * 0.5 - 0.5, self.rightPlaceView.height);

}

- (void)initInterfacce
{
    self.backgroundColor = [UIColor clearColor];
    //加载UI
    [self addSubview:self.labelTextField];
    self.labelTextField.delegate = self;
    [self addSubview:self.rightPlaceView];
    [self.rightPlaceView addSubview:self.leftButton];
    [self.rightPlaceView addSubview:self.rightButton];
}


- (void)setTintColor:(UIColor *)tintColor
{
    _tintColor = tintColor;
    self.leftButton.layer.borderColor = [self.tintColor CGColor];
    self.rightButton.layer.borderColor = [self.tintColor CGColor];
 
}

- (void)setValue:(double)value
{
    _value = value;
    self.labelTextField.text = [NSString stringWithFormat:@"%lg",self.value];
}

- (void)subb:(UIButton *)sender
{
    //减
    if(self.value > self.minimumValue)
    {
        self.value -= self.stepValue;
        if(self.valueChanged)
        {
            self.valueChanged(self.value);
        }
    }
    self.labelTextField.text = [NSString stringWithFormat:@"%lg",self.value];
}

- (void)add:(UIButton *)sender
{
    //加
    if(self.value < self.maximumValue)
    {
        self.value += self.stepValue;
        if(self.valueChanged)
        {
            self.valueChanged(self.value);
        }
    }
    self.labelTextField.text = [NSString stringWithFormat:@"%lg",self.value];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.text = @"";
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.value = textField.text.doubleValue;
    if(self.valueChanged)
    {
        self.valueChanged(self.value);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.value = textField.text.doubleValue;
    if(self.valueChanged)
    {
        self.valueChanged(self.value);
    }

    return [textField resignFirstResponder];
}
@end
