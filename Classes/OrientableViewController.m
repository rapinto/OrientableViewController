//
//  OrientableViewController.m
//
//
//  Created by Raphaël Pinto on 27/07/2015.
//
// The MIT License (MIT)
// Copyright (c) 2015 Raphael Pinto.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.



#import "OrientableViewController.h"
#import <AppUtils/AppUtils.h>



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
    float lMaxValue = MAX([AppUtils orientationDependentScreenSize].width, [AppUtils orientationDependentScreenSize].height);
    float lMinValue = MIN([AppUtils orientationDependentScreenSize].width, [AppUtils orientationDependentScreenSize].height);
    
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
