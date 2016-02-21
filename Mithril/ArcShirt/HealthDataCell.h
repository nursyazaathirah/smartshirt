//
//  HealthDataCell.h
//  ArcShirt
//
//  Created by john on 4/5/15.
//  Copyright (c) 2015 CS 145 Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthDataCell : UICollectionViewCell
@property (nonatomic) UIButton *logo;
@property CGRect screenRect;
- (void)setLogoImage:(NSString*)logoName;

@end
