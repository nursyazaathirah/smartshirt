//
//  AppDelegate.m
//  ArcShirt
//
//  Created by john on 4/5/15.
//  Copyright (c) 2015 CS 145 Team. All rights reserved.
//

#import "AppDelegate.h"
#import "DataCollectionViewController.h"
#import "DetailViewController.h"
#import "MyNavigationController.h"
#import "CRGradientNavigationBar.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    DataCollectionViewController *dataVC = [[DataCollectionViewController alloc]init];
    UIColor *firstColor = [UIColor colorWithRed:74.0/255.0f green:125.0/255.0f blue:127.0/255.0f alpha:1.0f];
    UIColor *secondColor = [UIColor colorWithRed:140.0/255.0f green:229.0/255.0f blue:187.0/255.0f alpha:1.0f];
    NSArray *colors = [NSArray arrayWithObjects:firstColor, secondColor, nil];
    [[CRGradientNavigationBar appearance] setBarTintGradientColors:colors];

    MyNavigationController *roomsSelectorNavController = [[MyNavigationController alloc]initWithNavigationBarClass:[CRGradientNavigationBar class] toolbarClass:nil];
    roomsSelectorNavController.viewControllers = @[dataVC];
    [[roomsSelectorNavController navigationBar] setTranslucent:YES];

    self.window.rootViewController = roomsSelectorNavController;
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
