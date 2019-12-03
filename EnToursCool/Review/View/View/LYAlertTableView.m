//
//  LYAlertTableView.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/20.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYAlertTableView.h"
#define WeakSelf typeof(self) __weak weakSelf = self;

@interface LYAlertTableView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end
@implementation LYAlertTableView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    _tableViewFrame = frame;
        
    return self;
    
}


- (void)reloadData {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
        
    });
    
}


- (void)setSelectBlock:(SelectAlertTableViewBlock)selectBlock {
    
    selectBlock ? _selectBlock = [selectBlock copy] : nil;
    
}


- (void)setTapBlock:(TapCompletionBlock)tapBlock {
    
    tapBlock ? _tapBlock = [tapBlock copy] : nil;
    
}


- (void)show {
    
    self.dataArray = [self.delegate alertTableVieDataSource];
    
    [self addSubview:self.tableView];
    
    self.tableView.scrollEnabled = NO;
    
    [self.tableView reloadData];
    
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    [window addSubview:self];
    
    
    self.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:0.2 animations:^ {
        
//        self.backgroundColor = [UIColor colorWithRed:(0)/255.0 green:(0)/255.0 blue:(0)/255.0 alpha:(0.3)];
        
        self.tableView.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        
    }];
    
}


- (void)hidden {
    
    [UIView animateWithDuration:0.2 animations:^ {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.tableView.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
}


- (void)showInView:(UIView*)view {
    
    dispatch_async(dispatch_get_main_queue(), ^ {
        
        self.dataArray = [self.delegate alertTableVieDataSource];
        
        [self addSubview:self.tableView];
        
        [self.tableView reloadData];
        
        [view addSubview:self];
        
        self.backgroundColor = [UIColor clearColor];
        
        [UIView animateWithDuration:0.2 animations:^ {
            
//            self.backgroundColor = [UIColor colorWithRed:(0)/255.0 green:(0)/255.0 blue:(0)/255.0 alpha:(0.3)];
            
            self.tableView.alpha = 1.0f;
            
        } completion:^(BOOL finished) {
            
            
        }];
        
    });
    
}


- (void)setTableViewFrame:(CGRect)tableViewFrame {
    
    _tableViewFrame = tableViewFrame;
    
    self.tableView.frame = _tableViewFrame;
    
}


- (void)setGlobalFrame:(CGRect)globalFrame {
    
    self.frame = globalFrame;
    
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _selectBlock ? _selectBlock(indexPath) :nil;
    [self hidden];

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.delegate alertTableView:self heightForRowAtIndexPath:indexPath];
    
}


#pragma mark - UITableViewDataSource
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  [self.delegate alertTableView:tableView cellForRowAtIndexPath:indexPath];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:_tableViewFrame style:UITableViewStylePlain];
        
        _tableView = tableView;
        
        _tableView.dataSource = self;
        
        _tableView.delegate = self;
        
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.backgroundColor = [UIColor whiteColor];
        
        _tableView.userInteractionEnabled = YES;
        
        _tableView.layer.cornerRadius = 4.0f;
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.shadowOffset = CGSizeMake(3, 3);//有偏移量的情况,默认向右向下有阴影
        _tableView.layer.shadowColor = [UIColor grayColor].CGColor;
        _tableView.layer.shadowOffset = CGSizeZero; //设置偏移量为0,四周都有阴影
        _tableView.layer.shadowRadius = 3.0f;//阴影半径，默认3
        _tableView.layer.shadowOpacity = 0.3f;//阴影透明度，默认0
        _tableView.layer.masksToBounds = NO;
        _tableView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:_tableView.bounds cornerRadius:_tableView.layer.cornerRadius].CGPath;
        [self addSubview:_tableView];
        
    }
    
    return _tableView;
    
}


- (NSMutableArray *)dataArray {
    
    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray new];
        
    }
    return _dataArray;
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    if (!CGRectContainsPoint(_tableView.frame, point)) {
        
        [self hidden];
        
        _tapBlock ? _tapBlock (YES) : nil;
        
    }
    
}

@end



