//
//  MasterViewController.m
//  MyTable
//
//  Created by Александр Никифоров on 17.12.11.
//  Copyright (c) 2011 i.thealeksandr@gmail.com. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@implementation MasterViewController
{
    NSArray *myNames;
    NSMutableArray *myPictures;
    NSMutableArray *myImages;
}

@synthesize detailViewController = _detailViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
    }
    return self;
}

- (void)dealloc
{
    [_detailViewController release];
    [super dealloc];
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
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *myStr=[[NSBundle mainBundle] pathForResource:@"GAGA" ofType:nil];
    myNames=[fileManager contentsOfDirectoryAtPath:myStr error:nil];
    [myNames retain];
    int count=[myNames count];
    myPictures=[[NSMutableArray alloc] initWithCapacity:count];
    myImages=[[NSMutableArray  alloc] initWithCapacity:count];
    for(int i=0;i<count;i++)
    {
        NSString *myStr=[[NSBundle mainBundle] pathForResource:[myNames objectAtIndex:i] ofType:nil inDirectory:@"GAGA"];
        UIImage *image=[UIImage imageWithContentsOfFile:myStr];
        [myImages addObject:image];
        CGSize mySize=CGSizeMake(12, 12);
        UIGraphicsBeginImageContext(mySize);
        [image drawInRect:CGRectMake(0, 0, mySize.width, mySize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
        UIGraphicsEndImageContext();   
        [myPictures addObject:newImage];
        
    }
	// Do any additional setup after loading the view, typically from a nib.

    
}

- (void)viewDidUnload
{
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

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [myNames count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    int index = [indexPath row];
    //NSString *myStr=[[NSBundle mainBundle] pathForResource:[myNames objectAtIndex:index] ofType:nil inDirectory:@"GAGA"];
    //UIImage *image=[UIImage imageWithContentsOfFile:myStr];
    cell.imageView.image=[myPictures objectAtIndex:index];
    // Configure the cell.
    cell.textLabel.text = NSLocalizedString([myNames objectAtIndex:index], [myNames objectAtIndex:index]);
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController) {
        self.detailViewController = [[[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil] autorelease];    
       [self.detailViewController.view setNeedsDisplay];
        [self.detailViewController names:myNames];
        
    }
    [self.detailViewController pictures:myPictures picIndex:[indexPath row]];
    //[self.detailViewController pictures:myPictures];
    int index = [indexPath row];
    //NSArray* arr=[self.detailViewController.myScroll subviews];
   // NSString *myStr=[[NSBundle mainBundle] pathForResource:[myNames objectAtIndex:index] ofType:nil inDirectory:@"GAGA"];
    //UIImage *image=[UIImage imageWithContentsOfFile:myStr];
    //self.detailViewController.myImage.image=image;
    CGPoint point = CGPointMake(320,0);
    self.detailViewController.myScroll.contentOffset=point;
    //self.detailViewController.myImage.contentMode=UIViewContentModeScaleAspectFit;
    self.detailViewController.title=[myNames objectAtIndex:index];
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

@end
