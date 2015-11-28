iOS开发中，系统自带的UIButton的默认的是图片在左，文字再右，系统自带UIButton显示效果：默认是图片在左，文字在右 
可是，开发中有时我们需要的Button的显示效果可能是这样需要的Button显示效果：文字在左，图片在右 
或者文字在上，图片在下……，此时系统就没办法满足我们的需要，要解决方法有两种： 
1：通过设置UIButton中文字和图片的UIEdgeInsets，让文字和图片的位置对调。 
2：自定义一个UIButton，重写里面的对应方法，根据需要重新设定文字和图片的位置。 
下面详细介绍一下这两种方法。 
一：通过设置UIButton中文字和图片的UIEdgeInsets，让文字和图片的位置对调。 
首先介绍一些UIEdgeInsets属性，该属性是设置控件距边框的边距的。通过这个方法设定： UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)，其中的四个参数分别代表控件的上边距、左边距、下边距、右边距的大小。如图所示：控件的边距 
上图中棕色的箭头代表图片控件的四个边距，黄色箭头代表文字控件的四个边距。要想达到我们的要求，其实就是增大图片控件的左边距和减小图片控件的右边距，再减小文字控件的左边距和增大文字控件的右边距。因此，我们只要能到UIButton，通过代码调整对应的左右边距即可。代码如下：

//此时downBtn的位置已有设定 下面的设置是在此基础上
    CGFloat padding = 5; //设置文字和图片的间距
    //1 修改文字的位置（让文字整体往左移动一个图片的大小 保存文字宽度不变）
    CGFloat titleTop = 0;
    //让文字右边距在设定的基础上 再增加一个图片的宽度 此时文字往左压 腾出的位置刚好放图片
    CGFloat titleRight = self.downBtn.imageView.frame.size.width;
    //让文字左边距减小一个图片的宽度 此时正好文字宽度不变
    CGFloat titleLeft = -titleRight;
    CGFloat titleBottom = 0;  
    UIEdgeInsets titleInset = UIEdgeInsetsMake(titleTop, titleLeft-padding, titleBottom, titleRight+padding);//此处titleLeft-padding和titleRight+padding是为了让文字往左多挪动padding的距离来设置文字和图片的间距。
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

二：自定义一个UIButton，重写里面的对应方法，根据需要重新设定文字和图片的位置。 
系统自带的UIButton是通过-(CGRect)titleRectForContentRect:(CGRect)contentRect方法和-(CGRect)imageRectForContentRect:(CGRect)contentRect获得文字和图片的位置。因此我们只需要继承UIButton，重写这两个方法，在里面根据我们的需要返回对应的位置即可。代码如下：

#import "FSButton.h"
#define FSFont [UIFont systemFontOfSize:16]
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
    self.imageView.contentMode = UIViewContentModeCenter;//设置图片居中显示 这样图片的高度就可以设置为边框的高度了   
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
    CGFloat imageX = contentRect.size.width-imageW;
    return CGRectMake(imageX, imageY, imageW, imageH);
}
@end

该方法也能满足我们的需求，但是存在一个问题：我们设置文字和图片的位置时，都是根据contentRect的宽高进行设定的，也就是设置后的文字会紧贴控件左边距，图片会紧贴控件右边框，所以如果我们的控件宽度很大，就会出现如下的显示效果：按钮宽度太大导致的显示效果 
为了看到效果，将按钮的背景设置为灰色。 
所以再通过代码自定义UIButton的时候，注意要先在storyboard中设置好UIButton的宽度。否则会出现如上图的效果。 
总结：前面介绍了两种方式来修改UIButton中文字和图片的位置，一种是直接通过UIEdgeInsets属性设置，一种是通过自定义UIButton来设置。如果通过自定义UIButton来设置，请注意设置好UIButton的宽高，至于第二种方法能否进行继续改进，仍在摸索中…… 
最后附上博客地址： http://blog.csdn.net/feisongfeiqin/article/details/50041003