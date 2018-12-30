//
//  UIImage+ZPAnnulus.h
//  图片裁剪
//
//  Created by 赵鹏 on 2018/12/30.
//  Copyright © 2018 apple. All rights reserved.
//

/**
 用于把正方形的图片裁剪成圆形并且在外面加一个带颜色的圆环的UIImage类的分类。
 */
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZPAnnulus)

/**
 如果向分类方法中的"borderWidth"参数传0并且"annulusColor"参数传nil的话则直接会把图片切成圆形而没有圆环。
 */
+ (instancetype)annulusWithImage:(NSString *)imageName border:(CGFloat)borderWidth annulusColor:(UIColor *)annulusColor;

@end

NS_ASSUME_NONNULL_END
