//
//  RCGestrueGiftView.h
//  RCGestureGiftDemo
//
//  Created by kkk on 2017/8/10.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCGestrueGiftView : UIView

@property (nonatomic, assign) CGSize imgSize;       //default is 30*30
@property (nonatomic, assign) CGFloat imgDistance;  //defatult is kImgDefaultCenterDistance
@property (nonatomic, strong) NSString *giftImgName; 

@end
