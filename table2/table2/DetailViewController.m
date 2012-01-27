//
//  DetailViewController.m
//  table2
//
//  Created by Александр Никифоров on 18.12.11.
//  Copyright (c) 2011 i.thealeksandr@gmail.com. All rights reserved.
//

#import "DetailViewController.h"
#import "MyCustomImageView.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController
{
    NSArray *myNames;
    NSMutableArray *myPictures;
    NSMutableArray *myImageView;
    int ind;
    int x;
    bool direction;
}

@synthesize detailItem = _detailItem;
@synthesize myScroll = _myScroll;


- (void)dealloc
{
    [_detailItem release];
    [_myScroll release];
    [super dealloc];
}

#pragma mark - Managing the detail item

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    CGPoint pointOne=_myScroll.contentOffset;
    NSArray *gallaryImageTextView = [_myScroll subviews];
    MyCustomImageView *gallaryImageTextViewNot;
    int count=gallaryImageTextView.count;
    for(int i=0;i<count;i++)
    {
        CGRect rect=[[gallaryImageTextView objectAtIndex:i] frame ];
        CGPoint pointTwo=rect.origin;
        if(pointTwo.x==pointOne.x){
            [[[gallaryImageTextView objectAtIndex:i] myText]resignFirstResponder];
            gallaryImageTextViewNot=[gallaryImageTextView objectAtIndex:i];
            break;
        }
    }
    [[NSNotificationCenter defaultCenter] removeObserver:nil name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:nil name:UIKeyboardWillShowNotification object:nil];
    count=gallaryImageTextView.count;
    //[gallaryImageTextView.myText resignFirstResponder];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGPoint pointOne=_myScroll.contentOffset;
    [self xBegin:x xEnd:pointOne.x];
    NSArray *gallaryImageTextView = [_myScroll subviews];
    int count=gallaryImageTextView.count;
    MyCustomImageView *gallaryImageTextViewNot;
    for(int i=0;i<count;i++)
    {
        CGRect rect=[[gallaryImageTextView objectAtIndex:i] frame ];
        CGPoint pointTwo=rect.origin;
        if(pointTwo.x==pointOne.x){
            gallaryImageTextViewNot=[gallaryImageTextView objectAtIndex:i];
            break;
        }
    }
    [[NSNotificationCenter defaultCenter] addObserver:gallaryImageTextViewNot selector:@selector(up:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:gallaryImageTextViewNot selector:@selector(down:) name:UIKeyboardWillHideNotification object:nil];
    //x=pointOne.x;
}
- (void)xBegin:(int)xB xEnd:(int)xE
{
    if(xB>xE){direction=true;[self changePictures:direction];}
    if(xE>xB){direction=false;[self changePictures:direction];}
}

- (void)changePictures:(BOOL)ScrollDirection
{
    //UIImage *image;
    //NSString *myStr;
    if(direction==true)
    {
        ind--;
    }
    else
    {
        ind++;
    }
    int indScroll=1;
    if(ind==0){indScroll=0;x=0;}
    if(ind==myPictures.count-1){indScroll=2;x=640;}
    MyCustomImageView *gallaryImageTextView;
    gallaryImageTextView = [myImageView objectAtIndex:indScroll];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^(void){
      //  if(ind!=0 && ind!=myPictures.count-1)
        //    _myScroll.contentOffset=CGPointMake(320, 0);
        NSString* myStr=[[NSBundle mainBundle] pathForResource:[myNames objectAtIndex:ind] ofType:nil inDirectory:@"GAGA"];
        UIImage* image=[UIImage imageWithContentsOfFile:myStr];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            gallaryImageTextView.myImageView.image=image;
        });
    });
    //myStr=[[NSBundle mainBundle] pathForResource:[myNames objectAtIndex:ind] ofType:nil inDirectory:@"GAGA"];
    //image=[UIImage imageWithContentsOfFile:myStr];
    
    gallaryImageTextView.myImageView.contentMode=UIViewContentModeScaleAspectFit;
    MyCustomImageView *leftImage,*rightImage;
    leftImage = [myImageView objectAtIndex:0];
    rightImage = [myImageView objectAtIndex:2];
    if(ind!=0 && ind!=myPictures.count-1){
        _myScroll.contentOffset=CGPointMake(320, 0);
        leftImage.myImageView.image=[myPictures objectAtIndex:ind-1];
        leftImage.myImageView.contentMode=UIViewContentModeScaleAspectFit;
        rightImage.myImageView.image=[myPictures objectAtIndex:ind+1];
        rightImage.myImageView.contentMode=UIViewContentModeScaleAspectFit;
        x=320;
    }
    else if(ind==0)
    {
        rightImage = [myImageView objectAtIndex:1];
        rightImage.myImageView.image=[myPictures objectAtIndex:ind+1];
        rightImage.myImageView.contentMode=UIViewContentModeScaleAspectFit; 
    }
    else if(ind==myPictures.count-1)
    {
        rightImage = [myImageView objectAtIndex:1];
        rightImage.myImageView.image=[myPictures objectAtIndex:ind-1];
        rightImage.myImageView.contentMode=UIViewContentModeScaleAspectFit; 
    }
}

