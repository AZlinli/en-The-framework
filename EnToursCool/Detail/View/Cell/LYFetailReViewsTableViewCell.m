//
//  LYFetailReViewsTableViewCell.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYFetailReViewsTableViewCell.h"
#import "LHRatingView.h"
#import "TagCollectionViewCustomLayout.h"
#import "LYReviewDetailListImageCollectionViewCell.h"
#import "LYDetailCommonSectionModel.h"

NSString * const LYFetailReViewsTableViewCellID = @"LYFetailReViewsTableViewCellID";

@interface LYFetailReViewsTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *reviewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *starContentView;
@property (weak, nonatomic) IBOutlet UILabel *contentTextLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *seeAllLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property(nonatomic, strong) LHRatingView *starView;

/**model*/
@property(nonatomic, strong) LYDetailCommonSectionModel *model;

@end

@implementation LYFetailReViewsTableViewCell

-(void)dataDidChange {
    self.model = self.data;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.lineView.backgroundColor = [LYTourscoolAPPStyleManager ly_lineColor];
    
    self.reviewsLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.reviewsLabel.font = [LYTourscoolAPPStyleManager ly_ArialBold_16];
    
    [self.scoreLabel rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
        confer.text(@"4.5").textColor([LYTourscoolAPPStyleManager ly_FFBB00Color]).font([LYTourscoolAPPStyleManager ly_ArialBold_16]);
        confer.text(@"/5").textColor([LYTourscoolAPPStyleManager ly_818D99Color]).font([LYTourscoolAPPStyleManager ly_ArialBold_12]);
    }];
    
    self.headerImageView.xk_radius = 16;
    self.headerImageView.xk_openClip = YES;
    self.headerImageView.xk_clipType = XKCornerClipTypeAllCorners;
    
    
    self.nameLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.nameLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    
    self.timeLabel.textColor = [LYTourscoolAPPStyleManager ly_7F7F7FColor];
    self.timeLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
    
    self.contentTextLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.contentTextLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    
    self.seeAllLabel.textColor = [LYTourscoolAPPStyleManager ly_19A8C7Color];
    self.seeAllLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
    
    self.starView = [[LHRatingView alloc]initWithFrame:self.starContentView.bounds];
      [self.starContentView addSubview:self.starView];
      self.starView.score = 5;
      self.starView.ratingType = INTEGER_TYPE;
    
    TagCollectionViewCustomLayout *layout = [[TagCollectionViewCustomLayout alloc]init];
       layout.minimumLineSpacing = 4;
       layout.minimumInteritemSpacing = 4;
       layout.maximumInteritemSpacing = 4;
       layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
       self.imageCollectionView.delegate = self;
       self.imageCollectionView.dataSource = self;
       self.imageCollectionView.showsHorizontalScrollIndicator = NO;
       self.imageCollectionView.collectionViewLayout = layout;
       [self.imageCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LYReviewDetailListImageCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
}

#pragma mark UICollectionViewDataSource && UICollectionViewDelegate && UICollectionViewDelegateFlowLayout


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LYReviewDetailListImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(104 , 104);
}

@end
