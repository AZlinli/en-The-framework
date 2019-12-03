//
//  LYNoteSectionController.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYNoteSectionController.h"
#import "LYHomeNoteModel.h"

#import "LYNoteCell.h"
#import "LYCollectionElementKindSectionHeader.h"
#import "LYCollectioneElementSectionFooter.h"
#import "LYEmptyCollectionCell.h"
#import "LYEmptyCollectionHeader.h"


@interface LYNoteSectionController()<IGListSupplementaryViewSource>

@property (nonatomic, strong) LYHomeNoteModel *homeNoteM;

@end

@implementation LYNoteSectionController

#pragma mark - superMethod

- (instancetype)init
{
    if (self = [super init])
    {
        self.supplementaryViewSource = self;
//        self.minimumLineSpacing = 0.0f;
//        self.minimumInteritemSpacing = 0.0f;
    }
    return self;
}

- (NSInteger)numberOfItems
{
    return 4;
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index
{
    LYNoteCell *cell = [self.collectionContext dequeueReusableCellWithNibName:NSStringFromClass([LYNoteCell class]) bundle:nil forSectionController:self atIndex:index];
    return cell;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index
{
     return CGSizeMake(kScreenWidth / 4, 107);
}

- (void)didUpdateToObject:(id)object
{
    self.homeNoteM = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index
{
    LYNSLog(@"点击了第%ld个item",index);
}

#pragma mark - IGListSupplementaryViewSource

- (NSArray<NSString *> *)supportedElementKinds
{
    return self.homeNoteM.collectionElementKindSectionArray;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind atIndex:(NSInteger)index
{
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter])
    {
        return CGSizeMake(self.collectionContext.containerSize.width,10.f);
    }
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader])
    {
        return CGSizeMake(self.collectionContext.containerSize.width,10.f);
    }
    return CGSizeZero;
}

- (UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind atIndex:(NSInteger)index
{
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        LYEmptyCollectionHeader * header = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader forSectionController:self nibName:@"LYEmptyCollectionHeader" bundle:nil atIndex:index];
        header.needLigray = YES;
        return header;
    }
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        LYEmptyCollectionCell * footer = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter forSectionController:self nibName:@"LYEmptyCollectionCell" bundle:nil atIndex:index];
        footer.needLigray = YES;
        return footer;
    }
    return nil;
}


@end
