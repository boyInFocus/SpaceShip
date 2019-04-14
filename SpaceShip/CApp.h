//
//  CApp.h
//  SimpleSK
//
//  Created by Justin on 2019/4/2.
//  Copyright © 2019 swcm. All rights reserved.
//
#ifndef _CApp_h_
#define _CApp_h_

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#define DT_IPHONE4 4
#define DT_IPHONE5 5
#define DT_IPHONEX 10
#define DT_IPAD 1000

extern int gDeviceType;

extern CGSize gScreenSize;

void deviceInit();

#endif
