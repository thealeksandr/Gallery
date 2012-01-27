//
//  MainViewController.h
//  Lamp Jamp
//
//  Created by Александр Никифоров on 24.01.12.
//  Copyright (c) 2012 i.thealeksandr@gmail.com. All rights reserved.
//

#import "FlipsideViewController.h"
#import "Game.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate,GameDelegate>

- (IBAction)showInfo:(id)sender;
- (IBAction)playGame:(id)sender;

@end
