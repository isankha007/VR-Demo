//
//  AlbumCell.h
//  PhotoGallery
//
//  Created by Sankhadeep on 10/03/16.
//  Copyright © 2016 Sankhadeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgvLogo;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (strong, nonatomic) IBOutlet UIView *vwTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblTotalImage;


@end
