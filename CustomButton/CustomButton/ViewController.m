//
//  ViewController.m
//  自定义UIButton
//
//  Created by fs on 15/11/25.
//  Copyright © 2015年 fs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *downBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //方法一
    //此时downBtn的位置已有设定 下面的设置是在此基础上
    CGFloat padding = 5; //设置文字和图片的间距
    //1 修改文字的位置（让文字整体往左移动一个图片的大小 保存文字宽度不变）
    CGFloat titleTop = 0;
    //让文字右边距在设定的基础上 再增加一个图片的宽度 此时文字往左压 腾出的位置刚好放图片
    CGFloat titleRight = self.downBtn.imageView.frame.size.width;
    //让文字左边距减小一个图片的宽度 此时正好文字宽度不变
    CGFloat titleLeft = -titleRight;
    CGFloat titleBottom = 0;
    
    UIEdgeInsets titleInset = UIEdgeInsetsMake(titleTop, titleLeft-padding, titleBottom, titleRight+padding);
    [self.downBtn setTitleEdgeInsets:titleInset];
    //2 修改图片的位置（让图片整体往右移动一个文字大小 保存图片宽度不变）
    CGFloat imageTop = 0;
    //让图片左边距在原有基础上 再增加文字的宽度 此时图片往右压 压出来的位置刚好放文字
    CGFloat imageLeft = self.downBtn.titleLabel.frame.size.width;
    CGFloat imageBottom = 0;
    //让图片右边距减小文字的宽度 此时图片的宽度才能保持不变
    CGFloat imageRight = -imageLeft;
    UIEdgeInsets imageInset = UIEdgeInsetsMake(imageTop, imageLeft, imageBottom, imageRight);
    [self.downBtn setImageEdgeInsets:imageInset];
   
    //方法二 在Main.storyboard中设置Custom class为自定义的FSButton
    
}



@end
