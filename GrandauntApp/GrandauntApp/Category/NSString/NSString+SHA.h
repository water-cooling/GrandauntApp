//
//  NSString+SHA.h
//  CCBAPP
//
//  Created by ccb－apple on 17/2/21.
//  Copyright © 2017年 mingda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SHA)

-(NSString *) sha1;
-(NSString *) sha224;
-(NSString *) sha256;
-(NSString *) sha384;
-(NSString *) sha512;

@end
