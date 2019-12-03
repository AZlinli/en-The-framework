//
//  LYDetailSelectDateTableViewCell.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailSelectDateTableViewCell.h"
#import "TagCollectionViewCustomLayout.h"
#import "LYDetailSelectDateCollectionViewCell.h"
#import "LYDetailSelectDateModel.h"

NSString * const LYDetailSelectDateTableViewCellID = @"LYDetailSelectDateTableViewCellID";

@interface LYDetailSelectDateTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
/**model*/
@property(nonatomic, strong) LYDetailSelectDateModel *model;
/**dataArray*/
@property(nonatomic, strong) NSArray *dataArray;
@end

@implementation LYDetailSelectDateTableViewCell
- (void)dataDidChange {
    self.model = self.data;
    self.dataArray = self.model.dateArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialBold_16];
    
    TagCollectionViewCustomLayout *layout = [[TagCollectionViewCustomLayout alloc]init];
    layout.minimumInteritemSpacing = 8;
    layout.minimumLineSpacing = 8;
    layout.maximumInteritemSpacing = 8;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LYDetailSelectDateCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:LYDetailSelectDateCollectionViewCellID];

    self.lineView.backgroundColor = [LYTourscoolAPPStyleManager ly_lineColor];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataArray.count > 4) {
        return 4;
    }
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(79 * kScreenWidthScale, 46);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LYDetailSelectDateModelItem *selectDateModelItem = self.dataArray[indexPath.row];
    LYDetailSelectDateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LYDetailSelectDateCollectionViewCellID forIndexPath:indexPath];
    cell.data = selectDateModelItem;
    return cell;
}

- (NSArray *)dataArray {
    if (!_dataArray ) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}
@end
