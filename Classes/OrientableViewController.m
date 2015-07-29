//
//  OrientableViewController.m
//  Dealabs
//
//  Created by Raphaël Pinto on 27/07/2015.
//  Copyright (c) 2015 HUME Network. All rights reserved.
//

#import "OrientableViewController.h"

@interface OrientableViewController ()

@end

@implementation OrientableViewController



#pragma mark -
#pragma mark Object Life Cycle Methods



- (id)init
{
    self = [super init];
    
    if (self)
    {
        [self addNotificationsObservers];
    }
    
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self addNotificationsObservers];
    }
    
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    
    if (self)
    {
        [self addNotificationsObservers];
    }
    
    
    return self;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"applicationDidChangeStatusBarOrientation"
                                                  object:nil];
    NSLog(@"%s", __PRETTY_FUNCTION__);
}



#pragma mark -
#pragma mark Data Management Methods



- (void)addNotificationsObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidChangeStatusBarOrientation)
                                                 name:@"applicationDidChangeStatusBarOrientation"
                                               object:nil];
}


+ (CGSize)orientationDependentScreenSize
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f)
    {
        return [[UIScreen mainScreen] bounds].size;
    }
    else
    {
        if ([[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationLandscapeLeft ||
            [[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationLandscapeRight)
        {
            return CGSizeMake([[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
        }
        else
        {
            return [[UIScreen mainScreen] bounds].size;
        }
    }
}



#pragma mark -
#pragma mark Rotation handling Methods



// iOS 7 support
- (void)applicationDidChangeStatusBarOrientation
{
    float lMaxValue = MAX([OrientableViewController orientationDependentScreenSize].width, [OrientableViewController orientationDependentScreenSize].height);
    float lMinValue = MIN([OrientableViewController orientationDependentScreenSize].width, [OrientableViewController orientationDependentScreenSize].height);
    
    if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeLeft ||
        [[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeRight)
    {
        [self handleRotationWithNewSize:CGSizeMake(lMaxValue, lMinValue)];
    }
    else
    {
        [self handleRotationWithNewSize:CGSizeMake(lMinValue, lMaxValue)];
    }
}


- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [self handleRotationWithNewSize:size];
}


// Override this method to handle the rotation mannually
- (void)handleRotationWithNewSize:(CGSize)size
{
}




@end
