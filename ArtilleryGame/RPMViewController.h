//
//  RPMViewController.h
//  ArtilleryGame
//
//  Created by Ryan Murphy on 4/24/12.
//  Copyright (c) 2012 Montana State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define GRAVITY 9.81*.05

@interface RPMViewController : UIViewController

- (IBAction)handleDrag:(UIPanGestureRecognizer *)recognizer;
-(void)fireShell:(UIImageView *)shell;
@end
