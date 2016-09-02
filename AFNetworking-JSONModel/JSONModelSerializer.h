//
//  JSONModelSerializer.h
//  AFNetworking-JSONModel
//
//  Created by Felix Ayala on 9/2/16.
//  Copyright © 2016 Felix Ayala. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface JSONModelSerializer : AFHTTPResponseSerializer

+ (instancetype)serializerForClass:(Class)responseClass;

@end
