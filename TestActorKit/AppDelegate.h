//
//  AppDelegate.h
//  TestActorKit
//
//  Created by Julian Krumow on 20.08.15.
//  Copyright (c) 2015 Julian Krumow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GHRunLoopWatchdog/GHRunLoopWatchdog.h>
#import <ActorKit/ActorKit.h>
#import <ActorKit/Supervision.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic) UIWindow *window;
@property (nonatomic) GHRunLoopWatchdog *runloopWatchdog;

- (void)fetchImages;
@end

