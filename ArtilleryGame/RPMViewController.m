//
//  RPMViewController.m
//  ArtilleryGame
//
//  Created by Ryan Murphy on 4/24/12.
//  Copyright (c) 2012 Montana State University. All rights reserved.
//
//  Free-for-All tank game!
//  Drag from the tank forward for power and angle, three hits makes a winner!

#import "RPMViewController.h"

@implementation RPMViewController

static CGPoint startLocation, endLocation, currentLocation;
static CGFloat velocity, yAccel, angle;
static int enemy, player, enemyTurret, playerTurret, playerOneHit, playerTwoHit;

- (IBAction)handleDrag:(UIPanGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        startLocation = [recognizer locationInView:self.view];
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        currentLocation = [recognizer locationInView:self.view];
        
        if (recognizer.view.tag == -1){
            CGFloat dx = currentLocation.x - startLocation.x;
            CGFloat dy = currentLocation.y - startLocation.y;
            angle = atan2(dy, dx);
            [(UIImageView *)[self.view viewWithTag:2] setTransform:CGAffineTransformMakeRotation(angle)];
        }
        
        if(recognizer.view.tag == -2){
            CGFloat dx = startLocation.x - currentLocation.x;
            CGFloat dy = startLocation.y - currentLocation.y;
            angle = atan2(dy, dx);
            [(UIImageView *)[self.view viewWithTag:4] setTransform:CGAffineTransformMakeRotation(angle)];
        }
        
    }

    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        endLocation = [recognizer locationInView:self.view];
        
        CGFloat dx = endLocation.x - startLocation.x;
        CGFloat dy = endLocation.y - startLocation.y;
        velocity = sqrt(dx*dx + dy*dy )*.1;
        
        if (recognizer.view.tag == -1){
            enemy = 3;
            enemyTurret = 4;
            player = 1;
            playerTurret = 2;
            CGFloat dx = endLocation.x - startLocation.x;
            CGFloat dy = endLocation.y - startLocation.y;
            angle = atan2(dy, dx);
            yAccel = (velocity*2)*sinf(angle);
            
            // get the right turret
            UIImageView * turret = (UIImageView *)[self.view viewWithTag:playerTurret];
            
            // put the shell in the turret
            UIImageView * shell = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lemon_shell.png"]];
            shell.center = turret.center;
            [[turret superview] addSubview:shell];
            
            // fire the shell
            [self performSelector:@selector(fireShell:) withObject:shell afterDelay:(1.0/30.0)];
        }
        
        if(recognizer.view.tag == -2){
            enemy = 1;
            enemyTurret = 2;
            player = 3;
            playerTurret = 4;
            CGFloat dx = startLocation.x - endLocation.x;
            CGFloat dy = startLocation.y - endLocation.y;
            angle = atan2(dy, dx);
            yAccel = (velocity*2)*sinf(-angle);
            
            // get the right turret
            UIImageView * turret = (UIImageView *)[self.view viewWithTag:playerTurret];
            
            // put the shell in the turret
            UIImageView * shell = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lemon_shell.png"]];
            shell.center = turret.center;
            [[turret superview] addSubview:shell];
            
            // fire the shell
            [self performSelector:@selector(fireShell:) withObject:shell afterDelay:(1.0/30.0)];
        }
        
    }
    
}

-(void)fireShell:(UIImageView *)shell
{
    CGPoint next;
    if (player == 1) {
        CGFloat xAccel = (velocity*.3)*cosf(fabsf(angle));
        next.y = shell.center.y + yAccel*.8;
        next.x = shell.center.x + xAccel;
        yAccel += GRAVITY;
    }
    else if(player == 3){
        CGFloat xAccel = velocity*cosf(fabsf(angle));
        next.y = shell.center.y + yAccel;
        next.x = shell.center.x - xAccel;
        yAccel += GRAVITY;
    }
    
    [UIImageView beginAnimations:nil context:NULL];
    [UIImageView setAnimationDuration:12.0f];
    
    CGSize shellSize = shell.frame.size;
    shell.frame = CGRectMake(next.x, next.y, shellSize.width, shellSize.height);
    
    [UIImageView commitAnimations];
    
    // Comment this out to see the actual firing, since the RectIntersectRect isn't working.
    // couldn't get CGRectIntersectRect, CGRectContainsRect, CGRectContainsPoint to work
    UIImageView * enemyTank = (UIImageView *)[self.view viewWithTag:enemy];
    if (CGRectIntersectsRect(enemyTank.frame, shell.frame)){
        if (enemy == 1){
            playerOneHit += 1;
            if (playerOneHit >= 3) {
                UIAlertView * winner = (UIAlertView *)[[UIAlertView alloc] 
                                                       initWithTitle:@"Game Over"
                                                       message:@"Congratulations Player Two, you win!"
                                                       delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
                
                [winner show];
                playerOneHit = 0;
                playerTwoHit = 0;
                shell.hidden = true;
                return;
            }
        }
        else if (enemy == 3){
            playerTwoHit += 1;
            if(playerTwoHit >= 3){
                UIAlertView * winner = (UIAlertView *)[[UIAlertView alloc] 
                                                        initWithTitle:@"Game Over"
                                                        message:@"Congratulations Player One, you win!"
                                                        delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil];
                                        
                [winner show];
                playerOneHit = 0;
                playerTwoHit = 0;
                shell.hidden = true;
                return;
            }
        }
    };
    if (shell.center.y < 90)
    {
        [self performSelector:@selector(fireShell:) withObject:shell afterDelay:(1.0/30.0)];
    }
    else{
        shell.hidden = true;
        return;
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
