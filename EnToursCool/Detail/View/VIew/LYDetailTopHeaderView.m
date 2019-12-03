//
//  LYDetailTopHeaderView.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailTopHeaderView.h"
#import "LYDetailViewModel.h"

NSString * const LYDetailTopHeaderViewID = @"LYDetailTopHeaderViewID";

@interface LYDetailTopHeaderView()
@property (weak, nonatomic) IBOutlet UIView *topLineView;

@property (weak, nonatomic) IBOutlet UIButton *specialNotesButton;
@property (weak, nonatomic) IBOutlet UIButton *expenseButton;
@property (weak, nonatomic) IBOutlet UIButton *itineraryButton;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation LYDetailTopHeaderView

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

    
    [self.specialNotesButton setTitleColor:[LYTourscoolAPPStyleManager ly_484848Color] forState:0];
    [self.specialNotesButton setTitleColor:[LYTourscoolAPPStyleManager ly_19A8C7Color] forState:UIControlStateSelected];
    self.specialNotesButton.titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    self.specialNotesButton.tag = 10003;


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
    
    [[self.specialNotesButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       @strongify(viewModel);
       @strongify(self);
        [viewModel.selectTypeButtonCommand execute:@(self.specialNotesButton.tag)];
    }];
    
    [[[RACObserve(viewModel, selectTypeButton) takeUntil:self.rac_prepareForReuseSignal]distinctUntilChanged] subscribeNext:^(NSNumber *  _Nullable x) {
        @strongify(self);
        NSInteger tag = x.integerValue;
        self.itineraryButton.selected = self.itineraryButton.tag == tag;
        self.itineraryButton.userInteractionEnabled = self.itineraryButton.tag != tag;
        
        self.expenseButton.selected = self.expenseButton.tag == tag;
        self.expenseButton.userInteractionEnabled = self.expenseButton.tag != tag;
        
        self.specialNotesButton.selected = self.specialNotesButton.tag == tag;
        self.specialNotesButton.userInteractionEnabled = self.specialNotesButton.tag != tag;

    }];
       
}
@end
