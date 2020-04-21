//
//  UIImage+Addition.m
//  FuelTreasureProject
//
//  Created by 吴仕海 on 4/8/15.
//  Copyright (c) 2015 XiTai. All rights reserved.
//

#import "UIImage+Addition.h"

@implementation UIImage (Addition)

@dynamic imageHeight;
@dynamic imageWidth;

+ (UIImage *)imageWithURLNamed:(NSString *)name{
    return nil;
}

+ (UIImage *)appLaunchImage{
    NSString *launchImageName = @"";
    if (SCREENWIDTH == 320 && SCREENHEIGHT == 480) {
        launchImageName = @"LaunchImage_1";
    }else if (SCREENWIDTH == 320 && SCREENHEIGHT == 568) {
        launchImageName = @"LaunchImage_2";
    }else if (SCREENWIDTH == 375 && SCREENHEIGHT == 667) {
        launchImageName = @"LaunchImage_3";
    }else if (SCREENWIDTH == 414 && SCREENHEIGHT == 736) {
        launchImageName = @"LaunchImage_4";
    }
    return [UIImage wy_imageName:launchImageName];
}

- (CGFloat)imageHeight{
    CGFloat height = self.size.height;
    if (IsIphone6Plus) {
//        return height/2;
    }else{
//        return height/2;
    }
    return height;
}
- (CGFloat)imageWidth{
    CGFloat width = self.size.width;
    if (IsIphone6Plus) {
//        return width/2;
    }else{
//        return width/2;
    }
    return width;
}


+ (UIImage *)wy_imageName:(NSString *)name{
    
    if (![name isKindOfClass:[NSString class]] || name == nil || [name isEqualToString:@""]) {
        return nil;
    }
    
    NSString *extension = [name pathExtension];
    
    if (extension == nil || [extension isEqualToString:@""]) {
        extension = @"png";//default
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[name stringByDeletingPathExtension] ofType:extension];
    return [UIImage imageWithContentsOfFile:filePath];
}

+ (UIImage *)imageWithColor:(UIColor*)color andSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    
    [color set];
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
    [path fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext ();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)imageByScalingToSize:(CGSize)targetSize fitScale:(BOOL)fitScale
{
    CGFloat scale = [UIScreen mainScreen].scale;
    if (fitScale) {
        return [self imageByScalingToSize:CGSizeMake(targetSize.width * scale, targetSize.height * scale)];
    } else {
        return [self imageByScalingToSize:targetSize];
    }
}

//按最大的放大 并截取中间  适合头像 和一些小图展示
- (UIImage *)imageByScalingToSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (!CGSizeEqualToSize(imageSize, targetSize)) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (scaledHeight > targetHeight) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        if (targetWidth < scaledWidth) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    
    // this is actually the interesting part:
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    
    return newImage ;
}
//按最大的边压缩 可以留白
- (UIImage *)imageByBigScalingToSize:(CGSize)targetSize{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (!CGSizeEqualToSize(imageSize, targetSize)) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        if(scaleFactor<1){
            scaledWidth  = width * scaleFactor;
            scaledHeight = height * scaleFactor;
        }else{
            scaledWidth=width;
            scaledHeight=height;
        }
        
    }
    
    
    // this is actually the interesting part:
    
    UIGraphicsBeginImageContext(CGSizeMake(scaledWidth, scaledHeight-1));
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    return newImage ;
}

// Returns a rescaled copy of the image, taking into account its orientation
// The image will be scaled disproportionately if necessary to fit the bounds specified by the parameter
- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality {
    BOOL drawTransposed;
    
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            drawTransposed = YES;
            break;
        default:
            drawTransposed = NO;
    }
    return [self resizedImage:newSize
                    transform:[self transformForOrientation:newSize]
               drawTransposed:drawTransposed
         interpolationQuality:quality];
}

#pragma mark -
#pragma mark Private helper methods

// Returns a copy of the image that has been transformed using the given affine transform and scaled to the new size
// The new image's orientation will be UIImageOrientationUp, regardless of the current image's orientation
// If the new size is not integral, it will be rounded up
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGRect transposedRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width);
    CGImageRef imageRef = self.CGImage;
    
    // Build a context that's the same dimensions as the new size
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    if((bitmapInfo == kCGImageAlphaLast) || (bitmapInfo == kCGImageAlphaNone))
        bitmapInfo = (CGBitmapInfo)kCGImageAlphaNoneSkipLast;
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(imageRef),
                                                0,
                                                CGImageGetColorSpace(imageRef),
                                                bitmapInfo);
    
    // Rotate and/or flip the image if required by its orientation
    CGContextConcatCTM(bitmap, transform);
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(bitmap, quality);
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return newImage;
}

// Returns an affine transform that takes into account the image orientation when drawing a scaled image
- (CGAffineTransform)transformForOrientation:(CGSize)newSize {
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:           // EXIF = 3
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:           // EXIF = 6
        case UIImageOrientationLeftMirrored:   // EXIF = 5
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:          // EXIF = 8
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
            
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:     // EXIF = 2
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:   // EXIF = 5
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        default:
            break;
    }
    
    return transform;
}

//wsh
+ (UIImage *)hj_imageName:(NSString *)name{
    if (![name isKindOfClass:[NSString class]] || name == nil || [name isEqualToString:@""]) {
        return nil;
    }
    NSString *extension = [name pathExtension];
    if (extension == nil || [extension isEqualToString:@""]) {
        extension = @"png";//default
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[name stringByDeletingPathExtension] ofType:extension];
    return [UIImage imageWithContentsOfFile:filePath];
}

+ (NSData *)compressToSize:(long)targetSize image:(UIImage *)image
{
    NSData *imgData = UIImageJPEGRepresentation(image, 1);
    return [self compressToSize:targetSize sourceSize:imgData.length image:image];
}


+ (NSData *)compressToSize:(long)targetSize sourceSize:(long)sourceSize image:(UIImage *)image
{
    NSLog(@"targetSize:%lu originSize%lu", targetSize, sourceSize);
    
    if (sourceSize <= targetSize) {
        NSData *data = UIImageJPEGRepresentation(image, 0.9);
        return data;
    }
    
    CGFloat compression = (CGFloat)targetSize / (CGFloat)sourceSize;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    NSLog(@"compression:%f size:%lu", compression, (unsigned long)[imageData length]);
    
    return imageData;
}


+ (UIImage *)imageFromView:(UIView *)view
{
    return [self imageFromView:view inset:UIEdgeInsetsZero];
}

+ (UIImage *)imageFromView:(UIView *)view inset:(UIEdgeInsets)inset
{
    CGSize size = view.frame.size;
    size.width = size.width - inset.left;
    size.width = size.width - inset.right;
    size.height = size.height - inset.top;
    size.height = size.height - inset.bottom;
    
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(size, NO,scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return viewImage;
}

+ (UIImage *)resizeImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
