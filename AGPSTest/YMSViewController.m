#import "YMSViewController.h"

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>

#import "LocationViewController.h"

#include "at.h"

@interface YMSViewController ()

@end

@implementation YMSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.


}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (IBAction)getInfo:(id)sender
{
    CoreTelephony *ct = [[CoreTelephony alloc] init];
    [ct getCellInfo];

    
//    int fd= InitConn(115200);
//    AT(fd);
//    
//    char buf[100] = "";
//    /* 这里是发送的AT命令，如下面的命令，可以获取CELL的一些信息， 还有其他的一些信息，网上找找就有了，不过不是所有的命令都可以用哦，有些iphone没有留接口，有就用到一个命令AT+CCED=0,1,这个可以获取CELL的较详细的信息，但是IPHONE就没有留接口，没法用，悲剧
//     */
//    //下面是一些我找到的，可以用的命令
//    //获取小区信息
//    //SendStrCmd(fd, "AT+CREG=2;+CREG?\r\n");
//    //获取当前小区的信号强度
//    //SendStrCmd(fd, "AT+CSQ\r\n");
//    //基带信息
//    //SendStrCmd(fd, "At+xgendata\r\n");
//    //获得IMSI。这命令用来读取或者识别SIM卡的IMSI（国际移动签署者标识）。在读取IMSI之前应该先输入PIN（如果需要PIN的话）。
//    SendStrCmd(fd, "AT+CCID");
//    //获得SIM卡的标识。这个命令使模块读取SIM卡上的EF-CCID文件
//    //SendStrCmd(fd, "AT+CCID\r\n");
//    //读取信息中心号码
//    //SendStrCmd(fd, "AT+CSCA?\r\n");
//    //单元广播信息标识。
//    //SendStrCmd(fd, "AT+CSCB?\r\n");
//    
//    //SendStrCmd(fd, "AT+XCELLINFO=1\r\n");
//    while (1)
//    {
//        read(fd, buf, 100);
//        printf("%s", buf);
//        memset(buf, 0, 100);
//    };

    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)clickButton:(id)sender
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = info.subscriberCellularProvider;
 /*   NSLog(@"carrier1:%@",[carrier description]);

    //当 iPhone 漫游到了其他网路的时候，就会执行这段 block
    info.subscriberCellularProviderDidUpdateNotifier =
    ^(CTCarrier *carrier)
    {
        NSLog(@"carrier2:%@",[carrier description]);
    };
    
    //获取移动国家码
    NSString *mcc = [carrier mobileCountryCode];
    NSLog(@"mcc:%@",mcc);
    //获取移动网络码
    NSString *mnc = [carrier mobileNetworkCode];
    NSLog(@"mnc:%@",mnc);
    //判断运营商
    if ([[mcc substringWithRange:NSMakeRange(0, 3)] isEqualToString:@"460"])
    {
        NSInteger MNC = [[mnc substringWithRange:NSMakeRange(0, 2)] intValue];
        if (MNC == 0 || MNC == 2 || MNC == 7)
        {
            NSLog(@"China Mobile");
        }
        else if (MNC == 1||MNC == 6)
        {
            NSLog(@"China Unicom");
        }
        else if (MNC == 3 || MNC == 5)
        {
            NSLog(@"China Telecom");
        }
        else if (MNC == 20)
        {
            NSLog(@"China Tietong");
        }
        else
        {
            NSLog(@"暂时无法获得信息");
        }

    }
*/
    //监控是不是有电话打进来、正在接听、或是已经挂断
    CTCallCenter *center = [[CTCallCenter alloc] init];
    center.callEventHandler = ^(CTCall *call)
    {
        NSLog(@"call:%@",[call description]);
    };

    NSString *title = @"sim卡信息";
    NSString *message = [NSString stringWithFormat:@"%@,MCC:%@,MNC:%@",carrier.carrierName,carrier.mobileCountryCode,carrier.mobileNetworkCode];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];
}

-(void)clickLocation:(id)sender
{
    LocationViewController *location = [[LocationViewController alloc] initWithNibName:@"LocationViewController" bundle:nil];
    
    [self presentModalViewController:location animated:YES];
    
    [location release];
}

@end
