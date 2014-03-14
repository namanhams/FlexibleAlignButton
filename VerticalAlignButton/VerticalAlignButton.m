//
//  VerticalAlignButton.m
//
//  Created by Pham Hoang Leon 13/3/14.
//  Copyright (c) 2014 namanhams. All rights reserved.
//

#import "VerticalAlignButton.h"
#import "UILabel+Font.h"
#import "NSMutableAttributedString+DefaultFont.h"

#define CAP_MAX(x, y) \
if(x > y) \
x = y;

#define CAP_MIN(x, y) \
if(x < y) \
x = y;

#define ROUND_SIZE(size) CGSizeMake(ceil(size.width), ceil(size.height))


@interface VerticalAlignButton () {
    BOOL _setupLabel;
    BOOL _setupImage;
}

@end


@implementation VerticalAlignButton

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self _setup];
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self _setup];
    return self;
}

- (void) _setup {
    self.clipsToBounds = YES;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
    _verticalGap = 5;
    _labelOnTop = YES;
}

- (void) setVerticalGap:(CGFloat)verticalGap {
    if(fabs(_verticalGap - verticalGap) < 0.0001)
        return;
    
    _verticalGap = verticalGap;
    [self setNeedsLayout];
}

- (void) setLabelOnTop:(BOOL)labelOnTop {
    if(_labelOnTop == labelOnTop)
        return;
    
    _labelOnTop = labelOnTop;
    [self setNeedsLayout];
}

// Override
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    if(! _setupLabel || ! _setupImage) {
//        NSLog(@"Seems that first time. Ignored");
        _setupLabel = true;
        return [super titleRectForContentRect:contentRect];
    }
    
    CGSize sizeThatFits = [self _sizeThatFitsLabel:contentRect];
    CGFloat width = sizeThatFits.width;
    CGFloat x, y, height;
    
    if(self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentCenter)
        x = (contentRect.size.width - width) / 2;
    else if(self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft)
        x = 0;
    else if(self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentFill) {
        x = 0;
        width = contentRect.size.width;
    }
    else {
        x = contentRect.size.width - width;
    }
    
    x += contentRect.origin.x;
    
    if(self.labelOnTop) {
        CGFloat totalHeight = [self _expectedHeight:contentRect];
        CAP_MAX(totalHeight, CGRectGetHeight(contentRect));
        
        if(self.contentVerticalAlignment == UIControlContentVerticalAlignmentTop)
            y = contentRect.origin.y;
        else if(self.contentVerticalAlignment == UIControlContentVerticalAlignmentCenter)
            y = contentRect.origin.y + (contentRect.size.height - totalHeight) / 2;
        else if(self.contentVerticalAlignment == UIControlContentVerticalAlignmentBottom)
            y = CGRectGetMaxY(contentRect) - totalHeight;
        else
            y = 0;
        
        CAP_MIN(y, CGRectGetMinY(contentRect));
    }
    else {
        CGRect imageRect = [self imageRectForContentRect:contentRect];
        y = CGRectGetMaxY(imageRect) + self.verticalGap;
        
        CAP_MAX(y, CGRectGetMaxY(contentRect));
    }
    
    height = CGRectGetMaxY(contentRect) - y;
    CAP_MAX(height, sizeThatFits.height);
    
    return CGRectMake((int)x, (int)y, width, height);
}


// Override
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    if(! _setupLabel || ! _setupImage) {
        _setupImage = true;
        return CGRectZero;
    }
    
    CGFloat width = (self.currentImage.size.width < contentRect.size.width ? self.currentImage.size.width : contentRect.size.width);
    CGFloat x, y, height;
    
    if(self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentCenter)
        x = (contentRect.size.width - width) / 2;
    else if(self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft)
        x = 0;
    else if(self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentFill) {
        x = 0;
        width = contentRect.size.width;
    }
    else {
        x = contentRect.size.width - width;
    }
    
    x += contentRect.origin.x;
    
    if(self.labelOnTop) {
        CGRect titleRect = [self titleRectForContentRect:contentRect];
        y = CGRectGetMaxY(titleRect) + self.verticalGap;
        
        CAP_MAX(y, CGRectGetMaxY(contentRect));
    }
    else {
        CGFloat totalHeight = [self _expectedHeight:contentRect];
        CAP_MAX(totalHeight, CGRectGetHeight(contentRect));
        
        if(self.contentVerticalAlignment == UIControlContentVerticalAlignmentTop)
            y = contentRect.origin.y;
        else if(self.contentVerticalAlignment == UIControlContentVerticalAlignmentCenter)
            y = contentRect.origin.y + (contentRect.size.height - totalHeight) / 2;
        else if(self.contentVerticalAlignment == UIControlContentVerticalAlignmentBottom)
            y = CGRectGetMaxY(contentRect) - totalHeight;
        else
            y = 0;
        
        CAP_MIN(y, CGRectGetMinY(contentRect))
    }
    
    height = CGRectGetMaxY(contentRect) - y;
    CAP_MAX(height, self.currentImage.size.height);
    
    return CGRectMake(x, y, width, height);
}

- (CGFloat) _expectedHeight:(CGRect)contentRect {
    CGSize labelSize = [self _sizeThatFitsLabel:contentRect];
    return labelSize.height + self.currentImage.size.height + self.verticalGap;
}

- (CGSize) _sizeThatFitsLabel:(CGRect)contentRect {
    if([self respondsToSelector:@selector(currentAttributedTitle)] && self.currentAttributedTitle) {
        if([self.currentAttributedTitle respondsToSelector:@selector(boundingRectWithSize:options:context:)]) {
            NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.currentAttributedTitle];
            [mutableAttributedString applyDefaultFont:[self.titleLabel originalFont]];
            CGRect boundingRect = [mutableAttributedString boundingRectWithSize:contentRect.size
                                                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                        context:nil];
            return ROUND_SIZE(boundingRect.size);
        }
        else {
            CGSize size = [self.currentAttributedTitle size];
            CAP_MAX(size.width, CGRectGetWidth(contentRect));
            CAP_MAX(size.height, CGRectGetHeight(contentRect));
            
            return ROUND_SIZE(size);
        }
    }
    else if(self.currentTitle){
        UIFont *font = self.titleLabel.font;
        
        if([self.currentTitle respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
            CGRect boundingRect = [self.currentTitle boundingRectWithSize:contentRect.size
                                                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                               attributes:@{NSFontAttributeName: font}
                                                                  context:nil];
            return ROUND_SIZE(boundingRect.size);
        }
        else {
            CGSize size = [self.currentTitle sizeWithFont:font
                                        constrainedToSize:contentRect.size
                                            lineBreakMode:self.titleLabel.lineBreakMode];
            return ROUND_SIZE(size);
        }
    }
    else
        return CGSizeZero;
    
    if(self.currentAttributedTitle)
        return CGSizeMake(contentRect.size.width, self.currentAttributedTitle.length * 1.5);
    else
        return CGSizeMake(contentRect.size.width, self.currentTitle.length * 1.5);
    
    return [self.titleLabel sizeThatFits:contentRect.size];
}

@end
