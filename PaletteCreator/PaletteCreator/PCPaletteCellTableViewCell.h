//
//  PCPaletteCellTableViewCell.h
//  PaletteCreator
//
//  Created by Diego on 15/11/16.
//  Copyright © 2016 Diego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCPaletteView.h"

@interface PCPaletteCellTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet PCPaletteView *paletteView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@end
