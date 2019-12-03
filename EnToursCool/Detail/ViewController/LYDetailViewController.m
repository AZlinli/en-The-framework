//
//  LYDetailViewController.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailViewController.h"
#import "LYReviewDetailListViewController.h"

#import "LYDetailBottomView.h"
#import "LYDetailTopView.h"
#import "LYDetailTableHeaderView.h"
#import "LYCustomDetailNavigationBar.h"

#import "LYDetailBaseModel.h"
#import "LYRouteListModel.h"
#import "LYDetailTopHeaderModel.h"
#import "LYDetailCommonSectionModel.h"
#import "LYDetailTableHeaderModel.h"
#import "LYDetailExpenseModel.h"
#import "LYDetailSpecialnotesModel.h"
#import "LYDetailSelectDateModel.h"
#import "LYDetailHighlightsModel.h"
#import "LYPickupDetailsModel.h"

#import "LYRouteSectionHeader.h"
#import "LYDetailCommonSectionHeaderView.h"
#import "LYRouteTextTableViewCell.h"
#import "LYRouteTextAndImageTableViewCell.h"
#import "LYRouteTextAndTitleTableViewCell.h"
#import "LYDetailTopHeaderView.h"
#import "LYDetailSelectDateTableViewCell.h"
#import "LYDetailHighlightsTableViewCell.h"
#import "LYPickupDetailsTableViewCell.h"
#import "LYDetailSeeMoreFooterView.h"
#import "LYDetailSpecialnotesHeaderView.h"
#import "LYDetailSpecialnotesTableViewCell.h"
#import "LYDetailExpenseTableViewCell.h"

#import "UIView+LYNib.h"

#import "LYDetailViewModel.h"

#import "LYFetailReViewsTableViewCell.h"
#import "LYDetailViewTableViewCell.h"

#import "LYSelectDateViewController.h"
#import "LYCommonSelectViewController.h"

static const CGFloat LYDetailBottomViewH = 54;
static const CGFloat LYDetailTopViewH = 70;
static const CGFloat LYDetailTopViewTag = 100001;
static const CGFloat LYDetailRouteSectionH = 58;

@interface LYDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTop;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**判断是否是第一次加载TopView*/
@property(nonatomic, assign) NSInteger isAddTopViewCount;
/**自定义导航栏*/
@property(nonatomic, strong) LYCustomDetailNavigationBar * customDetailNavigationBar;
/**viewModel*/
@property(nonatomic, strong) LYDetailViewModel *viewModel;

@property(nonatomic, strong) LYDetailTopView *detailTopView;

/**当前offsetY*/
@property(nonatomic, assign) CGFloat currentOffsetY;
@end

@implementation LYDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configInitData];
    [self configTableView];
    [self configBottomView];
    [self configCustomDetailNavigationBar];
    [self dealCommand];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
#pragma mark - base Config
//配置初始化数据
- (void)configInitData {
    self.isAddTopViewCount = 0;
}

//配置tableView
- (void)configTableView {
    self.tableViewTop.constant = - kStatusBarHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 100;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self configRegisterCellAndHeader];
}
//配置自定义导航栏
- (void)configCustomDetailNavigationBar {
    @weakify(self);
    self.customDetailNavigationBar = [LYCustomDetailNavigationBar loadFromNib];
    [self.view addSubview:self.customDetailNavigationBar];
    self.customDetailNavigationBar.backBlock = ^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    };
    self.customDetailNavigationBar.shareBlock = ^{
        @strongify(self);
        LYCommonSelectViewController *vc = [LYCommonSelectViewController new];
        vc.title = @"Select country code";
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self.customDetailNavigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.right.top.equalTo(self.view);
         make.height.offset(SafeAreaTopHeight);
    }];
}

