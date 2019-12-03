//
//  LYOrderDetailTravelPackageTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYOrderDetailTravelPackageTableViewCell.h"
#import "LYOrderDetailInfoModel.h"

NSString * const LYOrderDetailTravelPackageTableViewCellID = @"LYOrderDetailTravelPackageTableViewCellID";

@interface LYOrderDetailTravelPackageTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *productIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueAddServicesTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueAddServicesLabel;
@property (weak, nonatomic) IBOutlet UILabel *travelerLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactEmailLabel;

@property (weak, nonatomic) IBOutlet UILabel *arrivalFlightInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalAirlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalFlightNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalLandingAirportLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *departureFlightInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureAirlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureFlightNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureLandingAirportLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureTimeLabel;

@end

@implementation LYOrderDetailTravelPackageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    @weakify(self);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
       [[tap rac_gestureSignal] subscribeNext:^(id x) {
           @strongify(self);
           
       }];
       [self.productTitleLabel addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dataDidChange{
    LYOrderDetailTravelPackageModel *model = self.data;
    self.orderStatusLabel.text = model.orderStatus;

    self.productIDLabel.text = model.productID;
    self.dateLabel.text = model.date;

    self.travelerLabel.text = model.traveler;
    self.contactNameLabel.text = model.name;
    self.contactPhoneLabel.text = model.phone;
    self.contactEmailLabel.text = model.email;
    
    if (model.valueAddedService.length > 0) {
        self.valueAddServicesLabel.text = model.valueAddedService;
//        self.valueAddServicesLabel.hidden = NO;
//        self.valueAddServicesTitleLabel.hidden = NO;
    }else{
//        self.valueAddServicesLabel.hidden = YES;
//        self.valueAddServicesTitleLabel.hidden = YES;
        [self.valueAddServicesTitleLabel removeFromSuperview];
        [self.valueAddServicesLabel removeFromSuperview];
    }
    
    if(model.productTitle.length > 0){
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:model.productTitle];
        NSRange titleRange = {0,[title length]};
        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
        [title addAttribute:NSForegroundColorAttributeName value:[LYTourscoolAPPStyleManager ly_19A8C7Color] range:titleRange];
        self.productTitleLabel.attributedText = title;
        [self.productTitleLabel setFont:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    }
    
    if (model.isFlight ) {
        self.arrivalFlightInfoLabel.hidden = NO;
        self.arrivalAirlineLabel.hidden = NO;
        self.arrivalFlightNumLabel.hidden = NO;
        self.arrivalLandingAirportLabel.hidden = NO;
        self.arrivalTimeLabel.hidden = NO;
        self.departureFlightInfoLabel.hidden = NO;
        self.departureAirlineLabel.hidden = NO;
        self.departureFlightNumberLabel.hidden = NO;
        self.departureLandingAirportLabel.hidden = NO;
        self.departureTimeLabel.hidden = NO;
        
        self.arrivalAirlineLabel.text = model.arrivalAirline;
        self.arrivalFlightNumLabel.text = model.arrivalFlightNumber;
        self.arrivalLandingAirportLabel.text = model.arrivalLandingAirport;
        self.arrivalTimeLabel.text = model.arrivalTime;
        self.departureAirlineLabel.text = model.departureAirline;
        self.departureFlightNumberLabel.text = model.departureFlightNumber;
        self.departureLandingAirportLabel.text = model.departureLandingAirport;
        self.departureTimeLabel.text = model.departureTime;

    }else{
        self.arrivalFlightInfoLabel.hidden = YES;
        self.arrivalAirlineLabel.hidden = YES;
        self.arrivalFlightNumLabel.hidden = YES;
        self.arrivalLandingAirportLabel.hidden = YES;
        self.arrivalTimeLabel.hidden = YES;
        self.departureFlightInfoLabel.hidden = YES;
        self.departureAirlineLabel.hidden = YES;
        self.departureFlightNumberLabel.hidden = YES;
        self.departureLandingAirportLabel.hidden = YES;
        self.departureTimeLabel.hidden = YES;
    }

}

@end
