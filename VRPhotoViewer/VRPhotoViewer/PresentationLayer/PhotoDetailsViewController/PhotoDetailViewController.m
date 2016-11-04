//
//  PhotoDetailViewController.m
//  PhotoGallery
//
//  Created by Sankhadeep on 10/03/16.
//  Copyright © 2016 Sankhadeep. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "PhotoDetailCell.h"
#import "AlbumFromAPIViewController.h"

@interface PhotoDetailViewController ()

@end

@implementation PhotoDetailViewController

#pragma mark - View LifeCycle -

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.lblHeader.text = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    
    if (!self.arrmImagePhoto) {
        self.arrmImagePhoto= [[NSMutableArray alloc] init];
    } else {
        [self.arrmImagePhoto removeAllObjects];
    }
    
    ALAssetsGroupEnumerationResultsBlock assetsEnumerationBlock = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        
        if (result) {
            [self.arrmImagePhoto addObject:result];
        }
    };
    
    ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
    [self.assetsGroup setAssetsFilter:onlyPhotosFilter];
    [self.assetsGroup enumerateAssetsUsingBlock:assetsEnumerationBlock];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    return self.arrmImagePhoto.count;
}

#define kImageViewTag 1 // the image view inside the collection view cell prototype is tagged with "1"

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoDetailCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoDetailCell" forIndexPath:indexPath];
    ALAsset *asset = self.arrmImagePhoto[indexPath.row];
    CGImageRef thumbnailImageRef = [asset thumbnail];
    UIImage *thumbnail = [UIImage imageWithCGImage:thumbnailImageRef];
    
    // apply the image to the cell
    [cell.imgvPhotoDetails setTag:kImageViewTag];
    [cell.imgvPhotoDetails setImage:thumbnail];
    return cell;
}

#pragma mark - UICollectionView Delegate -

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - UIButton Action -

- (IBAction)btnBack_Click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnNext_Click:(id)sender
{
    AlbumFromAPIViewController *album = (AlbumFromAPIViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"AlbumFromAPIViewController"];
    [self.navigationController pushViewController:album animated:NO];
}


@end
