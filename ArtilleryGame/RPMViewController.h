//
//  RPMViewController.h
//  ArtilleryGame
//
//  Created by Ryan Murphy on 4/24/12.
//  Copyright (c) 2012 Montana State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#define GRAVITY 9.81*.1
#define PI 3.14159265

@interface RPMViewController : UIViewController

//@property(retain, nonatomic) IBOutlet UIImageView *tank1;
//@property(retain, nonatomic) IBOutlet UIImageView *tank2;
- (IBAction)handleDrag:(UIPanGestureRecognizer *)recognizer;
@end
