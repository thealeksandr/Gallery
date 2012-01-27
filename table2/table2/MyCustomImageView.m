//
//  myImageClass.m
//  2iph
//
//  Created by Александр Никифоров on 11.12.11.
//  Copyright (c) 2011 i.thealeksandr@gmail.com. All rights reserved.
//

#import "MyCustomImageView.h"

@implementation MyCustomImageView
@synthesize myImageView;
@synthesize myText;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [myText resignFirstResponder];
}
- (void)up:(NSNotification*)textNotification
{
    
    double animationDuration;
    [[textNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [UIView animateWithDuration:animationDuration animations:^{
        myText.center=CGPointMake(160, 185);
    }];
}
- (void)down:(NSNotification*)textNotification
{
    myText.center=CGPointMake(160, 400);
}
- (void)dealloc {
    [myImageView release];
    [myText release];
    [super dealloc];
}
@end
