//
//  PCCreateColorViewController.h
//  PaletteCreator
//
//  Created by Diego on 15/11/16.
//  Copyright © 2016 Diego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCColor.h"
#import "AppDelegate.h"


@class  PCPalette;

@interface PCCreateColorViewController : UIViewController<UITextFieldDelegate>{
    PCColor * currentColor;
    AppDelegate * dele;
}

#pragma mark RGB
@property (strong, nonatomic) IBOutlet UISwitch *rgbEnabledSlider;

@property (strong, nonatomic) IBOutlet UISlider *redSlider;
@property (strong, nonatomic) IBOutlet UISlider *greenSlider;

@property (strong, nonatomic) IBOutlet UISlider *blueSlider;


@property (strong, nonatomic) IBOutlet UITextField *redField;
@property (strong, nonatomic) IBOutlet UITextField *greenField;
@property (strong, nonatomic) IBOutlet UITextField *blueField;

#pragma mark HEX
@property (strong, nonatomic) IBOutlet UISwitch *hexEnabledSwitch;
@property (strong, nonatomic) IBOutlet UITextField *hexField;


#pragma mark Preview
@property (strong, nonatomic) IBOutlet UIView *preview;

@property PCPalette * palette;

@end
