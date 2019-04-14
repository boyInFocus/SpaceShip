//
//  CApp.m
//  SimpleSK
//
//  Created by Justin on 2019/4/2.
//  Copyright © 2019 swcm. All rights reserved.
//

#import "CApp.h"

int gDeviceType;
CGSize gScreenSize;

void deviceInit()
{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    CGFloat hOverW = size.height/size.width;
    //CGFloat wOverH = size.width/size.height;
    if(size.width == 1024 || size.height == 1024)
    {
        gDeviceType = DT_IPAD;
        gScreenSize = size;
    }
    else if(size.width == 480 || size.height == 480)
    {
        gDeviceType = DT_IPHONE4;
        gScreenSize = size;
    }
    else if((hOverW>1.77 && hOverW<1.78)||(hOverW>0.563 && hOverW<0.564))
    {
        gDeviceType = DT_IPHONE5;
        if(size.width > size.height)
        {
            gScreenSize = CGSizeMake(568, 320);
        }
        else
        {
            gScreenSize = CGSizeMake(320, 568);
        }
    }
    else if((hOverW>2.16 && hOverW<2.17)||(hOverW>0.46 && hOverW<0.47))
    {
        gDeviceType = DT_IPHONEX;
        if(size.width > size.height)
        {
            gScreenSize = CGSizeMake(812, 375);
        }
        else
        {
            gScreenSize = CGSizeMake(375, 812);
        }
    }
//    else if(size.width == 320 || size.height == 568)
//    {
//        gDeviceType = DT_IPHONE5;
//        if(size.width > size.height)
//        {
//            gScreenSize = CGSizeMake(568, 320);
//        }
//        else
//        {
//            gScreenSize = CGSizeMake(320, 568);
//        }
//    }
//    else if(size.width == 414 || size.height == 896)
//    {
//        gDeviceType = DT_IPHONEX;
//        gScreenSize = size;
//    }
}
