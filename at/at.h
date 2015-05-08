/*
 *  at.h
 *  SGSMInfo
 *
 *  Created by a on 11-8-5.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

void HexDumpLine(unsigned char *buf, int remainder, int offset);
void HexDump(unsigned char *buf, int size);
void SendCmd(int fd, void *buf, size_t size);
void SendStrCmd(int fd, char *buf);
int ReadResp(int fd);
int InitConn(int speed);
void CloseConn(int fd);
void SendAT(int fd);
void AT(int fd);
int SetPDUMode(int fd);
int SendSMS(int fd, char *to, char *text);
char * ReadSMSList(int fd);
int DeleteSMS(int fd, int n);
void DeleteAllSMS(int fd);
int ReadPB(int fd);
char *ReadSMS(int fd, int idx);
