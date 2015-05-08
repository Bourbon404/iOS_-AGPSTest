//
//  LocationViewController.h
//  AGPSTest
//
//  Created by Bourbon on 13-11-19.
//  Copyright (c) 2013年 武汉理工大学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

@interface LocationViewController : UIViewController<CLLocationManagerDelegate>
{
   IBOutlet UILabel *label1;
   IBOutlet UILabel *label2;
   IBOutlet UILabel *label3;
}
@property(nonatomic,retain) CLLocationManager *locationManager;

-(IBAction)clickReturn:(id)sender;

@end
