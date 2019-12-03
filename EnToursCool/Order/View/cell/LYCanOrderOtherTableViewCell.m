//
//  LYCanOrderOtherTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYCanOrderOtherTableViewCell.h"
#import "UITextView+WZB.h"

#import "LYSafeImagePickerViewController.h"
#import "UIView+LYUtil.h"
#import "UIImage+LYUtil.h"
#import "LYCanOrderOtherCollectionViewCell.h"

NSString * const LYCanOrderOtherTableViewCellID = @"LYCanOrderOtherTableViewCellID";
@interface LYCanOrderOtherTableViewCell()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,LYCanOrderOtherCollectionViewCellDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (nonatomic, strong) LYSafeImagePickerViewController *imagePickerController;
@end

@implementation LYCanOrderOtherTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textView.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.textView.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
    self.textView.wzb_placeholder = @"Tell Us Something About Your Trip.";
    self.textView.wzb_placeholderColor = [LYTourscoolAPPStyleManager ly_AEAEAEColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"LYCanOrderOtherCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:LYCanOrderOtherCollectionViewCellID];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dataDidChange{
    NSArray *array = self.data;
    [self.imageArray removeAllObjects];
    [self.imageArray addObjectsFromArray:array];
    [self.collectionView reloadData];
}


- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}


- (void)addPic{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * acncelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];

    [alertController addAction:acncelAction];
    @weakify(self);
    
    UIAlertAction * photoAction = [UIAlertAction actionWithTitle:@"Take a photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self setupImagePickerControllerWithType:0];
    }];

    [alertController addAction:photoAction];
    
    UIAlertAction * photoAlbumAction = [UIAlertAction actionWithTitle:@"Albums" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self setupImagePickerControllerWithType:1];
    }];

    [alertController addAction:photoAlbumAction];
    
    [self.viewController presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - UIImagePickerControllerDelegate

- (void)setupImagePickerControllerWithType:(NSInteger)type
{
    if (!self.imagePickerController) {
        LYSafeImagePickerViewController *imagePickerController = [[LYSafeImagePickerViewController alloc] init];
        imagePickerController.allowsEditing = YES;
        self.imagePickerController = imagePickerController;
    }
    if (!self.imagePickerController.delegate) {
        self.imagePickerController.delegate = self;
    }
    if (type == 0) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self.viewController presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.imagePickerController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    self.imagePickerController.delegate = nil;
}

//todo
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.imageArray addObject:image];
     if(self.delegate && [self.delegate respondsToSelector:@selector(modifyImage:)]){
           [self.delegate modifyImage:self.imageArray];
       }
//    self.userHeaderImageView.image = [UIImage rescaleToSize:image toSize:CGSizeMake(35.f, 35.f)];
//    self.modifyUserInfoViewModel.userUpdateFace = @"1";
//    [self.modifyUserInfoViewModel.updateImageCommand execute:image];
//
    [self.imagePickerController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    self.imagePickerController.delegate = nil;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.imageArray.count == 6) {
        return 6;
    }else{
        return self.imageArray.count + 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     LYCanOrderOtherCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LYCanOrderOtherCollectionViewCellID forIndexPath:indexPath];
    if (self.imageArray.count == 6 && indexPath.row == 5) {
        cell.isAddPic = NO;
        cell.delegate = self;
        cell.data = [self.imageArray objectAtIndex:indexPath.row];
    }else{
        if (indexPath.row == self.imageArray.count) {
             cell.isAddPic = YES;
             cell.data = @"";
         }else{
             cell.isAddPic = NO;
             cell.delegate = self;
             cell.data = [self.imageArray objectAtIndex:indexPath.row];
         }
    }
 
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.imageArray.count) {
        [self addPic];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (kScreenWidth - 22)/3;
    return CGSizeMake(width, 120); // todo 需要计算
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
   return 0.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark -LYCanOrderOtherCollectionViewCellDelegate
-(void)deleteImage:(UIImage *)image{
    if (image && [self.imageArray containsObject:image]) {
        [self.imageArray removeObject:image];
        if(self.delegate && [self.delegate respondsToSelector:@selector(modifyImage:)]){
            [self.delegate modifyImage:self.imageArray];
        }
    }
}

#pragma mark -UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textViewReturnData:)]) {
        [self.delegate textViewReturnData:textView.text];
    }
    [textView resignFirstResponder];
}

@end
