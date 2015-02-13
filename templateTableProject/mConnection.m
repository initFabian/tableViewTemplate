//
//  mConnection.m
//  templateTableProject
//
//  Created by Fabian Buentello on 2/12/15.
//  Copyright (c) 2015 Fabian Buentello. All rights reserved.
//

#import "mConnection.h"

//NETWORKING
NSURLSession *session;
NSURLSessionDataTask *dataTask;


@implementation mConnection


/**
 *  This is where all the Networking happens.
 *
 *  @param session NSURLSession: mySessionWithPassword:
 *  @param req     NSMutableURLRequest: myRequestWithURL:
 *  @param handler Function: Callback
 */
- (void)dataTaskFromSession:(NSURLSession *)session andRequest:(NSMutableURLRequest *)req withCallBack:(void(^)(bool error, NSMutableArray *response))handler{
    
    _completionHandler = [handler copy];
    
    dataTask = [session
                dataTaskWithRequest:req
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    
                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                    
                    if (!error && ((long)[httpResponse statusCode] == 200)) {
                        
                        NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                        
                        _completionHandler(false, json);
                        
                    } else {
                        _completionHandler(true, nil);
                    }
                    
                    return ;
                }];
    [dataTask resume];
}


/**
 *  Sets the NSURLSession that will be passed to dataTaskFromSession:andRequest:withCallBack:
 *
 *  @param pwd String: Password for the config node
 *
 *  @return NSURLSession Object
 */

- (NSURLSession *)mySessionWithPassword:(NSString *)pwd {
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = @{@"AUTH": pwd};
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    return session;
}

-(NSURLSession *)mySession {
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    return session;
}

/**
 *  Sets NSMutableURLRequest that will be passed to dataTaskFromSession:andRequest:withCallBack:
 *
 *  @param url String: IP Address of Node-Red instance
 *
 *  @return NSMutableURLRequest Object
 */
- (NSMutableURLRequest *)myRequestWithURL:(NSString *)url {
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    return req;
}



-(void)verifyipAddress:(NSString *)ipAddress
          withPassword:(NSString *)password
          withCallBack:(void (^)(bool error, NSMutableArray *response))ipHandler {
    _ipHandler = [ipHandler copy];
    NSURLSession *session = [self mySessionWithPassword:password];
    NSMutableURLRequest *request = [self myRequestWithURL:[NSString stringWithFormat:@"http://%@/injector/status",ipAddress]];
    
    [self dataTaskFromSession:session andRequest:request withCallBack:^(bool error, NSMutableArray *response) {
        _ipHandler(error, response);
    }];
}


-(void)getDataWithURL:(NSString *)urlString uponCompletion:(void (^)(bool, NSMutableArray *))handler {
    _dataHandler = [handler copy];
    NSURLSession *sess = [self mySession];
    
    NSMutableURLRequest *req = [self myRequestWithURL:urlString];
    [self dataTaskFromSession:sess andRequest:req withCallBack:^(bool error, NSMutableArray *response) {
        
        _dataHandler(error,response);
    }];
}

-(void)verifyUserWithUrl:(NSString *)url
            withUsername:(NSString *)username
            withPassword:(NSString *)password
          uponCompletion:(void (^)(bool, NSMutableArray *))userHandler {
    _userHandler = [userHandler copy];
    NSURLSession *sess = [self mySession];
    
    //need to pass in username and password
    NSMutableURLRequest *req = [self myRequestWithURL:[NSString stringWithFormat:@"%@%@%@",url,username,password]];
    [self dataTaskFromSession:sess andRequest:req withCallBack:^(bool error, NSMutableArray *response) {

        _userHandler(error,response);
    }];
}
@end

































