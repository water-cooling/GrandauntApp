//
//  UIImage+fixOrientation.m
//  TestCamera
//
//  Created by zzzili on 13-9-25.
//  Copyright (c) 2013年 zzzili. All rights reserved.
//

#import "UIImage+fixOrientation.h"

@implementation UIImage (fixOrientation)

- (UIImage *)fixOrientation
{
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation)
    {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
   
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [[UIImage alloc]initWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);

    return img;
}
- (NSData*) getBMPImageDataToSize:(CGSize)size
{
    CGContextRef context = NULL;
    CGColorSpaceRef colorSpace;
    uint32_t *bitmapData = NULL;
    
    size_t bitsPerPixel = 32;
    size_t bitsPerComponent = 8;
    size_t bytesPerPixel = bitsPerPixel / bitsPerComponent;
    
    size_t width = size.width;
    size_t height = size.height;
    
    size_t bytesPerRow = width * bytesPerPixel;
    size_t bufferLength = bytesPerRow * height;
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if(!colorSpace)
    {
        return nil;
    }
    
    // Allocate memory for image data
    bitmapData = (uint32_t *)malloc(bufferLength);
    
    if(!bitmapData)
    {
        CGColorSpaceRelease(colorSpace);
        return nil;
    }
    //Create bitmap context
    context = CGBitmapContextCreate(bitmapData,
                                    width,
                                    height,
                                    bitsPerComponent,
                                    bytesPerRow,
                                    colorSpace,
                                    1);	// RGBA
    if(!context)
    {
        free(bitmapData);
        bitmapData = NULL;
    }
    CGContextClearRect(context, CGRectMake(0, 0, width, height));
    CGColorSpaceRelease(colorSpace);
    
    if(!context)
    {
        return nil;
    }
    
    CGRect rect = CGRectMake(0, 0, width, height);
    
    // Draw image into the context to get the raw image data
    CGContextDrawImage(context, rect, self.CGImage);
    
    // Get a pointer to the data
    unsigned char *bitmapData1 = (unsigned char *)CGBitmapContextGetData(context);
    
    // Copy the data and release the memory (return memory allocated with new)
    bytesPerRow = CGBitmapContextGetBytesPerRow(context);
    
    NSData* newData = nil;
    
    if(bitmapData1)
    {
        int len = 54 + (int)sizeof(unsigned char) *(int) bytesPerRow * (int)height;
        int area = (int)(width*height);
        newData = [[NSMutableData alloc] initWithLength:len];
        unsigned char* newBitmap = (unsigned char*)[newData bytes];
        
        height = -height;
        
        memset(newBitmap, 0, 54);
        newBitmap[0] = 'B';
        newBitmap[1] = 'M';
        memcpy(newBitmap+2, &len, 4);
        newBitmap[10] = 54;
        newBitmap[14] = 0x28;
        memcpy(newBitmap + 18, &width, 4);
        memcpy(newBitmap + 22, &height, 4);
        newBitmap[26] = 1;
        newBitmap[28] = 32;
        
        if(newBitmap)
        {	// Copy the data
            for (int i = 0; i < area; i++)
            {
                int offset = i<<2;
                newBitmap[54+offset+0] = bitmapData1[offset+2];//B
                newBitmap[54+offset+1] = bitmapData1[offset+1];//G
                newBitmap[54+offset+2] = bitmapData1[offset+0];//R
                newBitmap[54+offset+3] = bitmapData1[offset+3];//A
            }
        }
    }
    else
    {
    }
    
    CGContextRelease(context);
    free(bitmapData);
    
    //    return [newData autorelease];
    return newData;
    
}
- (NSData*) getBMPImageData
{
    return [self getBMPImageDataToSize:self.size];
}
- (NSData *)getDataByfixOrientation
{
    
    // No-op if the orientation is already correct
//    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
            
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation)
    {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    NSData * data = CGBitmapContextGetData(ctx);

    CGContextRelease(ctx);

    return data;
}
- (NSData *)ktj_needData
{
    NSData *data = objc_getAssociatedObject(self, @selector(ktj_needData));
    if (!data) {
        data = UIImageJPEGRepresentation(self, 0.5);
        objc_setAssociatedObject(self, @selector(ktj_needData), data, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return data;
}
- (void)ktj_cleanData {
    objc_setAssociatedObject(self, @selector(ktj_needData), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
