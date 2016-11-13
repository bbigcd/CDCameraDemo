//
//  PhotoDetailViewController.m
//  WYPHealthyThird
//
//  Created by bbigcd on 16/11/11.
//  Copyright © 2016年 veepoo. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "iCarousel.h"

@interface PhotoDetailViewController ()
<iCarouselDelegate,
iCarouselDataSource>

{
    iCarousel *_icarousel;
    ALAssetsLibrary *library;
    NSArray *imageArray;
    NSMutableArray *mutableArray;
}

@property (nonatomic, strong) UIButton *dismissBtn;

@end

@implementation PhotoDetailViewController

static NSInteger count = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self getAllPictures];
    
    [self setupiCarousel];
        
    [self setupDismissBtn];
}

- (void)setupiCarousel{
    _icarousel = [[iCarousel alloc] init];
    [_icarousel setFrame:[UIScreen mainScreen].bounds];
    _icarousel.delegate = self;
    _icarousel.dataSource = self;
    _icarousel.type = iCarouselTypeLinear;
    _icarousel.pagingEnabled  = YES;
    _icarousel.scrollEnabled = YES;
    [self.view addSubview:_icarousel];
}

- (void)setupDismissBtn{
    if (_dismissBtn == nil) {
        _dismissBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_dismissBtn setFrame:CGRectMake(10, CGRectGetHeight(self.view.frame) - 72.5, 60, 60)];
        [_dismissBtn setTintColor:[UIColor whiteColor]];
        [_dismissBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_dismissBtn addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_dismissBtn];
    }
}

- (void)getAllPictures{
    library = [[ALAssetsLibrary alloc] init];
    imageArray = [[NSArray alloc] init];
    mutableArray = [[NSMutableArray alloc] init];
    NSMutableArray *assetURLDictionaries = [[NSMutableArray alloc] init];
    
    void (^assetEnumerator)( ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if(result != nil) {
            if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                
                NSURL *url= (NSURL*) [[result defaultRepresentation] url];
                
                [library assetForURL:url
                         resultBlock:^(ALAsset *asset){
                             [mutableArray addObject:asset];
                             
                             if ([mutableArray count] == count){
                                 imageArray = [[NSArray alloc] initWithArray:mutableArray];
                                 [_icarousel reloadData];
                             }
                         }
                        failureBlock:^(NSError *error){
                            NSLog(@"operation was not successfull!");
                        }];
                
            } 
        }
    };
    
    NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
    
    void (^ assetGroupEnumerator) (ALAssetsGroup *, BOOL *)= ^(ALAssetsGroup *group, BOOL *stop) {
        if(group != nil) {
            [group enumerateAssetsUsingBlock:assetEnumerator];
            [assetGroups addObject:group];
            count = [group numberOfAssets];
        }
    };
    
    assetGroups = [[NSMutableArray alloc] init];
    
    [library enumerateGroupsWithTypes:ALAssetsGroupAll
                           usingBlock:assetGroupEnumerator
                         failureBlock:^(NSError *error) {
                             NSLog(@"There is an error");
                         }];
}

- (void)dismissViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --iCarouselDelegate--
/** 允许滚动 */
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    return value;
    
}

/** 滚动到第几个 */
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    
}

#pragma mark --iCarouselDataSource--

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return imageArray.count;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel{
    return [UIScreen mainScreen].bounds.size.width;
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    ALAsset *asset = imageArray[index];
    imageView.image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
    
     UIView *cardView = view;
     if (cardView == nil) {
         cardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
     }
    
    [cardView addSubview:imageView];
     return cardView;
    
}


- (void)dealloc{
    _icarousel = nil;
}

@end
