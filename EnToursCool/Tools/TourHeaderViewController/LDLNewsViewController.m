
//
//  NewsViewController.m
//  01-news
//
//  Created by Lai DongLing on 16/8/4.
//  Copyright © 2016年 LaiDongling . All rights reserved.
//

#import "LDLNewsViewController.h"
#import "LDLButton.h"

static CGFloat const titleScrollViewH = 45;
static CGFloat const LDLScale = 1.2;

#define LDLScreenW [UIScreen mainScreen].bounds.size.width
#define LDLScreenH [UIScreen mainScreen].bounds.size.height
#define LDLRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]

@interface LDLNewsViewController ()<UIScrollViewDelegate>

@property(nonatomic,weak)UIScrollView *titleView;
@property(nonatomic,weak)UIScrollView *contentView;
@property(nonatomic,strong) UIView *underline;
@property (nonatomic , assign) NSUInteger currentIndex;
//是否已经初始化了，默认NO
@property(nonatomic,assign)BOOL isInitial;
@property(nonatomic,strong)NSMutableArray<LDLButton *> *titleBtns;
@property(nonatomic,weak)LDLButton *selectBtn;

//记录上一次titleBtn的最大X值;
@property (nonatomic, assign) CGFloat lastBtnMaxX;



@end

@implementation LDLNewsViewController

#pragma mark  - 控制器生命周期-----

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lastBtnMaxX = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addLine];
    [self addTitleView];

    [self addContentView];
 }

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //添加所有标题;
    if (!_isInitial) {
    [self setUpAllTitleButton];
    if (!self.needCancleUnderLine)
    {
        //添加下划线;
        [self addUnderLineView];
    }
    }
    _isInitial = YES;

}
#pragma mark  - lazyLoading-----
- (NSMutableArray<LDLButton *> *)titleBtns
{
    if (!_titleBtns) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}

- (void)addLine
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    line.backgroundColor = [LYTourscoolAPPStyleManager ly_F1F1F1Color];
    [self.view addSubview:line];
}

- (void)addTitleView
{
    CGFloat titleViewX = 0;
    CGFloat titleViewY = self.navigationController ? 1 : 1 ;
    UIScrollView *titleView = [[UIScrollView alloc]init];
    titleView.frame = CGRectMake(titleViewX, titleViewY, LDLScreenW, titleScrollViewH);
    titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleView];
    titleView.delegate = self;
    _titleView = titleView;
    titleView.tag = 101;
//    titleView.backgroundColor = [UIColor orangeColor];
}
//添加下划线;
- (void)addUnderLineView
{

    // 第一个按钮
    LDLButton *firstTitleButton = self.titleView.subviews.firstObject;
    
    // 下划线
    UIView *underline = [[UIView alloc] init];
    underline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    underline.height = 2;
    underline.backgroundColor = [LYTourscoolAPPStyleManager ly_19A8C7Color];
    underline.y = self.titleView.height - underline.height;
    [self.titleView addSubview:underline];
    self.underline = underline;
    
    // 默认选中第一个按钮
    // 改变按钮状态
    firstTitleButton.selected = YES; // UIControlStateSelected
    self.selectBtn = firstTitleButton;
    
    [firstTitleButton.titleLabel sizeToFit]; // 主动根据文字内容计算按钮内部label的大小
    // 下划线宽度 == 按钮内部文字的宽度
    underline.width = firstTitleButton.titleLabel.width + 10;
    // 下划线中心点x
    underline.centerX = firstTitleButton.centerX;

}
- (void)addContentView
{
    CGFloat contentViewX = 0;
    CGFloat contentViewY = CGRectGetMaxY(self.titleView.frame);
    CGFloat contentViewH = LDLScreenH - contentViewY;
    UIScrollView *contentView = [[UIScrollView alloc]init];
    contentView.frame = CGRectMake(contentViewX, contentViewY, LDLScreenW, contentViewH);
    contentView.backgroundColor = [UIColor whiteColor];
    _contentView = contentView;
    contentView.delegate = self;
    [self.view addSubview:contentView];
    contentView.tag = 102;
}
- (void)setUpAllTitleButton
{
    
    //1.获取子控件总数;
    NSInteger count = self.childViewControllers.count;
    //2.遍历子控件设置标题按钮;
    CGFloat btnY = 0;
    CGFloat btnH = titleScrollViewH;
    for (int i = 0 ; i < count; i++) {
        LDLButton *btn = [LDLButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        UIViewController *VC = self.childViewControllers[i];
        [btn setTitle:VC.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn.titleLabel sizeToFit]; // 主动根据文字内容计算按钮内部label的大小
        CGFloat btnWidth = btn.titleLabel.width + (kScreenWidth - 250)/4;
        btn.frame =CGRectMake(self.lastBtnMaxX, btnY, btnWidth, btnH);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:btn];
        /**
         *  默认选择第0个btn;
         */
        if (i == 0) {
            [self btnClick:btn];
        }
        //4.存入按钮数组;
//        NSLog(@"&&&&&&&&&&&&********%@*********",self.titleBtns);
        [self.titleBtns addObject:btn];
        //5.记录最大x值
        self.lastBtnMaxX = CGRectGetMaxX(btn.frame);
    }
//    CGFloat contentW = (self.lastBtnMaxX > kScreenWidth) ? self.lastBtnMaxX : kScreenWidth;
    CGFloat contentW = kScreenWidth;

    self.titleView.contentSize = CGSizeMake(contentW, 0);
    self.titleView.showsHorizontalScrollIndicator = NO;
//      //6.设置内容滚动范围;
    self.contentView.contentSize = CGSizeMake(LDLScreenW * count, 0);
    self.contentView.showsHorizontalScrollIndicator = NO;
    self.contentView.pagingEnabled = YES;
    self.contentView.bounces = NO;
}

