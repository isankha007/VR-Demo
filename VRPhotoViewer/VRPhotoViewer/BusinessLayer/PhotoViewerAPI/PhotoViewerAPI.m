//
//  PhotoViewerAPI.m
//  VRPhotoViewer
//
//  Created by Sankhadeep on 10/03/16.
//  Copyright © 2016 Sankhadeep. All rights reserved.
//

#import "PhotoViewerAPI.h"

@implementation PhotoViewerAPI


-(void)getAlbums
{
    APIManager *apiManager = [[APIManager alloc] init];
    [apiManager setDelegate:(id)self];
 /*   NSDictionary *params = @{
                             @"sid":@"TestSID",
                             @"token":@"TestToken",
                             @"pageSize":@"10",
                             //@"method":@"GetAlbums",
                             @"pageNumber":@"1"
                             };*/
    
    [apiManager startRequestWithURL:BASE_URL withRequestType:kAPIManagerRequestTypeGET withDataDictionary:nil CalledforMethod:GetAlbums];
}

#pragma mark - APIManager Delegate Implementation -

/********************************************//*!
* @brief This method is used to handle APIManagerDidFinishRequestWithData delegate if above all method send successfull response from server then this method will called and redirect to screen according to their delegate method.
***********************************************/

-(void)APIManagerDidFinishRequestWithData:(id)responseData withRequestType:(APIManagerRequestType)requestType CalledforMethod:(APIManagerCalledForMethodName)APImethodName
{
    NSDictionary *dictResponse = (NSDictionary *)responseData;
    [self.PhotoVieweAPIDelegate PhotoViewerRespose:dictResponse method:APImethodName];
}

/********************************************//*!
* @brief This method is used to handle APIManagerDidFinishRequestWithError delegate if above all method send unsuccessfull response from server or there are any error during service call then this method will called and redirect to screen according to their delegate method.
***********************************************/

-(void)APIManagerDidFinishRequestWithError:(NSError *)error withRequestType:(APIManagerRequestType)requestType CalledforMethod:(APIManagerCalledForMethodName)APImethodName
{
    [self.PhotoVieweAPIDelegate PhotoViewerError:error method:APImethodName];
}

@end
