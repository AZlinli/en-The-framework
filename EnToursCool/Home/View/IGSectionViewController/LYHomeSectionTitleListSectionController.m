//
//  LYLYHomeSectionTitleListSectionController.m
//  ToursCool
//
//  Created by tourscool on 2/13/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYHomeSectionTitleListSectionController.h"
#import "LYHomeSectionTitleCollectionViewCell.h"
#import "LYCollectionElementKindSectionHeader.h"
#import "LYHomeSectionTitleListSectionModel.h"


@interface LYHomeSectionTitleListSectionController () <IGListSupplementaryViewSource>
@property (nonatomic, strong) LYHomeSectionTitleListSectionModel * homeIGListBaseModel;
@end

@implementation LYHomeSectionTitleListSectionController

- (instancetype)init
{
    if (self = [super init]) {
        self.supplementaryViewSource = self;
    }
    return self;
}

- (NSArray<NSString *> *)supportedElementKinds
{
    return self.homeIGListBaseModel.collectionElementKindSectionArray;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind atIndex:(NSInteger)index
{
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        return CGSizeMake(self.collectionContext.containerSize.width, 7.f);
    }
    return CGSizeZero;
}

- (UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind atIndex:(NSInteger)index
{
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        LYCollectionElementKindSectionHeader * header = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter forSectionController:self nibName:@"LYCollectionElementKindSectionHeader" bundle:nil atIndex:index];
        header.backgroundColor = [UIColor whiteColor];
        return header;
    }
    return nil;
}

- (NSInteger)numberOfItems
{
    return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index
{
    return CGSizeMake(self.collectionContext.containerSize.width, 57.f);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index
{
    LYHomeSectionTitleCollectionViewCell * cell = [self.collectionContext dequeueReusableCellWithNibName:@"LYHomeSectionTitleCollectionViewCell" bundle:nil forSectionController:self atIndex:index];
    cell.data = self.homeIGListBaseModel;
    return cell;
}

- (void)didUpdateToObject:(id)object
{
    self.homeIGListBaseModel = object;
}
@end
