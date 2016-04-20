在iOS开发中，系统自带的UIButton的默认的是图片在左，文字再右，系统自带UIButton显示效果：默认是图片在左，文字在右 
可是，开发中有时我们需要的Button的显示效果可能是这样需要的Button显示效果：文字在左，图片在右 
或者文字在上，图片在下……，此时系统就没办法满足我们的需要，要解决方法有两种:</br>
1：通过设置UIButton中文字和图片的UIEdgeInsets，让文字和图片的位置对调。 </br>
2：自定义一个UIButton，重写里面的对应方法，根据需要重新设定文字和图片的位置。</br> 
下面详细介绍一下这两种方法。 </br>
一：通过设置UIButton中文字和图片的UIEdgeInsets，让文字和图片的位置对调。</br> 
首先介绍一些UIEdgeInsets属性，该属性是设置控件距边框的边距的。通过这个方法设定： UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)，其中的四个参数分别代表控件的上边距、左边距、下边距、右边距的大小。如图所示：控件的边距 
上图中棕色的箭头代表图片控件的四个边距，黄色箭头代表文字控件的四个边距。要想达到我们的要求，其实就是增大图片控件的左边距和减小图片控件的右边距，再减小文字控件的左边距和增大文字控件的右边距。因此，我们只要能到UIButton，通过代码调整对应的左右边距即可。</br>
二：自定义一个UIButton，重写里面的对应方法，根据需要重新设定文字和图片的位置。 </br>
系统自带的UIButton是通过-(CGRect)titleRectForContentRect:(CGRect)contentRect方法和-(CGRect)imageRectForContentRect:(CGRect)contentRect获得文字和图片的位置。因此我们只需要继承UIButton，重写这两个方法，在里面根据我们的需要返回对应的位置即可。</br>
该方法也能满足我们的需求，但是存在一个问题：我们设置文字和图片的位置时，都是根据contentRect的宽高进行设定的，也就是设置后的文字会紧贴控件左边距，图片会紧贴控件右边框，所以如果我们的控件宽度很大，就会导致文字和图片间距过大的显示效果 
为了看到效果，将按钮的背景设置为灰色。 </br>
所以再通过代码自定义UIButton的时候，注意要先在storyboard中设置好UIButton的宽度。否则会出现如上图的效果。 </br>
总结：前面介绍了两种方式来修改UIButton中文字和图片的位置，一种是直接通过UIEdgeInsets属性设置，一种是通过自定义UIButton来设置。如果通过自定义UIButton来设置，请注意设置好UIButton的宽高，至于第二种方法能否进行继续改进，仍在摸索中…… </br>
最后附上博客地址： http://blog.csdn.net/feisongfeiqin/article/details/50041003
