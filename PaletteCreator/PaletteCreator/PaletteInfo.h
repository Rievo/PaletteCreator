//
//  SecondViewController.h
//  PaletteCreator
//
//  Created by Diego on 15/11/16.
//  Copyright © 2016 Diego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCPalette.h"
#import "AppDelegate.h"
@class PCPaletteView;


@interface PaletteInfo : UIViewController<UITextFieldDelegate>{
    
    AppDelegate * dele;
   
    IBOutlet PCPaletteView *palettePreview;
    IBOutlet UITextField *nameTextField;
}

@property PCPalette * palette;

@end

