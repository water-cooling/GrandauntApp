//
//  UIImage+DrawImage.h
//  YltxShare
//
//  Created by yltx on 2019/5/8.
//  Copyright © 2019 com.yltx.ZR.share. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (DrawImage)

+(UIImage *)addGoodsImage:(UIImage *)GoodsImg GoodTitle:(NSString *)Goodtitle PriceText:(NSString *)PriceText CashText:(NSString *)CashText TicketText:(NSString *)TicketText QcodeImg:(UIImage *)QcodeImg isDrawLine:(BOOL)isDrawLine;
@end

NS_ASSUME_NONNULL_END
