//
//  PCColor.h
//  PaletteCreator
//
//  Created by Diego on 15/11/16.
//  Copyright © 2016 Diego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface PCColor : NSObject

@property UIColor * color;
//@property NSString * name;

@property int red;
@property int green;
@property int blue;

- (instancetype)initWithHexString:(NSString *)str;
- (instancetype)initWithRed:(float)r andGreen:(float)g andBlue:(float) b andAlpha:(float)a;
- (instancetype)initWith255Red:(int)r andGreen:(int)g andBlue:(int) b andAlpha:(float)a;

-(NSDictionary *)convertToDictionary;
@end
