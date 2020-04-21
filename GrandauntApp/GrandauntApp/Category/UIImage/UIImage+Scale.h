//
//  UIImage+Scale.h
//  DrawYourSister
//
//  Created by Sima IMac on 14/11/25.
//  Copyright (c) 2014年 toolwiz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage(UIImageScale)
-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage*)scaleToSize:(CGSize)size;
-(UIImage*)scaleNoScreenToSize:(CGSize)size;

-(UIImage*)scaleToSize2:(CGSize)size;
- (UIImage *)TelescopicImageToSize:(CGSize) size;
- (UIImage*)rotate90Clockwise;

/*
 * @brief rotate image 90 counterClockwise
 */
- (UIImage*)rotate90CounterClockwise;

/*
 * @brief rotate image 180 degree
 */
- (UIImage*)rotate180;

/*
 * @brief rotate image to default orientation
 */
- (UIImage*)rotateImageToOrientationUp;

/*
 * @brief flip horizontal
 */
- (UIImage*)flipHorizontal;

/*
 * @brief flip vertical
 */
- (UIImage*)flipVertical;

/*
 * @brief flip horizontal and vertical
 */
- (UIImage*)flipAll;
@end
