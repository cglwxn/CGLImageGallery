//
//  AppDelegate.m
//  探索更流畅的tablView和collectionView互嵌套
//
//  Created by Guanglei Cheng on 2019/12/26.
//  Copyright © 2019 Guanglei Cheng. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "CustomNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *vc = [[ViewController alloc] init];
    CustomNavigationController *nav = [[CustomNavigationController alloc] initWithRootViewController:vc];
//    [nav setNavigationBarHidden:YES];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}





@end
