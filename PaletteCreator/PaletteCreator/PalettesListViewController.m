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


-(NSString *)generateXML{
    NSString * text = @"";
    
    //text = [text stringByAppendingString:@""];
    
    
    //Palettes
    text = [text stringByAppendingString:@"<palettes>"];
    
    for(int i = 0; i< dele.palettes.count; i++){
        PCPalette * temp = dele.palettes[i];
        text = [text stringByAppendingString:[NSString stringWithFormat:@"<palette name=\"%@\">", temp.name]];
        
        //For each color
        for(PCColor * pccolor in temp.colors){
         
            
            text = [text stringByAppendingString:[NSString stringWithFormat:@"<color red=\"%d\" green=\"%d\" blue=\"%d\"/>",pccolor.red,pccolor.green, pccolor.blue]];
        }
        text = [text stringByAppendingString:@"</palette>"];
    }
    text = [text stringByAppendingString:@"</palettes>"];
    
    return text;
}


- (IBAction)generateXML:(id)sender {
    [self generateXML];
}


-(void) writeToTextFile{
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/palettes.xml",
                          documentsDirectory];
    //create content - four lines of text
    NSString *content = [self generateXML];
    //save content to the documents directory
    [content writeToFile:fileName
              atomically:NO
                encoding:NSStringEncodingConversionAllowLossy
                   error:nil];
    
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

-(void)reloadTable:(NSNotification *)not{
    [table reloadData];
}
@end
