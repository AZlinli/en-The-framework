//
//  LYSelectDateCalendarCell.m
//  ToursCool
//
//  Created by tourscool on 11/1/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYSelectDateCalendarCell.h"
#import "LYSelectDatePriceModel.h"
#import <EventKit/EventKit.h>
NSString * const LYSelectDateCalendarCellID = @"LYSelectDateCalendarCellID";

@interface LYSelectDateCalendarCell()
@property (strong, nonatomic) EKEvent *event;
@property (strong, nonatomic) LYSelectDatePriceModel *selectDatePriceModel;
@property (nonatomic, strong) UIImageView *tagImv;

@end

@implementation LYSelectDateCalendarCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        CALayer *selectionLayer = [[CALayer alloc] init];
        selectionLayer.backgroundColor = [LYTourscoolAPPStyleManager ly_19A8C7ColorAlpha:0.2].CGColor;
        selectionLayer.cornerRadius = 6.f;
        selectionLayer.actions = @{@"hidden":[NSNull null]};
        selectionLayer.hidden = YES;
        [self.contentView.layer insertSublayer:selectionLayer below:self.titleLabel.layer];
        self.selectionLayer = selectionLayer;
        self.shapeLayer.hidden = YES;
        
        UILabel * label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        label.textColor = [LYTourscoolAPPStyleManager ly_C9C9C9Color];
        label.font = [UIFont obtainPingFontWithStyle:LYPingFangSCLight size:10.f];
        label.textAlignment = NSTextAlignmentCenter;
//        label.adjustsFontSizeToFitWidth = YES;
//        self.dateEventLabel = label;
        
        //添加特价标签
        UIImageView *tagImv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redTag"]];
        [self addSubview:tagImv];
        self.tagImv = tagImv;
        self.tagImv.hidden = YES;
        
        if (self.eventIndicator) {
            [self.eventIndicator removeFromSuperview];
        }
        UILabel * priceLabel = [[UILabel alloc] init];
        [self.contentView addSubview:priceLabel];
        priceLabel.textColor = [LYTourscoolAPPStyleManager ly_3D3D3DColor];
        priceLabel.font = [UIFont obtainPingFontWithStyle:LYPingFangSCLight size:10.f];
        priceLabel.textAlignment = NSTextAlignmentCenter;
        priceLabel.adjustsFontSizeToFitWidth = YES;
//        priceLabel.text = @"$9999";
        self.priceLabel = priceLabel;
        [self setPriceLabelFont:NO];
//        self.priceLabel.backgroundColor = [UIColor blueColor];
        
    }
    return self;
}

- (void)setPriceLabelTextWithTitle:(NSString *)title
{
    if (title.length)
    {
        self.priceLabel.text = title;
//        //处理特价
//        [self setItemSpecial:self.selectDatePriceModel.isSpecial.boolValue];

    }else{
        self.priceLabel.text = nil;
    }
   
}

- (void)setPriceis:(LYSelectDatePriceModel *)selectDatePriceModel eventTitle:(EKEvent *)event
{
    self.event = event;
    self.selectDatePriceModel = selectDatePriceModel;
}

//- (void)setPriceisSoldout:(NSString *)isSoldout
//{
//    if ([isSoldout integerValue] == 1) {
//        self.priceLabel.textColor = [LYTourscoolAPPStyleManager ly_EC6564Color];
//        [self.titleLabel setValue:[LYTourscoolAPPStyleManager ly_3D3D3DColor] forKey:@"textColor"];
//    }else{
//        self.priceLabel.textColor = [LYTourscoolAPPStyleManager ly_3D3D3DColor];
//        [self.titleLabel setValue:[LYTourscoolAPPStyleManager ly_3D3D3DColor] forKey:@"textColor"];
//    }
//}

- (void)setPriceLabelTextColorWithType:(BOOL)type
{
    if (type) {
        self.priceLabel.textColor = [LYTourscoolAPPStyleManager ly_168FAAColor];
        self.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_168FAAColor];
    }else{
        [self restCellStyleWith:YES];
    }
    [self setPriceLabelFont:type];
}

- (void)layoutSubviews
{
//    self.dateEventLabel.frame = CGRectMake(0, 5.f, CGRectGetWidth(self.bounds), 10.f);
    self.titleLabel.centerY -= 4;
    self.priceLabel.frame = CGRectMake(2.f, 40.f, CGRectGetWidth(self.bounds) - 4.f, 12.f);
    self.tagImv.frame = CGRectMake(self.width - 10, 8, 10, 10);
    [self cellSelect];
    [super layoutSubviews];
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    self.selectionLayer.frame = CGRectMake(0, 8, CGRectGetWidth(self.contentView.bounds), CGRectGetWidth(self.contentView.bounds));
}

- (void)setPriceLabelFont:(BOOL)type
{
    if (type) {
        self.priceLabel.font = [UIFont obtainPingFontWithStyle:LYPingFangSCLight size:11.f];
        self.priceLabel.frame = CGRectMake(-3.f, 40.f, CGRectGetWidth(self.bounds) + 3.f, 12.f);
    }else{
        self.priceLabel.font = [UIFont obtainPingFontWithStyle:LYPingFangSCLight size:9.f];
        self.priceLabel.frame = CGRectMake(2.f, 40.f, CGRectGetWidth(self.bounds) - 4.f, 12.f);
    }
}

- (void)setItemSpecial:(BOOL)type
{
    if (type)
       {
           self.priceLabel.textColor = [LYTourscoolAPPStyleManager ly_EC6564Color];
       }else{
           self.priceLabel.textColor = [LYTourscoolAPPStyleManager ly_3D3D3DColor];
       }
}

- (void)cellSelect
{
    if (self.selected) {
        self.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_168FAAColor];
        self.priceLabel.textColor = [LYTourscoolAPPStyleManager ly_168FAAColor];
        self.selectionLayer.hidden = NO;
        [self setPriceLabelFont:YES];
    }else{
        [self setPriceLabelFont:NO];
        [self restCellStyleWith:YES];
    }
}

- (void)restCellStyleWith:(BOOL)type
{
    self.selectionLayer.hidden = type;
        
    if (self.priceLabel.text.length)
    {
        [self.titleLabel setValue:[LYTourscoolAPPStyleManager ly_3D3D3DColor] forKey:@"textColor"];
        
        if ([self.selectDatePriceModel.isSpecial integerValue] == 1)  //是特价
           {
               self.priceLabel.textColor = [LYTourscoolAPPStyleManager ly_EC6564Color];
               self.tagImv.hidden = NO;
           }else{
               self.priceLabel.textColor = [LYTourscoolAPPStyleManager ly_3D3D3DColor];
               self.tagImv.hidden = YES;
           }
    }else{
        self.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_C9C9C9Color];
    }
}

@end
