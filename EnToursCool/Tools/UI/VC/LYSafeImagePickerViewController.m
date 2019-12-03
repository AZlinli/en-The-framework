//
//  LYSafeImagePickerViewController.m
//  ToursCool
//
//  Created by tourscool on 1/11/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYSafeImagePickerViewController.h"

@interface LYSafeImagePickerViewController ()

@end

@implementation LYSafeImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)willDealloc
{
    if (@available(iOS 11.0, *)) {
        return NO;
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
