//
//  GAHeaderView.m
//  GAIA供应
//
//  Created by  GAIA on 2017/9/20.
//  Copyright © 2017年 laidongling. All rights reserved.
//

#import "GAHeaderView.h"
#import "GAButton.h"

@interface GAHeaderView()

@property (nonatomic,strong)GAButton *btn;
//上次选中的button
@property(nonatomic,strong)GAButton *selectBtn;
@property(nonatomic,strong)UIView *underLine;
//标题栏高度
@property (nonatomic , assign) CGFloat titleH;
//标题栏宽度
@property (nonatomic , assign) CGFloat titleW;
//传入的标题数组
@property (nonatomic , copy) NSArray *titleArr;
@property (nonatomic , strong) NSMutableArray *buttonArr;

@property (nonatomic , copy) titleBtnClick click;

//默认字体颜色
@property (strong, nonatomic) UIColor *titleColor;
//选中字体颜色
@property (strong, nonatomic) UIColor *titleSelctColor;
//下划线颜色
@property (strong, nonatomic) UIColor *lineColor;

//第一次加载的时候设置下划线中心点
@property (assign, nonatomic) BOOL isFirstLoad;

@end

@implementation GAHeaderView

#pragma mark - lifeCircle

+ (instancetype)headerWithTitleH:(CGFloat)titleH headWidth:(CGFloat)width arr:(NSArray *)titleArr titleColor:(UIColor *)titleColor titleSelectColor:(UIColor *)titleSelectColor lineColor:(UIColor *)lineColor titleBlock:(titleBtnClick)clickBlock
{
    return [[self alloc] initWithTitleH:titleH headWidth:width arr:titleArr titleColor:titleColor titleSelectColor:titleSelectColor lineColor:lineColor titleBlock:clickBlock];
}

- (instancetype)initWithTitleH:(CGFloat)titleH headWidth:(CGFloat)width arr:(NSArray *)titleArr titleColor:(UIColor *)titleColor titleSelectColor:(UIColor *)titleSelectColor lineColor:(UIColor *)lineColor titleBlock:(titleBtnClick)clickBlock
{
    if (self = [super init])
    {
        self.click = clickBlock;
        self.titleH = titleH;
        self.titleW = width;
        self.titleColor = titleColor;
        self.titleSelctColor = titleSelectColor;
        self.lineColor = lineColor;
        self.titleArr = titleArr;
        [self setUpAllTitleButton];
        [self addUnderLine:titleH];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = self.titleW / self.titleArr.count;
    for (UIButton *button in self.subviews)
    {
        if ([button isKindOfClass:[UIButton class]])
        {
            btnX = button.tag * btnW;
            button.frame = CGRectMake(btnX, btnY, btnW,self.titleH);
        }
    }
//    self.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:.5].CGColor;
//    self.layer.shadowOffset = CGSizeMake(0, 2);
//    self.layer.shadowRadius = 2;
//    self.layer.shadowOpacity = .6;
    
    if (self.isFirstLoad)
    {
        self.underLine.centerX = ((UIButton *)self.buttonArr.firstObject).centerX;
        self.isFirstLoad = NO;
    }
}

#pragma mark - privitMethod
- (void)clearHeadTag
{
    [self removeFromSuperview];
}

- (void)setUpAllTitleButton
{
    self.buttonArr = [NSMutableArray array];
    for (int i = 0 ; i < self.titleArr.count; i++)
    {
        GAButton *btn = [GAButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.buttonArr addObject:btn];
        
        if (i == 0)
        {
            [self btnClick:btn];
        }
    }
}

- (void)addUnderLine:(CGFloat)titleH
{
    self.isFirstLoad = YES;
    CGFloat lineX = 0;
    CGFloat lineY = titleH - 2;
    CGFloat lineW = self.titleW / self.titleArr.count;
    CGFloat lineH = 2;
    UIView *underView = [[UIView alloc]init];
    underView.frame = CGRectMake(lineX, lineY, lineW, lineH);
    underView.backgroundColor = self.lineColor;
    [self addSubview:underView];
    self.underLine = underView;
    
}


#pragma mark - action

- (void)btnClick:(GAButton *)btn
{
    _selectBtn.selected = NO;
    [_selectBtn setTitleColor:self.titleColor forState:UIControlStateNormal];
    [btn setTitleColor:self.titleSelctColor forState:UIControlStateNormal];
    btn.selected = YES;
    _selectBtn = btn;
    [UIView animateWithDuration:0.2 animations:^{
        self.underLine.centerX = btn.centerX;
    }];
    OBJC_BLOCK_EXEC(self.click,btn.tag);
    
}

- (void)selectAtIndex:(NSUInteger)index
{
    GAButton *btn = ((GAButton *)self.buttonArr[index]);
    _selectBtn.selected = NO;
    [_selectBtn setTitleColor:self.titleColor forState:UIControlStateNormal];
    [btn setTitleColor:self.titleSelctColor forState:UIControlStateNormal];
    btn.selected = YES;
    _selectBtn = btn;
    [UIView animateWithDuration:0.2 animations:^{
        self.underLine.centerX = btn.centerX;
    }];
}


@end
