//
//  cellObject.m
//  templateTableProject
//
//  Created by Fabian Buentello on 2/12/15.
//  Copyright (c) 2015 Fabian Buentello. All rights reserved.
//

#import "cellObject.h"

@implementation cellObject
@synthesize username,firstName,lastName;

- (id) initWithUserName:(NSString *)uName andFirstName:(NSString *)fName andLastName:(NSString *)lName {
    
    if (self = [self init]) {
        
        self.username = uName;
        self.firstName = fName;
        self.lastName = lName;
    }
    
    return self;

}
@end
