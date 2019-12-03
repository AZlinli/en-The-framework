//
//  LYProductListViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/20.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYProductListViewController.h"
#import "LYProductListViewModel.h"
#import "LYProductListVCNavigationTitleView.h"
#import "LYProductListTableViewCell.h"
#import "LYProductPopViewController.h"
#import "LYProductListFilterViewController.h"

@interface LYProductListViewController ()<UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate,LYProductPopViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *fliterButton1;
@property (weak, nonatomic) IBOutlet UIButton *fliterButton2;
@property (weak, nonatomic) IBOutlet UIButton *fliterButton3;
@property (nonatomic, strong) LYProductListViewModel *viewModel;

@end

@implementation LYProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
    [self bindViewModel];
}

- (void)setupInterface{
    LYProductListVCNavigationTitleView * productListSearchTextField = [[LYProductListVCNavigationTitleView alloc] init];
    [productListSearchTextField setGoSearchVCBlock:^{
//        [LYRouterManager openSomeOneVCWithParameters:@[self.navigationController,@{@"itemType":@"0"}] urlKey:SearchViewControllerKey];
    }];
    self.navigationItem.titleView = productListSearchTextField;
    
    
    [self.fliterButton1 setImage:[UIImage imageNamed:@"list_down_arrow"] forState:UIControlStateNormal];
    [self.fliterButton1 setTitle:@"Sort" forState:UIControlStateNormal];
    [self.fliterButton1 setTitleEdgeInsets:UIEdgeInsetsMake(0, - self.fliterButton1.imageView.image.size.width, 0, self.fliterButton1.imageView.image.size.width + 10)];
    [self.fliterButton1 setImageEdgeInsets:UIEdgeInsetsMake(0, self.fliterButton1.titleLabel.bounds.size.width+ 10, 0, -self.fliterButton1.titleLabel.bounds.size.width)];
    
    [self.fliterButton2 setImage:[UIImage imageNamed:@"list_down_arrow"] forState:UIControlStateNormal];
    [self.fliterButton2 setTitle:@" Duration" forState:UIControlStateNormal];
    [self.fliterButton2 setTitleEdgeInsets:UIEdgeInsetsMake(0, - self.fliterButton2.imageView.image.size.width, 0, self.fliterButton2.imageView.image.size.width + 10)];
    [self.fliterButton2 setImageEdgeInsets:UIEdgeInsetsMake(0, self.fliterButton2.titleLabel.bounds.size.width+ 10, 0, -self.fliterButton2.titleLabel.bounds.size.width)];
    
    
    [self.fliterButton3 setImage:[UIImage imageNamed:@"list_down_arrow"] forState:UIControlStateNormal];
    [self.fliterButton3 setTitle:@"Filter" forState:UIControlStateNormal];
    [self.fliterButton3 setTitleEdgeInsets:UIEdgeInsetsMake(0, - self.fliterButton3.imageView.image.size.width, 0, self.fliterButton3.imageView.image.size.width + 10)];
    [self.fliterButton3 setImageEdgeInsets:UIEdgeInsetsMake(0, self.fliterButton3.titleLabel.bounds.size.width+ 10, 0, -self.fliterButton3.titleLabel.bounds.size.width)];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LYProductListTableViewCell" bundle:nil] forCellReuseIdentifier:LYProductListTableViewCellID];
}

- (void)bindViewModel{
    self.viewModel = [[LYProductListViewModel alloc] initWithParameter:self.data];
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
    LYProductListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYProductListTableViewCellID];
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

- (IBAction)clickFliterButton1:(id)sender {
    
    UIButton *button = sender;
    
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYProductListStoryboard" bundle:nil];
    LYProductPopViewController * popVC = [sb instantiateViewControllerWithIdentifier:@"LYProductPopViewController"];
    popVC.delegate = self;
    popVC.index = 1;
    popVC.data = self.viewModel.sortArray;
    popVC.preferredContentSize = CGSizeMake(252.0f, 245.0f);
    popVC.modalPresentationStyle = UIModalPresentationPopover;

    UIPopoverPresentationController *popver = [popVC popoverPresentationController];
    popver.delegate = self;
    popver.permittedArrowDirections = UIPopoverArrowDirectionUp; // 箭头位置
    popver.sourceView = button; // 设置目标视图
    popver.sourceRect = CGRectMake(button.frame.size.width/2, button.frame.origin.y, 10.0f, 0.0f); // 弹出视图显示位置
    popver.backgroundColor = [UIColor whiteColor];
    [self presentViewController:popVC animated:YES completion:NULL];
}

- (IBAction)clickFliterButton2:(id)sender {
    UIButton *button = sender;
    
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYProductListStoryboard" bundle:nil];
    LYProductPopViewController * popVC = [sb instantiateViewControllerWithIdentifier:@"LYProductPopViewController"];
    popVC.index = 2;
    popVC.delegate = self;
    popVC.preferredContentSize = CGSizeMake(252.0f, 245.0f);
    popVC.modalPresentationStyle = UIModalPresentationPopover;

    UIPopoverPresentationController *popver = [popVC popoverPresentationController];
    popver.delegate = self;
    popver.permittedArrowDirections = UIPopoverArrowDirectionUp; // 箭头位置
    popver.sourceView = button; // 设置目标视图
    popver.sourceRect = CGRectMake(button.frame.size.width/2, button.frame.origin.y, 10.0f, 0.0f); // 弹出视图显示位置
    popver.backgroundColor = [UIColor whiteColor];
    [self presentViewController:popVC animated:YES completion:NULL];
}

- (IBAction)clickFliterButton3:(id)sender {
//    [self.fliterView filtrateViewAnimateWithType:YES];
//    [self.navigationController pushViewController:self.filterVC animated:YES];
    LYProductListFilterViewController *vc = [[LYProductListFilterViewController alloc] init];
    vc.viewModel = self.viewModel;
    vc.data = self.viewModel.fliterArray;
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - LYProductPopViewControllerDelegate
-(void)selectedItem:(id)model index:(NSInteger)index{
    //todo
    if (model) {
        if (index == 1) {

        }else{

        }
    }
}

#pragma mark - UIPopoverPresentationControllerDelegate
- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return YES;
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

@end
