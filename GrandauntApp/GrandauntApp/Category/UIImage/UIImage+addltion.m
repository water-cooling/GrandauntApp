//
//  LoginViewController.h
//  smallCourse
//
//  Created by MAC on 16/1/5.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import <Accelerate/Accelerate.h>

@implementation UIImage (addltion)

+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)setEditImgFelder:(NSString *)editImgFelder {
    objc_setAssociatedObject(self, @selector(editImgFelder), editImgFelder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)editImgFelder {
    return objc_getAssociatedObject(self, @selector(editImgFelder));
}

- (UIImage *)cutImageWithsize: (CGSize)size
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((self.size.width / self.size.height) < (size.width / size.height)) {
        newSize.width = self.size.width;
        newSize.height = self.size.width *size.height / size.width;
        
        imageRef = CGImageCreateWithImageInRect([self CGImage], CGRectMake(0, fabs(self.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = self.size.height;
        newSize.width = self.size.height * size.width /size.height;
        
        imageRef = CGImageCreateWithImageInRect([self CGImage], CGRectMake(fabs(self.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
    }
    UIImage *img = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return img;
}

#pragma mark 高斯模糊
- (UIImage *)blurryWithBlurLevel:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = self.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                       &outBuffer,
                                       NULL,
                                       0,
                                       0,
                                       boxSize,
                                       boxSize,
                                       NULL,
                                       kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    return returnImage;
}

#pragma mark ~~ 截屏 ~~
+ (UIImage *)screenShot{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+(UIImage*)decodeBase64ToImage:(NSString*)strEncodeData {
    
  NSString *  str = [strEncodeData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
    
    //进行空字符串的处理
    
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    //进行换行字符串的处理
    
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    
    //去掉头部的前缀//data:image/jpeg;base64, （可根据实际数据情况而定，如果数据有固定的前缀，就执行下面的方法，如果没有就注销掉或删除掉）
    
     str = [str substringFromIndex:23];
    //23 是根据前缀的具体字符长度而定的。
    
    NSData * imageData =[[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *photo = [UIImage imageWithData:imageData ];
    
    return  photo;
}
@end
