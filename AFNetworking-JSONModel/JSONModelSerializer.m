//
//  JSONModelSerializer.m
//  AFNetworking-JSONModel
//
//  Created by Felix Ayala on 9/2/16.
//  Copyright © 2016 Felix Ayala. All rights reserved.
//

#import "JSONModelSerializer.h"
#import <JSONModel/JSONModel.h>

@interface JSONModelSerializer ()

@property (nonatomic, strong) Class responseClass;

@end

@implementation JSONModelSerializer

+ (instancetype)serializerForClass:(Class)responseClass {
	
	if (![responseClass isSubclassOfClass:[JSONModel class]]) {
		NSLog(@"ERROR: You must pass as a parameter a class that inherits from JSONModel. You passed %@", responseClass);
		return nil;
	}
	
	JSONModelSerializer *serializer = [[self alloc] init];
	serializer.responseClass = responseClass;
	
	return serializer;
}

- (id)responseObjectForResponse:(NSURLResponse *)response
						   data:(NSData *)data
						  error:(NSError *__autoreleasing *)error {
	
	NSData *validatedData = [super responseObjectForResponse:response data:data error:error];
	if (*error) {
		NSLog(@"%@", *error);
		return validatedData;
	}
	
	JSONModel *jsonModel = [[self.responseClass alloc] initWithData:validatedData error:error];
	if (*error) {
		NSLog(@"%@", *error);
		return validatedData;
	}
	
	return jsonModel;
}

@end
