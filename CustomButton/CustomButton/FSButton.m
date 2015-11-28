//
//  FSButton.m
//  自定义UIButton
//
//  Created by fs on 15/11/25.
//  Copyright © 2015年 fs. All rights reserved.
//

#import "FSButton.h"
#define FSFont [UIFont systemFontOfSize:16]
#define FSPadding 5
//自定义UIButton
@implementation FSButton

//从storyboard或xib中加载 会调用该方法
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

//完成一些初始化操作
- (void)initialize{
    self.titleLabel.font = FSFont;
    self.imageView.contentMode = UIViewContentModeCenter;
    
}

//通过代码初始化会调用该方法
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}


/**
 *  系统在显示按钮的文字和图片时会调用以下两个方法获得它们的位置尺寸
 *  因此我们可以重写这两个方法 返回修改后的尺寸
 */
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleH = contentRect.size.height;
    
    CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    NSDictionary *attrs = @{NSFontAttributeName:FSFont};
    //根据文字大小 计算文字的宽度
    CGFloat titleW = [self.currentTitle boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageY = 0;
    CGFloat imageW = 30;//自己设定
    CGFloat imageH = contentRect.size.height;
    CGFloat imageX = contentRect.size.width-imageW;//FSPadding是为了设置文字和图片的间距

    return CGRectMake(imageX, imageY, imageW, imageH);
}

@end
