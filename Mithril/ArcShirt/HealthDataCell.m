//
//  HealthDataCell.m
//  ArcShirt
//
//  Created by john on 4/5/15.
//  Copyright (c) 2015 CS 145 Team. All rights reserved.
//

#import "HealthDataCell.h"

@implementation HealthDataCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.screenRect = frame;
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1];
        self.logo = [[UIButton alloc]initWithFrame:CGRectMake(self.screenRect.size.width/13,
                                                                    self.screenRect.size.height/4,
                                                                    self.screenRect.size.height/2,
                                                                    self.screenRect.size.height/2)];
        [self.contentView addSubview:self.logo];
        UIImage *logoImage;
        logoImage = [UIImage imageNamed:@"temperature"];
        [self addSubview:self.logo];
    }
    return self;
}

- (void)setLogoImage:(NSString*)logoName
{
//    UIImage *logoImage;
//    
//    if ([logoName isEqualToString:@"temperature"])
//    {
//        logoImage = [UIImage imageNamed:@"temperature"];
//    }
//    [self.logo setBackgroundImage:logoImage forState:UIControlStateNormal];
//    self.logo.contentMode = UIViewContentModeScaleAspectFit;
    
}

@end
