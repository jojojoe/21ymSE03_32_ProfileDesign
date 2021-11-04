//
//  UIImageFoundation.m
//  filterStickers
//
//  Created by mac on 2021/10/8.
//

#import "UIImageFoundation.h"

@implementation UIImageFoundation
+(CAShapeLayer *)drawCircleTipWithRects:(CGRect)rect{

    //画圈
    CAShapeLayer *dotteLine =  [CAShapeLayer layer];
    CGMutablePathRef dottePath =  CGPathCreateMutable();
    dotteLine.lineWidth = 20 ;
    dotteLine.strokeColor = [UIColor whiteColor].CGColor;
    dotteLine.fillColor = [UIColor clearColor].CGColor;
    CGPathAddEllipseInRect(dottePath, nil, rect);
    dotteLine.path = dottePath;
    return dotteLine;
}
@end
