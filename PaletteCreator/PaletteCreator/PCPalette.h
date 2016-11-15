//
//  PCPalette.h
//  PaletteCreator
//
//  Created by Diego on 15/11/16.
//  Copyright © 2016 Diego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCColor.h"


@interface PCPalette : NSObject

@property NSMutableArray * colors;
@property NSString * name;
@property NSString * information;
@property NSString * identifier;

@end
