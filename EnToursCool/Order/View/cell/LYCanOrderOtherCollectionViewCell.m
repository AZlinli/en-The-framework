//
//  LYCanOrderOtherCollectionViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYCanOrderOtherCollectionViewCell.h"
#import "UIView+LYCorner.h"

NSString * const LYCanOrderOtherCollectionViewCellID = @"LYCanOrderOtherCollectionViewCellID";

@interface LYCanOrderOtherCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIView *addPicView;
@property (weak, nonatomic) IBOutlet UIImageView *commentImagView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end

@implementation LYCanOrderOtherCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)dataDidChange{
    if (self.isAddPic) {
        self.deleteButton.hidden = YES;
        self.commentImagView.hidden = YES;
        self.addPicView.hidden = NO;
        [self drawAddPicView];
    }else{
        self.deleteButton.hidden = NO;
        self.commentImagView.hidden = NO;
        self.addPicView.hidden = YES;
        UIImage *image = self.data;
        self.commentImagView.image = image;
    }
}


- (IBAction)cliclDeleteButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteImage:)]) {
        [self.delegate deleteImage:self.data];
    }
}

- (void)drawAddPicView{

    self.addPicView.alpha = 1.0;
    self.addPicView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.addPicView.layer.shadowColor = [UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha:0.16].CGColor;
    self.addPicView.layer.shadowOffset = CGSizeMake(0,4);
    self.addPicView.layer.shadowRadius = 6;
    self.addPicView.layer.shadowOpacity = 1;
    self.addPicView.layer.cornerRadius = 8;
}

@end
