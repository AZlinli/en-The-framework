//
//  UIView+LYNib.m
//  myTools
//
//  Created by 罗勇 on 2016/11/25.
//  Copyright © 2016年 saber. All rights reserved.
//

#import "UIView+LYNib.h"

@implementation UIView (LYNib)
+ (instancetype)loadFromNib{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil];
    return [nibs firstObject];
}

+ (instancetype)loadFromNibWithName:(NSString*)aName{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:aName owner:self options:nil];
    return [nibs firstObject];
}

+ (instancetype)loadFromNibWithFrame:(CGRect)frame{
    UIView * nibView = [self loadFromNib];
    nibView.frame = frame;
    return nibView;
}

+ (UINib *)nib{
    return [UINib nibWithNibName:NSStringFromClass([self class])
                          bundle:[NSBundle mainBundle]];
}
@end
