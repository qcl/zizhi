//
//  FirstViewController.m
//  zizhi-sample
//
//  Created by Qing-Cheng Li on 2016/10/10.
//  Copyright © 2016年 QCLS. All rights reserved.
//

#import "FirstViewController.h"
#import "HelloViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"XingZhe Test 🐒";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)helloBtnDidTap:(id)sender {
    NSLog(@"hello button did tap");
    HelloViewController *hvc = [[HelloViewController alloc] init];
    [self.navigationController pushViewController:hvc animated:YES];

}
@end
