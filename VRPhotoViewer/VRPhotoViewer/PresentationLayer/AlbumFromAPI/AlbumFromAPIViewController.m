//
//  AlbumFromAPIViewController.m
//  VRPhotoViewer
//
//  Created by Sankhadeep on 10/03/16.
//  Copyright © 2016 Sankhadeep. All rights reserved.
//

#import "AlbumFromAPIViewController.h"
#import "AlbumFromAPICell.h"
#import "PhotoViewerAPI.h"
#import "PhotoAlbumObject.h"
#import "PhotoUrl.h"
@interface AlbumFromAPIViewController ()
{
    PhotoAlbumObject *objPhotoAlbum;
}
@end

@implementation AlbumFromAPIViewController
@synthesize indicator,albumCollectionVw,vwNavigationHeader,arrmAlbums,lblHeaderForAlbum;

#pragma mark - View LifeCycle -

- (void)viewDidLoad
{
    [super viewDidLoad];
    [albumCollectionVw setHidden:YES];
    [albumCollectionVw setBackgroundColor:[UIColor whiteColor]];
}

 -(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [albumCollectionVw setDataSource:(id)self];
    [albumCollectionVw setDelegate:(id)self];
    [lblHeaderForAlbum setText:@"Choose Image"];
    [self getAlbum];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionView DataSource -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrmAlbums count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumFromAPICell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"AlbumFromAPICell" forIndexPath:indexPath];
    PhotoAlbumObject *objPhoto = [arrmAlbums objectAtIndex:indexPath.row];
    [cell.lblAlbumName setText:[objPhoto strDisplayName]];
    [cell.imgvAlbum sd_setImageWithURL:[NSURL URLWithString:[[[[arrmAlbums objectAtIndex:indexPath.row] arrmPhoto] objectAtIndex:0] strPhotoUrl]] placeholderImage:[UIImage imageNamed:@""]  options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){[cell.indicator startAnimating];}completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){[cell.indicator stopAnimating];}];

    return cell;
}

#pragma mark - UICollectionView Delegate -

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - API Response Delegate Implementation -

-(void)PhotoViewerRespose:(id)rsponseObject method:(APIManagerCalledForMethodName)methodName
{
    NSDictionary *dictResponse = (NSDictionary *)rsponseObject;
    if (methodName==GetAlbums)
    {
        self.view.userInteractionEnabled=YES;
        [self.indicator stopAnimating];
        NSString *strSuccess = [NSString stringWithFormat:@"%@",[dictResponse valueForKey:@"IsSuccess"]];
        if ([strSuccess isEqualToString:@"1"])
        {
            arrmAlbums = [[NSMutableArray alloc] init];
            for (int i=0; i<[[dictResponse valueForKey:@"SearchResult"] count]; i++)
            {
                objPhotoAlbum = [[PhotoAlbumObject alloc] init];
                objPhotoAlbum.strAlbumStatusId=[ValidationClass NullCheckString:[NSString stringWithFormat:@"%@",[[[dictResponse valueForKey:@"SearchResult"] objectAtIndex:i] valueForKey:@"AlbumStatusId"]]];
                objPhotoAlbum.strDateCreated=[ValidationClass NullCheckString:[NSString stringWithFormat:@"%@",[[[dictResponse valueForKey:@"SearchResult"] objectAtIndex:i] valueForKey:@"DateCreated"]]];
                objPhotoAlbum.strDisplayName=[ValidationClass NullCheckString:[NSString stringWithFormat:@"%@",[[[dictResponse valueForKey:@"SearchResult"] objectAtIndex:i] valueForKey:@"DisplayName"]]];
                objPhotoAlbum.strDisplayOrder=[ValidationClass NullCheckString:[NSString stringWithFormat:@"%@",[[[dictResponse valueForKey:@"SearchResult"] objectAtIndex:i] valueForKey:@"DisplayOrder"]]];
                objPhotoAlbum.strLastUpdate=[ValidationClass NullCheckString:[NSString stringWithFormat:@"%@",[[[dictResponse valueForKey:@"SearchResult"] objectAtIndex:i] valueForKey:@"LastUpdate"]]];
                objPhotoAlbum.arrmPhoto=[[NSMutableArray alloc] init];
                for (int j=0; j<[[[[dictResponse valueForKey:@"SearchResult"] objectAtIndex:i] valueForKey:@"Photos"] count]; j++)
                {
                    PhotoUrl *objPhotoUrl = [[PhotoUrl alloc] init];
                    objPhotoUrl.strPhotoUrl = [ValidationClass NullCheckString:[NSString stringWithFormat:@"%@",[[[[[dictResponse valueForKey:@"SearchResult"] objectAtIndex:i] valueForKey:@"Photos"] objectAtIndex:j] valueForKey:@"Url"]]];
                    objPhotoUrl.strDisplayOrder = [ValidationClass NullCheckString:[NSString stringWithFormat:@"%@",[[[[[dictResponse valueForKey:@"SearchResult"] objectAtIndex:i] valueForKey:@"Photos"] objectAtIndex:j] valueForKey:@"DisplayOrder"]]];
                    [objPhotoAlbum.arrmPhoto addObject:objPhotoUrl];
                }
                [arrmAlbums addObject:objPhotoAlbum];
            }
            if ([arrmAlbums count]>0)
            {
                [albumCollectionVw setHidden:NO];
                [albumCollectionVw reloadData];
            }
        }
    }
}

-(void)PhotoViewerError:(NSError*)rsponseObject method:(APIManagerCalledForMethodName)methodName
{
    self.view.userInteractionEnabled=YES;
    [self.indicator stopAnimating];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:NETWORK_ERROR delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
#pragma mark- Self Method -

-(void)getAlbum
{
    PhotoViewerAPI *photoViewer=[PhotoViewerAPI new];
    photoViewer.PhotoVieweAPIDelegate=nil;
    photoViewer.PhotoVieweAPIDelegate=(id)self;
    self.view.userInteractionEnabled=NO;
    [self.indicator startAnimating];
    [photoViewer getAlbums];
}

#pragma mark - UIButton Action -

- (IBAction)btnback_Click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
