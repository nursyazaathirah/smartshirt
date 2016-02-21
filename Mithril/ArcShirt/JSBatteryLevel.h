//
//  JSBatteryLevel.h
//  ArcShirt
//
//  Created by john on 4/5/15.
//  Copyright (c) 2015 CS 145 Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSBatteryLevel : UIButton
@property (nonatomic, strong) NSMutableArray *dots;

- (void)lightUp:(int)count;
- (void)dimDown:(int)count;


@end
