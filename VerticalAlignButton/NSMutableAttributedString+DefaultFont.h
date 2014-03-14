//
//  NSMutableAttributedString+DefaultFont.h
//
//  Created by Pham Hoang Leon 14/3/14.
//  Copyright (c) 2014 namanhams. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (DefaultFont)

// Apply the given font to any range within the current attributed string that doesn't have font
- (void) applyDefaultFont:(UIFont *)font;

@end
