//
//  PCColor.m
//  PaletteCreator
//
//  Created by Diego on 15/11/16.
//  Copyright © 2016 Diego. All rights reserved.
//

#import "PCColor.h"


@implementation PCColor

@synthesize color;



- (instancetype)initWithHexString:(NSString *)str
{
    self = [super init];
    if (self) {
        
        if(str.length == 6){
            //-----------------------------------------
            // Convert hex string to an integer
            //-----------------------------------------
            unsigned int hexint = 0;
            
            // Create scanner
            NSScanner *scanner = [NSScanner scannerWithString:str];
            
            // Tell scanner to skip the # character
            [scanner setCharactersToBeSkipped:[NSCharacterSet
                                               characterSetWithCharactersInString:@"#"]];
            [scanner scanHexInt:&hexint];
            
            //-----------------------------------------
            // Create color object, specifying alpha
            //-----------------------------------------
            UIColor *c =
            [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                            green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                             blue:((CGFloat) (hexint & 0xFF))/255
                            alpha:1.0];
            
            _red = (int) ((hexint & 0xFF0000) >> 16);
            _green = (int) ((hexint & 0xFF00) >> 8);
            _blue = (int) (hexint & 0xFF);
            
            
            color = c;
        //    _name = str;
        }else{
            color = [UIColor redColor];
         //   _name = str;
        }
        
    }
    return self;
}



- (instancetype)initWithRed:(float)r andGreen:(float)g andBlue:(float) b andAlpha:(float)a
{
    self = [super init];
    if (self) {
        color = [UIColor colorWithRed:r green:g blue:b alpha:a];
       // _name = [NSString stringWithFormat:@"(%.2f,%.2f,%.2f)", r, g, b];
    }
    return self;
}

- (instancetype)initWith255Red:(int)r andGreen:(int)g andBlue:(int) b andAlpha:(float)a
{
    self = [super init];
    if (self) {
        color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
       // _name = [NSString stringWithFormat:@"(%.d,%d,%d)", r, g, b];
        
        _red = r;
        _green = g;
        _blue = b;
    }
    return self;
}



@end
