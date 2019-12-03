//
//  LYRACWeightsTableViewViewModel.h
//  LYBook
//
//  Created by luoyong on 2018/8/15.
//  Copyright © 2018年 luoyong. All rights reserved.
//

#import "LYConfigurationCellIdentifier.h"
@interface LYRACWeightsTableViewViewModel : NSObject
/**
 网络请求
 */
@property (strong, readonly, nonatomic) RACCommand * requestDataCommand;
/**
 点击cell
 */
@property (strong, readonly, nonatomic) RACCommand * didSelectRowCommand;
/**
 点击emptyButton
 */
@property (strong, readonly, nonatomic) RACCommand * didTapButtonCommand;
/**
 点击emptyView
 */
@property (strong, readonly, nonatomic) RACCommand * didTapViewCommand;
/**
 数据源
 */
@property (copy, readonly, nonatomic) NSArray * dataArray;
/**
 URL地址
 */
@property (strong, readonly, nonatomic) NSString * urlString;
/**
 总量
 */
@property (strong, readonly, nonatomic) NSString * total;
/**
 参数
 */
@property (strong, readonly, nonatomic) NSDictionary * parameter;
/**
 解析数据模型Class
 */
@property (strong, nonatomic) Class dataClass;
/**
 CellID
 */
@property (copy, nonatomic) NSString * cellID;

@property (assign, nonatomic) BOOL onlyUseData;
@property (copy, nonatomic) NSDictionary * onlyUseDataDictionary;
@property (nonatomic, readonly, assign) NSInteger page;
@property (nonatomic, readonly, assign) BOOL moreData;
/**
 解析数组类型
 */
@property (assign, nonatomic) BOOL analysisArrayType;
/**
 初始化

 @param urlString 请求地址
 @param parameter 参数
 @param page 当前页数
 @param limitPage 每页条数
 @return LYRACTableViewViewModel
 */
- (instancetype)initUrlString:(NSString *)urlString parameter:(NSDictionary *)parameter page:(NSInteger)page limitPage:(NSInteger)limitPage;
/**
 更新请求参数

 @param dic 参数
 */
- (void)updateParameterWithDic:(NSDictionary *)dic;
/**
 添加数据

 @param model 数据
 */
- (void)insertOneData:(id)model;
///**
// 删除全部数据
// */
//- (void)deleteAllData;
///**
// 删除一条数据
//
// @param model 数据
// */
//- (void)deleteOneData:(id)model;
@end
