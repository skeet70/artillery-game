//
//  RPMViewController.h
//  ArtilleryGame
//
//  Created by Ryan Murphy on 4/24/12.
//  Copyright (c) 2012 Montana State University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPMViewController : UIViewController

//@property(retain, nonatomic) IBOutlet UIImageView *tank1;
//@property(retain, nonatomic) IBOutlet UIImageView *tank2;
- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;
@end
