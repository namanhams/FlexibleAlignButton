FlexibleAlignButton
===================

UIButton subclass that supports flexible text/image alignment. 
The default UIButton only supports horizontal alignment with image to the left and text to the right. This is kind of restricted. What if you want image to the right and text to the left ? Or you want them to be displayed vertically ?
Then this custom UIButton is for you. 

There's a sample project to show case. 

<h2><b>Example</b></h2>
![alt text](http://imageshack.com/a/img540/5046/jK4RKq.png "Image top Text bottom")
![alt text](http://imageshack.com/a/img673/2019/Q8nS72.png "Text top Image bottom")
![alt text](http://imageshack.com/a/img905/9017/qJufe8.png "Text left Image top")

<h2><b>Usage</b></h2>
```
FlexibleAlignButton *btn = .....
btn.alignment = kButtonAlignmentLabelLeft;
btn.gap = 5; // gap between text and image
```

<h2><b>Features</b></h2>
- Support vertical/horizontal alignment
- Also handles calculating frame for attributed text. 
- Supports iOS 5 and above, ARC/non-ARC projects 
