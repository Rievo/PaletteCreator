//
//  PCPaletteView.m
//  PaletteCreator
//
//  Created by Diego on 15/11/16.
//  Copyright © 2016 Diego. All rights reserved.
//

#import "PCPaletteView.h"

@implementation PCPaletteView
@synthesize palette;



- (void)drawRect:(CGRect)rect {
    
    float htalDiv = rect.size.width / palette.colors.count;
    
    UIBezierPath * back = [UIBezierPath bezierPathWithRect:rect];
    [[UIColor blackColor]setStroke];
    [[UIColor grayColor]setFill];
    [back setLineWidth:3.0];
    [back fill];
    [back stroke];
    
    for(int i = 0; i <palette.colors.count; i++){
        PCColor * pccolor = palette.colors[i];
        UIColor * color = pccolor.color;
        UIBezierPath * zone = [UIBezierPath bezierPathWithRect:CGRectMake(i * htalDiv,
                                                                          0,
                                                                          htalDiv,
                                                                          rect.size.height)];
        [zone setLineWidth:2.0];
        [color setFill];
        [[UIColor blackColor]setStroke];
        [zone fill];
        [zone stroke];
    }
}


-(void)prepare{
    [self setNeedsDisplay];
}


@end
