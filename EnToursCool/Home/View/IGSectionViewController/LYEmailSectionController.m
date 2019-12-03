//
//  LYEmailSectionController.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYEmailSectionController.h"
#import "LYHomeSendEmailModel.h"
#import "LYEMailCell.h"
#import "LYCollectionElementKindSectionHeader.h"
#import "NSString+LYSize.h"

@interface LYEmailSectionController()<IGListSupplementaryViewSource>
@property (nonatomic, strong) LYHomeSendEmailModel *emailModel;
@property (nonatomic, assign) CGFloat height;

@end

@implementation LYEmailSectionController
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
    LYEMailCell *cell = [self.collectionContext dequeueReusableCellWithNibName:NSStringFromClass([LYEMailCell class]) bundle:nil forSectionController:self atIndex:index];
    cell.data = self.emailModel;
    return cell;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index
{
     return CGSizeMake(kScreenWidth, self.height);
}

- (void)didUpdateToObject:(id)object
{
    self.emailModel = object;
    CGFloat heightSpace = [self.emailModel.subTitle getSpaceHeightWithFont:[LYTourscoolAPPStyleManager ly_ArialRegular_15] Width:kScreenWidth - 32 space:2];
    CGFloat totalHeight = heightSpace + 113;
    self.height = totalHeight;
}

#pragma mark - IGListSupplementaryViewSource

- (NSArray<NSString *> *)supportedElementKinds
{
    return self.emailModel.collectionElementKindSectionArray;
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
