//
//  ViewController.m
//  ALmakeAPITester
//
//  Created by allenlin on 9/12/14.
//  Copyright (c) 2014 Raccoonism. All rights reserved.
//

#import "ViewController.h"
#import "ALAPITester.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary *outputDic = @{@"name":@"allen",@"height":@"170",@"hello":@12};
    NSDictionary *exampleDic = @{@"name":@"allee",@"height":@12,@"xoxo":@"1234"};
    
    ALAPITester *tester = [[ALAPITester alloc] init];
    NSString *diffStr = (NSString *)[tester diffAPI:outputDic withExample:exampleDic];
    NSLog(@"diffStr:%@",diffStr);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
