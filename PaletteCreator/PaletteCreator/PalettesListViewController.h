//
//  FirstViewController.h
//  PaletteCreator
//
//  Created by Diego on 15/11/16.
//  Copyright © 2016 Diego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface PalettesListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    AppDelegate * dele;
    IBOutlet UITableView *table;
}


@end

