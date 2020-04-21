//
//  UIImage+fixOrientation.h
//  TestCamera
//
//  Created by zzzili on 13-9-25.
//  Copyright (c) 2013年 zzzili. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (fixOrientation)

- (UIImage *)fixOrientation;
- (NSData *)ktj_needData;
- (NSData *)getDataByfixOrientation;
- (void)ktj_cleanData;
- (NSData*) getBMPImageData;
@end
