//
//  LYDateView.m
//  ToursCool
//
//  Created by tourscool on 12/29/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYDateView.h"

@interface LYDateView ()
@property (nonatomic, weak) IBOutlet UIDatePicker * datePicker;
@property (nonatomic, weak) IBOutlet UIButton * cancelButton;
@property (nonatomic, weak) IBOutlet UIButton * affirmButton;
@end

@implementation LYDateView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
    self.datePicker.maximumDate = [NSDate new];
    self.datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    @weakify(self);
    [[self.cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self removeFromSuperview];
    }];
    
    [[self.affirmButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.userSelectDateBlock) {
            self.userSelectDateBlock(self.datePicker.date);
        }
        [self removeFromSuperview];
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self removeFromSuperview];
}


- (void)customSetPicker{
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    self.datePicker.minimumDate = [NSDate new];
    self.datePicker.maximumDate = nil;
}

@end
