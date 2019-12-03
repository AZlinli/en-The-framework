//
//  LYSelectDateTableViewSectionHeaderView.m
//  ToursCool
//
//  Created by tourscool on 11/1/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYSelectDateTableViewHeaderView.h"
#import "LYSelectDatePriceAndMonthCollectionViewCell.h"
#import "LYSelectDateCalendarCell.h"
#import "LYSelectDatePriceAndMonthModel.h"
#import "LYSelectDateViewModel.h"
#import "LYSelectDatePriceModel.h"
#import "LYDateTools.h"
#import <FSCalendar/FSCalendar.h>
#import <EventKit/EventKit.h>

static NSString * DateFormatterString = @"yyyy-MM-dd";
@interface LYSelectDateTableViewHeaderView()<FSCalendarDataSource,FSCalendarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) IBOutlet FSCalendar * calendar;
@property (nonatomic, weak) IBOutlet UICollectionView * monthCollectionView;
@property (nonatomic, strong) NSString * minDateStr;
@property (nonatomic, strong) NSString * maxDateStr;
@property (nonatomic, strong) LYSelectDateViewModel * selectDateViewModel;
@end
@implementation LYSelectDateTableViewHeaderView


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _minDateStr = [LYDateTools dateToStringWithFormatterStr:DateFormatterString date:[NSDate new]];
        _maxDateStr = [LYDateTools dateToStringWithFormatterStr:DateFormatterString date:[[LYDateTools gregorian] dateByAddingUnit:NSCalendarUnitMonth value:3 toDate:[NSDate new] options:NSCalendarMatchStrictly]];
        LYNSLog(@"%@ %@", _minDateStr, _maxDateStr);
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.monthCollectionView registerNib:[UINib nibWithNibName:@"LYSelectDatePriceAndMonthCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:LYSelectDatePriceAndMonthCollectionViewCellID];
    self.monthCollectionView.dataSource = self;
    self.monthCollectionView.delegate = self;
    [self.calendar registerClass:[LYSelectDateCalendarCell class] forCellReuseIdentifier:LYSelectDateCalendarCellID];
    self.calendar.dataSource = self;
    self.calendar.delegate = self;
    self.calendar.today = nil;
    self.calendar.appearance.titleDefaultColor = [LYTourscoolAPPStyleManager ly_191919Color];
    self.calendar.appearance.titlePlaceholderColor = [LYTourscoolAPPStyleManager ly_C9C9C9Color];
    self.calendar.swipeToChooseGesture.enabled = YES;
    self.calendar.placeholderType = FSCalendarPlaceholderTypeNone;
    self.calendar.adjustsBoundingRectWhenChangingMonths = YES;
    self.calendar.firstWeekday = 1;
    self.calendar.appearance.titleFont = [UIFont obtainPingFontWithStyle:LYPingFangSCMedium size:14.f];
    self.calendar.appearance.selectionColor = [LYTourscoolAPPStyleManager ly_4BB1F5Color];
    self.calendar.appearance.titleWeekendColor = [LYTourscoolAPPStyleManager ly_FB605DColor];
    self.calendar.appearance.borderRadius = 0.1;
//    self.calendar.scrollEnabled = NO;
}

- (void)dataDidChange
{
    self.selectDateViewModel = self.data;
    self.minDateStr = [LYDateTools dateToStringWithFormatterStr:DateFormatterString date:self.selectDateViewModel.minimumDate];
    self.maxDateStr = [LYDateTools dateToStringWithFormatterStr:DateFormatterString date:self.selectDateViewModel.maximumDate];
    
    @weakify(self);
    
    [RACObserve(self.calendar, currentPage) subscribeNext:^(NSDate *  _Nullable x) {
        @strongify(self);
        [self.selectDateViewModel.monthArray enumerateObjectsUsingBlock:^(LYSelectDatePriceAndMonthModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.isSelected = NO;
            if ([x compare:obj.date] == NSOrderedSame) {
                obj.isSelected = YES;
            }
        }];
    }];
    
    [RACObserve(self.selectDateViewModel, monthArray) subscribeNext:^(NSArray *  _Nullable x) {
        @strongify(self);
        if (x.count) {
            [self.monthCollectionView reloadData];
        }
    }];
    
    [[RACObserve(self.selectDateViewModel, events) skip:1] subscribeNext:^(NSArray *  _Nullable x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.selectDateViewModel.selectDate) {
                NSString * titleStr = [self.selectDateViewModel obtainPriceWithDate:self.selectDateViewModel.selectDate];
                if (titleStr.length) {
                    [self.calendar selectDate:self.selectDateViewModel.selectDate scrollToDate:YES];
                    [self calculateBackDateWithStarDate:self.selectDateViewModel.selectDate type:YES];
                }
            }else{
                [self calculateBackDateWithStarDate:nil type:NO];
            }
            [self.calendar reloadData];
        });
    }];
    
}

