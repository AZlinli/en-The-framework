//
//  LYProductPopViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYProductPopViewController.h"
#import "LYProductPopTableViewCell.h"
#import "LYProductListPopFliterModel.h"

@interface LYProductPopViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation LYProductPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
}

- (void)setupInterface{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LYProductPopTableViewCell" bundle:nil] forCellReuseIdentifier:LYProductPopTableViewCellID];
    self.dataArray = self.data;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LYProductPopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYProductPopTableViewCellID];
    cell.data = [self.dataArray objectAtIndex:indexPath.row];
    if (indexPath.row == self.dataArray.count -1) {
        cell.sepLine.hidden = YES;
    }else{
        cell.sepLine.hidden = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     LYProductListPopFliterModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedItem::)]) {
        [self.delegate selectedItem:model index:self.index];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