- (void)pictures:(NSMutableArray*)myLoadedPictures picIndex:(int)index
{
    //myPictures=[NSMutableArray arrayWithCapacity:count]; 
    
    NSString *myStr;
    UIImage *image;
    ind=index;
    myPictures=myLoadedPictures;
    MyCustomImageView *gallaryImageTextView;
    if(index!=0){
        gallaryImageTextView = [myImageView objectAtIndex:0];
        myStr=[[NSBundle mainBundle] pathForResource:[myNames objectAtIndex:index-1] ofType:nil inDirectory:@"GAGA"];
        image=[UIImage imageWithContentsOfFile:myStr];
        gallaryImageTextView.myImageView.image=[myLoadedPictures objectAtIndex:index-1];
        gallaryImageTextView.myImageView.contentMode=UIViewContentModeScaleAspectFit;
    }
    myStr=[[NSBundle mainBundle] pathForResource:[myNames objectAtIndex:index] ofType:nil inDirectory:@"GAGA"];
    image=[UIImage imageWithContentsOfFile:myStr];
    gallaryImageTextView = [myImageView objectAtIndex:1];
    gallaryImageTextView.myImageView.image=image;
    gallaryImageTextView.myImageView.contentMode=UIViewContentModeScaleAspectFit;
    if(index!=[myNames count]-1){
        myStr=[[NSBundle mainBundle] pathForResource:[myNames objectAtIndex:index+1] ofType:nil inDirectory:@"GAGA"];
        gallaryImageTextView = [myImageView objectAtIndex:2];
        image=[UIImage imageWithContentsOfFile:myStr];
        gallaryImageTextView.myImageView.image=[myLoadedPictures objectAtIndex:index+1];;
        gallaryImageTextView.myImageView.contentMode=UIViewContentModeScaleAspectFit;

    }
    
}
- (void)names:(NSArray *)myPicNames
{
    myNames=myPicNames;
}

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release]; 
        _detailItem = [newDetailItem retain]; 

        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {

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
    _myScroll.contentSize=CGSizeMake(960,416);
    myImageView=[[NSMutableArray alloc] initWithCapacity:3];
    for(int i = 0;i<3;i++)
    {  
        CGRect rect=CGRectMake(320*i, 0, 320, 416);
        MyCustomImageView *gallaryImageTextView = [[[NSBundle mainBundle]loadNibNamed:@"View" owner:nil options:nil] objectAtIndex:0];
        gallaryImageTextView.frame=rect;
        [myImageView addObject:gallaryImageTextView];
        [_myScroll addSubview:gallaryImageTextView];
    }
    x=320;
 /*   NSArray *subview =[_myScroll subviews];
    int count=subview.count;
    myImageView=[[NSMutableArray alloc] initWithCapacity:count];
    for (int j=0;j<3;j++){
        CGPoint pointOne=CGPointMake(j*320, 0);
        for(int i=0;i<count;i++)
        {
            CGRect rect=[[subview objectAtIndex:i] frame ];
            CGPoint pointTwo=rect.origin;
            if(pointTwo.x==pointOne.x){
                [myImageView addObject:[subview objectAtIndex:i]];
                break;
            }
        }
    }*/
    [self configureView];
    
}

- (void)viewDidUnload
{
    [self setMyScroll:nil];
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
    CGPoint pointOne=_myScroll.contentOffset;
    NSArray *gallaryImageTextView = [_myScroll subviews];
    int count=gallaryImageTextView.count;
    MyCustomImageView *gallaryImageTextViewNot;
    for(int i=0;i<count;i++)
    {
        CGRect rect=[[gallaryImageTextView objectAtIndex:i] frame ];
        CGPoint pointTwo=rect.origin;
        if(pointTwo.x==pointOne.x){
            gallaryImageTextViewNot=[gallaryImageTextView objectAtIndex:i];
            break;
        }
    }
    [[NSNotificationCenter defaultCenter] addObserver:gallaryImageTextViewNot selector:@selector(up:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:gallaryImageTextViewNot selector:@selector(down:) name:UIKeyboardWillHideNotification object:nil];
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}
							
@end
