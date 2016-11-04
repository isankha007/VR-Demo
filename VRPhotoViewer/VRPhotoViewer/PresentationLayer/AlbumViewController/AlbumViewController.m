//
//  AlbumViewController.m
//  PhotoGallery
//
//  Created by Sankhadeep on 10/03/16.
//  Copyright © 2016 Sankhadeep. All rights reserved.
//

#import "AlbumViewController.h"
#import "AlbumCell.h"
#import "PhotoDetailViewController.h"

@interface AlbumViewController ()

@end

@implementation AlbumViewController

@synthesize albumCollection,vwNavigation,lblHeader;

#pragma mark - View LifeCycle -

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.assetsLibrary == nil) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    if (self.arrmImageAlbusIcon == nil) {
        self.arrmImageAlbusIcon = [[NSMutableArray alloc] init];
    } else {
        [self.arrmImageAlbusIcon removeAllObjects];
    }
    
    // setup our failure view controller in case enumerateGroupsWithTypes fails
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        NSString *errorMessage = nil;
        switch ([error code]) {
            case ALAssetsLibraryAccessUserDeniedError:
            case ALAssetsLibraryAccessGloballyDeniedError:
                errorMessage = @"The user has declined access to it.";
                break;
            default:
                errorMessage = @"Reason unknown.";
                break;
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    };
    
    // emumerate through our groups and only add groups that contain photos
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop)
    {
        ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
        [group setAssetsFilter:onlyPhotosFilter];
        if ([group numberOfAssets] > 0)
        {
            [self.arrmImageAlbusIcon addObject:group];
        }
        else
        {
            [albumCollection performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        }
    };
    
    // enumerate only photos
    NSUInteger groupTypes = ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupSavedPhotos;
    [self.assetsLibrary enumerateGroupsWithTypes:groupTypes usingBlock:listGroupBlock failureBlock:failureBlock];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionView DataSource -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.arrmImageAlbusIcon count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"AlbumCell" forIndexPath:indexPath];
    // [cell.imgvLogo setFrame:CGRectMake(0, 0, 150, 150)];
    [cell.imgvLogo.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [cell.imgvLogo.layer setBorderWidth: 2.0];
    cell.imgvLogo.tag=indexPath.row;
    
    ALAssetsGroup *groupForCell = self.arrmImageAlbusIcon[indexPath.row];
    CGImageRef posterImageRef = [groupForCell posterImage];
    UIImage *posterImage = [UIImage imageWithCGImage:posterImageRef];
    cell.imgvLogo.image = posterImage;
    cell.lblName.text = [groupForCell valueForProperty:ALAssetsGroupPropertyName];
    cell.lblTotalImage.text = [@(groupForCell.numberOfAssets) stringValue];
    return cell;
}

#pragma mark - UICollectionView Delegate -

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoDetailViewController *photoDetailsVC = (PhotoDetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"PhotoDetailViewController"];
    photoDetailsVC.assetsGroup = self.arrmImageAlbusIcon[indexPath.row];
    [self.navigationController pushViewController:photoDetailsVC animated:NO];
}


#pragma mark - Self Method-



@end
