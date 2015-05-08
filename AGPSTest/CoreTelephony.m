//CoreTelephony.m
#import "CoreTelephony.h"
#include <dlfcn.h>
#import <UIKit/UIKit.h>
#include <stdio.h>
#include <stdlib.h>


CFMachPortRef port;
struct CTServerConnection *sc=NULL;
//struct CTServerConnection scc;
struct CellInfo cellinfo;
int b;
int t1;

@implementation CoreTelephony

int callback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
    printf("Callback called\n");
    return 0;
}

- (void) getCellInfo
{

    void *libHandle = dlopen("/System/Library/Frameworks/CoreTelephony.framework/CoreTelephony", RTLD_LAZY);
    int (*CTGetSignalStrength)();
    CTGetSignalStrength = dlsym(libHandle, "CTGetSignalStrength");
    if( CTGetSignalStrength == NULL)
    {
        NSLog(@"Could not find CTGetSignalStrength");
    }
    int result = CTGetSignalStrength();
    
    NSString *title1 = @"信号强度";
    NSString *message1 = [NSString stringWithFormat:@"%d",result];
    [self showAlertTitle:title1 Message:message1];
    
    dlclose(libHandle);
    
//    int cellcount;
//    char* sdk_path = "/System/Library/Frameworks/CoreTelephony.framework/CoreTelephony";
//    
//    // void * dlopen( const char * pathname, int mode );
//    // 功能：以指定模式打开指定的动态连接库文件，并返回一个句柄给调用进程。 打开错误返回NULL,成功，返回库引用
//    // RTLD_LAZY 暂缓决定，等有需要时再解出符号。这个参数使得未解析的symbol将在使用时去解析
//    int* handle =dlopen(sdk_path, RTLD_LAZY);
//    if (handle == NULL) {
//        return;
//    }
//    
//    // void* dlsym(void* handle,const char* symbol) 该函数在<dlfcn.h>文件中。将库中的一个函数绑定到预定义的函数地址(即获取到函数的指针)。handle是由dlopen打开动态链接库后返回的指针，symbol就是要求获取的函数的名称，函数返回值是void*,指向函数的地址，供调用使用。
//    struct CTServerConnection * (*CTServerConnectionCreate)() = dlsym(handle, "_CTServerConnectionCreate");
//    sc=CTServerConnectionCreate(kCFAllocatorDefault, callback, &t1);
//    
//    //    int (*CTServerConnectionGetPort)() = dlsym(handle, "_CTServerConnectionGetPort");
//    //    port=CFMachPortCreateWithPort(kCFAllocatorDefault, _CTServerConnectionGetPort(sc), NULL, NULL, NULL);
//    
//    void (*CTServerConnectionCellMonitorStart)() = dlsym(handle, "_CTServerConnectionCellMonitorStart");
//    CTServerConnectionCellMonitorStart(&t1,sc);
//    
//    int* (*CTServerConnectionCellMonitorGetCellCount)() = dlsym(handle, "_CTServerConnectionCellMonitorGetCellCount");
//    CTServerConnectionCellMonitorGetCellCount(&t1,sc,&cellcount);
//    NSLog(@"cellcount:%d",cellcount);
//    
//    void (*CTServerConnectionCellMonitorGetCellInfo)() = dlsym(handle, "_CTServerConnectionCellMonitorGetCellInfo");
//    
//    for(int b=0;b<cellcount;b++)
//    {
//        NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
//        
//        memset(&cellinfo, 0, sizeof(struct CellInfo));
//        int ts = 0;
//        
//        /** 这个方法的问题出现在这里，3.0以前的版本是４个参数，运行后会崩溃，后来发现新版本中是５个参数，不过获取的结果不理想，只获取了５个结果:MNC,MCC，LAC,CELLID,PXLEVEL，其他４项四项返回－１*/
//        CTServerConnectionCellMonitorGetCellInfo(&t1, sc, b, &ts, &cellinfo);
//        
//        printf("Cell Site: %d, MNC: %d, ",b,cellinfo.servingmnc);
//        printf("LAC: %d, Cell ID: %d, Station: %d, ",cellinfo.location, cellinfo.cellid, cellinfo.station);
//        printf("Freq: %d, RxLevel: %d, ", cellinfo.freq, cellinfo.rxlevel);
//        printf("C1: %d, C2: %d\n", cellinfo.c1, cellinfo.c2);
//        
//        [pool release];
//        pool = nil;
//    }
//    
//    // 使用dlclose（）来卸载打开的库
//    dlclose(handle);

    
    //发送at指令
//    int fd= InitConn(115200);
//    AT(fd);
//    
//    char buf[100] = "";
//    
//    /** 这里是发送的AT命令，如下面的命令，可以获取CELL的一些信息， 还有其他的一些信息，网上找找就有了，不过不是所有的命令都可以用哦，有些iphone没有留接口，有就用到一个命令AT+CCED=0,1,这个可以获取CELL的较详细的信息，但是IPHONE就没有留接口，没法用，悲剧*/
//    //下面是一些我找到的，可以用的命令
//    //获取小区信息
//    //SendStrCmd(fd, "AT+CREG=2;+CREG?\r\n");
//    //获取当前小区的信号强度
//    //SendStrCmd(fd, "AT+CSQ\r\n");
//    //基带信息
//    //SendStrCmd(fd, "At+xgendata\r\n");
//    //获得IMSI。这命令用来读取或者识别SIM卡的IMSI（国际移动签署者标识）。在读取IMSI之前应该先输入PIN（如果需要PIN的话）。
//    //SendStrCmd(fd, "AT+CCID\r\n");
//    //获得SIM卡的标识。这个命令使模块读取SIM卡上的EF-CCID文件
//    //SendStrCmd(fd, "AT+CCID\r\n");
//    //读取信息中心号码
//    //SendStrCmd(fd, "AT+CSCA?\r\n");
//    //单元广播信息标识。
//    //SendStrCmd(fd, "AT+CSCB?\r\n");
//    
//    SendStrCmd(fd, "AT+XCELLINFO=1\r\n");
//    while (1) 
//    {
//        read(fd, buf, 100);
//        printf("%s", buf);
//        memset(buf, 0, 100);
//    };
}


-(void)showAlertTitle:(NSString *)title Message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];
}


@end
/**
 *  Freq 表示的是频率
 */
/*
在开发手机多基站定位的过程中，会获取手机当前基站周边的其他基站的接收侧信号等级rxlev，当我们要做多基站定位时，要转化成基站侧的信号强度。
RXLEV跟接收信号强度的对应关系如下表：（信号依次增强）
RXLEV = 0                    RX < -110 dBm
RXLEV = 1        -110 dBm =< RX < -109 dBm
RXLEV = 2        -109 dBm =< RX < -108 dBm
RXLEV = 3        -108 dBm =< RX < -107 dBm
…                           …
RXLEV = 61       -50  dBm =< RX <  -49 dBm
RXLEV = 62       -49  dBm =< RX <= -48 dBm
RXLEV = 63                   RX >  -48 dBm
*/