//获取当前控制器
- (UIViewController *)currentVc
{
    if (self.currentIndex)
    {
        return self.childViewControllers[self.currentIndex];
    }else
    {
        return self.childViewControllers.firstObject;
    }
}

//点击了某个button;
- (void)btnClick:(LDLButton *)btn
{
    NSInteger index = btn.tag;
    [self btnTitleSelect:btn];
    [self.contentView setContentOffset:CGPointMake(index * LDLScreenW, 0) animated:YES];
    [self setUpChildController:btn.tag];
}

- (void)setUpChildController:(NSInteger)i
{
    UIViewController *vc = self.childViewControllers[i];
    if (vc.view.superview) return;
    CGFloat X = i * LDLScreenW;
    CGFloat Y = 0;
    CGFloat W = self.contentView.frame.size.width;
    CGFloat H = self.contentView.frame.size.height;

    vc.view.frame = CGRectMake(X, Y, W, H);
    [self.contentView addSubview:vc.view];
}

- (void)btnTitleSelect:(LDLButton *)btn
{
    if (_selectBtn == btn)
    {
        return;
    }
    _selectBtn.selected = NO;
    btn.selected = YES;
    if (!self.isInitial)
    {
        _selectBtn.transform = CGAffineTransformIdentity;
        btn.transform = CGAffineTransformMakeScale(LDLScale, LDLScale);
    }
    _selectBtn = btn;
    // 设置标题缩放
    //文字居中;
    [self setUpCenter:btn];
    //移动下划线;
    [UIView animateWithDuration:0.15 animations:^{
        
        self.underline.width = btn.titleLabel.width + 10;
        self.underline.centerX = btn.centerX;
    }];
}

- (void)setUpCenter:(LDLButton *)btn
{
    CGFloat offsetX = btn.center.x - LDLScreenW * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }
    CGFloat maxOffsetX = self.titleView.contentSize.width - LDLScreenW;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    [self.titleView setContentOffset:CGPointMake(offsetX, 0) animated:YES];

}
#pragma mark ----UIScrollViewDelegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 101) {
        
        return;
    }
    NSInteger count = self.titleBtns.count;
    NSInteger leftI = scrollView.contentOffset.x / LDLScreenW;
    NSInteger rightI = leftI + 1;
//    NSLog(@"------****%@***-------",self.titleBtns);
    LDLButton *leftBtn = self.titleBtns[leftI];
    
    LDLButton *rightBtn;
    if (rightI < count) {
        rightBtn = self.titleBtns[rightI];
    }
    CGFloat Rscale = scrollView.contentOffset.x/LDLScreenW -leftI;
    CGFloat Lscale = 1 - Rscale;
    CGFloat transformScale = LDLScale - 1;

    leftBtn.transform = CGAffineTransformMakeScale(Lscale * transformScale + 1, Lscale * transformScale + 1);
    rightBtn.transform = CGAffineTransformMakeScale(Rscale * transformScale + 1, Rscale * transformScale + 1);
    
    // 4.标题颜色渐变
//    // 4.1获取右边按钮颜色
//    UIColor *rightColor = [UIColor colorWithRed:Rscale green:0.659 blue:0.780 alpha:1];
//    UIColor *leftColor = [UIColor colorWithRed:Lscale green:0.282 blue:0.282 alpha:1];
//    [leftBtn setTitleColor:leftColor forState:UIControlStateNormal];
//    [rightBtn setTitleColor:rightColor forState:UIControlStateNormal];

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger i = scrollView.contentOffset.x / LDLScreenW;
    self.currentIndex = i;
    if (_selectBtn == self.titleBtns[i])
    {
        return;
    }
    [self btnTitleSelect:self.titleBtns[i]];
    [self setUpChildController:i];
}


@end
