//
//  LYReviewDetailListTableViewCell.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYReviewDetailListTableViewCell.h"
#import "LYReviewDetailListImageCollectionViewCell.h"
#import "LHRatingView.h"
#import "TagCollectionViewCustomLayout.h"

@interface LYReviewDetailListTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *textContentLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectonView;
@property(nonatomic, strong) LHRatingView *starView1;
@property (weak, nonatomic) IBOutlet UIView *starContentView;

@end

@implementation LYReviewDetailListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.nameLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.nameLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    
    self.headerImageView.xk_radius = 16;
    self.headerImageView.xk_openClip = YES;
    self.headerImageView.xk_clipType = XKCornerClipTypeAllCorners;
    self.lineView.backgroundColor = [LYTourscoolAPPStyleManager ly_F1F1F1Color];
    
    self.timeLabel.textColor = [LYTourscoolAPPStyleManager ly_7F7F7FColor];
    self.timeLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
    self.starView1 = [[LHRatingView alloc]initWithFrame:self.starContentView.bounds];
    [self.starContentView addSubview:self.starView1];

    self.starView1.score = 5;
    self.starView1.ratingType = INTEGER_TYPE;
    
    TagCollectionViewCustomLayout *layout = [[TagCollectionViewCustomLayout alloc]init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 4;
    layout.maximumInteritemSpacing = 4;
    self.imageCollectonView.delegate = self;
    self.imageCollectonView.dataSource = self;
    self.imageCollectonView.collectionViewLayout = layout;
    [self.imageCollectonView registerNib:[UINib nibWithNibName:NSStringFromClass([LYReviewDetailListImageCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
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
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(104 * kScreenWidthScale, 83 * kScreenHeightScale);
}

@end
