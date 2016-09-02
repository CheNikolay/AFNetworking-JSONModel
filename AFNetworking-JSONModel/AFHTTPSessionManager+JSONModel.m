//
//  AFHTTPSessionManager+JSONModel.m
//  AFNetworking-JSONModel
//
//  Created by Felix Ayala on 9/2/16.
//  Copyright © 2016 Felix Ayala. All rights reserved.
//

#import "AFHTTPSessionManager+JSONModel.h"
#import <JSONModel/JSONModel.h>

static NSString *const kErrorDomain = @"felixaya.la";

NS_ENUM(NSInteger, JSONModelSerializeError) {
	JSONModelSerializeInvalidObjectError = 1000,
	JSONModelSerializeInvalidClassError,
};

@implementation AFHTTPSessionManager (JSONModel)

- (void)GET:(NSString *)URLString parameters:(id)parameters responseClass:(Class)responseClass complete:(CompleteHandler)complete {
	
	[self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		
		[self handleResponse:responseObject responseClass:responseClass complete:complete];
		
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		if (complete) complete(nil, nil, error);
	}];
	
}

- (void)POST:(NSString *)URLString parameters:(id)parameters responseClass:(Class)responseClass complete:(CompleteHandler)complete {
	
	[self POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		
		[self handleResponse:responseObject responseClass:responseClass complete:complete];
		
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		if (complete) complete(nil, nil, error);
	}];
	
}

- (void)handleResponse:(id)responseObject responseClass:(Class)responseClass complete:(CompleteHandler)complete {
	if (![responseObject isKindOfClass:[NSDictionary class]]) {
		
		NSDictionary *userInfo = @{
								   NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Can't convert response object to NSDictionary. Your response: %@", responseObject],
								   NSLocalizedRecoverySuggestionErrorKey: @"Subclass JSONModel in order to serialize the response"
								   };
		NSError *error = [[NSError alloc] initWithDomain:kErrorDomain code:JSONModelSerializeInvalidObjectError userInfo:userInfo];
		
		if (complete) complete(responseObject, nil, error);
		
		return;
	}
	
	if (![responseClass isSubclassOfClass:[JSONModel class]]) {
		
		NSDictionary *userInfo = @{
								   NSLocalizedDescriptionKey: [NSString stringWithFormat:@"You must pass as a parameter a class that inherits from JSONModel. You passed %@", [responseClass class]],
								   NSLocalizedRecoverySuggestionErrorKey: @"Subclass JSONModel in order to serialize the response"
								   };
		NSError *error = [[NSError alloc] initWithDomain:kErrorDomain code:JSONModelSerializeInvalidClassError userInfo:userInfo];
		
		if (complete) complete(responseObject, nil, error);
		
		return;
	}
	
	
	NSError *err = nil;
	JSONModel *serializedResponse = [[responseClass alloc] initWithDictionary:responseObject error:&err];
	
	if (!err) {
		if (complete) complete(responseObject, nil, err);
	} else {
		if (complete) complete(responseObject, serializedResponse, nil);
	}
}

@end
