//
//  LYDealsSectionController.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDealsSectionController.h"
#import "LYDealsCell.h"
#import "LYSectionHeadCell.h"
#import "LYHomeDealsModel.h"
#import "LYCollectionElementKindSectionHeader.h"


@interface LYDealsSectionController()<IGListSupplementaryViewSource>

@property (nonatomic, strong) LYHomeDealsModel *dealsModel;

@end

@implementation LYDealsSectionController
#pragma mark - superMethod

- (instancetype)init
{
    if (self = [super init])
    {
        self.supplementaryViewSource = self;
    }
    return self;
}

- (NSInteger)numberOfItems
{
    return 1;
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index
{
    LYDealsCell *cell = [self.collectionContext dequeueReusableCellWithNibName:NSStringFromClass([LYDealsCell class]) bundle:nil forSectionController:self atIndex:index];
    return cell;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index
{
    CGFloat bigImvWidth = (kScreenWidth - 16 * 2 - 5) / 2;
    CGFloat bigImvHeight = bigImvWidth * 197 / 169;
    return CGSizeMake(kScreenWidth, bigImvHeight + 20);
}

- (void)didUpdateToObject:(id)object
{
    self.dealsModel = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index
{
    
}

#pragma mark - IGListSupplementaryViewSource

- (NSArray<NSString *> *)supportedElementKinds
{
    return self.dealsModel.collectionElementKindSectionArray;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind atIndex:(NSInteger)index
{
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter])
    {
        return CGSizeMake(self.collectionContext.containerSize.width,10.f);
    }
    return CGSizeZero;
}

- (UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind atIndex:(NSInteger)index
{
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        LYCollectionElementKindSectionHeader * header = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter forSectionController:self nibName:@"LYCollectionElementKindSectionHeader" bundle:nil atIndex:index];
        return header;
    }
    return nil;
}
@end
