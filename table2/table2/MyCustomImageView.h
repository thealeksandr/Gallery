//
//  myImageClass.h
//  2iph
//
//  Created by Александр Никифоров on 11.12.11.
//  Copyright (c) 2011 i.thealeksandr@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCustomImageView : UIView
@property (retain, nonatomic) IBOutlet UIImageView *myImageView;
@property (retain, nonatomic) IBOutlet UITextField *myText;
- (void)up:(NSNotification*)textNotification;
- (void)down:(NSNotification*)textNotification;
@end
