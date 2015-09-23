//
//  mConnection.h
//  templateTableProject
//
//  Created by Fabian Buentello on 2/12/15.
//  Copyright (c) 2015 Fabian Buentello. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mConnection : NSObject{
    void (^_completionHandler)(bool error, NSMutableArray *response);
    void (^_userHandler)(bool error, NSMutableArray *response);
    void (^_dataHandler)(bool error, NSMutableArray *response);
}



- (void) verifyUserWithUrl:(NSString *)url
              withUsername:(NSString *)username
              withPassword:(NSString *)password
            uponCompletion:(void(^)(bool error,NSMutableArray *response))userHandler;

- (void) getDataWithURL:(NSString *)urlString
        uponCompletion:(void(^)(bool error, NSMutableArray *response))handler;
@end