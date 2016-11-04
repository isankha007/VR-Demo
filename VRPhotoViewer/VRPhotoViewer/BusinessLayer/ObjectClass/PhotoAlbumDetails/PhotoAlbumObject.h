//
//  PhotoAlbumObject.h
//  VRPhotoViewer
//
//  Created by Sankhadeep on 10/03/16.
//  Copyright © 2016 Sankhadeep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoAlbumObject : NSObject
@property (nonatomic, strong)NSString *strDisplayName;
@property (nonatomic, strong)NSString *strDateCreated;
@property (nonatomic, strong)NSString *strAlbumStatusId;
@property (nonatomic, strong)NSString *strDisplayOrder;
@property (nonatomic, strong)NSString *strLastUpdate;
@property (nonatomic, strong)NSMutableArray *arrmPhoto;

@end
