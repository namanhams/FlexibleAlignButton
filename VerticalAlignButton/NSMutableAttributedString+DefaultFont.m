//
//  NSMutableAttributedString+DefaultFont.m
//
//  Created by Pham Hoang Leon 14/3/14.
//  Copyright (c) 2014 namanhams. All rights reserved.
//

#import "NSMutableAttributedString+DefaultFont.h"

@implementation NSMutableAttributedString (DefaultFont)

- (void) applyDefaultFont:(UIFont *)font {
    if(! font)
        return;
    
    [self enumerateAttribute:NSFontAttributeName
                     inRange:NSMakeRange(0, self.length)
                     options:0
                  usingBlock:^(id value, NSRange range, BOOL *stop) {
                      if(! value) {
                          [self addAttribute:NSFontAttributeName
                                       value:font
                                       range:range];
                      }
                  }];
}

@end