//配置底部悬浮视图
- (void)configBottomView {
    LYDetailBottomView *bottomView = [LYDetailBottomView loadFromNib];
    @weakify(self);
    bottomView.bookingBtnClickBlock = ^{
        @strongify(self);
        LYSelectDateViewController *dateVc = [UIStoryboard storyboardWithName:@"Booking" bundle:nil].instantiateInitialViewController;
        [self.navigationController pushViewController:dateVc animated:YES];
    };
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       if (@available(iOS 11.0, *)) {
          make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
          make.bottom.equalTo(self.view.mas_bottom);
        }
          make.left.right.equalTo(self.view);
          make.height.offset(LYDetailBottomViewH);
    }];
}
//配置吸顶的视图
- (void)configDetailTopView:(CGFloat )offsetY {
    LYDetailTopView *topView = [LYDetailTopView loadFromNib];
    topView.frame = CGRectMake(0, SafeAreaTopHeight, kScreenWidth, LYDetailTopViewH);
    topView.data = self.viewModel;
    topView.tag = LYDetailTopViewTag;
    __block NSInteger currentHeaderIdx;
       [self.viewModel.detailSectionArray enumerateObjectsUsingBlock:^(LYDetailBaseModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
           if ([model isKindOfClass:[LYDetailTopHeaderModel class]]) {
               currentHeaderIdx = idx;
               *stop = YES;
           }
       }];
    CGRect sectionRect = [self.tableView rectForHeaderInSection:currentHeaderIdx];
    CGFloat currentOffsetY = sectionRect.origin.y - LYDetailTopViewH - 10 - kSafeAreaHeight - (SafeAreaTopHeight - 64);
    NSLog(@"sectionRectY --------------------%f",sectionRect.origin.y);
    NSLog(@"currentOffsetY===================%f",currentOffsetY);
    if (offsetY >= currentOffsetY) {
       self.isAddTopViewCount += 1;
       if (self.isAddTopViewCount == 1) {
          [self.view addSubview:topView];
       }
    }else if (offsetY < currentOffsetY){
       for (UIView *subView in self.view.subviews) {
           if (subView.tag == LYDetailTopViewTag) {
               self.isAddTopViewCount = 0;
               [subView removeFromSuperview];
           }
       }
   }
    self.detailTopView = topView;
}
//注册cell和header
- (void)configRegisterCellAndHeader {
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYDetailTableHeaderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:LYDetailTableHeaderViewID];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYDetailCommonSectionHeaderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:LYDetailCommonSectionHeaderViewID];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYDetailSeeMoreFooterView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:LYDetailSeeMoreFooterViewID];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYRouteSectionHeader class]) bundle:nil] forHeaderFooterViewReuseIdentifier:LYRouteSectionHeaderViewID];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYDetailSpecialnotesHeaderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:LYDetailSpecialnotesHeaderViewID];


    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYDetailTopHeaderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:LYDetailTopHeaderViewID];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYRouteTextTableViewCell class]) bundle:nil] forCellReuseIdentifier:LYRouteTextTableViewCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYRouteTextAndImageTableViewCell class]) bundle:nil] forCellReuseIdentifier:LYRouteTextAndImageTableViewCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYRouteTextAndTitleTableViewCell class]) bundle:nil] forCellReuseIdentifier:LYRouteTextAndTitleTableViewCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYFetailReViewsTableViewCell class]) bundle:nil] forCellReuseIdentifier:LYFetailReViewsTableViewCellID];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYDetailViewTableViewCell class]) bundle:nil] forCellReuseIdentifier:LYDetailViewTableViewCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYDetailSelectDateTableViewCell class]) bundle:nil] forCellReuseIdentifier:LYDetailSelectDateTableViewCellID];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYDetailHighlightsTableViewCell class]) bundle:nil] forCellReuseIdentifier:LYDetailHighlightsTableViewCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYPickupDetailsTableViewCell class]) bundle:nil] forCellReuseIdentifier:LYPickupDetailsTableViewCellID];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYDetailSpecialnotesTableViewCell class]) bundle:nil] forCellReuseIdentifier:LYDetailSpecialnotesTableViewCellID];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYDetailExpenseTableViewCell class]) bundle:nil] forCellReuseIdentifier:LYDetailExpenseTableViewCellID];


}

