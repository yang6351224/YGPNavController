//
//  ViewController.m
//  ygpNav
//
//  Created by yang on 3/13/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "ViewController.h"
#import "ssViewController.h"
#import "YGPNavController.h"

@interface ViewController ()
{
 

}
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
     self.title=@"1";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   
   self.navigationController.interactivePopGestureRecognizer.enabled=NO;


   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)push:(id)sender {
     ssViewController *ss = [[ssViewController alloc]init];
     [self.navigationController pushViewController:ss animated:NO];
     
}
@end
