//
//  EBDropdownList.m
//  DropdownListDemo
//
//  Created by Laidongling on 2018/4/17.
//  Copyright © 2018年 HoYo. All rights reserved.
//

#import "EBDropdownListView.h"
#import "UIView+LYCorner.h"
#import "NSString+LYSize.h"
#import "EBDropCell.h"

@implementation EBDropdownListItem

- (instancetype)initWithItem:(NSString*)itemId itemName:(NSString*)itemName
{
    self = [super init];
    if (self) {
        _itemId = itemId;
        _itemName = itemName;
    }
    return self;
}

- (instancetype)init {
    return [self initWithItem:nil itemName:nil];
}

- (CGFloat)rowHeight
{
    if (_itemName.filterSpace.length)
    {
       CGFloat height = [_itemName heightWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:kScreenWidth - 32 - 20 - 6 - 5];
        return height + 20;
    }else
    {
        return 0;
    }
}
@end


@interface EBDropdownListView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *arrowImg;
@property (nonatomic, strong) UITableView *tbView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, copy) EBDropdownListViewSelectedBlock selectedBlock;
@end

static CGFloat const kArrowImgHeight= 4;
static CGFloat const kArrowImgWidth= 6;
static CGFloat const kTextLabelX = 5;
static CGFloat const kItemCellHeight = 40;

@implementation EBDropdownListView

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self setupProperty];
    }
    return self;
}

- (instancetype)initWithDataSource:(NSArray*)dataSource {
    _dataSource = dataSource;
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupFrame];
}

#pragma mark - Setup
- (void)setupProperty {
    _textColor = [UIColor blackColor];
    _font = [UIFont systemFontOfSize:14];
    _selectedIndex = 0;
    _textLabel.font = _font;
    _textLabel.textColor = _textColor;
    _textLabel.text = _initailString;
    
    UITapGestureRecognizer *tapLabel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewExpand:)];
    [_textLabel addGestureRecognizer:tapLabel];

    UITapGestureRecognizer *tapImg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewExpand:)];
    [_arrowImg addGestureRecognizer:tapImg];
}

- (void)setupView
{
    [self.tbView registerNib:[UINib nibWithNibName:NSStringFromClass([EBDropCell class]) bundle:nil] forCellReuseIdentifier:EBDropCellID];
    self.tbView.scrollEnabled = NO;
    [self addSubview:self.textLabel];
    [self addSubview:self.arrowImg];
}

- (void)setupFrame {
    CGFloat viewWidth = CGRectGetWidth(self.bounds)
    , viewHeight = CGRectGetHeight(self.bounds);
  
    _textLabel.frame = CGRectMake(kTextLabelX, 0, viewWidth - kTextLabelX - kArrowImgWidth - 20 , viewHeight);
    _arrowImg.frame = CGRectMake(CGRectGetWidth(_textLabel.frame) + 10 , viewHeight / 2 - kArrowImgHeight / 2, kArrowImgWidth, kArrowImgHeight);
}

#pragma mark - Events
-(void)tapViewExpand:(UITapGestureRecognizer *)sender {
    [self rotateArrowImage];
    
//    CGFloat tableHeight = _dataSource.count * kItemCellHeight;
    CGFloat tableHeight = [self getAllRowHeight];

    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.backgroundView];
    [window addSubview:self.tbView];
    
    // 获取按钮在屏幕中的位置
    CGRect frame = [self convertRect:self.bounds toView:window];
    CGFloat tableViewY = frame.origin.y + frame.size.height;
    CGRect tableViewFrame;
    tableViewFrame.size.width = frame.size.width;
    tableViewFrame.size.height = tableHeight;
    tableViewFrame.origin.x = frame.origin.x;
    if (tableViewY + tableHeight < CGRectGetHeight([UIScreen mainScreen].bounds)) {
        tableViewFrame.origin.y = tableViewY;
    }else {
        tableViewFrame.origin.y = frame.origin.y - tableHeight;
    }
    _tbView.frame = tableViewFrame;
    
    UITapGestureRecognizer *tagBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewDismiss:)];
    [_backgroundView addGestureRecognizer:tagBackground];
}

-(void)tapViewDismiss:(UITapGestureRecognizer *)sender {
    [self removeBackgroundView];
}

#pragma mark - Methods
- (void)setDropdownListViewSelectedBlock:(EBDropdownListViewSelectedBlock)block {
    _selectedBlock = block;
}

- (void)setViewBorder:(CGFloat)width borderColor:(UIColor*)borderColor cornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = width;
}

- (void)rotateArrowImage {
    // 旋转箭头图片
    _arrowImg.transform = CGAffineTransformRotate(_arrowImg.transform, M_PI);
}

- (void)removeBackgroundView {
    [_backgroundView removeFromSuperview];
    [_tbView removeFromSuperview];
    [self rotateArrowImage];
}

- (void)selectedItemAtIndex:(NSInteger)index {
    _selectedIndex = index;
    if (index < _dataSource.count) {
        EBDropdownListItem *item = _dataSource[index];
        _selectedItem = item;
        _textLabel.text = item.itemName;
    }
}

- (CGFloat)getAllRowHeight
{
    CGFloat height = 0.0;
    for (EBDropdownListItem *item in _dataSource)
    {
        height += item.rowHeight;
    }
    return height;
}

#pragma mark - UITableDatasource

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EBDropCell *cell = [self.tbView dequeueReusableCellWithIdentifier:EBDropCellID];
    cell.dropItem = self.dataSource[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self selectedItemAtIndex:indexPath.row];
    [self removeBackgroundView];
    if (_selectedBlock) {
        _selectedBlock(self);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EBDropdownListItem *item = self.dataSource[indexPath.row];
    return item.rowHeight;
}


#pragma mark - Setter

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    if (dataSource.count > 0) {
        [self selectedItemAtIndex:_selectedIndex];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [self selectedItemAtIndex:selectedIndex];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    _textLabel.font = font;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    _textLabel.textColor = textColor;
}

- (void)setInitailString:(NSString *)initailString
{
    _initailString = initailString;
    _textLabel.text = initailString;
}

#pragma mark - Getter
- (UILabel*)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.userInteractionEnabled = YES;
        _textLabel.numberOfLines = 1;
    }
    return _textLabel;
}

- (UIImageView*)arrowImg {
    if (!_arrowImg) {
        _arrowImg = [UIImageView new];
        _arrowImg.image = [UIImage imageNamed:@"dropDown"];
        _arrowImg.userInteractionEnabled = YES;
    }
    return _arrowImg;
}

- (UITableView*)tbView {
    if (!_tbView) {
        _tbView = [UITableView new];
        _tbView.dataSource = self;
        _tbView.delegate = self;
        _tbView.tableFooterView = [UIView new];
        _tbView.backgroundColor = [UIColor whiteColor];
        _tbView.layer.shadowOffset = CGSizeMake(4, 4);
        _tbView.layer.shadowColor = [LYTourscoolAPPStyleManager ly_C7D0D9Color].CGColor;
        _tbView.layer.shadowOpacity = 0.8;
        _tbView.layer.shadowRadius = 4;
        _tbView.layer.borderColor = [LYTourscoolAPPStyleManager ly_C7D0D9Color].CGColor;
        _tbView.layer.borderWidth = 0.5;
        _tbView.layer.cornerRadius = 4.f;
        _tbView.layer.masksToBounds = YES;
        

        
        
    }
    return _tbView;
}

- (UIView*)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _backgroundView;
}


@end
