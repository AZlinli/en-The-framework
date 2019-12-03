//
//  LYShareViewModel.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/18.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//
#import "LYShareModel.h"
#import "LYShareViewModel.h"
#import "NSString+LYSize.h"
#import "NSString+LYTool.h"

@interface LYShareViewModel()
@property (nonatomic, readwrite, copy) NSString * url;
@property (nonatomic, readwrite, copy) NSString * type;
@property (nonatomic, readwrite, copy) NSArray * sharedTypeArray;


@property (nonatomic, readwrite, copy) NSString * title;

@property (nonatomic, readwrite, copy) NSString * content;
@property (nonatomic, readwrite, copy) NSString * userName;
@end

@implementation LYShareViewModel

/// 初始化
/// @param parameter title 分享标题
/// content 分享内容
/// url 分享链接
/// image 图片地址
/// mini_path 小程序地址
/// type 类型 1 分享拉新保存相册 2 分享拉新复制链接
/// price: 价格
- (instancetype)initWithParameter:(NSDictionary *)parameter
{
    if (self = [super init]) {
        
        if (![[NSString stringWithFormat:@"%@", parameter[@"type"]] isEmpty]) {
            self.type = [NSString stringWithFormat:@"%@", parameter[@"type"]];
        }

        if (![[NSString stringWithFormat:@"%@", parameter[@"title"]] isEmpty]) {
            self.title = [NSString stringWithFormat:@"%@", parameter[@"title"]];
        }else{
            self.title = @"ToursCool";
        }


        if (![[NSString stringWithFormat:@"%@", parameter[@"content"]] isEmpty]) {
            self.content = [NSString stringWithFormat:@"%@", parameter[@"content"]];
        }else{
            self.content = @"ToursCool";
        }

        if (![[NSString stringWithFormat:@"%@", parameter[@"url"]] isEmpty]) {
            self.url = [NSString stringWithFormat:@"%@", parameter[@"url"]];
            if([self.url containsString:@"?"]){
                self.url = [NSString stringWithFormat:@"%@&platform=app&phone_type=ios", self.url];
            }else{
                self.url = [NSString stringWithFormat:@"%@?platform=app&phone_type=ios", self.url];
            }

        }else{
            self.url = @"https://m.tourscool.com";
        }

        if (parameter[@"image"]){
            if ([parameter[@"image"] isKindOfClass:[NSData class]]) {
                NSData * imageData = [[NSData alloc] initWithBase64EncodedData:parameter[@"image"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                self.image = [[UIImage alloc] initWithData:imageData];
            }else if (![[NSString stringWithFormat:@"%@", parameter[@"image"]] isEmpty]) {
                self.image = parameter[@"image"];
            }else{
                self.image = [UIImage imageNamed:@"mine_user_big_placeholder_img"];
            }
        }else{
            self.image = [UIImage imageNamed:@"mine_user_big_placeholder_img"];
        }

        if (parameter[@"imageHD"]){
            if ([parameter[@"imageHD"] isKindOfClass:[NSData class]]) {
                NSData * imageData = [[NSData alloc] initWithBase64EncodedData:parameter[@"imageHD"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                self.imageHD = [[UIImage alloc] initWithData:imageData];
            }else if (![[NSString stringWithFormat:@"%@", parameter[@"imageHD"]] isEmpty]) {
                self.imageHD = parameter[@"imageHD"];
            }else{
                self.imageHD = [UIImage imageNamed:@"mine_user_big_placeholder_img"];
            }
        }else{
            self.imageHD = [UIImage imageNamed:@"mine_user_big_placeholder_img"];
        }

//        if ([self.type integerValue] != 0) {
//            self.title = @"偷偷告诉你一件事...";
//            self.content = @"出境旅游不等侯，领了红包立刻走，跟好友一起浪~";
//            if ([self.type integerValue] == 2) {
//                self.image = nil;
//            }
//        }

        NSMutableArray * array = [NSMutableArray array];
        
        LYShareModel * facebookModel = [[LYShareModel alloc] init];
        facebookModel.imageName = @"detail_facebook";
        facebookModel.type = 1;
        facebookModel.name = @"Facebook";
        [array addObject:facebookModel];
        
        LYShareModel * twitterModel = [[LYShareModel alloc] init];
        twitterModel.imageName = @"detail_twitter";
        twitterModel.type = 2;
        twitterModel.name = @"Twitter";
        [array addObject:twitterModel];
        
        LYShareModel * whatIsAppModel = [[LYShareModel alloc] init];
        whatIsAppModel.imageName = @"detail_messenger";
        whatIsAppModel.type = 3;
        whatIsAppModel.name = @"Whatsapp";
        [array addObject:whatIsAppModel];
        
        LYShareModel * copyLinkModel = [[LYShareModel alloc] init];
        copyLinkModel.imageName = @"detail_copy";
        copyLinkModel.type = 4;
        copyLinkModel.name = [LYLanguageManager ly_localizedStringForKey:@"Share_Copy_Link"];
        [array addObject:copyLinkModel];
        
        self.sharedTypeArray = [array copy];
    }
    return self;
}

@end
