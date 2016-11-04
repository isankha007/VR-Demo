//
//  AlbumFromAPICell.h
//  VRPhotoViewer
//
//  Created by Sankhadeep on 10/03/16.
//  Copyright © 2016 Sankhadeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumFromAPICell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgvAlbum;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (strong, nonatomic) IBOutlet UIView *vwTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblAlbumName;

@end
