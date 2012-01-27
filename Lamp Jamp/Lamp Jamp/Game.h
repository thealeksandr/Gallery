//
//  Game.h
//  Lamp Jamp
//
//  Created by Александр Никифоров on 25.01.12.
//  Copyright (c) 2012 i.thealeksandr@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Game;

@protocol GameDelegate
- (void)GameDidFinish:(Game *)controller;
@end

@interface Game : UIViewController

@property (assign, nonatomic) IBOutlet id <GameDelegate> delegate;

- (IBAction)done:(id)sender;

@end