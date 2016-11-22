//
//  SecondViewController.m
//  PaletteCreator
//
//  Created by Diego on 15/11/16.
//  Copyright © 2016 Diego. All rights reserved.
//

#import "PaletteInfo.h"
#import "PCCreateColorViewController.h"
#import "PCPaletteView.h"


@interface PaletteInfo ()

@end

@implementation PaletteInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dele = (AppDelegate *)[[UIApplication sharedApplication]delegate];

    _palette = [[PCPalette alloc] init];
    palettePreview.palette = _palette;
    [self updatePaletteView];
    nameTextField.delegate = self;
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(updatePaletteView)
                                                name:@"updatePalettePreview" object:nil];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField == nameTextField){
        _palette.name = nameTextField.text;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addColorToPalette:(id)sender {
    [self performSegueWithIdentifier:@"showCreateColor" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"showCreateColor"])
    {
        // Get reference to the destination view controller
        PCCreateColorViewController  *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.palette = _palette;
    }
}

-(void)updatePaletteView{
    [palettePreview setNeedsDisplay];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [nameTextField resignFirstResponder];
    [self setEditing:NO];
}


- (IBAction)savePalette:(id)sender {
    
    if(nameTextField.text.length == 0){
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Error"
                                      message:@"Name cannot be empty"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            //do something when click button
        }];
        [alert addAction:okAction];
        UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        [vc presentViewController:alert animated:YES completion:nil];
    }else{
        if(palettePreview.palette.colors.count > 0){
            
            [dele.palettes addObject:palettePreview.palette];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updatePalettesTable"
                                                                object:self
                                                              userInfo:nil];
            
            UINavigationController *nav = self.navigationController;
            [nav popViewControllerAnimated:YES];
        }else{
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Error"
                                          message:@"There must be at least a color"
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                
                //do something when click button
            }];
            [alert addAction:okAction];
            UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
            [vc presentViewController:alert animated:YES completion:nil];
        }
    }
    
    
    
}



@end
