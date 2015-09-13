//
//  templateTableViewController.h
//  templateTableProject
//
//  Created by Fabian Buentello on 2/12/15.
//  Copyright (c) 2015 Fabian Buentello. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customCell.h"
#import "mConnection.h"
#import "cellObject.h"
#import "UIImageView+WebCache.h"

@interface templateTableViewController : UITableViewController
@property(strong, nonatomic) NSMutableArray *tableArray;
@end
