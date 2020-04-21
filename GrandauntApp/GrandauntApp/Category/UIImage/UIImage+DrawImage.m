//
//  UIImage+DrawImage.m
//  YltxShare
//
//  Created by yltx on 2019/5/8.
//  Copyright © 2019 com.yltx.ZR.share. All rights reserved.
//

@implementation UIImage (DrawImage)

+(UIImage *)addGoodsImage:(UIImage *)GoodsImg GoodTitle:(NSString *)Goodtitle PriceText:(NSString *)PriceText CashText:(NSString *)CashText TicketText:(NSString *)TicketText QcodeImg:(UIImage *)QcodeImg isDrawLine:(BOOL)isDrawLine{

    int w =  zScreen_Width;
    
    int h = zScreen_Height;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(w, h), NO, [UIScreen mainScreen].scale);
    
    [GoodsImg drawInRect:CGRectMake(0, 0, w, h/2)];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //2、设置起点
    
    [path moveToPoint:CGPointMake(5,  h/2+2)];
    //设置终点
    
    [path setLineWidth:0.5];
    
    [path addLineToPoint:CGPointMake(w-5,  h/2+2)];
    
    [[UIColor colorWithHexString:@"#F3F3F3"] setStroke];
    
    //3、渲染上下文到View的layer
    [path stroke];
    
    UIFont * titleFont = [UIFont fontWithName:@"PingFang-SC-Medium" size:16];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paragraphStyle.lineSpacing = 5;
    
    NSDictionary * titledict = @{NSFontAttributeName:titleFont,NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"],NSParagraphStyleAttributeName:paragraphStyle};
    
    
    CGSize titlesize = [Goodtitle boundingRectWithSize:CGSizeMake(zScreen_Width-150,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:titledict context:nil].size;
   
    [Goodtitle drawInRect:CGRectMake(10, h/2+10, zScreen_Width-150, titlesize.height+5) withAttributes:titledict];
    
    //礼品卡不加折扣
    if (isDrawLine) {
        NSDictionary * pricedict = @{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:20],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"],NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        [PriceText drawInRect:CGRectMake(10, h/2+10+titlesize.height+5+10, zScreen_Width, 25) withAttributes:pricedict];
    }
    
    NSDictionary * Cashdict = @{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:22],NSForegroundColorAttributeName:DefeatColor};
    
    if (![CashText isEqualToString:@""]) {
        [CashText drawInRect:CGRectMake(10, h/2+titlesize.height+55, zScreen_Width, 25) withAttributes:Cashdict];
    }
    
//    
//    UIImage * ticketImg =  [UIImage imageNamed:@"券"];
//    
//    [ticketImg drawInRect:CGRectMake(10, h/2+titlesize.height+86, 54, 16)];
//    
//    
//    [@"券" drawInRect:CGRectMake(13,h/2+titlesize.height+86 , 12.5, 14) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:12],NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    
//    [TicketText drawInRect:CGRectMake(37,h/2+titlesize.height+86 , 25, 14) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:12],NSForegroundColorAttributeName:DefeatColor}];

    [QcodeImg drawInRect:CGRectMake(zScreen_Width-120, h/2+15, 100, 100)];

    [@"长按识别二维码" drawInRect:CGRectMake(zScreen_Width-120, h/2+125, 100, 17) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:13],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"]}];

    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
