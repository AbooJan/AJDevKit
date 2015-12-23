//
//  TestMyNetWork.m
//  
//
//  Created by admin on 13-5-22
//  Copyright (c) 2012年 cnmobi . All rights reserved.
//

#import "TestMyNetWork.h"
#import "Reachability.h"

@implementation TestMyNetWork

+ (BOOL)testConnection
{
    BOOL result = YES;

    Reachability *reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    
    NetworkStatus status;
    
    status = [reach currentReachabilityStatus];
    
    if (status == NotReachable){
        
        result = NO;
        
    } else if (status == ReachableViaWWAN){
        
        result = YES;
        
    } else if (status == ReachableViaWiFi){
        
        result = YES;
        
    }else {
        
        result = NO;
        
    }
    
    return result;

}

@end
