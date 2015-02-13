//
//  cellObject.h
//  templateTableProject
//
//  Created by Fabian Buentello on 2/12/15.
//  Copyright (c) 2015 Fabian Buentello. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cellObject : NSObject

@property(weak, nonatomic) NSString *username;
@property(weak, nonatomic) NSString *firstName;
@property(weak, nonatomic) NSString *lastName;


- (id) initWithUserName:(NSString *)uName andFirstName:(NSString *)fName andLastName:(NSString *)lName;

@end