- (LYDetailViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[LYDetailViewModel alloc]init];
    }
    return _viewModel;
}

- (void)dealCommand {
    @weakify(self);
    [self.viewModel.showMoreRouteCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *  _Nullable x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    
    [self.viewModel.showMoreSpecialNotesCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *  _Nullable x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    
    [self.viewModel.selectTypeButtonCommand.executionSignals.switchToLatest subscribeNext:^(NSNumber *  _Nullable x) {
        @strongify(self);
        self.viewModel.tapButton = YES;
        if (x.integerValue == 10001) {
            CGRect sectionRect = [self.tableView rectForHeaderInSection:[self.viewModel obtainSectionArrayWithModel:[LYDetailTopHeaderModel class]]];
            CGPoint sectionPoint = CGPointMake(0, sectionRect.origin.y - LYDetailTopViewH - 10);
            [self.tableView setContentOffset:sectionPoint animated:YES];
        }else if (x.integerValue == 10002) {
            CGRect sectionRect = [self.tableView rectForHeaderInSection:[self.viewModel obtainSectionArrayWithModel:[LYDetailExpenseModel class]]];
            CGPoint sectionPoint = CGPointMake(0, sectionRect.origin.y - 2 * LYDetailTopViewH - 10);
            [self.tableView setContentOffset:sectionPoint animated:YES];
        }else if (x.integerValue == 10003) {

            CGRect sectionRect = [self.tableView rectForHeaderInSection:[self.viewModel obtainSectionArrayWithModel:[LYDetailSpecialnotesModel class]]];
            CGPoint sectionPoint = CGPointMake(0, sectionRect.origin.y - 2 * LYDetailTopViewH - 10);
            [self.tableView setContentOffset:sectionPoint animated:YES];
        }
    }];
    
    [self.viewModel.showMoreHighlightsCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *  _Nullable x) {
           @strongify(self);
           NSIndexPath *indexPath = x[@"indexPath"];
           [UIView performWithoutAnimation:^{
             [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
           }];
    }];
    
    [self.viewModel.showMoreExpenseCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *  _Nullable x) {
           @strongify(self);
           NSIndexPath *indexPath = x[@"indexPath"];
           [UIView performWithoutAnimation:^{
             [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
           }];
    }];
    
    [self.viewModel.footerShowMoreCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *  _Nullable x) {
           @strongify(self);
           NSInteger section = [x[@"section"] integerValue];
        [UIView performWithoutAnimation:^{
           [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }];
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.detailSectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LYDetailBaseModel *model = self.viewModel.detailSectionArray[section];
    if ([model isKindOfClass:[LYRouteListModel class]]) {
        LYRouteListModel *routelistModel = (LYRouteListModel *)model;
        if ([routelistModel.showMore boolValue] == YES) {
            return routelistModel.listArray.count;
        }
        return 0;
    }
    
    if ([model isKindOfClass:[LYDetailCommonSectionModel class]]) {
        LYDetailCommonSectionModel *commonSectionModel = (LYDetailCommonSectionModel *)model;
        return commonSectionModel.commonSectionArray.count;
    }
    
    //Pick-up Details LYPickupDetailsModel
    if ([model isKindOfClass:[LYPickupDetailsModel class]]) {
        LYPickupDetailsModel *pickupDetailsModel = (LYPickupDetailsModel *)model;
        if (pickupDetailsModel.isShowFooter) {
            if (pickupDetailsModel.isSeeMore) {
                return pickupDetailsModel.itemArray.count;
            }else{
                return 3;
            }
        }else{
            return 3;
        }
    }
    //Expense
    if ([model isKindOfClass:[LYDetailExpenseModel class]]) {
        LYDetailExpenseModel *expenseModel = (LYDetailExpenseModel *)model;
        return expenseModel.dataArray.count;
    }
    
    //Specialnotes
    if ([model isKindOfClass:[LYDetailSpecialnotesModel class]]) {
        LYDetailSpecialnotesModel *specialnotesModel = (LYDetailSpecialnotesModel *)model;
        if ([specialnotesModel.showMore boolValue]) {
            return 1;
        }
        return 0;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    @weakify(self);
    LYDetailBaseModel *model = self.viewModel.detailSectionArray[indexPath.section];
    //行程相关
   if ([model isKindOfClass:[LYRouteListModel class]]) {
       LYRouteListModel *routelistModel = (LYRouteListModel *)model;
       LYDetailBaseModel *listModel = routelistModel.listArray[indexPath.row];
       if ([listModel isKindOfClass:[LYRouteListContentTextModel class]]) {
           LYRouteTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LYRouteTextTableViewCellID forIndexPath:indexPath];
           LYRouteListContentTextModel *textModel = (LYRouteListContentTextModel*)listModel;
           cell.data = textModel;
           return cell;
       }else if ([listModel isKindOfClass:[LYRouteListScenicSpotModel class]]){
           LYRouteTextAndImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LYRouteTextAndImageTableViewCellID forIndexPath:indexPath];
           LYRouteListScenicSpotModel *spotModel = (LYRouteListScenicSpotModel*)listModel;
           cell.data = spotModel;
           return cell;
       }else if ([listModel isKindOfClass:[LYRouteListhHotelModel class]]){
           LYRouteTextAndTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LYRouteTextAndTitleTableViewCellID forIndexPath:indexPath];
           LYRouteListhHotelModel *hotelModel = (LYRouteListhHotelModel*)listModel;
           cell.data = hotelModel;
           return cell;
       }else if ([listModel isKindOfClass:[LYRouteListhMealsModel class]]){
           LYRouteTextAndTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LYRouteTextAndTitleTableViewCellID forIndexPath:indexPath];
           LYRouteListhMealsModel *mealsModel = (LYRouteListhMealsModel*)listModel;
           cell.data = mealsModel;
           return cell;
       }
    }
    //装有评价reviews、View、Highlights相关
    if ([model isKindOfClass:[LYDetailCommonSectionModel class]]) {
           LYDetailCommonSectionModel *commonSectionModel = (LYDetailCommonSectionModel *)model;
            LYDetailBaseModel *baseModel = commonSectionModel.commonSectionArray[indexPath.row];
        if ([baseModel isKindOfClass:[LYDetailReviewsModel class]]) {
            LYDetailReviewsModel *reviewsModel = (LYDetailReviewsModel *)baseModel;
            LYFetailReViewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LYFetailReViewsTableViewCellID forIndexPath:indexPath];
            cell.data = reviewsModel;
            return cell;
        }
        if ([baseModel isKindOfClass:[LYDetailViewsModel class]]) {
           LYDetailViewsModel *viewsModel = (LYDetailViewsModel *)baseModel;
           LYDetailViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LYDetailViewTableViewCellID forIndexPath:indexPath];
           cell.data = viewsModel;
           return cell;
        }
        
        if ([baseModel isKindOfClass:[LYDetailSelectDateModel class]]) {
            LYDetailSelectDateModel *selectDateModel = (LYDetailSelectDateModel *)baseModel;
            LYDetailSelectDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LYDetailSelectDateTableViewCellID forIndexPath:indexPath];
            cell.data = selectDateModel;
            return cell;
        }

        if ([baseModel isKindOfClass:[LYDetailHighlightsModel class]]) {
           LYDetailHighlightsModel *highlightsModel = (LYDetailHighlightsModel *)baseModel;
           LYDetailHighlightsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LYDetailHighlightsTableViewCellID forIndexPath:indexPath];
            cell.seeMoreButtonBlock = ^{
                @strongify(self);
                [self.viewModel.showMoreHighlightsCommand execute:@{@"model":highlightsModel,@"indexPath":indexPath}];
            };
           cell.data = highlightsModel;
           return cell;
        }
    }
    
    //Pick-up Details LYPickupDetailsModel
    if ([model isKindOfClass:[LYPickupDetailsModel class]]) {
        LYPickupDetailsModel *pickupDetailsModel = (LYPickupDetailsModel *)model;
        LYPickupDetailsModelItem *item = pickupDetailsModel.itemArray[indexPath.row];
        LYPickupDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LYPickupDetailsTableViewCellID forIndexPath:indexPath];
        cell.data = item;
        return cell;
    }
     //Expense
       if (([model isKindOfClass:[LYDetailExpenseModel class]])) {
           LYDetailExpenseModel *expenseModel = (LYDetailExpenseModel *)model;
           LYDetailBaseModel *item = expenseModel.dataArray[indexPath.row];
            LYDetailExpenseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LYDetailExpenseTableViewCellID forIndexPath:indexPath];
           cell.expenseSeeMoreButtonBlock = ^{
               @strongify(self);
               [self.viewModel.showMoreExpenseCommand execute:@{@"model":item,@"indexPath":indexPath}];
           };
           cell.data = item;
           return cell;
       }
    
    
     //Special notes
       if (([model isKindOfClass:[LYDetailSpecialnotesModel class]])) {
           LYDetailSpecialnotesModel *specialnotesModel = (LYDetailSpecialnotesModel *)model;
            LYDetailSpecialnotesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LYDetailSpecialnotesTableViewCellID forIndexPath:indexPath];
           cell.data = specialnotesModel;
           return cell;
       }
    

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
      //tableHeader
       if (([model isKindOfClass:[LYDetailTableHeaderModel class]])) {
           cell.backgroundColor = [LYTourscoolAPPStyleManager ly_lineColor];
       }
    return cell;

}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYDetailBaseModel *model = self.viewModel.detailSectionArray[indexPath.section];
    //行程相关
    if ([model isKindOfClass:[LYRouteListModel class]]) {
         LYRouteListModel *routelistModel = (LYRouteListModel *)model;
          LYDetailBaseModel *listModel = routelistModel.listArray[indexPath.row];
        if ([listModel isKindOfClass:[LYRouteListContentTextModel class]]) {
            LYRouteListContentTextModel *textModel = (LYRouteListContentTextModel *)listModel;
             return textModel.contentTextCellH;
         }else if ([listModel isKindOfClass:[LYRouteListScenicSpotModel class]]){
             LYRouteListScenicSpotModel *soptModel = (LYRouteListScenicSpotModel *)listModel;
              return soptModel.scenicSpotCellH;
         }else if ([listModel isKindOfClass:[LYRouteListhHotelModel class]]){
             LYRouteListhHotelModel *hotelModel = (LYRouteListhHotelModel *)listModel;
              return hotelModel.hotelCellH;
         }else if ([listModel isKindOfClass:[LYRouteListhMealsModel class]]){
             LYRouteListhMealsModel *mealsModel = (LYRouteListhMealsModel *)listModel;
              return mealsModel.mealsCellH;
         }
       }
    //公共的section里面
      if ([model isKindOfClass:[LYDetailCommonSectionModel class]]) {
          LYDetailCommonSectionModel *commonModel = (LYDetailCommonSectionModel *)model;
          LYDetailBaseModel* commonlistModel = commonModel.commonSectionArray[indexPath.row];
          //Select Date
           if ([commonlistModel isKindOfClass:[LYDetailSelectDateModel class]]) {
                 return 136;
             }
          //Highlights
          if ([commonlistModel isKindOfClass:[LYDetailHighlightsModel class]]) {
              LYDetailHighlightsModel * highlightsModel = (LYDetailHighlightsModel *)commonlistModel;
              if (highlightsModel.isFixationHighlightsCellH) {
                  if (highlightsModel.isShowMore) {
                      return highlightsModel.highlightsCellH;
                  }else{
                      return highlightsModel.fixationHighlightsCellH;
                  }
              }else{
                  return highlightsModel.highlightsExceptSeemoreButtonCellH;
              }
            }
      }
    //吸顶的section
    if (([model isKindOfClass:[LYDetailTopHeaderModel class]])) {
        return 0.001f;
    }
    //tableHeader
    if (([model isKindOfClass:[LYDetailTableHeaderModel class]])) {
        return 10;
    }
    
    //Pick-up Details LYPickupDetailsModel
    if ([model isKindOfClass:[LYPickupDetailsModel class]]) {
        return 95;
    }
    //Expense
    if (([model isKindOfClass:[LYDetailExpenseModel class]])) {
        LYDetailExpenseModel *expenseModel = (LYDetailExpenseModel*)model;
        LYDetailExpenseModelItem *expenseModelItem = expenseModel.dataArray[indexPath.row];
        if (expenseModelItem.isFixationHighlightsCellH) {
            if (expenseModelItem.isShowMore) {
                return expenseModelItem.highlightsCellH;
            }else{
                return expenseModelItem.fixationHighlightsCellH;
            }
        }else{
            return expenseModelItem.highlightsExceptSeemoreButtonCellH;
        }
        
    }

    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    LYDetailBaseModel *model = self.viewModel.detailSectionArray[section];
    //行程相关
    if ([model isKindOfClass:[LYRouteListModel class]]) {
        return LYDetailRouteSectionH;
    }
    //吸顶section
    if (([model isKindOfClass:[LYDetailTopHeaderModel class]])) {
        return LYDetailTopViewH;
    }
    //tableHeader
    if (([model isKindOfClass:[LYDetailTableHeaderModel class]])) {
        LYDetailTableHeaderModel *headerModel = (LYDetailTableHeaderModel *)model;
        return headerModel.tableHeaderH;
    }
    //Pick-up Details LYPickupDetailsModel
    if ([model isKindOfClass:[LYPickupDetailsModel class]]) {
        return 53;
    }
    //Expense
    if (([model isKindOfClass:[LYDetailExpenseModel class]])) {
        return 53;
    }
    //Special notes
    if (([model isKindOfClass:[LYDetailSpecialnotesModel class]])) {
        return 50;
    }
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    @weakify(self);
    LYDetailBaseModel *model = self.viewModel.detailSectionArray[section];
    //Pick-up Details LYPickupDetailsModel
    if ([model isKindOfClass:[LYPickupDetailsModel class]]) {
        LYPickupDetailsModel *pickupDetailsModel = (LYPickupDetailsModel *)model;
        LYDetailSeeMoreFooterView *seeMoreFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:LYDetailSeeMoreFooterViewID];
        seeMoreFooterView.footerSeeMoreButtonBlock = ^{
            @strongify(self);
            [self.viewModel.footerShowMoreCommand execute:@{@"model":pickupDetailsModel,@"section":@(section)}];
        };
        seeMoreFooterView.data = pickupDetailsModel;
        return seeMoreFooterView;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    LYDetailBaseModel *model = self.viewModel.detailSectionArray[section];
    //Pick-up Details LYPickupDetailsModel
    if ([model isKindOfClass:[LYPickupDetailsModel class]]) {
        LYPickupDetailsModel *pickupDetailsModel = (LYPickupDetailsModel *)model;
        if (!pickupDetailsModel.isShowFooter) {
            return 20;
        }
        return 54;
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    @weakify(self);
    LYDetailBaseModel *model = self.viewModel.detailSectionArray[section];
    LYRouteListModel *listModel = (LYRouteListModel *)model;
    //行程相关
    if ([model isKindOfClass:[LYRouteListModel class]]) {
        LYRouteSectionHeader *routeSectionHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:LYRouteSectionHeaderViewID];
        [routeSectionHeader setUserTapRouteSectionHeaderViewBlock:^{
            @strongify(self);
            [self.viewModel.showMoreRouteCommand execute:@{@"model":listModel,@"section":@(section)}];

        }];
        routeSectionHeader.data = model;
        return routeSectionHeader;
    }
    //吸顶section
    if (([model isKindOfClass:[LYDetailTopHeaderModel class]])) {
        LYDetailTopHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:LYDetailTopHeaderViewID];
        header.data = self.viewModel;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topHeaderTap)];
        [header addGestureRecognizer:tap];
        return header;
        
    }
    
    //tableHeader
       if (([model isKindOfClass:[LYDetailTableHeaderModel class]])) {
           LYDetailTableHeaderModel *headerModel = (LYDetailTableHeaderModel *)model;
           LYDetailTableHeaderView *tableHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:LYDetailTableHeaderViewID];
           tableHeaderView.data = headerModel;
           return tableHeaderView;
       }
    
    //Pick-up Details LYPickupDetailsModel
    if ([model isKindOfClass:[LYPickupDetailsModel class]]) {
        LYPickupDetailsModel *pickupDetailsModel = (LYPickupDetailsModel *)model;
        LYDetailCommonSectionHeaderView *commonSectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:LYDetailCommonSectionHeaderViewID];
        commonSectionHeaderView.headerTitleLabel.text = pickupDetailsModel.title;
        return commonSectionHeaderView;
    }

    //Expense
       if (([model isKindOfClass:[LYDetailExpenseModel class]])) {
            LYDetailCommonSectionHeaderView *commonSectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:LYDetailCommonSectionHeaderViewID];
            commonSectionHeaderView.headerTitleLabel.text = @"Expense";
            return commonSectionHeaderView;
       }
    
     //Special notes
       if (([model isKindOfClass:[LYDetailSpecialnotesModel class]])) {
           LYDetailSpecialnotesModel *specialnotesModel = (LYDetailSpecialnotesModel *)model;
            LYDetailSpecialnotesHeaderView *specialnotesHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:LYDetailSpecialnotesHeaderViewID];
           specialnotesHeaderView.userTapSpecialnotesSectionHeaderViewBlock = ^{
               @strongify(self);
               [self.viewModel.showMoreRouteCommand execute:@{@"model":specialnotesModel,@"section":@(section)}];
           };
           specialnotesHeaderView.data = specialnotesModel;
           return specialnotesHeaderView;
       }
    
    //默认header
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    return headerView;
}

