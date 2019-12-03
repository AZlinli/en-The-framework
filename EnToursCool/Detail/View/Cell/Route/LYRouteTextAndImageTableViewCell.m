//
//  LYRouteTextAndImageTableViewCell.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYRouteTextAndImageTableViewCell.h"
#import "TagCollectionViewCustomLayout.h"
#import "LYReviewDetailListImageCollectionViewCell.h"
#import "LYRouteListModel.h"

NSString * const LYRouteTextAndImageTableViewCellID = @"LYRouteTextAndImageTableViewCellID";

@interface LYRouteTextAndImageTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *topLineView;
@property (weak, nonatomic) IBOutlet UIImageView *botImageView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectView;
@property (weak, nonatomic) IBOutlet UILabel *textContentLabel;
/**model*/
@property(nonatomic, strong) LYRouteListScenicSpotModel *model;
/**collectioView datasoure*/
@property(nonatomic, strong) NSArray *imageArray;
@end

@implementation LYRouteTextAndImageTableViewCell

-(void)dataDidChange {
    self.model = self.data;
    self.titleLabel.text = self.model.title;
    self.textContentLabel.text = self.model.text;
    self.imageArray = self.model.imageArray;
    [self.imageCollectView reloadData];
    self.botImageView.image = [UIImage imageNamed:@"detail_scenic_spot"];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.botImageView.xk_radius = 8.5;
    self.botImageView.xk_clipType = XKCornerClipTypeAllCorners;
    self.botImageView.xk_openClip = YES;
    
    self.lineView.backgroundColor = [LYTourscoolAPPStyleManager ly_19A8C7Color];
    self.topLineView.backgroundColor = [LYTourscoolAPPStyleManager ly_19A8C7Color];

    self.titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    self.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    
    self.textContentLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    self.textContentLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    
    TagCollectionViewCustomLayout *layout = [[TagCollectionViewCustomLayout alloc]init];
    layout.minimumLineSpacing = 4;
    layout.minimumInteritemSpacing = 4;
    layout.maximumInteritemSpacing = 4;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.imageCollectView.delegate = self;
    self.imageCollectView.dataSource = self;
    self.imageCollectView.showsHorizontalScrollIndicator = NO;
    self.imageCollectView.collectionViewLayout = layout;
    [self.imageCollectView registerNib:[UINib nibWithNibName:NSStringFromClass([LYReviewDetailListImageCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *url = self.imageArray[indexPath.row];
    LYReviewDetailListImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.data = url;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(135, 102);
}

- (NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSArray array];
    }
    return _imageArray;
}
@end
