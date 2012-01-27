//
//  FlipsideViewController.h
//  Lamp Jamp
//
//  Created by Александр Никифоров on 24.01.12.
//  Copyright (c) 2012 i.thealeksandr@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (assign, nonatomic) IBOutlet id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
