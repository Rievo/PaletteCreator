//
//  PCCreateColorViewController.m
//  PaletteCreator
//
//  Created by Diego on 15/11/16.
//  Copyright © 2016 Diego. All rights reserved.
//

#import "PCCreateColorViewController.h"
#import "PCPalette.h"


@interface PCCreateColorViewController ()

@end

@implementation PCCreateColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dele = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    [self enableHex];
    [self disableRGB];
    [self readRGBSlidersAndUpdateLabels];
    [self updateRGBColor];
    [self readHexFieldAndUpdateColor];
    
    _hexField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)rgbSwitchChanged:(id)sender {
    if(_rgbEnabledSlider.isOn == TRUE){
        [_hexEnabledSwitch setOn:FALSE];
        [self disableHEX];
        [self enableRGB];
    }else{
        [_hexEnabledSwitch setOn:TRUE];
        [self enableHex];
        [self disableRGB];
    }
}

- (IBAction)hexSwitchChanged:(id)sender {
    if(_hexEnabledSwitch.isOn == TRUE){
        [_rgbEnabledSlider setOn:FALSE];
        [self enableHex];
        [self disableRGB];
    }else{
        [_rgbEnabledSlider setOn:true];
        [self disableHEX];
        [self enableRGB];
    }
}


-(void)readRGBSlidersAndUpdateLabels{
    int r = (int)_redSlider.value;
    int g = (int)_greenSlider.value;
    int b = (int)_blueSlider.value;
    
    [_redField setText:[NSString stringWithFormat:@"%d", r]];
    [_greenField setText:[NSString stringWithFormat:@"%d", g]];
    [_blueField setText:[NSString stringWithFormat:@"%d", b]];
}

-(void)disableRGB{
    [_redField setEnabled:NO];
    [_redField setAlpha:0.5];
    [_greenField setEnabled:NO];
    [_greenField setAlpha:0.5];
    [_blueField setEnabled:NO];
    [_blueField setAlpha:0.5];
    
    [_redSlider setEnabled:NO];
    [_redSlider setAlpha:0.5];
    [_greenSlider setEnabled:NO];
    [_greenSlider setAlpha:0.5];
    [_blueSlider setEnabled:NO];
    [_blueSlider setAlpha:0.5];
}
-(void)enableRGB{
    [_redField setEnabled:YES];
    [_redField setAlpha:1.0];
    [_greenField setEnabled:YES];
    [_greenField setAlpha:1.0];
    [_blueField setEnabled:YES];
    [_blueField setAlpha:1.0];
    
    [_redSlider setEnabled:YES];
    [_redSlider setAlpha:1.0];
    [_greenSlider setEnabled:YES];
    [_greenSlider setAlpha:1.0];
    [_blueSlider setEnabled:YES];
    [_blueSlider setAlpha:1.0];
}

-(void)disableHEX{
    [_hexField setEnabled:NO];
    [_hexField setAlpha:0.5];
}
-(void)enableHex{
    [_hexField setEnabled:YES];
    [_hexField setAlpha:1.0];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (IBAction)redSliderUpdated:(id)sender {
    [self readRGBSlidersAndUpdateLabels];
    [self updateRGBColor];
}

- (IBAction)greenSliderUpdated:(id)sender {
    [self readRGBSlidersAndUpdateLabels];
    [self updateRGBColor];
}
- (IBAction)blueSliderUpdated:(id)sender {
    [self readRGBSlidersAndUpdateLabels];
    [self updateRGBColor];
}

-(void)updateRGBColor{
    int r = _redSlider.value;
    int g = _greenSlider.value;
    int b = _blueSlider.value;
    
    currentColor = [[PCColor alloc] initWith255Red:r andGreen:g andBlue:b andAlpha:1.0];
    [_preview setBackgroundColor:currentColor.color];
}

-(void)readHexFieldAndUpdateColor{
    NSString * str = _hexField.text;
    currentColor = [[PCColor alloc] initWithHexString:str];
    [_preview setBackgroundColor:currentColor.color];
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self readHexFieldAndUpdateColor];
}


- (IBAction)addCurrentColorToPalette:(id)sender {
    [_palette.colors addObject:currentColor];
    
    
    UINavigationController *nav = self.navigationController;
    [nav popViewControllerAnimated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updatePalettePreview"
                                                        object:self
                                                      userInfo:nil];
    //Update palette preview
}



@end
