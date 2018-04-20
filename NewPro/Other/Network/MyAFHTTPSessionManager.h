//
//  MyAFHTTPSessionManager.h
//  LNetwork
//
//  Created by idea on 2018/4/11.
//  Copyright © 2018年 idea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface MyAFHTTPSessionManager : NSObject

+ (AFHTTPSessionManager *)sharedHTTPSession;
+ (AFURLSessionManager *)sharedURLSession;

@end
