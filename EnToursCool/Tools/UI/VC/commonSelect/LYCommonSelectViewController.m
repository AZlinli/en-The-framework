//
//  LYCommonSelectViewController.m
//  EnToursCool
//
//  Created by Lin Li on 2019/12/2.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYCommonSelectViewController.h"
#import "LYCommonSelectViewModel.h"
#import "LYCommonSelectHeaderView.h"

static NSString * LYCommonSelectCellID = @"LYCommonSelectCellID";
static NSString * LYCommonSelectHeaderID = @"LYCommonSelectHeaderID";
static CGFloat CELL_HEIGHT = 44;
static CGFloat HEADER_HEIGHT = 28;

@interface LYCommonSelectViewController ()<UITableViewDelegate,UITableViewDataSource>
/**tableView*/
@property(nonatomic, strong) UITableView *tableView;
/**viewModel*/
@property(nonatomic, strong) LYCommonSelectViewModel *viewModel;
@end

@implementation LYCommonSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTable];
    [self bindViewModel];
}

- (void)creatTable {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [LYTourscoolAPPStyleManager ly_FFFFFFColor];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    // 注册cell
    [self.tableView registerClass:[LYCommonSelectTableViewCell class] forCellReuseIdentifier:LYCommonSelectCellID];
    [self.tableView registerClass:[LYCommonSelectHeaderView class] forHeaderFooterViewReuseIdentifier:LYCommonSelectHeaderID];
}

- (void)bindViewModel
{
    self.viewModel = [[LYCommonSelectViewModel alloc] init];
    @weakify(self);
    [self.viewModel.httpRequestCountriesCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        [UIView dismissHUDWithView:self.view];
    }];
    
    [self.viewModel.httpRequestCountriesCommand.executing subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self);
        if ([x boolValue]) {
            [UIView showLoadingHUDWithView:self.view msg:nil];
        }else{
            [UIView dismissHUDWithView:self.view];
        }
    }];
    
    [self.viewModel.httpRequestCountriesCommand execute:nil];
    
    [RACObserve(self.viewModel, dataArray) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataDictionary[self.viewModel.dataArray[section]].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYCommonSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LYCommonSelectCellID forIndexPath:indexPath];
    cell.data = self.viewModel.dataDictionary[self.viewModel.dataArray[indexPath.section]][indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HEADER_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *title = self.viewModel.dataArray[section];
    LYCommonSelectHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:LYCommonSelectHeaderID];
    headerView.data = title;
    return headerView;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return  self.viewModel.dataArray;
}

@end

#pragma mark - LYCommonSelectModel

@implementation LYCommonSelectModel
MJCodingImplementation

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"countriesID":@"id",@"telcode":@"tel_code"};
}

- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues
{
    if (self.name.length) {
        NSString * pinying = [NSString transformChineseToPinYingWithChinese:self.name];
        self.allPinYin = [pinying undockSpecialSymbol];
        self.pinyin = [NSString allFirstLetter:self.name];
        self.key = [NSString firstLetter:self.name];
    }
}
@end


#pragma mark - LYCommonSelectTableViewCell

@interface LYCommonSelectTableViewCell()
/**name*/
@property(nonatomic, strong) UILabel *nameLabel;
/**codeLabel*/
@property(nonatomic, strong) UILabel *codeLabel;
/**model*/
@property(nonatomic, strong) LYCommonSelectModel *model;

@end

@implementation LYCommonSelectTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

- (void)dataDidChange {
    self.model = self.data;
    self.nameLabel.text = self.model.name;
    self.codeLabel.text = self.model.telcode;
}


- (void)setUI {
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.codeLabel];
    
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(16);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(16);
        make.right.equalTo(self.codeLabel.mas_left).offset(-10);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [LYTourscoolAPPStyleManager ly_lineColor];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(1);
    }];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
        _nameLabel.textColor = [LYTourscoolAPPStyleManager ly_3D3D3DColor];
    }
    return _nameLabel;
}

- (UILabel *)codeLabel {
    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc]init];
        _codeLabel.textAlignment = NSTextAlignmentCenter;
        _codeLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
        _codeLabel.textColor = [LYTourscoolAPPStyleManager ly_7F7F7FColor];
    }
    return _codeLabel;
}

@end


