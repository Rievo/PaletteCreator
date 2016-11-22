//
//  PCPalette.m
//  PaletteCreator
//
//  Created by Diego on 15/11/16.
//  Copyright © 2016 Diego. All rights reserved.
//

#import "PCPalette.h"
#import "PCColor.h"


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

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if(self){
        
         _colors = [[NSMutableArray alloc] init];
        
        if([dic isKindOfClass:[NSDictionary class]]){
            NSString * name = [dic objectForKey:@"_name"];
            _name = name;
            
            NSArray * colorsArray = [dic objectForKey:@"colors"];
            if([colorsArray isKindOfClass:[NSDictionary class]]){
                colorsArray = [[NSArray alloc] initWithObjects:[dic objectForKey:@"colors"], nil];
            }
            
            
            
            for(NSDictionary * colorDic in colorsArray){
                NSArray * cd = [colorDic objectForKey:@"color"];
                if([cd isKindOfClass:[NSDictionary class]]){
                    cd = [[NSArray alloc] initWithObjects:[colorDic objectForKey:@"color"], nil];
                }
                
                for(NSDictionary * color in cd){
                    NSString * redStr = [color objectForKey:@"_red"];
                    NSString * greenStr = [color objectForKey:@"_green"];
                    NSString * blueStr = [color objectForKey:@"_blue"];
                    
                    int red = [redStr intValue];
                    int green = [greenStr intValue];
                    int blue = [blueStr intValue];
                    
                    PCColor * tempc = [[PCColor alloc] initWith255Red:red
                                                             andGreen:green
                                                              andBlue:blue
                                                             andAlpha:1.0];
                    [_colors addObject:tempc];
                }
                
                
            }
        }else{
            
        }
        
        
    }
    return self;
}
@end
