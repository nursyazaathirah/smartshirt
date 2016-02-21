//
//  MyNavigationController.m
//  ArcShirt
//
//  Created by john on 4/5/15.
//  Copyright (c) 2015 CS 145 Team. All rights reserved.
//

#import "MyNavigationController.h"
#import "CRGradientNavigationBar.h"

@interface MyNavigationController ()
@property CGRect screenRect;
@property UIBlurEffect *blurEffect;
@property UIVisualEffectView *blurView;
@end

@implementation MyNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.screenRect = [[UIScreen mainScreen] bounds];
    
    /* blur effect background */
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                          0,
                                                                          self.screenRect.size.width,
                                                                          self.screenRect.size.height)];
    imageView.image = [UIImage imageNamed:@"background"];
    [self.view addSubview:imageView];
    self.blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.blurView =  [[UIVisualEffectView alloc]initWithEffect:self.blurEffect];
    self.blurView.frame = imageView.bounds;
    [imageView addSubview:self.blurView];
    [self.view sendSubviewToBack:imageView];
    self.navigationBar.hidden = true;
}


@end
