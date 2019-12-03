//
//  LYWishListViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/20.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYWishListViewController.h"
#import "LYWishListViewModel.h"
#import "LYWishListTableViewCell.h"
#import "LYWishListEditView.h"
#import "LYWishListItemModel.h"
#import "LYToursCoolAPPManager.h"

@interface LYWishListViewController ()<UITableViewDelegate,UITableViewDataSource,LYWishListEditViewDelegate>
@property (nonatomic, strong) LYWishListViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;
@property (weak, nonatomic) IBOutlet UIView *deletedView;
@property (nonatomic, strong) LYWishListEditView *editView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewBottomCons;
@property (weak, nonatomic) IBOutlet UIView *nullView;
@property (weak, nonatomic) IBOutlet UIButton *goAndSeeButton;

@end

@implementation LYWishListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
    [self bindViewModel];
}

- (void)setupInterface{
    self.navigationItem.title = @"My Wishlist";
    self.deletedView.hidden = YES;
    self.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size: 16];
    self.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.titleLabel.text = @"My Wishlist";
    self.removeButton.titleLabel.font =  [UIFont fontWithName:@"Arial" size: 12];
    [self.removeButton setTitleColor:[UIColor colorWithHexString:@"19A8C7"] forState:UIControlStateNormal];
    [self.removeButton setTitle:@"Remove" forState:UIControlStateNormal];
    
    [self.removeButton setTitleColor:[UIColor colorWithHexString:@"19A8C7"] forState:UIControlStateSelected];
    [self.removeButton setTitle:@"Done" forState:UIControlStateSelected];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"LYWishListTableViewCell" bundle:nil] forCellReuseIdentifier:LYWishListTableViewCellID];
    
    LYWishListEditView *editView = [[LYWishListEditView alloc] init];
    editView.delegate = self;
    editView.data = @(0);
    [self.view addSubview:editView];
    [editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottomMargin);
        make.left.right.equalTo(self.view);
        make.height.offset(70.f);
    }];
    self.editView = editView;
    self.editView.hidden = YES;
    self.nullView.hidden = YES;
    
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"Go and see"];
       
       [tncString addAttribute:NSUnderlineStyleAttributeName
                         value:@(NSUnderlineStyleSingle)
                         range:(NSRange){0,[tncString length]}];

       [tncString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"19A8C7"]  range:NSMakeRange(0,[tncString length])];
       

       [tncString addAttribute:NSUnderlineColorAttributeName value:[UIColor colorWithHexString:@"19A8C7"] range:(NSRange){0,[tncString length]}];
       [self.goAndSeeButton setAttributedTitle:tncString forState:UIControlStateNormal];
}

- (void)bindViewModel{
    self.viewModel = [[LYWishListViewModel alloc] init];
    
    @weakify(self);
    [[RACObserve(self.viewModel, isSelectedAll) skip:1] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.editView.data = @(self.viewModel.deleteArray.count);
    }];
    
    [[RACObserve(self.viewModel, dataArray) skip:1] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (self.viewModel.dataArray.count == 0) {
            self.editView.hidden = YES;
            self.removeButton.selected = NO;
            self.nullView.hidden = NO;
        }else{
            [self.tableview reloadData];
            self.nullView.hidden = YES;
        }
        
        self.editView.count = self.viewModel.dataArray.count;
    }];
    self.editView.count = self.viewModel.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LYWishListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYWishListTableViewCellID];
    cell.data = [self.viewModel.dataArray objectAtIndex:indexPath.row];
    if (indexPath.row == self.viewModel.dataArray.count -1) {
        cell.sepLine.hidden = YES;
    }else{
        cell.sepLine.hidden = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    @weakify(self);
    return @[[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:[LYLanguageManager ly_localizedStringForKey:@"Remove"] handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        @strongify(self);
        [self.viewModel.deleteItemsCommand execute:indexPath];
    }]];
}

- (IBAction)clickRemoveButton:(id)sender {
    self.removeButton.selected = !self.removeButton.selected;
    self.editView.hidden = !self.removeButton.selected;
    [self.editView modifySelectButtonState];
    [self.viewModel.dataArray enumerateObjectsUsingBlock:^(LYWishListItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isEdit = !obj.isEdit;
        obj.isSelected = NO;
    }];
    
    if (self.editView.hidden) {
        self.tableviewBottomCons.constant = 0.f;
    }else{
        self.tableviewBottomCons.constant = 50.f;
    }
}

-(void)clickSelectedAllButton:(BOOL)isSelected{
    [self.viewModel.dataArray enumerateObjectsUsingBlock:^(LYWishListItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isSelected = isSelected;
    }];
    
}

-(void)clickDeleteButton{
    [self.viewModel.deleteItemsCommand execute:nil];
}

//todo
- (IBAction)clickGoAndSeeButton:(id)sender {
    [self endFlowBackVC];
    [LYToursCoolAPPManager switchHome];
}

- (void)endFlowBackVC
{
    UIViewController * lastViewController = [self.navigationController.viewControllers objectAtIndex:0];
    if (self.navigationController.viewControllers.count >= 1) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    if (lastViewController.presentingViewController) {
        [lastViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
