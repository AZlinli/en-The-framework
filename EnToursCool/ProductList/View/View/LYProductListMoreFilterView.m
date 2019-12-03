//
//  LYProductListMoreFilterView.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/29.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYProductListMoreFilterView.h"
#import "LYProductListMoreFilterSectionHeader.h"
#import "LYProductListMoreFilterTableViewCell.h"
#import "LYProductListFliterModel.h"

@interface LYProductListMoreFilterView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView * backView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UIButton * saveButton;
@property (nonatomic, copy) NSArray<NSString *> * dataTitleArray;
@property (nonatomic, copy) NSDictionary<NSString *, NSArray *> * dataDictionary;
@end

@implementation LYProductListMoreFilterView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];
        self.backView = [[UIView alloc] init];
        self.backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backView];
        
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backButton setImage:[UIImage imageNamed:@"close_button"] forState:UIControlStateNormal];
        [self.backView addSubview:self.backButton];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = @"title";
        self.titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_17];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"3D3D3D"];
        [self.backView addSubview:self.titleLabel];
        
        self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
        self.saveButton.titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_16];
        [self.saveButton setTitleColor:[LYTourscoolAPPStyleManager ly_19A8C7Color] forState:UIControlStateNormal];
        [self.backView addSubview:self.saveButton];
        
        self.tableView = [[UITableView alloc] init];
        [self.backView addSubview:self.tableView];
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 16.f, 0, 16.f);
        
        [self.tableView registerNib:[UINib nibWithNibName:@"LYProductListMoreFilterTableViewCell" bundle:nil] forCellReuseIdentifier:LYProductListMoreFilterTableViewCellID];
        [self.tableView registerClass:[LYProductListMoreFilterSectionHeader class] forHeaderFooterViewReuseIdentifier:LYProductListMoreFilterSectionHeaderID];
        

        self.tableView.sectionIndexColor = [UIColor colorWithHexString:@"3d3d3d"];
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        @weakify(self);
       [[self.backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           @strongify(self);
               [self filtrateViewAnimateWithType:NO];
       }];
           
       [[self.saveButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           @strongify(self);
               [self filtrateViewAnimateWithType:NO];
       }];
        
        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backView.mas_top).offset(52.f);
            make.left.equalTo(self.backView.mas_left).offset(16.f);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.backView.mas_centerX);
            make.centerY.equalTo(self.backButton.mas_centerY);
        }];
        
        [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel.mas_centerY);
            make.right.equalTo(self.backView.mas_right).offset(-16.f);
        }];
        
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10.f);
            make.right.bottom.left.equalTo(self.backView);
        }];
        
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.width.equalTo(self.mas_width).multipliedBy(0.8);
            make.right.equalTo(self.mas_right).offset(kScreenWidth*0.8);
        }];
    }
    return self;
}

- (void)dataDidChange{
    [self filtrateViewAnimateWithType:YES];
//    self.filtrateModel = self.data;
//    self.titleLabel.text = self.filtrateModel.title;
    self.titleLabel.text = @"Departure City";
//    NSArray<LYFiltrateItemModel *> * data = self.data;//self.filtrateModel.items;
    
    LYFiltrateItemModel *model0 = [[LYFiltrateItemModel alloc] init];
    model0.name = @"abc";
    model0.firstCode = @"A";
    
    LYFiltrateItemModel *model1 = [[LYFiltrateItemModel alloc] init];
    model1.name = @"bc";
    model1.firstCode = @"B";
    
    LYFiltrateItemModel *model2 = [[LYFiltrateItemModel alloc] init];
    model2.name = @"abc";
    model2.firstCode = @"C";
    
    NSArray<LYFiltrateItemModel *> * data = @[model0,model1,model2];
    
    NSMutableDictionary * dataMutableDictionary = [NSMutableDictionary dictionary];
    [data enumerateObjectsUsingBlock:^(LYFiltrateItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray * array = [NSMutableArray arrayWithArray:dataMutableDictionary[obj.firstCode]];
        [array addObject:obj];
        [dataMutableDictionary setObject:array forKey:obj.firstCode];
    }];
    self.dataDictionary = [dataMutableDictionary copy];
    self.dataTitleArray = [[dataMutableDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
//    @weakify(self);
//    [RACObserve(self.filtrateModel, selectItemArray) subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
//        NSMutableString * selectString = [NSMutableString string];
//        [self.filtrateModel.selectItemArray enumerateObjectsUsingBlock:^(LYFiltrateItemModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [selectString appendFormat:@"%@、",obj.name];
//        }];
//        if (selectString.length) {
//            self.currentSelectLabel.text = [NSString stringWithFormat:@"%@:%@", [LYLanguageManager ly_localizedStringForKey:@"Filtrate_Select_Title"],[selectString substringToIndex:selectString.length - 1]];
//        }else{
//            self.currentSelectLabel.text = @"";
//            [self.filtrateCityTableView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.currentSelectLabel.mas_bottom).offset(0.f);
//            }];
//        }
//    }];
//    if (self.filtrateModel.multipleChoice) {
//        self.affirmButton.hidden = NO;
//    }else{
//        self.affirmButton.hidden = YES;
//    }
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataTitleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataDictionary[self.dataTitleArray[section]].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYProductListMoreFilterTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYProductListMoreFilterTableViewCellID];
    cell.data = self.dataDictionary[self.dataTitleArray[indexPath.section]][indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.dataTitleArray.count <= 1) {
        return nil;
    }
    LYProductListMoreFilterSectionHeader * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:LYProductListMoreFilterSectionHeaderID];
    header.data = self.dataTitleArray[section];
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.filtrateModel.multipleChoice) {
//        LYFiltrateItemModel * model = self.dataDictionary[self.dataTitleArray[indexPath.section]][indexPath.row];
//        NSMutableArray * selectItemArray = [NSMutableArray arrayWithArray:self.filtrateModel.selectItemArray];
//        if ([selectItemArray containsObject:model]) {
//            model.selected = NO;
//            [selectItemArray removeObject:model];
//        }else{
//            model.selected = YES;
//            [selectItemArray addObject:model];
//        }
//        self.filtrateModel.selectItemArray = [selectItemArray copy];
//    }else{
//        NSMutableArray * selectItemArray = [NSMutableArray arrayWithArray:self.filtrateModel.selectItemArray];
//        LYFiltrateItemModel * model = self.dataDictionary[self.dataTitleArray[indexPath.section]][indexPath.row];
//        [selectItemArray enumerateObjectsUsingBlock:^(LYFiltrateItemModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if (model.itemID != obj.itemID) {
//                obj.selected = NO;
//            }
//        }];
//        [selectItemArray removeAllObjects];
//
//        model.selected = !model.selected;
//        if (model.selected) {
//            [selectItemArray addObject:model];
//        }
//        self.filtrateModel.selectItemArray = [selectItemArray copy];
//        [self filtrateViewAnimateWithType:NO];
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (self.dataTitleArray.count <= 1) {
        return nil;
    }
    return self.dataTitleArray;
}

- (void)filtrateViewAnimateWithType:(BOOL)type
{
    if (type) {
        [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right);
        }];
        [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.alpha = 1.f;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(kScreenWidth*0.8);
        }];
        [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:10 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.alpha = 0.0;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if ([[[touches anyObject] view] isKindOfClass:[self class]]) {
        [self filtrateViewAnimateWithType:NO];
    }
}

@end
