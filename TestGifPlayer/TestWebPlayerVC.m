//
//  TestWebPlayerVC.m
//  TestGifPlayer
//
//  Created by 王士良 on 2018/4/26.
//  Copyright © 2018年 王士良. All rights reserved.
//

#import "TestWebPlayerVC.h"

@interface TestWebPlayerVC ()

@end

@implementation TestWebPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
 [self showPlayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showPlayer
{


    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"test4" ofType:@"gif"];
    if (!filePath) { // 没有数据.
        NSLog(@"=== 没有图片数据 ===");
        return;
    }
    CGSize size = CGSizeMake(160, 160);

//    UIImage *tempImg = [UIImage imageWithContentsOfFile:filePath];

    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(20, 100, size.width, size.height)];
    webView.center = self.view.center;
    webView.userInteractionEnabled = NO;
    webView.opaque = NO;
    webView.backgroundColor = [UIColor clearColor];
    webView.layer.borderWidth = 2;
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.view addSubview:webView];

    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data) {
        [webView loadData:data MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    }
}


@end
