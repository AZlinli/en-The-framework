//
//  LYCommitCommentViewModel.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYCommitCommentViewModel.h"
#import "LYHTTPRequestManager.h"

@interface LYCommitCommentViewModel()
@property(nonatomic, readwrite, strong) RACCommand *submitCommand;
@end

@implementation LYCommitCommentViewModel
- (instancetype)initWithParameter:(NSDictionary *)parameter{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (RACCommand *)submitCommand{
    if (!_submitCommand) {
        @weakify(self);
        _submitCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            //先上传图片，后提交评论
            if (self.otherText.length == 0 || self.otherText.length > 1800) {
                 return [RACSignal return:@{@"code":@"1",@"type":@"1"}];
            }
            return [RACSignal return:@{@"code":@"0",@"type":@"1"}];
        }];
    }
    return _submitCommand;
}

@end
