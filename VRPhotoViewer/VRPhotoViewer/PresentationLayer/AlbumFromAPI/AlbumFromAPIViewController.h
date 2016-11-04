//
//  AlbumFromAPIViewController.h
//  VRPhotoViewer
//
//  Created by Sankhadeep on 10/03/16.
//  Copyright © 2016 Sankhadeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumFromAPIViewController : UIViewController
@property (strong, nonatomic) IBOutlet UICollectionView *albumCollectionVw;
@property (strong, nonatomic) IBOutlet UIView *vwNavigationHeader;
@property (strong, nonatomic) IBOutlet UILabel *lblHeaderForAlbum;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (nonatomic, strong) NSMutableArray *arrmAlbums;
- (IBAction)btnback_Click:(id)sender;

@end
