//
//  PhotoViewerAPI.h
//  VRPhotoViewer
//
//  Created by Sankhadeep on 10/03/16.
//  Copyright © 2016 Sankhadeep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"APIManager.h"

@protocol PhotoViewerDelegate <NSObject>

-(void)PhotoViewerRespose:(id)rsponseObject method:(APIManagerCalledForMethodName)methodName;
-(void)PhotoViewerError:(NSError*)rsponseObject method:(APIManagerCalledForMethodName)methodName;

@end

@interface PhotoViewerAPI : NSObject
@property(retain,nonatomic)id<PhotoViewerDelegate>PhotoVieweAPIDelegate;
-(void)getAlbums;
@end
