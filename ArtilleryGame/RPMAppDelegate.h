//
//  RPMAppDelegate.h
//  ArtilleryGame
//
//  Created by Ryan Murphy on 4/24/12.
//  Copyright (c) 2012 Montana State University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

/*
 The game appears reasonably well conceived, but the codebase is not object-oriented
 and the game is partially broken - every shell I fire gives a "you won" alert. You
 should at least have ShellViews and TankViews to distribute the game logic to
 model classes.
 
 Grade: 80%
 Course grade: 72% (B-)
*/