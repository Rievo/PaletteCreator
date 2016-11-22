//
//  AppDelegate.m
//  PaletteCreator
//
//  Created by Diego on 15/11/16.
//  Copyright © 2016 Diego. All rights reserved.
//

#import "AppDelegate.h"
#import "PCPalette.h"
#import "XMLDictionary.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _palettes = [[NSMutableArray alloc] init];
    
    [self loadDatabase];
    
    return YES;
}

-(void)loadDatabase{
    NSError * error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/palettes.json",
                          documentsDirectory];
    
    
    NSString *content = [[NSString alloc] initWithContentsOfFile:fileName
                                                    usedEncoding:nil
                                                           error:&error];
    
    NSLog(@"Error: %@", [error description]);
    
    [self parseJSONContent:content];
}

-(void)parseJSONContent:(NSString *)str{
    
    if(str != nil){
        NSData* jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *jsonError;
        NSArray * jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
        
        for(NSDictionary * dic in jsonArray){
                    
            PCPalette * temp = [[PCPalette alloc] init];
            temp.name = [dic objectForKey:@"name"];
            temp.information = [dic objectForKey:@"information"];
            if(temp.information == nil) temp.information = @"";
            
            NSArray * colorsArray = [dic objectForKey:@"colors"];
            
            for(NSDictionary * colorDic in colorsArray){
                NSNumber * rn = [colorDic objectForKey:@"red"];
                NSNumber * gn = [colorDic objectForKey:@"green"];
                NSNumber * bn = [colorDic objectForKey:@"blue"];
                
                int r = [rn intValue];
                int g = [gn intValue];
                int b = [bn intValue];
                
                PCColor * color = [[PCColor alloc] initWith255Red:r andGreen:g andBlue:b andAlpha:1.0];
                [temp.colors addObject:color];
            }
            
            
            [_palettes addObject:temp];
        }

    }
    
}

-(void)parseXMLContent:(NSString *)str{
    NSDictionary * dic = [NSDictionary dictionaryWithXMLString:str];
    NSArray * pals = [dic objectForKey:@"palette"];
    
    for(NSDictionary * dic in pals){
        PCPalette * temp = [[PCPalette alloc] initWithDictionary:dic];
        
        [self.palettes addObject:temp];
    }

}
//Method retrieves content from documents directory and
//displays it in an alert



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //Save database
    [self writeToTextFile];
}

-(void) writeToTextFile{
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/palettes.json",
                          documentsDirectory];
    //create content - four lines of text
    //NSString *content = [self generateXML];
    NSString * content = [self generateJSON];
    
    //save content to the documents directory
    [content writeToFile:fileName
              atomically:NO
                encoding:NSStringEncodingConversionAllowLossy
                   error:nil];
    
}

-(NSString *)generateJSON{
    
    

    
    NSMutableArray * palettesArray = [[NSMutableArray alloc] init];
    
    for( int i = 0; i< self.palettes.count; i++){
        PCPalette * pal = self.palettes[i];
        NSMutableDictionary * paletteDic = [[NSMutableDictionary alloc] init];
        [paletteDic setObject:pal.name forKey:@"name"];
        
        if(pal.information != nil)
            [paletteDic setObject:pal.information forKey:@"information"];
        if(pal.identifier != nil)
            [paletteDic setObject:pal.identifier forKey:@"identifier"];
        
        NSMutableArray * colorsArray = [[NSMutableArray alloc] init];
        for(PCColor * color in pal.colors){
            NSDictionary * colorDic = [color convertToDictionary];
            [colorsArray addObject:colorDic];
        }
        
        [paletteDic setObject:colorsArray forKey:@"colors"];
        
        [palettesArray addObject:paletteDic];
    }
    
    NSError * error;
    
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:palettesArray
                        options:NSJSONWritingPrettyPrinted
                        error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", jsonString);
    
    
    return  jsonString;
}

-(NSString *)generateXML{
    NSString * text = @"";
    
    //text = [text stringByAppendingString:@""];
    
    
    //Palettes
    text = [text stringByAppendingString:@"<palettes>"];
    
    for(int i = 0; i< self.palettes.count; i++){
        PCPalette * temp = self.palettes[i];
        text = [text stringByAppendingString:[NSString stringWithFormat:@"<palette name=\"%@\">"
                                              , temp.name]];
        
        text = [text stringByAppendingString:@"<colors>"];
        //For each color
        for(PCColor * pccolor in temp.colors){
            
            text = [text stringByAppendingString:[NSString stringWithFormat:@"<color  red=\"%d\" green=\"%d\" blue=\"%d\">",pccolor.red,pccolor.green, pccolor.blue]];
            
            text = [text stringByAppendingString:@"</color>"];
            //text = [text stringByAppendingString:[NSString stringWithFormat:@"<color red=\"%d\" green=\"%d\" blue=\"%d\"/>",pccolor.red,pccolor.green, pccolor.blue]];
            
        }
        text = [text stringByAppendingString:@"</colors>"];
        text = [text stringByAppendingString:@"</palette>"];
    }
    text = [text stringByAppendingString:@"</palettes>"];
    
    return text;
}


@end
