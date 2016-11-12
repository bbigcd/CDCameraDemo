//
//  PhotoDetailViewController.m
//  WYPHealthyThird
//
//  Created by bbigcd on 16/11/11.
//  Copyright © 2016年 veepoo. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "ALAssetsLibrary+CDAssetsLibrary.h"
#import "iCarousel.h"

@interface PhotoDetailViewController ()
<iCarouselDelegate,
iCarouselDataSource>

{
    iCarousel *_icarousel;
}

@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imagesArray = [[NSMutableArray alloc] init];
    
//    self.dataSource = @[[UIColor blueColor], [UIColor redColor]];
    [self getFirstPhoto];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
//    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setupiCarousel];
    });
    
    
    [self setupDismissBtn];
}

- (void)setupiCarousel{
    _icarousel = [[iCarousel alloc] init];
    [_icarousel setFrame:[UIScreen mainScreen].bounds];
    _icarousel.delegate = self;
    _icarousel.dataSource = self;
    _icarousel.type = iCarouselTypeLinear;
    _icarousel.pagingEnabled  = YES;
    _icarousel.scrollEnabled = self.dataSource.count > 1;
    [self.view addSubview:_icarousel];
}

- (void)setupDismissBtn{
    UIButton *bnt = [UIButton buttonWithType:UIButtonTypeSystem];
    [bnt setFrame:CGRectMake(10, CGRectGetHeight(self.view.frame) - 72.5, 60, 60)];
    [bnt setTintColor:[UIColor blackColor]];
    [bnt setTitle:@"返回" forState:UIControlStateNormal];
    [bnt addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bnt];
}

- (void)getFirstPhoto{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    __weak typeof(self) weakSelf = self;
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            /* NSEnumerationReverse 遍历方式*/
            [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {
                    ALAssetRepresentation *representation = [result defaultRepresentation];
                    
//                    NSDate *imageDate = [result valueForProperty:ALAssetPropertyDate];
                    UIImage *fullResolutionImage = [UIImage imageWithCGImage:[representation fullScreenImage]];
                    [weakSelf.imagesArray addObject:fullResolutionImage];
//                NSLog(@"count - %ld", weakSelf.imagesArray.count);
                    *stop = YES;
                }
                
            }];
            *stop = YES;
        }
    } failureBlock:^(NSError *error) {
//        if (error) {
//            if (block) {
//                block(nil,error);
//            }
//        }
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
//    if (option == iCarouselOptionSpacing) {
//        return 0;
//    }
//    NSLog(@"%f", value);
    return value;
    
}

/** 滚动到第几个 */
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    
}

#pragma mark --iCarouselDataSource--

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.imagesArray.count;
//    return self.dataSource.count;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel{
    return [UIScreen mainScreen].bounds.size.width;
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view{
    
     UIView *cardView = view;
     if (!cardView) {
         cardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cardView.bounds.size.width, cardView.bounds.size.height)];
         
         UIImageView *imageView = [[UIImageView alloc] initWithFrame:cardView.bounds];
         [cardView addSubview:imageView];
         imageView.contentMode = UIViewContentModeScaleAspectFit;
//         imageView.tag = 100;
         imageView.image = self.imagesArray[index];
         view.clipsToBounds = YES;
         view.backgroundColor = [UIColor darkGrayColor];
     
     }
     
     return cardView;
    
//    if (view == nil) {
//        UIView *colorView = [[UIView alloc] initWithFrame:carousel.bounds];
//        colorView.backgroundColor = self.dataSource[index];
//        return colorView;
//    }else{
//        view.backgroundColor = self.dataSource[index];
//        return view;
//    }
//    return nil;
}
/*
- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    return CATransform3DTranslate(transform, offset * self.view.frame.size.width, 0, 0);
}
*/
@end
