//
//  mConnection.h
//  templateTableProject
//
//  Created by Fabian Buentello on 2/12/15.
//  Copyright (c) 2015 Fabian Buentello. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mConnection : NSObject {
    void (^_completionHandler)(bool error, NSMutableArray *response);
    void (^_ipHandler)(bool error, NSMutableArray *response);
    void (^_userHandler)(bool error, NSMutableArray *response);
    void (^_dataHandler)(bool error, NSMutableArray *response);
}

/**
 *  Verify The IP Address before saving it
 *
 *  @param ipAddress     String: IP Address of Node-Red instance
 *  @param password      String: Password for the config node
 *  @param verifyHandler Function: Callback
 */
- (void) verifyipAddress:(NSString *)ipAddress
            withPassword:(NSString *)password
            withCallBack:(void(^)(bool error, NSMutableArray *response))ipHandler;

- (void) verifyUserWithUrl:(NSString *)url
              withUsername:(NSString *)username
              withPassword:(NSString *)password
            uponCompletion:(void(^)(bool error,NSMutableArray *response))userHandler;

- (void) getDataWithURL:(NSString *)urlString
        uponCompletion:(void(^)(bool error, NSMutableArray *response))handler;
@end