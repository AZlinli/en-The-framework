//
//  LYHomeViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/18.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYHomeViewController.h"

#import <IGListKit.h>
#import "LYCustomRefreshNormalHeader.h"
#import "LYCustomRefreshAutoStateFooter.h"

#import "LYShareViewController.h"
#import "LYSearchViewController.h"

#import "TourSearchView.h"
#import "LYReviewDetailViewController.h"
#import "LYReviewDetailListViewController.h"

#import "LYHomeViewModel.h"

#import "LYHomeBannerModel.h"
#import "LYBannerSectionController.h"
#import "LYDetailViewController.h"

#import "LYHomeMenuModel.h"
#import "LYHomeMenuSectionController.h"

#import "LYHomeSectionTitleListSectionModel.h"
#import "LYHomeSectionTitleListSectionController.h"

#import "LYHomeExploreModel.h"
#import "LYHomeExploreDetailController.h"

#import "LYHomeDealsModel.h"
#import "LYDealsSectionController.h"

#import "LYHomeSendEmailModel.h"
#import "LYEmailSectionController.h"

#import "LYInspirationModel.h"
#import "LYInspirationSectionController.h"

#import "LYHomeNoteModel.h"
#import "LYNoteSectionController.h"



@interface LYHomeViewController ()<IGListAdapterDataSource>

@property (nonatomic, strong)  TourSearchView *searchView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) IGListAdapter *adapter;

@property (nonatomic, strong) LYHomeViewModel * homeViewModel;
@property (nonatomic, strong) LYBannerSectionController * homeBannerSectionController;

@end

@implementation LYHomeViewController

#pragma mark - life

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
    [self bind];
    [self cofigCollectionView];
    [self addRefresh];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏透明
    [self.navigationController.navigationBar lt_setBackgroundColor:UIColor.clearColor];
     self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.homeBannerSectionController bannerCycleScrollViewAdjustWhenControllerViewWillAppera];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //导航栏恢复
    [self.navigationController.navigationBar lt_reset];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

#pragma mark - privite

- (void)setupNav
{
    self.adapter.collectionView.contentInset = UIEdgeInsetsMake(-SafeAreaTopHeight, 0, 0, 0);
    
    [self.navigationController.navigationBar lt_setBackgroundColor:UIColor.clearColor];
    TourSearchView *searchView = [[TourSearchView alloc] initWithLeftImgName:@"" placeString:@"" rightImgName:@"" click:^{
        //点击后跳转的action
        LYDetailViewController *vc = [[LYDetailViewController alloc]initWithNibName:@"LYDetailViewController" bundle:nil];
           vc.hidesBottomBarWhenPushed = YES;
           [self.navigationController pushViewController:vc animated:YES];
           ;
    } rightClick:^{
        //点击右边的action
    }];
    searchView.backgroundColor = [UIColor clearColor];
//    searchView.height = 30;
    self.navigationItem.titleView = searchView;
    self.searchView = searchView;
    
}

- (void)bind
{
    self.homeViewModel = [LYHomeViewModel sharedHomeViewModel];
    @weakify(self);
    [RACObserve(self.homeViewModel, homeSectionArray) subscribeNext:^(NSArray *  _Nullable x) {
        @strongify(self);
//        self.homeViewModel.homeSectionArray = x;
        [self.adapter reloadDataWithCompletion:nil];
       }];
}

- (void)cofigCollectionView
{
    //配置数据00组数据配置
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, - SafeAreaTopHeight, kScreenWidth, self.view.height) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    IGListAdapterUpdater *updater = [[IGListAdapterUpdater alloc] init];
    _adapter = [[IGListAdapter alloc] initWithUpdater:updater viewController:self workingRangeSize:0];
    _adapter.collectionView = self.collectionView;
    _adapter.dataSource = self;
    [self.view addSubview:self.collectionView];
}

- (void)addRefresh
{
    @weakify(self)
      LYCustomRefreshNormalHeader * customRefreshNormalHeader = [LYCustomRefreshNormalHeader headerWithRefreshingBlock:^{
               @strongify(self);
    //           [self.homeCollectionView.mj_footer resetNoMoreData];
    //           self.homeViewModel.page = 1;
    //            [self.homeViewModel.homePhoneHTTPRequestCommand execute:nil];
    //           [self.homeViewModel.homeHTTPRequestCommand execute:nil];
            [self.collectionView.mj_header endRefreshing];
            }];
           
    //       [customRefreshNormalHeader updateRefreshTitleStateTextColor];
           customRefreshNormalHeader.arrowView.hidden = NO;
           self.collectionView.mj_header = customRefreshNormalHeader;
}

#pragma mark - IGListAdapterDataSource

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter
{
    return nil;
}

- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter
{
    return self.homeViewModel.homeSectionArray;
    
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object
{
    if ([object isKindOfClass:[LYHomeBannerModel class]])
    {
        if (!self.homeBannerSectionController)
        {
            self.homeBannerSectionController = [[LYBannerSectionController alloc] init];
        }
            return self.homeBannerSectionController;
    }
    if ([object isKindOfClass:[LYHomeMenuModel class]])
    {
         LYHomeMenuSectionController * sectionController = [[LYHomeMenuSectionController alloc] init];
         return sectionController;
    }
    if ([object isKindOfClass:[LYHomeSectionTitleListSectionModel class]]) {
        LYHomeSectionTitleListSectionController * sectionController = [[LYHomeSectionTitleListSectionController alloc] init];
        return sectionController;
    }
    if ([object isKindOfClass:[LYHomeExploreModel class]])
    {
        LYHomeExploreDetailController *exploreDetailVc = [[LYHomeExploreDetailController alloc] init];
        return exploreDetailVc;
    }
    if ([object isKindOfClass:[LYHomeDealsModel class]])
    {
        LYDealsSectionController *dealsVc = [[LYDealsSectionController alloc] init];
        return dealsVc;
    }
    if ([object isKindOfClass:[LYHomeSendEmailModel class]])
    {
        LYEmailSectionController *emailVc = [[LYEmailSectionController alloc] init];
        return emailVc;
    }
    if ([object isKindOfClass:[LYInspirationModel class]])
    {
        LYInspirationSectionController *insprirationVc = [[LYInspirationSectionController alloc] init];
        return insprirationVc;
    }
    if ([object isKindOfClass:[LYHomeNoteModel class]])
    {
        LYNoteSectionController *sectionVc = [[LYNoteSectionController alloc] init];
        return sectionVc;
    }
     return nil;
}


@end
