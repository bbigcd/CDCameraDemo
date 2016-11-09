//
//  ViewController.m
//  CDCameraDemo
//
//  Created by bbigcd on 16/11/7.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import "ViewController.h"
#import "CameraViewController.h"
#import "Camera1ViewController.h"
#import "Camera2ViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

static NSString *const ID = @"cell";

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        
        CGRect frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setTableFooterView:[[UIView alloc] init]];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self tableView];
}


#pragma mark --UITableViewDataSource--

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = @"拍照";
    
    return cell;
}
/**
 *  点击cell触发此方法
 *
 *  @param tableView 列表
 *  @param indexPath cell所在的位置
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    CameraViewController *vc = [[CameraViewController alloc] init];
    
    Camera1ViewController *vc = [[Camera1ViewController alloc] init];
    
//    Camera2ViewController *vc = [[Camera2ViewController alloc] init];
    
//    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
   
}




@end
