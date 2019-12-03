//
//  LYInspirationSectionController.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYInspirationSectionController.h"
#import "LYInspirationModel.h"

#import "LYInspirationCell.h"
#import "LYSectionHeadCell.h"
#import "LYEmptyCollectionCell.h"
#import "LYEmptyCollectionHeader.h"



@interface LYInspirationSectionController()<IGListSupplementaryViewSource>

@property (nonatomic, strong) LYInspirationModel *inspirationM;

@end

@implementation LYInspirationSectionController
#pragma mark - superMethod

- (instancetype)init
{
    if (self = [super init])
    {
        self.supplementaryViewSource = self;
         self.minimumLineSpacing = 0.0f;
         self.minimumInteritemSpacing = 0.0f;
    }
    return self;
}

- (NSInteger)numberOfItems
{
    return 3;
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index
{
    LYInspirationCell *cell = [self.collectionContext dequeueReusableCellWithNibName:NSStringFromClass([LYInspirationCell class]) bundle:nil forSectionController:self atIndex:index];
    return cell;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index
{
    return CGSizeMake(kScreenWidth, 10 + 150 *(kScreenWidth - 32) / 343);
}

- (void)didUpdateToObject:(id)object
{
    self.inspirationM = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"您点击了第%ld个item",(long)index);
}

#pragma mark - IGListSupplementaryViewSource

- (NSArray<NSString *> *)supportedElementKinds
{
    return self.inspirationM.collectionElementKindSectionArray;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind atIndex:(NSInteger)index
{
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter])
    {
        return CGSizeMake(self.collectionContext.containerSize.width,14.f);
    }
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader])
    {
        return CGSizeMake(self.collectionContext.containerSize.width,7.f);
    }
    return CGSizeZero;
}

- (UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind atIndex:(NSInteger)index
{
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        LYEmptyCollectionHeader * header = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader forSectionController:self nibName:@"LYEmptyCollectionHeader" bundle:nil atIndex:index];
        return header;
    }
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        LYEmptyCollectionCell * footer = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter forSectionController:self nibName:@"LYEmptyCollectionCell" bundle:nil atIndex:index];
        return footer;
    }
    return nil;
}
@end
