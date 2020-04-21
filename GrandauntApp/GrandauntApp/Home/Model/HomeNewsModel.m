//
//  HomeNewsModel.m
//  eleoke
//
//  Created by humengfan on 2018/7/29.
//  Copyright © 2018年 王师傅 Mac. All rights reserved.
//

#import "HomeNewsModel.h"

@implementation HomeNewsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID": @"id"};
}

@end


@implementation BannerModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID": @"id"};
}

@end

@implementation HomeNewsResponseModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"rows" : @"HomeNewsModel",
             @"advRows" : @"BannerModel",

             };
    
}

@end


@implementation HomeNewsdataModel

@end


@implementation HomeNewsModels

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"messages" : @"MessageModel",
             
             };
    
}

- (NSString *)acapnia:(NSString *)mesoprescutum {
   NSString *tremandraceae = @"notedness";
   return tremandraceae;
}



- (NSArray *)corrosional:(NSArray *)protrusile {
   NSArray *scutation = @[
     @"fluxibility",
     @"beshower",
     @"dodecafid",
     @"hamshackle",
     @"uterotubal",
     @"flysch",
     @"syncretistical",
     @"kahili",
     @"embergoose",
     @"rorqual",
     @"rastaban",
     @"untemperateness",
     @"catechistic",
     @"omnisciency",
  ];
    return scutation;
}

- (NSString *)excursory:(NSString *)carbona {
   NSString *elaeosaccharum = @"wacken";
   return elaeosaccharum;
}



- (NSData *)schizogregarinida:(NSString *)drainpipe {
   NSData *paten = [@"deltic" dataUsingEncoding:NSUTF8StringEncoding];
   return paten;
}

- (NSString *)embezzlement:(NSString *)faints {
   NSString *subepoch = @"extrajudicially";
   return subepoch;
}



@end
