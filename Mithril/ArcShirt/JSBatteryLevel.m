//
//  JSBatteryLevel.m
//  ArcShirt
//
//  Created by john on 4/5/15.
//  Copyright (c) 2015 CS 145 Team. All rights reserved.
//

#import "JSBatteryLevel.h"
#import <QuartzCore/QuartzCore.h>

@implementation JSBatteryLevel


- (void)layoutSubviews
{
    self.dots = [[NSMutableArray alloc] init];

    double alpha = 0.1;
    double cornerRadiusIndex = 2.5;
    self.backgroundColor = [UIColor clearColor];
    
    // 0
    UIView *zero = [[UIView alloc] initWithFrame:[self boundsByNumber:0]];
    zero.backgroundColor = [UIColor colorWithWhite:255.0 alpha:alpha];
    zero.layer.cornerRadius = zero.bounds.size.width / cornerRadiusIndex;
    [self addSubview:zero];
    self.dots[0] = zero;
    
    // 1
    UIView *one = [[UIView alloc] initWithFrame:[self boundsByNumber:1]];
    one.backgroundColor = [UIColor colorWithWhite:255.0 alpha:alpha];
    one.layer.cornerRadius = one.bounds.size.width / cornerRadiusIndex;
    [self addSubview:one];
    self.dots[1] = one;

    // 2
    UIView *two = [[UIView alloc] initWithFrame:[self boundsByNumber:2]];
    two.backgroundColor = [UIColor colorWithWhite:255.0 alpha:alpha];
    two.layer.cornerRadius = two.bounds.size.width / cornerRadiusIndex;
    [self addSubview:two];
    self.dots[2] = two;

    // 3
    UIView *three = [[UIView alloc] initWithFrame:[self boundsByNumber:3]];
    three.backgroundColor = [UIColor colorWithWhite:255.0 alpha:alpha];
    three.layer.cornerRadius = three.bounds.size.width / cornerRadiusIndex;
    [self addSubview:three];
    self.dots[3] = three;

    // 4
    UIView *four = [[UIView alloc] initWithFrame:[self boundsByNumber:4]];
    four.backgroundColor = [UIColor colorWithWhite:255.0 alpha:alpha];
    four.layer.cornerRadius = four.bounds.size.width / cornerRadiusIndex;
    [self addSubview:four];
    self.dots[4] = four;

    // 5
    UIView *five = [[UIView alloc] initWithFrame:[self boundsByNumber:5]];
    five.backgroundColor = [UIColor colorWithWhite:255.0 alpha:alpha];
    five.layer.cornerRadius = five.bounds.size.width / cornerRadiusIndex;
    [self addSubview:five];
    self.dots[5] = five;

    // 6
    UIView *six = [[UIView alloc] initWithFrame:[self boundsByNumber:6]];
    six.backgroundColor = [UIColor colorWithWhite:255.0 alpha:alpha];
    six.layer.cornerRadius = six.bounds.size.width / cornerRadiusIndex;
    [self addSubview:six];
    self.dots[6] = six;

    // 7
    UIView *seven = [[UIView alloc] initWithFrame:[self boundsByNumber:7]];
    seven.backgroundColor = [UIColor colorWithWhite:255.0 alpha:alpha];
    seven.layer.cornerRadius = seven.bounds.size.width / cornerRadiusIndex;
    [self addSubview:seven];
    self.dots[7] = seven;

    // 8
    UIView *eight = [[UIView alloc] initWithFrame:[self boundsByNumber:8]];
    eight.backgroundColor = [UIColor colorWithWhite:255.0 alpha:alpha];
    eight.layer.cornerRadius = eight.bounds.size.width / cornerRadiusIndex;
    [self addSubview:eight];
    self.dots[8] = eight;

    // 9
    UIView *nine = [[UIView alloc] initWithFrame:[self boundsByNumber:9]];
    nine.backgroundColor = [UIColor colorWithWhite:255.0 alpha:alpha];
    nine.layer.cornerRadius = six.bounds.size.width / cornerRadiusIndex;
    [self addSubview:nine];
    self.dots[9] = nine;

    // 10
    UIView *ten = [[UIView alloc] initWithFrame:[self boundsByNumber:10]];
    ten.backgroundColor = [UIColor colorWithWhite:255.0 alpha:alpha];
    ten.layer.cornerRadius = ten.bounds.size.width / cornerRadiusIndex;
    [self addSubview:ten];
    self.dots[10] = ten;

    // 11
    UIView *eleven = [[UIView alloc] initWithFrame:[self boundsByNumber:11]];
    eleven.backgroundColor = [UIColor colorWithWhite:255.0 alpha:alpha];
    eleven.layer.cornerRadius = eleven.bounds.size.width / cornerRadiusIndex;
    [self addSubview:eleven];
    self.dots[11] = eleven;
}

