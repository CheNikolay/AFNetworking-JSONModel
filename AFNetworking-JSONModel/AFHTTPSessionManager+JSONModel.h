//
//  AFHTTPSessionManager+JSONModel.h
//  AFNetworking-JSONModel
//
//  Created by Felix Ayala on 9/2/16.
//  Copyright © 2016 Felix Ayala. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@class JSONModel;

typedef void(^CompleteHandler)(id responseObject, JSONModel *responseModel, NSError *error);

@interface AFHTTPSessionManager (JSONModel)

- (void)GET:(NSString *)URLString parameters:(id)parameters responseClass:(Class)responseClass complete:(CompleteHandler)complete;
- (void)POST:(NSString *)URLString parameters:(id)parameters responseClass:(Class)responseClass complete:(CompleteHandler)complete;
- (void)handleResponse:(id)responseObject responseClass:(Class)responseClass complete:(CompleteHandler)complete;

@end
