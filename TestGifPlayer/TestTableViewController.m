//
//  TestTableViewController.m
//  TestGifPlayer
//
//  Created by 王士良 on 2018/4/26.
//  Copyright © 2018年 王士良. All rights reserved.
//

#import "TestTableViewController.h"

#import "TestWebPlayerVC.h"
#import "TestImageViewPlayerVC.h"
#import "TestContentPlayerVC.h"

@interface TestTableViewController ()

@property(nonatomic) NSArray *dataList;
@property(nonatomic) NSArray *vcNameList;
@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataList = @[
                      @"UIImageView播放",
                      @"webView播放",
                      @"ViewContent播放",
                      ];

    self.vcNameList = @[
                        @"TestImageViewPlayerVC",
                        @"TestWebPlayerVC",
                        @"TestContentPlayerVC",
                        ];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.textLabel.text = [[self.dataList objectAtIndex:indexPath.row] description];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *vcName = self.vcNameList[indexPath.row];
    UIViewController *showVC = [NSClassFromString(vcName) new];
    showVC.title = [self.dataList[indexPath.row] description];
    [self.navigationController pushViewController:showVC animated:YES];

}


@end