- (void)setCalendarMinDateStr:(NSString *)minDateStr maxDate:(NSString *)maxDateStr
{
    if (minDateStr.length) {
        self.minDateStr = minDateStr;
    }
    if (maxDateStr.length) {
        self.maxDateStr = maxDateStr;
    }
    if (minDateStr.length || maxDateStr.length) {
        [self.calendar reloadData];
    }
}

#pragma mark - FSCalendarDataSource,FSCalendarDelegate

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return self.selectDateViewModel.minimumDate;
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return self.selectDateViewModel.maximumDate;
}

- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date
{
    return nil;
}

- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
{
    if (!self.selectDateViewModel.events){
        return 0;
    }
    NSArray<EKEvent *> *events = [self.selectDateViewModel eventsForDate:date];
    return events.count;
}

- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    LYSelectDateCalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:LYSelectDateCalendarCellID forDate:date atMonthPosition:monthPosition];
    LYSelectDatePriceModel * selectDatePriceModel = [self.selectDateViewModel obtainSelectDatePriceModelWithDate:date];
    NSString * titleStr = [self.selectDateViewModel obtainPriceWithDate:date];
    if (titleStr.length) {
        [cell setPriceLabelTextWithTitle:titleStr];
    }else{
        [cell setPriceLabelTextWithTitle:titleStr];
    }
    if ([selectDatePriceModel.isSoldout integerValue] != 1 && titleStr.length) {
        cell.userInteractionEnabled = YES;
    }else{
        cell.userInteractionEnabled = NO;
    }
    EKEvent *event = [self.selectDateViewModel eventsForDate:date].firstObject;
    [cell setPriceis:selectDatePriceModel eventTitle:event];
//    [cell setItemSpecial:selectDatePriceModel.isSpecial.boolValue];
    
    return cell;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    if ([self.selectDateViewModel obtainPriceWithDate:date]) {
        LYSelectDateCalendarCell *cell = (LYSelectDateCalendarCell *)[calendar cellForDate:date atMonthPosition:monthPosition];
        LYSelectDatePriceModel * model = [self.selectDateViewModel obtainSelectDatePriceModelWithDate:date];
        self.selectDateViewModel.isSpecial = model.isSpecial;
        cell.selectionLayer.hidden = NO;
        [cell setPriceLabelTextColorWithType:YES];
//        [cell setItemSpecial:model.isSpecial.boolValue];
        
        [self calculateBackDateWithStarDate:date type:YES];
    }
}

- (void)calculateBackDateWithStarDate:(NSDate *)starDate type:(BOOL)type
{
    if (type) {
        NSDate * endDate = [[LYDateTools gregorian] dateByAddingUnit:NSCalendarUnitDay value:[self.selectDateViewModel.durationDays integerValue]-1 toDate:starDate options:NSCalendarMatchStrictly];
        NSString * nowDateStr = [LYDateTools dateToStringWithFormatterStr:@"MM月dd日" date:starDate];
        NSString * endDateStr = [LYDateTools dateToStringWithFormatterStr:@"MM月dd日" date:endDate];
        self.selectDateViewModel.selectDate = starDate;
//        [[NSUserDefaults standardUserDefaults] setObject:starDate forKey:@"UserSelelctDate"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        self.selectDateViewModel.selectDate = nil;
    }
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    if ([self.selectDateViewModel obtainPriceWithDate:date]) {
        LYSelectDateCalendarCell *cell = (LYSelectDateCalendarCell *)[calendar cellForDate:date atMonthPosition:monthPosition];
        LYSelectDatePriceModel * model = [self.selectDateViewModel obtainSelectDatePriceModelWithDate:date];
        self.selectDateViewModel.isSpecial = model.isSpecial;
        cell.selectionLayer.hidden = YES;
        [cell setPriceLabelTextColorWithType:NO];
//        [cell setItemSpecial:model.isSpecial.boolValue];

//        [self.selectDateViewModel.selectDateCommand execute:nil];
        [self calculateBackDateWithStarDate:date type:NO];
    }
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.selectDateViewModel.monthArray.count;
//    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LYSelectDatePriceAndMonthCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:LYSelectDatePriceAndMonthCollectionViewCellID forIndexPath:indexPath];
    cell.data = self.selectDateViewModel.monthArray[indexPath.item];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(46.f, 54.f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.selectDateViewModel.monthArray enumerateObjectsUsingBlock:^(LYSelectDatePriceAndMonthModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isSelected = NO;
    }];
    LYSelectDatePriceAndMonthModel * model = self.selectDateViewModel.monthArray[indexPath.item];
    model.isSelected = YES;
    [self.calendar setCurrentPage:model.date animated:YES];
    [LYAnalyticsServiceManager analyticsEvent:@"CalendarTopClick" attributes:nil label:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
