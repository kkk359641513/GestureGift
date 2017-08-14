//
//  RCGestrueGiftView.m
//  RCGestureGiftDemo
//
//  Created by kkk on 2017/8/10.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import "RCGestrueGiftView.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import <Foundation/Foundation.h>

#define kImgDefaultHeight  30
#define kImgDefaultWidth   30
#define kImgDefaultCenterDistance 30


@interface RCGestrueGiftView (){
    CGPoint currentPoint;
    CGPoint previousPoint;
    BOOL isUsed;
    CGFloat temDistance;
    CGPoint tempPoint;
}

@property (nonatomic, assign) CGFloat imgHeight;
@property (nonatomic, assign) CGFloat imgWidth;
@property (nonatomic, strong) UIButton *clearBtn;

@end

@implementation RCGestrueGiftView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initlize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initlize];
    }
    return self;
}

- (void)initlize
{
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    self.clipsToBounds = YES;
    self.imgHeight = kImgDefaultHeight;
    self.imgWidth = kImgDefaultWidth;
    self.imgDistance = kImgDefaultCenterDistance;
}

#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    previousPoint = [touch previousLocationInView:self];
    currentPoint = [touch locationInView:self];
    
    previousPoint = currentPoint;

    [self creatImgViewWithLocation:currentPoint];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //获取滑动的触摸点
    UITouch *touch = [touches anyObject];
    previousPoint = isUsed ? currentPoint : previousPoint;
    currentPoint = [touch locationInView:self];
    
    if (currentPoint.x < 0 || (currentPoint.x - self.bounds.size.width) > 0 ||currentPoint.y < 0 || currentPoint.y - self.bounds.size.height > 0){
        return;
    }
    
    NSLog(@"cur___%@",NSStringFromCGPoint(currentPoint));
    CGFloat distance = [self distanceFromPointX:previousPoint distanceToPointY:currentPoint];
    isUsed = distance > self.imgDistance ? YES : NO;
    
    if(distance < self.imgDistance ) return;
    //NSLog(@"11111___%@",NSStringFromCGPoint(currentPoint));

    [self handlePrePoint:previousPoint currentPoint:currentPoint];
    

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

#pragma mark - HandlePoints
//处理point
- (void)handlePrePoint:(CGPoint)prePoint currentPoint:(CGPoint)curPoint
{
    //1.计算两点之间的距离
    CGFloat distannce = [self distanceFromPointX:prePoint distanceToPointY:curPoint];
    NSLog(@"distance___%f",distannce);
    //2.计算两点之间的角度
   CGFloat angle = [self angleForStartPoint:prePoint EndPoint:curPoint];
    NSLog(@"angle___%f",angle);
    //3.循环算出两点之间符合放图片的点
    temDistance = distannce;
    tempPoint = prePoint;
    while (temDistance > _imgDistance) {
        CGFloat y =  sin(angle) * _imgDistance + tempPoint.y;
        CGFloat x =  cos(angle) * _imgDistance + tempPoint.x;
        tempPoint = CGPointMake(x, y);

        if ((y-_imgHeight/2) < 0) {
            y = _imgHeight/2;
        }
        if ((y+_imgHeight/2) > self.bounds.size.height) {
            y = self.bounds.size.height - _imgHeight/2;
        }
        
        if ((x-_imgWidth/2) < 0) {
            x = _imgWidth/2;
        }
        if ((x+_imgWidth/2) > self.bounds.size.width) {
            x = self.bounds.size.width - _imgWidth/2;
        }
        CGPoint putImgPoint = CGPointMake(x, y);
        NSLog(@"putImgPoint____%@",NSStringFromCGPoint(putImgPoint));
        [self creatImgViewWithLocation:putImgPoint];
        temDistance = [self distanceFromPointX:putImgPoint distanceToPointY:curPoint];
        NSLog(@"temdistance___%f",temDistance);
        currentPoint = tempPoint;
    }
   
    
}




#pragma mark - setter
- (void)setImgSize:(CGSize)imgSize
{
    self.imgWidth = imgSize.width;
    self.imgHeight = imgSize.height;
}


#pragma mark - CreatImgView
- (void)creatImgViewWithLocation:(CGPoint)center
{
    ASImageNode *node = [[ASImageNode alloc]init];
    node.image = [UIImage imageNamed:self.giftImgName];
    node.bounds = CGRectMake(0, 0, _imgWidth, _imgHeight);
    node.view.center = center;
    [self addSubview:node.view];
}

#pragma mark - caculate
//计算两点之间的距离
- (float)distanceFromPointX:(CGPoint)start distanceToPointY:(CGPoint)end{
    float distance;
    CGFloat xDist = (end.x - start.x);
    CGFloat yDist = (end.y - start.y);
    distance = sqrt((xDist * xDist) + (yDist * yDist));
    return distance;
}

//计算两个点与X轴线的夹角：
-(CGFloat)angleForStartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint{
    
    CGPoint Xpoint = CGPointMake(startPoint.x + 100, startPoint.y);
    
    CGFloat a = endPoint.x - startPoint.x;
    CGFloat b = endPoint.y - startPoint.y;
    CGFloat c = Xpoint.x - startPoint.x;
    CGFloat d = Xpoint.y - startPoint.y;
    
    CGFloat rads = acos(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
    
    if (startPoint.y>endPoint.y) {
        rads = -rads;
    }
    return rads;
}




@end







