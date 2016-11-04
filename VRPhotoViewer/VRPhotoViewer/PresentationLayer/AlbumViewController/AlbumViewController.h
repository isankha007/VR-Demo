//
//  AlbumViewController.h
//  PhotoGallery
//
//  Created by Sankhadeep on 10/03/16.
//  Copyright © 2016 Sankhadeep. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AssetsLibrary/AssetsLibrary.h> 

@interface AlbumViewController : UIViewController
@property (strong, nonatomic) IBOutlet UICollectionView *albumCollection;
@property (strong, nonatomic) IBOutlet UIView *vwNavigation;
@property (strong, nonatomic) IBOutlet UILabel *lblHeader;
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSMutableArray *arrmImageAlbusIcon;

@end
