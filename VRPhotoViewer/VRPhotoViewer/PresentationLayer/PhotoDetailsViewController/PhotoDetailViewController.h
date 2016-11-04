//
//  PhotoDetailViewController.h
//  PhotoGallery
//
//  Created by Sankhadeep on 10/03/16.
//  Copyright © 2016 Sankhadeep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h> 

@interface PhotoDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UICollectionView *photoCollection;
@property (strong, nonatomic) IBOutlet UILabel *lblHeader;
@property (strong, nonatomic) IBOutlet UIView *vwNavigation;
@property (nonatomic, strong) NSMutableArray *arrmImagePhoto;
@property (nonatomic, strong) NSString *strHeaderText;
@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;
- (IBAction)btnNext_Click:(id)sender;
- (IBAction)btnBack_Click:(id)sender;

@end
