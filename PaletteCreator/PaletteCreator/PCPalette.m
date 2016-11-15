//
//  PCPalette.m
//  PaletteCreator
//
//  Created by Diego on 15/11/16.
//  Copyright © 2016 Diego. All rights reserved.
//

#import "PCPalette.h"

@implementation PCPalette

- (instancetype)init
{
    self = [super init];
    if (self) {
        _colors = [[NSMutableArray alloc] init];
        _name = @"default";
        _information = @"";
    }
    return self;
}
@end
