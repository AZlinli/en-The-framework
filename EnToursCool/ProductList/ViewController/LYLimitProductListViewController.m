//
//  LYLimitProductListViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYLimitProductListViewController.h"
#import "LYLimitProductListViewModel.h"
#import "LYProductListVCNavigationTitleView.h"
#import "LYProductListTableViewCell.h"
#import "LYCountyCollectionCell.h"

@interface LYLimitProductListViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) LYLimitProductListViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation LYLimitProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
    [self bindViewModel];
}

- (void)setupInterface{
    @weakify(self);
    LYProductListVCNavigationTitleView * productListSearchTitleView = [[LYProductListVCNavigationTitleView alloc] init];
    [productListSearchTitleView setSearchReturnBlock:^(NSString * _Nullable searchTitle) {
        @strongify(self);
    }];
    self.navigationItem.titleView = productListSearchTitleView;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LYProductListTableViewCell" bundle:nil] forCellReuseIdentifier:LYProductListTableViewCellID];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"LYCountyCollectionCell" bundle:nil] forCellWithReuseIdentifier:LYCountyCollectionCellID];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

- (void)bindViewModel{
    self.viewModel = [[LYLimitProductListViewModel alloc] init];
    
//    @weakify(self);
//    [self.viewModel.getDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
//    }];
//    
//    [self.viewModel.getDataCommand execute:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.viewModel.dataArray.count;
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LYProductListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYProductListTableViewCellID];
//    cell.data = [self.viewModel.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     LYCountyCollectionCell *countyCell = [collectionView dequeueReusableCellWithReuseIdentifier:LYCountyCollectionCellID forIndexPath:indexPath];
     //        countyCell.data = self.exploreModel.countries[indexPath.item];
             return countyCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LYNSLog(@"点击了collectionView1的第%ld个",indexPath.row);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
     return CGSizeMake(78, 30); // todo 需要计算
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
   return 8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(3, 16, 3, 0);
}

@end
