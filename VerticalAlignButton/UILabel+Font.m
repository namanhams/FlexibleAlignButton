//
//  UILabel+DefaultFont.m
//
//  Created by Pham Hoang Leon 14/3/14.
//  Copyright (c) 2014 namanhams. All rights reserved.
//

#import "UILabel+Font.h"
#import "MethodSwizzling.h"
#import <objc/runtime.h>

#define kOriginalFont @"OriginalFont"

@implementation UILabel (Font)

+ (void) load {
    // Swap 'setFont:' method with our custom method
    // We want to intercept the 'setFont' method
    Swizzle([self class], @selector(setFont:), @selector(_setMyFont:));
}

- (void) _setMyFont:(UIFont *)font {
    objc_setAssociatedObject(self, kOriginalFont, font, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self _setMyFont:font];
}

- (UIFont *) originalFont {
    UIFont *font = objc_getAssociatedObject(self, kOriginalFont);
    if(! font)
        return self.font;
    else
        return font;
}

- (void) dealloc {
    objc_setAssociatedObject(self, kOriginalFont, nil, OBJC_ASSOCIATION_ASSIGN);
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
}

@end
