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
    int cellcount;
    char* sdk_path = "/System/Library/Frameworks/CoreTelephony.framework/CoreTelephony";
    
    // void * dlopen( const char * pathname, int mode ); 
    // 功能：以指定模式打开指定的动态连接库文件，并返回一个句柄给调用进程。 打开错误返回NULL,成功，返回库引用
    // RTLD_LAZY 暂缓决定，等有需要时再解出符号。这个参数使得未解析的symbol将在使用时去解析
    int* handle =dlopen(sdk_path, RTLD_LAZY);
    if (handle == NULL) {
        return;
    }
    
    // void* dlsym(void* handle,const char* symbol) 该函数在<dlfcn.h>文件中。将库中的一个函数绑定到预定义的函数地址(即获取到函数的指针)。handle是由dlopen打开动态链接库后返回的指针，symbol就是要求获取的函数的名称，函数返回值是void*,指向函数的地址，供调用使用。
    struct CTServerConnection * (*CTServerConnectionCreate)() = dlsym(handle, "_CTServerConnectionCreate");
    sc=CTServerConnectionCreate(kCFAllocatorDefault, callback, &t1);
    
    //    int (*CTServerConnectionGetPort)() = dlsym(handle, "_CTServerConnectionGetPort");
    //    port=CFMachPortCreateWithPort(kCFAllocatorDefault, _CTServerConnectionGetPort(sc), NULL, NULL, NULL);
    
    void (*CTServerConnectionCellMonitorStart)() = dlsym(handle, "_CTServerConnectionCellMonitorStart");
    CTServerConnectionCellMonitorStart(&t1,sc);
    
    int* (*CTServerConnectionCellMonitorGetCellCount)() = dlsym(handle, "_CTServerConnectionCellMonitorGetCellCount");
    CTServerConnectionCellMonitorGetCellCount(&t1,sc,&cellcount);
    NSLog(@"cellcount:%d",cellcount);
    
    void (*CTServerConnectionCellMonitorGetCellInfo)() = dlsym(handle, "_CTServerConnectionCellMonitorGetCellInfo");
    
    if (cellcount == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法获取基站信息"
                                                        message:@"没有基站，或者您的手机不支持该方式查找基站！"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    for(int b=0;b<cellcount;b++)
    { 
        NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
        
        memset(&cellinfo, 0, sizeof(struct CellInfo));
        int ts = 0;
        
        /** 这个方法的问题出现在这里，3.0以前的版本是４个参数，运行后会崩溃，后来发现新版本中是５个参数，不过获取的结果不理想，只获取了５个结果:MNC,MCC，LAC,CELLID,PXLEVEL，其他４项四项返回－１*/
        CTServerConnectionCellMonitorGetCellInfo(&t1, sc, b, &ts, &cellinfo);
        
        printf("Cell Site: %d, MNC: %d, ",b,cellinfo.servingmnc);
        printf("LAC: %d, Cell ID: %d, Station: %d, ",cellinfo.location, cellinfo.cellid, cellinfo.station);
        printf("Freq: %d, RxLevel: %d, ", cellinfo.freq, cellinfo.rxlevel);
        printf("C1: %d, C2: %d\n", cellinfo.c1, cellinfo.c2);
        
        NSString *strA = [NSString stringWithFormat:@"Cell Site: %d, MNC: %d, ",b,cellinfo.servingmnc];
        NSString *strB = [NSString stringWithFormat:@"LAC: %d, Cell ID: %d, Station: %d, ",cellinfo.location, cellinfo.cellid, cellinfo.station];
        NSString *strC = [NSString stringWithFormat:@"Freq: %d, RxLevel: %d, ", cellinfo.freq, cellinfo.rxlevel];
        NSString *strD = [NSString stringWithFormat:@"C1: %d, C2: %d\n", cellinfo.c1, cellinfo.c2];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"基站信息"
                                                        message:[[NSString alloc] initWithFormat:@"第一部分信息：\n%@\n\n\n第二部分信息：\n%@\n\n\n第三部分信息：\n%@\n\n\n第四部分信息：\n%@",strA,strB,strC,strD]
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        [pool release];
        pool = nil;
    }
    
    // 使用dlclose（）来卸载打开的库
    dlclose(handle);
}

@end
