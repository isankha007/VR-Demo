
/********************************************//*!
* @file APIManager.m
* @brief Contains constants and global parameters
* Sankhadeep! Inc. ("COMPANY") CONFIDENTIAL
* Unpublished Copyright (c) 2015 Sankhadeep! Inc., All Rights Reserved.
***********************************************/


#import "APIManager.h"

@implementation APIManager
{
}

+ (APIManager *)sharedManagerWithDelegate:(id)delegate
{
    static APIManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        [sharedMyManager setDelegate:delegate];
    });
    return sharedMyManager;
}

- (void)startRequestWithURL:(NSURL *)url withRequestType:(APIManagerRequestType)requestType withDataDictionary:(NSDictionary *)dataDictionary CalledforMethod:(APIManagerCalledForMethodName)APImethodName
{
    NSLog(@"Request : %@", dataDictionary);
    if (url == nil || (requestType != kAPIManagerRequestTypeGET && requestType != kAPIManagerRequestTypePOST))
    {
        NSLog(@"Please call APIManager properly.");
        return;
    }
    networkManager = [AFHTTPRequestOperationManager manager];
   /* if ([url.absoluteString isEqualToString:BASE_URL])
    {
        networkManager.requestSerializer = [AFJSONRequestSerializer serializer];
    }*/
   // networkManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    networkManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    NSLog(@"APIManager start request");
    NSLog(@"%@", dataDictionary);

    if (requestType == kAPIManagerRequestTypeGET)
    {
        [networkManager GET:url.absoluteString parameters:dataDictionary
                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSLog(@"APIManager success.");
                        [self.delegate APIManagerDidFinishRequestWithData:responseObject withRequestType:requestType CalledforMethod:APImethodName];
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"APIManager error.");
                        [self.delegate APIManagerDidFinishRequestWithError:error withRequestType:requestType CalledforMethod:APImethodName];
                    }];
    }
    else
    {
        [networkManager POST:url.absoluteString parameters:dataDictionary
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                         NSLog(@"APIManager success.");
                         NSLog(@"Request : %@", dataDictionary);
                         [self.delegate APIManagerDidFinishRequestWithData:(NSData *)responseObject withRequestType:requestType CalledforMethod:APImethodName];
                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         NSLog(@"APIManager error.");
                         [self.delegate APIManagerDidFinishRequestWithError:error withRequestType:requestType CalledforMethod:APImethodName];
                     }];
    }
}

-(void)cancelRequestWithURL:(NSURL *)url withRequestType:(APIManagerRequestType)requestType withDataDictionary:(NSDictionary *)dataDictionary CalledforMethod:(APIManagerCalledForMethodName)APImethodName
{
    [networkManager DELETE:url.absoluteString parameters:dataDictionary
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     NSLog(@"APIManager success.");
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"APIManager error.");
                 }];
}

- (void)startRequestForImageUploadingWithURL:(NSURL *)url withRequestType:(APIManagerRequestType)requestType withDataDictionary:(NSDictionary *)dataDictionary arrImage:(NSMutableArray *)arrImage CalledforMethod:(APIManagerCalledForMethodName)APImethodName  index:(NSInteger)index isMultiple:(BOOL)isMultiple
{
    NSString *strmsg;
    if (isMultiple==YES)
    {
         strmsg=[NSString stringWithFormat:@"Uploading %ld/%lu",(long)index,(unsigned long)arrImage.count];
    }
    else
    {
        strmsg=@"Uploading image";
    }
    NSLog(@"meesage=%@",strmsg);
    
    if (url == nil || (requestType != kAPIManagerRequestTypeGET && requestType != kAPIManagerRequestTypePOST))
    {
        NSLog(@"Please call APIManager properly.");
        return;
    }
    networkManager=nil;
    networkManager = [AFHTTPRequestOperationManager manager];
    networkManager.requestSerializer = [AFJSONRequestSerializer serializer];
    networkManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [networkManager POST:url.absoluteString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        NSData *dataimg=UIImageJPEGRepresentation([arrImage objectAtIndex:index], 1.0);
       // [formData appendPartWithFileData:[arrImage objectAtIndex:index] name:@"files[0]" fileName:@"files.jpg" mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:dataimg name:@"files[0]" fileName:@"files.jpg" mimeType:@"image/jpeg"];
    }
    success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
         NSDictionary *dictResponse = (NSDictionary *)responseObject;
        NSLog(@"dictResponse...%@",dictResponse);
         NSInteger i=index;
         i=i+1;
         if (i<arrImage.count)
         {
             [self startRequestForImageUploadingWithURL:(NSURL *)url withRequestType:(APIManagerRequestType)requestType withDataDictionary:(NSDictionary *)dataDictionary arrImage:(NSMutableArray *)arrImage CalledforMethod:(APIManagerCalledForMethodName)APImethodName index:i isMultiple:YES];
         }
         else
         {
             [self.delegate APIManagerDidFinishRequestWithData:(NSData *)responseObject withRequestType:requestType CalledforMethod:APImethodName];
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self.delegate APIManagerDidFinishRequestWithError:error withRequestType:requestType CalledforMethod:APImethodName];
     }];
}

- (void)CancelAllRequest
{
    //AFHTTPRequestOperationManager *networkManager = [AFHTTPRequestOperationManager manager];
    [networkManager.operationQueue cancelAllOperations];
}

@end
