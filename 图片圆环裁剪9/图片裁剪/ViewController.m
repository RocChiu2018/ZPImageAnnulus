//
//  ViewController.m
//  图片裁剪
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+ZPAnnulus.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self directAddAnnulus];
    
//    [self callCategoryMethod];
}

#pragma mark ————— 直接添加圆环 —————
/**
 先在一个比正方形图片四周各大一个边距(border)的大正方形内画一个大圆，并且给这个大圆着色。然后在正方形图片内画一个小圆，大圆和小圆的间距就是圆环了。
 */
-(void)directAddAnnulus
{
    //加载图片
    UIImage *image = [UIImage imageNamed:@"阿狸头像"];
    
    //获取图片的宽和高（图片为正方形，宽高相等）
    CGFloat imageWH = image.size.width;
    
    //设置圆环的宽度
    CGFloat border = 1;
    
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
    [[UIColor redColor] set];
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
     7、把加完圆环的图片显示到UIImageView控件上面：
     */
    self.imageView.image = newImage;
}

#pragma mark ————— 调用分类的方法添加圆环 —————
- (void)callCategoryMethod
{
    UIImage *image = [UIImage annulusWithImage:@"阿狸头像" border:1.0 annulusColor:[UIColor yellowColor]];
    
    //如果向分类方法中的"borderWidth"参数传0并且"annulusColor"参数传nil的话则直接会把图片切成圆形而没有圆环。
//    UIImage *image = [UIImage annulusWithImage:@"阿狸头像" border:0 annulusColor:nil];
    
    self.imageView.image = image;
}

@end
