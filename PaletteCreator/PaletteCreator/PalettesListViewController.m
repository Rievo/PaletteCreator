//
//  FirstViewController.m
//  PaletteCreator
//
//  Created by Diego on 15/11/16.
//  Copyright © 2016 Diego. All rights reserved.
//

#import "PalettesListViewController.h"
#import "PCPalette.h"
#import "PCPaletteCellTableViewCell.h"

@interface PalettesListViewController ()

@end

@implementation PalettesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    dele = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //dele.navigationCntr = [[UINavigationController alloc] initWithRootViewController:self];
    
    table.dataSource = self;
    table.delegate = self;
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(reloadTable:)
                                                name:@"updatePalettesTable"
                                              object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dele.palettes.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"paletteCell";
    PCPaletteCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                   forIndexPath:indexPath];
    PCPalette * palette = [dele.palettes objectAtIndex:indexPath.row];
    [cell.nameLabel setText:palette.name];
    cell.paletteView.palette = palette;
    [cell.paletteView setNeedsDisplay];
    NSLog(@"Palette.colors= %lu", (unsigned long)palette.colors.count);
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)reloadTable:(NSNotification *)not{
    [table reloadData];
}
@end
