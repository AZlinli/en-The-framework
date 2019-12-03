//
//  LYReviewDetailListHeaderView.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYReviewDetailListHeaderView.h"
#import "LHRatingView.h"
#import "LYAlertTableView.h"
#import "LYAlertTableViewCell.h"

@interface LYReviewDetailListHeaderView()<AlertTableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *allReviewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UIView *allGradeContentView;
@property (weak, nonatomic) IBOutlet UILabel *serviceLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueformoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *safetyLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotelandRepastLabel;
@property (weak, nonatomic) IBOutlet UILabel *tourguideserviceLabel;
@property (weak, nonatomic) IBOutlet UIButton *newestFirstButton;
@property (weak, nonatomic) IBOutlet UILabel *sortByLabel;

@property (weak, nonatomic) IBOutlet UIView *longline;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UIView *starContentView1;
@property (weak, nonatomic) IBOutlet UIView *starContentView2;
@property (weak, nonatomic) IBOutlet UIView *starContentView3;
@property (weak, nonatomic) IBOutlet UIView *starContentView4;
@property (weak, nonatomic) IBOutlet UIView *starContentView5;

@property(nonatomic, strong) LHRatingView *starView1;
@property(nonatomic, strong) LHRatingView *starView2;
@property(nonatomic, strong) LHRatingView *starView3;
@property(nonatomic, strong) LHRatingView *starView4;
@property(nonatomic, strong) LHRatingView *starView5;


@property (nonatomic, strong) LYAlertTableView *alertTableView;
//弹出列表数据
@property (nonatomic, strong) NSMutableArray *alertTableDataArr;

@end

@implementation LYReviewDetailListHeaderView
- (void)awakeFromNib {
    [super awakeFromNib];
    [self configStarView];
    
    self.allReviewsLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.allReviewsLabel.font = [LYTourscoolAPPStyleManager ly_ArialBold_20];
    
    self.gradeLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.gradeLabel.font = [LYTourscoolAPPStyleManager ly_ArialBoldMT_30];
    
    self.serviceLabel.textColor = [LYTourscoolAPPStyleManager ly_7F7F7FColor];
    self.serviceLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
    
    self.valueformoneyLabel.textColor = [LYTourscoolAPPStyleManager ly_7F7F7FColor];
    self.valueformoneyLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
    
    self.safetyLabel.textColor = [LYTourscoolAPPStyleManager ly_7F7F7FColor];
    self.safetyLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
    
    self.hotelandRepastLabel.textColor = [LYTourscoolAPPStyleManager ly_7F7F7FColor];
    self.hotelandRepastLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
    
    self.tourguideserviceLabel.textColor = [LYTourscoolAPPStyleManager ly_7F7F7FColor];
    self.tourguideserviceLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
    
    self.sortByLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.sortByLabel.font = [LYTourscoolAPPStyleManager ly_ArialBold_16];
    
    [self.newestFirstButton setTitleColor:[LYTourscoolAPPStyleManager ly_707070Color] forState:0];
    self.newestFirstButton.titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    [self.newestFirstButton setImage:[UIImage imageNamed:@""] forState:0];
    [self.newestFirstButton setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];

    
    self.longline.backgroundColor = [LYTourscoolAPPStyleManager ly_F1F1F1Color];
    self.lineView.backgroundColor = [LYTourscoolAPPStyleManager ly_F1F1F1Color];
    LYAlertTableView *alertTableView = [[LYAlertTableView alloc] init];
    @weakify(self);
    alertTableView.selectBlock = ^(NSIndexPath *indexPath) {
        @strongify(self);
        [self.newestFirstButton setTitle:self.alertTableDataArr[indexPath.row] forState:0];
    };
    alertTableView.delegate = self;
    _alertTableView = alertTableView;

}

- (void)configStarView {
    CGRect starView1Frame = self.starContentView1.bounds;
    CGRect starView2Frame = self.starContentView2.bounds;
    CGRect starView3Frame = self.starContentView3.bounds;
    CGRect starView4Frame = self.starContentView4.bounds;
    CGRect starView5Frame = self.starContentView5.bounds;
    
    self.starView1 = [[LHRatingView alloc]initWithFrame:starView1Frame];
    self.starView1.score = 5;
    self.starView1.ratingType = INTEGER_TYPE;
    [self.starContentView1 addSubview:self.starView1];
    
    self.starView2 = [[LHRatingView alloc]initWithFrame:starView2Frame];
    self.starView2.score = 5;
    self.starView2.ratingType = INTEGER_TYPE;
    [self.starContentView2 addSubview:self.starView2];
    
    
    self.starView3 = [[LHRatingView alloc]initWithFrame:starView3Frame];
    self.starView3.score = 5;
    self.starView3.ratingType = INTEGER_TYPE;
    [self.starContentView3 addSubview:self.starView3];
    
    
    self.starView4 = [[LHRatingView alloc]initWithFrame:starView4Frame];
    self.starView4.score = 5;
    self.starView4.ratingType = INTEGER_TYPE;
    [self.starContentView4 addSubview:self.starView4];
    
    
    self.starView5 = [[LHRatingView alloc]initWithFrame:starView5Frame];
    self.starView5.score = 5;
    self.starView5.ratingType = INTEGER_TYPE;
    [self.starContentView5 addSubview:self.starView5];
    
}

- (IBAction)newestFirstButtonAction:(UIButton *)sender {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    CGRect buttonRect = [sender convertRect:sender.bounds toView:window];
          //设置弹出选项view
    CGRect alertTableRect = CGRectMake(buttonRect.origin.x - 69, buttonRect.origin.y + buttonRect.size.height + 4, 179, 202);
    _alertTableView.tableViewFrame = alertTableRect;
    [_alertTableView show];
}

- (NSMutableArray *)alertTableDataArr {
    
    if (_alertTableDataArr == nil) {
        
        _alertTableDataArr = [NSMutableArray arrayWithObjects:@"Newest First", @"Hightest Rated", @"Lowest Rated", @"Image Reviews only",nil];
        
    }
    
    return _alertTableDataArr;
}

#pragma mark - AlertTableViewDelegate 弹框
//提供数据源
- (NSMutableArray*)alertTableVieDataSource {
    
    return self.alertTableDataArr;
    
}

//更改对应的cell样式
- (UITableViewCell*)alertTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
       static NSString *alertIndentify = @"alertIndentify";
   
       LYAlertTableViewCell *alertCell = [tableView dequeueReusableCellWithIdentifier:alertIndentify];
   if (alertCell == nil) {
        alertCell= (LYAlertTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"LYAlertTableViewCell" owner:self options:nil]  lastObject];
      }
      
    alertCell.data = self.alertTableDataArr[indexPath.row];
    return alertCell;
    
}

//每一个cell 的高度
- (CGFloat)alertTableView:(LYAlertTableView *)alertTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

@end
