FlexibleAlignButton
===================

UIButton subclass that supports flexible text/image alignment. 
The default UIButton only supports horizontal alignment with image to the left and text to the right. This is kind of restricted. What if you want image to the right and text to the left ? Or you want them to be displayed vertically ?
Then this custom UIButton is for you. 

There's a sample project to show case. 

Example usage : 
```
FlexibleAlignButton *btn = .....
btn.alignment = kButtonAlignmentLabelLeft;
btn.gap = 5; // gap between text and image
```

Features:
- Support vertical/horizontal alignment
- Also handles calculating frame for attributed text. 
- Supports iOS 5 and above, ARC/non-ARC projects 
