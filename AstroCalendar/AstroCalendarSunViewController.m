//
//  AstroCalendarSunViewController.m
//  AstroCalendar
//
//  Created by Paul Moore on 11-11-02.
//  Copyright (c) 2011 University of British Columbia. All rights reserved.
//  https://github.com/paulmoore/AstroCalendar
/*
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 */

#import "AstroCalendarSunViewController.h"
#import "AstroCalendarDayViewController.h"
#import "AstroCalendarMoonViewController.h"
#import "AstroCalendarSelectDateViewController.h"
#import "UINavigationController+UniqueStack.h"

@implementation AstroCalendarSunViewController

@synthesize navController;

- (id)initWithNavController:(UINavigationController *)controller
{
    self = [super initWithSunday:YES];
    if (self)
    {
        // Custom initialization
        self.navController = controller;
        self.title = @"Sun Calendar";
    }
    return self;
}

- (void)calendarMonthView:(TKCalendarMonthView*)monthView didSelectDate:(NSDate*)date
{
    // Avoid the View Controller being 'double pushed' if this event fires more than once.
    if (self.navController.visibleViewController == self)
    {
        if (! [self.navController pushUniqueControllerOfType:[AstroCalendarDayViewController class] animated:YES])
        {
            UIViewController *dayController = [[AstroCalendarDayViewController alloc] initWithNavController:self.navController];
            [self.navController pushViewController:dayController animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Toolbar Button Actions

- (void)didSelectMoonCalendarFromToolbar
{
    if (! [self.navController pushUniqueControllerOfType:[AstroCalendarMoonViewController class] animated:YES])
    {
        UIViewController *moonController = [[AstroCalendarMoonViewController alloc] initWithNavController:self.navController];
        [self.navController pushViewController:moonController animated:YES];
    }
}

- (void)didSelectSelectDatesFromToolbar
{
    if (! [self.navController pushUniqueControllerOfType:[AstroCalendarSelectDateViewController class] animated:YES])
    {
        UIViewController *selectController = [[AstroCalendarSelectDateViewController alloc] initWithNavController:self.navController andIsEndDate:NO];
        [self.navController pushViewController:selectController animated:YES];
    }
}

- (void)didSelectOptionsFromToolbar
{
    // TODO Go to options menu.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Because we are not loading from a NIB, the default Color is Black, so we have to hard-code it here.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *moonButton = [[UIBarButtonItem alloc] initWithTitle:@"Moon Calendar" style:UIBarButtonItemStyleBordered target:self action:@selector(didSelectMoonCalendarFromToolbar)];
    UIBarButtonItem *selectDatesButton = [[UIBarButtonItem alloc] initWithTitle:@"Select Dates" style:UIBarButtonItemStyleBordered target:self action:@selector(didSelectSelectDatesFromToolbar)];
    UIBarButtonItem *optionsButton = [[UIBarButtonItem alloc] initWithTitle:@"Options" style:UIBarButtonItemStyleBordered target:self action:@selector(didSelectOptionsFromToolbar)];
    NSArray *buttons = [NSArray arrayWithObjects:moonButton, selectDatesButton, optionsButton, nil];
    [self setToolbarItems:buttons animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.navController = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
