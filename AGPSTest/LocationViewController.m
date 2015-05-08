//
//  LocationViewController.m
//  AGPSTest
//
//  Created by Bourbon on 13-11-19.
//  Copyright (c) 2013年 武汉理工大学. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 1000.0f;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_locationManager startUpdatingLocation];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_locationManager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clickReturn:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark Core Location
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currLocation = [locations lastObject];
    label1.text = [NSString stringWithFormat:@"%3.5f",currLocation.coordinate.latitude];
    label2.text = [NSString stringWithFormat:@"%3.5f",currLocation.coordinate.longitude];
    label3.text = [NSString stringWithFormat:@"%3.5f",currLocation.altitude];//高度，但是好像要在除以10才是当前海拔
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",error);
}

@end
