//
//  DataCell.m
//  ArcShirt
//
//  Created by john on 4/11/15.
//  Copyright (c) 2015 CS 145 Team. All rights reserved.
//

#import "DataCell.h"

@implementation DataCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1];
        
        [self.contentView addSubview:self.logo];
        UIImage *logoImage;
        logoImage = [UIImage imageNamed:@"temperature"];
        [self addSubview:self.logo];
    }
    return self;
}

- (void)setLogoImage:(NSString*)logoName
{
    
}
@end
