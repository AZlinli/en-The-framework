//
//  LYProjectAllEnumeration.h
//  ToursCool
//
//  Created by tourscool on 12/28/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#ifndef LYProjectAllEnumeration_h
#define LYProjectAllEnumeration_h
typedef NS_ENUM(NSInteger, LYPeopleCellCircularDirection){
    LYPeopleCellCircularDirectionNothing = 1,
    LYPeopleCellCircularDirectionAll,
    LYPeopleCellCircularDirectionTop,
    LYPeopleCellCircularDirectionBottom
};

typedef NS_ENUM(NSInteger, LYThirdPartyLoginType){
    LYThirdPartyLoginTypeQQ = 1,
    LYThirdPartyLoginTypeWeChat,
    LYThirdPartyLoginTypeFaceBook,
    LYThirdPartyLoginTypeSinaWeiBo
};
/**
 未追评
 */
#define User_NO_Append 900003
/**
 已追评
 */
#define User_Comment_Complete 900004

#endif /* LYProjectAllEnumeration_h */