- (void)topHeaderTap{
    __block NSInteger currentHeaderIdx;
    [self.viewModel.detailSectionArray enumerateObjectsUsingBlock:^(LYDetailBaseModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([model isKindOfClass:[LYDetailTopHeaderModel class]]) {
            currentHeaderIdx = idx;
            *stop = YES;
        }
    }];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:currentHeaderIdx] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LYDetailBaseModel *model = self.viewModel.detailSectionArray[indexPath.section];
    //装有评价reviews、View、Highlights相关
    if ([model isKindOfClass:[LYDetailCommonSectionModel class]]) {
           LYDetailCommonSectionModel *commonSectionModel = (LYDetailCommonSectionModel *)model;
            LYDetailBaseModel *baseModel = commonSectionModel.commonSectionArray[indexPath.row];
        if ([baseModel isKindOfClass:[LYDetailReviewsModel class]]) {
            LYReviewDetailListViewController *vc = [[LYReviewDetailListViewController alloc]initWithNibName:NSStringFromClass([LYReviewDetailListViewController class]) bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }

    }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    self.currentOffsetY = offsetY;
    NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, offsetY + kTopHeight/2 + kTopHeight - 10)];
    NSLog(@"%lu---%f", indexPath.section,offsetY);
    [self.customDetailNavigationBar setupViewStyleWithAlpha:offsetY/90];
    [self configDetailTopView:offsetY];
    if (self.viewModel.tapButton) {
        return;
    }
    LYDetailBaseModel *model = self.viewModel.detailSectionArray[indexPath.section];
    //吸顶section
    if (([model isKindOfClass:[LYDetailTopHeaderModel class]])) {
        [self.viewModel updateSelectTypeButtonWithTag:10001];
    }
    //Expense
    if (([model isKindOfClass:[LYDetailExpenseModel class]])) {
        [self.viewModel updateSelectTypeButtonWithTag:10002];
    }
    //Special notes
    if (([model isKindOfClass:[LYDetailSpecialnotesModel class]])) {
         [self.viewModel updateSelectTypeButtonWithTag:10003];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.viewModel.tapButton = NO;
}
@end
