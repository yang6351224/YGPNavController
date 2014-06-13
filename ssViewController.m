//
//  ssViewController.m
//  ygpNav
//
//  Created by yang on 3/13/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "ssViewController.h"
#import <MapKit/MapKit.h>

#import "ViewControlleraa.h"

@interface ssViewController ()
{
    MKMapView * map;
}
@end

@implementation ssViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
          self.title=@"2";
    }
    return self;
}
- (IBAction)push:(id)sender {
    ViewControlleraa * v = [[ViewControlleraa alloc]init];
    [self.navigationController pushViewController:v animated:NO];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    map = [[MKMapView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:map];
    self.navigationController.interactivePopGestureRecognizer.enabled=NO;

    UIButton * bu = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [bu setFrame:CGRectMake(100, 100, 100, 100)];
    [bu addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    
    [map addSubview:bu];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
