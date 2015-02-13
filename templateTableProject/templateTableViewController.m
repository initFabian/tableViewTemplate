//
//  templateTableViewController.m
//  templateTableProject
//
//  Created by Fabian Buentello on 2/12/15.
//  Copyright (c) 2015 Fabian Buentello. All rights reserved.
//

#import "templateTableViewController.h"

#define urlString @"http://www.json-generator.com/api/json/get/chtlTsLAzm?indent=2"
@interface templateTableViewController () {
    
    mConnection *mConnect;
}

@end

@implementation templateTableViewController
@synthesize tableArray;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    mConnect = [[mConnection alloc] init];
    self.tableArray = [[NSMutableArray alloc] init];
    // Initialize the refresh control.
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self
                            action:@selector(pulledRefresh)
                  forControlEvents:UIControlEventValueChanged];
    [self performSelector:@selector(getTableViewData) withObject:nil afterDelay:1.0];
    [self getTableViewData];
}

-(void)pulledRefresh {
    if (self.refreshControl) {
        
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor lightGrayColor] forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self getTableViewData];
    }
}

- (void)getTableViewData {
    
    
    __block templateTableViewController * weakSelf = self;
    
    [mConnect getDataWithURL:urlString uponCompletion:^(bool error, NSMutableArray *response) {
        if (!error) {

            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableArray *tempArr = [NSMutableArray new];
                
                for (int x = 0; x < response.count; x++) {
                    NSString *username = [[response objectAtIndex:x] objectForKey:@"username"];
                    NSString *firstname = [[response objectAtIndex:x] objectForKey:@"firstname"];
                    NSString *lastname = [[response objectAtIndex:x] objectForKey:@"lastname"];
                    cellObject *obj = [[cellObject alloc] initWithUserName:username andFirstName:firstname andLastName:lastname];
                    [tempArr addObject:obj];
                }
                weakSelf.tableArray = [NSMutableArray arrayWithArray:tempArr];
                [weakSelf.refreshControl endRefreshing];
                // Reload table data
                [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            });
            
        } else {
            weakSelf.tableArray = response;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
                
                [[[UIAlertView alloc] initWithTitle:@"Sorry!"
                                            message:@"There was an issue connecting, please try again."
                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            });
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [tableArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    customCell *cell = (customCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
        cellObject *currObj = [self.tableArray objectAtIndex:indexPath.row];
        cell.cellLabel.text = currObj.username;
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
