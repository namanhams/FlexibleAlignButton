//
//  UILabel+DefaultFont.h
//
//  Created by Pham Hoang Leon 14/3/14.
//  Copyright (c) 2014 namanhams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Font)

// Original font is the font that is set by calling 'setFont:', or is the default font used by
// UILabel if 'setFont:' is never called.
// This may not be same value as 'font' property. If 'attributedText' is set, 'font' property
// will be one of the UIFont that is used in the 'attributedText', and is not the original font
- (UIFont *) originalFont;

@end
