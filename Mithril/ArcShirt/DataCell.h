//
//  DataCell.h
//  ArcShirt
//
//  Created by john on 4/11/15.
//  Copyright (c) 2015 CS 145 Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataCell : UICollectionViewCell
@property (nonatomic) UIButton *logo;
- (void)setLogoImage:(NSString*)logoName;

@end
