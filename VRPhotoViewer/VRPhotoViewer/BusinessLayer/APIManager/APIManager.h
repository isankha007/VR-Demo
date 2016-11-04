
/********************************************//*!
* @file APIManager.h
* @brief Contains constants and global parameters
* Sankhadeep! Inc. ("COMPANY") CONFIDENTIAL
* Unpublished Copyright (c) 2015 Sankhadeep! Inc., All Rights Reserved.
***********************************************/


#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum
{
    kAPIManagerRequestTypeGET,
    kAPIManagerRequestTypePOST
} APIManagerRequestType;

typedef enum {
    GetAlbums,
} APIManagerCalledForMethodName;



@protocol APIManagerDelegate <NSObject>

@required
- (void) APIManagerDidFinishRequestWithData:(id)responseData withRequestType:(APIManagerRequestType)requestType CalledforMethod:(APIManagerCalledForMethodName)APImethodName;
- (void) APIManagerDidFinishRequestWithError:(NSError *)error withRequestType:(APIManagerRequestType)requestType CalledforMethod:(APIManagerCalledForMethodName)APImethodName;
@end

@interface APIManager : NSObject
{
    AFHTTPRequestOperationManager *networkManager;
   // AFHTTPSessionManager
}

@property (nonatomic, retain) id <APIManagerDelegate> delegate;
+ (APIManager *)sharedManagerWithDelegate:(id)delegate;
- (void) startRequestWithURL:(NSURL *)url
             withRequestType:(APIManagerRequestType)requestType
          withDataDictionary:(NSDictionary *)dataDictionary CalledforMethod:(APIManagerCalledForMethodName)APImethodName;

- (void) cancelRequestWithURL:(NSURL *)url
             withRequestType:(APIManagerRequestType)requestType
          withDataDictionary:(NSDictionary *)dataDictionary CalledforMethod:(APIManagerCalledForMethodName)APImethodName;

- (void)startRequestForImageUploadingWithURL:(NSURL *)url withRequestType:(APIManagerRequestType)requestType withDataDictionary:(NSDictionary *)dataDictionary arrImage:(NSMutableArray *)arrImage CalledforMethod:(APIManagerCalledForMethodName)APImethodName  index:(NSInteger)index isMultiple:(BOOL)isMultiple;

- (void)CancelAllRequest;


@end