- (void)lightUp:(int)count
{
    UIView *dot = self.dots[count];
    dot.backgroundColor = [UIColor colorWithRed:183.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
}

- (void)dimDown:(int)count
{
    UIView *dot = self.dots[count];
    dot.backgroundColor = [UIColor colorWithWhite:255.0 alpha:0.1];
}

- (CGRect)boundsByNumber:(int)number
{
    CGPoint boundsCenter = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    int x = boundsCenter.x;
    int y = boundsCenter.y;
    int W = self.bounds.size.width;
    int H = self.bounds.size.height;
    int w = self.bounds.size.width * 0.1;
    int h = self.bounds.size.height * 0.1;
    
    double addX = W/4;
    double addY = (1-cbrt(3)/2)*(double)W/2;

    if (number == 0)
    {
        return CGRectMake(x-w/2, 0, w, h);
    }

    else if (number == 1)
    {
        addX = W/4-w/2;
        addY = (1-cbrt(3)/2)*(double)W/2-h/2;
        return CGRectMake(x-w/2+addX, addY, w, h);
    }
    
    else if (number == 2)
    {
        addX = (1-cbrt(3)/2)*(double)W/2-h/2;
        addY = W/4-w/2;
        return CGRectMake(W-w-addX, y-h/2-addY, w, h);
    }
    
    else if (number == 3)
    {
        return CGRectMake(W-w, y-h/2, w, h);
    }
    
    else if (number == 4)
    {
        addX = (1-cbrt(3)/2)*(double)W/2-h/2;
        addY = W/4-w/2;
        return CGRectMake(W-w-addX, y-h/2+addY, w, h);
    }
    
    else if (number == 5)
    {
        addX = W/4-w/2;
        addY = (1-cbrt(3)/2)*(double)W/2-h/2;
        return CGRectMake(x-w/2+addX, H-h-addY, w, h);
    }
    
    else if (number == 6)
    {
        return CGRectMake(x-w/2, H-h, w, h);
    }
    
    else if (number == 7)
    {
        addX = W/4-w/2;
        addY = (1-cbrt(3)/2)*(double)W/2-h/2;
        return CGRectMake(x-w/2-addX, H-h-addY, w, h);
    }
    
    else if (number == 8)
    {
        addX = (1-cbrt(3)/2)*(double)W/2-h/2;
        addY = W/4-w/2;
        return CGRectMake(addX, y-h/2+addY, w, h);
    }
    
    else if (number == 9)
    {
        return CGRectMake(0, y-h/2, w, h);
    }
    
    else if (number == 10)
    {
        addX = (1-cbrt(3)/2)*(double)W/2-h/2;
        addY = W/4-w/2;
        return CGRectMake(addX, y-h/2 - addY, w, h);
    }
    
    else if (number == 11)
    {
        addX = W/4-w/2;
        addY = (1-cbrt(3)/2)*(double)W/2-h/2;
        return CGRectMake(x-w/2-addX, addY, w, h);
    }
    
    else {
        return CGRectMake(boundsCenter.x, 0, self.bounds.size.width * 0.1, self.bounds.size.height * 0.1);
    }
}

@end
