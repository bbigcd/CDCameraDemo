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

// 停止条件
static NSInteger count = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithHue:0.00 saturation:0.00 brightness:0.97 alpha:1.00]];
    
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
        [_dismissBtn setTintColor:[UIColor blackColor]];
        _dismissBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_dismissBtn setTitle:@"Back" forState:UIControlStateNormal];
        [_dismissBtn addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_dismissBtn];
    }
}

- (void)getAllPictures{
    library = [[ALAssetsLibrary alloc] init];
    imageArray = [[NSArray alloc] init];
    mutableArray = [[NSMutableArray alloc] init];
    
    // 枚举block 将ALAsset存入数组，直接存图片会导致运行内存过高
    void (^assetEnumerator)(ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if(result != nil) {
            if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                
                NSURL *url= (NSURL*) [[result defaultRepresentation] url];
                
                [library assetForURL:url resultBlock:^(ALAsset *asset){
                             [mutableArray addObject:asset];
                             if ([mutableArray count] == count){
                                 imageArray = [[NSArray alloc] initWithArray:mutableArray];
                                 [_icarousel reloadData];
                             }
                         }
                        failureBlock:^(NSError *error){
                            NSLog(@"获取照片失败");
                        }];
            } 
        }
    };
    
    void (^ assetGroupEnumerator) (ALAssetsGroup *, BOOL *)= ^(ALAssetsGroup *group, BOOL *stop) {
        if(group != nil) {
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            // NSEnumerationReverse逆序遍历
            [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:assetEnumerator];
            count = [group numberOfAssets];
        }
    };
    
    // 外层枚举
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                           usingBlock:assetGroupEnumerator
                         failureBlock:^(NSError *error) {
                             NSLog(@"获取相册异常");
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
//    else if (option == iCarouselOptionSpacing){
//        return 10;
//    }
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
    return 200;
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view{
    ALAsset *asset = imageArray[index];
    // 由于view只有一个superview,此处用tag来解决重用问题
    if (view == nil) {
        view = [[UIImageView alloc] initWithFrame:self.view.bounds];
        view.tag = 1;
        ((UIImageView *)view).contentMode = UIViewContentModeScaleAspectFit;
        ((UIImageView *)view).clipsToBounds = YES;
        ((UIImageView *)view).image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
    }else{
        view = (UIImageView *)[view viewWithTag:1];
        ((UIImageView *)view).image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
    }
    return view;
}


- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)dealloc{
    _icarousel = nil;
}

@end
