//
//  DetailViewController.h
//  table2
//
//  Created by Александр Никифоров on 18.12.11.
//  Copyright (c) 2011 i.thealeksandr@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (retain, nonatomic) IBOutlet UIScrollView *myScroll;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)pictures:(NSMutableArray*)myPictures picIndex:(int)index;
- (void)xBegin:(int)xB xEnd:(int)xE;  
- (void)changePictures:(BOOL)ScrollDirection;
- (void)names:(NSArray*)myPicNames;
@end
