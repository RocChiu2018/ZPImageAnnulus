//
//  UIImage+ZPAnnulus.m
//  图片裁剪
//
//  Created by 赵鹏 on 2018/12/30.
//  Copyright © 2018 apple. All rights reserved.
//

#import "UIImage+ZPAnnulus.h"

@implementation UIImage (ZPAnnulus)

+ (instancetype)annulusWithImage:(NSString *)imageName border:(CGFloat)borderWidth annulusColor:(UIColor *)annulusColor
{
    //加载图片
    UIImage *image = [UIImage imageNamed:imageName];
    
    //获取图片的宽和高（图片为正方形，宽高相等）
    CGFloat imageWH = image.size.width;
    
    //设置圆环的宽度
    CGFloat border = borderWidth;
    
    //设置大正方形的宽和高
    CGFloat bigSquareWH = imageWH + 2 * border;
    
    /**
     1、创建一个与大正方形大小相同的基于位图(bitmap)的图形上下文：可以把图形上下文看成是一个画板，以后所绘制的内容都画在这个画板上。
     size参数：图形上下文的尺寸；
     opaque参数：不透明度（YES：不透明；NO：透明）；
     scale参数：缩放比例。
     */
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(bigSquareWH, bigSquareWH), NO, 0.0);
    
    /**
     2、以大正方形为背景，画一个正切于这个大正方形的大圆：
     */
    
    //2.1 用贝塞尔路径在大正方形内画一个大圆：
    UIBezierPath *bigRoundnessPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, bigSquareWH, bigSquareWH)];
    
    //2.2 为大圆设置颜色：
    [annulusColor set];
    [bigRoundnessPath fill];
    
    /**
     3、以正方形图片为背景，画一个正切于这个图片的小圆，图片在这个小圆内的保留，超过这个小圆的就裁切掉。
     */
    
    //3.1 用贝塞尔路径在正方形图片内画一个小圆：
    UIBezierPath *smallRoundnessPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(border, border, imageWH, imageWH)];
    
    //3.2 把上述小圆设为裁剪区域：
    [smallRoundnessPath addClip];
    
    /**
     4、在图形上下文中绘制图片：
     */
    [image drawAtPoint:CGPointMake(border, border)];
    
    /**
     5、从图形上下文中取出加完圆环的图片：
     */
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    /**
     6、关闭图形上下文：
     */
    UIGraphicsEndImageContext();
    
    /**
     7、返回加完圆环的图片：
     */
    return newImage;
}

@end
