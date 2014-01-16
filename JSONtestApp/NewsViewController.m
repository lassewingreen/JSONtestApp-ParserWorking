//
//  NewsViewController.m
//  JSONtestApp
//
//  Created by Lasse Wingreen on 02/01/14.
//  Copyright (c) 2014 Agro52 Aps. All rights reserved.
//

#import "NewsViewController.h"
#import "NSString+strippedHTMLforString.h"
#import "NSString+StripHTMLwithRegEX.h"

@interface NewsViewController ()


@end

@implementation NewsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"player";

    
  //  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
    {
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL * url = [NSURL URLWithString:@"http://playnation.eu/beta/hacks/getItem.php"];
        NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
        NSString * params =@"tableName=player";
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                               
                                                               NSLog(@"Response:%@ %@\n", response, error);
                                                               
                                                               
                                                               if(error == nil)
                                                               {
                                                                   NSString * text = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
                                                                   NSLog(@"Data = %@",text);
                                                               
                                                                   
                                                                   NSString* mystring = text;
                                                                   NSString* stripped = [mystring stripHtml];
                                                                   
                                                                   NSLog(@"Stripped Data = %@",stripped);
                                                                   
                                                                   NSData* strippedJsonData = [stripped dataUsingEncoding:NSUTF8StringEncoding];
                                                                   
                                                                   
                                                                   NSError *jsonNewsError = nil;
                                                                   
                                                                   newsDictionaryJson = [NSJSONSerialization
                                                                                         JSONObjectWithData:strippedJsonData
                                                                                         options:NSJSONReadingAllowFragments
                                                                                         error:&jsonNewsError];
                                                                   
                                                                   
                                                                   
                                                                   
                                                                   
                                                                    
                                                                   if (!newsDictionaryJson) {
                                                                            NSLog(@"Error parsing JSON: %@", jsonNewsError);
                                                                   }
                                                                   
                                                                   else {
                                                                       NSLog(@"jsonList: %@", newsDictionaryJson);
                                                                       
                                                                       NSLog(@"jsonKeyList: %@", playerIdArray);
                                                                   }
                                                                   
                                                               
                                                                    
                                                                    }
                                                              
                                                                    
                                                                    
                                                           }];
        [dataTask resume];
        
    }
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


//
//
//-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//
//     NSLog(@"Connection Recived Response!");
//
//    newsData = [[NSMutableData alloc] init];
//
//}
//
//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theNewsData {
//
//    NSLog(@"Connection Recived Data!");
//
//    [newsData appendData:theNewsData];
//
//
//}
//
//
//-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
//
//    NSLog(@"Connection succeded!");
//
//
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//
//    NSError *jsonNewsError = nil;
//
//    newsTableArray = [NSJSONSerialization JSONObjectWithData:newsData options:NSJSONReadingAllowFragments error:&jsonNewsError];
//
//    [NewsTableView reloadData];
//
//    if (!newsTableArray) {
//        NSLog(@"Error parsing JSON: %@", jsonNewsError);
//    }    else {
//        for(NSDictionary *jsonNewsItems in newsTableArray) {
//            NSLog(@"Item: %@", jsonNewsItems);
//        }
//
//    }
//
//
//}
//
//
//
//
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//    
//    UIAlertView *newsErrorView = [[UIAlertView alloc] initWithTitle:@"Network Error" message:@"The dowload could not complete! -Because of an error" delegate:nil cancelButtonTitle:@"Dissmiss" otherButtonTitles:nil];
//    [newsErrorView show];
//    
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//    
//}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [newsDictionaryJson count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        UITableViewCell *cellNews = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewsCell"];
        
    
    //cellNews.textLabel.text = news [indexPath.row];
    
    return cellNews;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
