//
//  LYDetailTopView.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailTopView.h"
#import "LYDetailViewModel.h"

@interface LYDetailTopView()
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIButton *itineraryButton;
@property (weak, nonatomic) IBOutlet UIButton *expenseButton;
@property (weak, nonatomic) IBOutlet UIButton *specialnotesButton;

@end

@implementation LYDetailTopView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.itineraryButton setTitleColor:[LYTourscoolAPPStyleManager ly_484848Color] forState:0];
    [self.itineraryButton setTitleColor:[LYTourscoolAPPStyleManager ly_19A8C7Color] forState:UIControlStateSelected];
    self.itineraryButton.titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    self.itineraryButton.tag = 10001;
    
    [self.expenseButton setTitleColor:[LYTourscoolAPPStyleManager ly_484848Color] forState:0];
    [self.expenseButton setTitleColor:[LYTourscoolAPPStyleManager ly_19A8C7Color] forState:UIControlStateSelected];
    self.expenseButton.titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    self.expenseButton.tag = 10002;

    
    [self.specialnotesButton setTitleColor:[LYTourscoolAPPStyleManager ly_484848Color] forState:0];
    [self.specialnotesButton setTitleColor:[LYTourscoolAPPStyleManager ly_19A8C7Color] forState:UIControlStateSelected];
    self.specialnotesButton.titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    self.specialnotesButton.tag = 10003;


    self.lineView.backgroundColor = [LYTourscoolAPPStyleManager ly_lineColor];
}

- (void)dataDidChange {
    LYDetailViewModel *viewModel = self.data;
    @weakify(self);
    @weakify(viewModel);
    
    [[self.itineraryButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           @strongify(viewModel);
           @strongify(self);
           [viewModel.selectTypeButtonCommand execute:@(self.itineraryButton.tag)];
    }];
    
    [[self.expenseButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           @strongify(viewModel);
           @strongify(self);
           [viewModel.selectTypeButtonCommand execute:@(self.expenseButton.tag)];
       }];
    
    [[self.specialnotesButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       @strongify(viewModel);
       @strongify(self);
       [viewModel.selectTypeButtonCommand execute:@(self.specialnotesButton.tag)];
    }];
    
    [[RACObserve(viewModel, selectTypeButton)distinctUntilChanged] subscribeNext:^(NSNumber *  _Nullable x) {
        @strongify(self);
        NSInteger tag = x.integerValue;
        self.itineraryButton.selected = self.itineraryButton.tag == tag;
        self.itineraryButton.userInteractionEnabled = self.itineraryButton.tag != tag;
        
        self.expenseButton.selected = self.expenseButton.tag == tag;
        self.expenseButton.userInteractionEnabled = self.expenseButton.tag != tag;
        
        self.specialnotesButton.selected = self.specialnotesButton.tag == tag;
        self.specialnotesButton.userInteractionEnabled = self.specialnotesButton.tag != tag;

    }];
       
}
@end
