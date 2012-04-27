//
//  RPMViewController.m
//  ArtilleryGame
//
//  Created by Ryan Murphy on 4/24/12.
//  Copyright (c) 2012 Montana State University. All rights reserved.
//

#import "RPMViewController.h"

@implementation RPMViewController

static CGPoint startLocation, endLocation, currentLocation;
static CGFloat velocity;
static int enemy, player, enemyTurret, playerTurret;

- (IBAction)handleDrag:(UIPanGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        startLocation = [recognizer locationInView:self.view];
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        currentLocation = [recognizer locationInView:self.view];
        
        if (recognizer.view.tag == -1){
            CGFloat dx = currentLocation.x - startLocation.x;
            CGFloat dy = currentLocation.y - startLocation.y;
            CGFloat angle = atan2(dy, dx);
            [(UIImageView *)[self.view viewWithTag:2] setTransform:CGAffineTransformMakeRotation(angle)];
        }
        
        if(recognizer.view.tag == -2){
            CGFloat dx = startLocation.x - currentLocation.x;
            CGFloat dy = startLocation.y - currentLocation.y;
            CGFloat angle = atan2(dy, dx);
            [(UIImageView *)[self.view viewWithTag:4] setTransform:CGAffineTransformMakeRotation(angle)];
        }
        
    }

    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        endLocation = [recognizer locationInView:self.view];
        
        CGFloat dx = endLocation.x - startLocation.x;
        CGFloat dy = endLocation.y - startLocation.y;
        CGFloat length = sqrt(dx*dx + dy*dy );
        velocity = length * .1;
        
        // give the lemon velocity, and have gravity act on it every second
        // handle collisions
        
        if (recognizer.view.tag == -1){
            enemy = 3;
            enemyTurret = 4;
            player = 1;
            playerTurret = 2;
            
            // get the right turret
            UIImageView * turret = (UIImageView *)[self.view viewWithTag:playerTurret];
            
            // put the shell in the turret
            UIImageView * shell = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lemon_shell.png"]];
            shell.center = turret.center;
            [[turret superview] addSubview:shell];
            
            // fire the shell
            [self performSelector:@selector(fireShell:) withObject:shell afterDelay:(1/50)];
        }
        
        if(recognizer.view.tag == -2){
            enemy = 1;
            enemyTurret = 2;
            player = 3;
            playerTurret = 4;
            
            // get the right turret
            UIImageView * turret = (UIImageView *)[self.view viewWithTag:playerTurret];
            
            // put the shell in the turret
            UIImageView * shell = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lemon_shell.png"]];
            shell.center = turret.center;
            [[turret superview] addSubview:shell];
            
            // fire the shell
        }
        
    }
    
}

-(void)fireShell:(UIImageView *)shell
{
    CGPoint next;
    next.y = shell.center.y + velocity;
    next.x = shell.center.x + fabsf(velocity);
    velocity = velocity - GRAVITY;
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:0.5f] forKey:kCATransactionAnimationDuration];
    
    CGSize shellSize = shell.frame.size;
    shell.frame = CGRectMake(next.x, next.y, shellSize.width, shellSize.height);
    
    [CATransaction commit];
    
    if (shell.center.y < 354 && CGRectIntersectsRect(shell.frame, ((UIImageView *)[self.view viewWithTag:enemy]).frame) == false)
    {
        [self performSelector:@selector(fireShell:) withObject:shell afterDelay:(1/50)];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
