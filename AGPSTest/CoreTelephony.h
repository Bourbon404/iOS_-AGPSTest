//CoreTelephony.h
#import <Foundation/Foundation.h>

struct CTServerConnection
{
    int a;
    int b;
    CFMachPortRef myport;
    int c;
    int d;
    int e;
    int f;
    int g;
    int h;
    int i;
};
struct CellInfo
{
    int servingmnc;
    int network;
    int location;
    int cellid;
    int station;
    int freq;
    int rxlevel;
    // int freq;
    int c1;
    int c2;
};

@interface CoreTelephony : NSObject

- (void) getCellInfo;

int callback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo);

@end




