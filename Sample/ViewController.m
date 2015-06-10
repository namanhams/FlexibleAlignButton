//
//  ViewController.m
//  Sample
//
//  Created by Pham Hoang Leon 13/3/14.
//  Copyright (c) 2014 namanhams. All rights reserved.
//

#import "ViewController.h"
#import "FlexibleAlignButton.h"
#import <CoreText/CoreText.h>

#define UIEdgeInsetsLog(insets) NSLog(@"%@", NSStringFromUIEdgeInsets(insets))

void printSubviews(UIView *view) {
    NSLog(@"%@", view);
    for(int i = 0; i < view.subviews.count; i++)
        printSubviews(view.subviews[i]);
}

@interface ViewController ()

@property (nonatomic, strong) IBOutlet FlexibleAlignButton *btn;
@property (nonatomic, strong) IBOutlet UISegmentedControl *horizontalSegment;
@property (nonatomic, strong) IBOutlet UISegmentedControl *verticalSegment;
@property (nonatomic, strong) IBOutlet UISegmentedControl *alignmentSegment;
@property (nonatomic, strong) IBOutlet UISegmentedControl *gapSegment;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.btn.alignment = kButtonAlignmentLabelTop;
    self.btn.layer.borderColor = [UIColor blueColor].CGColor;
    self.btn.layer.borderWidth = 1.0;
    self.btn.backgroundColor = [UIColor clearColor];
    [self.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn setTitle:@"This is a title" forState:UIControlStateNormal];
    self.btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.btn.titleLabel.numberOfLines = 0;
    self.btn.imageView.contentMode = UIViewContentModeScaleAspectFit;

    NSString *s = @"Super Freaking long Attributed String Long Long Long";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:s];
    [attributedString addAttribute:NSFontAttributeName
                             value:self.btn.titleLabel.font
                             range:NSMakeRange(4, 6)];
    [attributedString addAttribute:NSFontAttributeName
                             value:[UIFont boldSystemFontOfSize:20]
                             range:NSMakeRange(0, 7)];
    
    [self.btn setAttributedTitle:attributedString forState:UIControlStateHighlighted];
	
	[self.btn sizeToFit];
}

- (IBAction)segmentChanged:(id)sender {
    UISegmentedControl *segment = (UISegmentedControl *) sender;
    if(self.horizontalSegment == segment) {
        if(segment.selectedSegmentIndex == 0) {
            self.btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
        else if(segment.selectedSegmentIndex == 1) {
            self.btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
        else if(segment.selectedSegmentIndex == 2) {
            self.btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
        else { // Fill
            self.btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
        }
    }
	else if(self.verticalSegment == segment) {
		if(segment.selectedSegmentIndex == 0) { 
			self.btn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
		}
		else if(segment.selectedSegmentIndex == 1) {
			self.btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		}
		else if(segment.selectedSegmentIndex == 2) {
			self.btn.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
		}
		else {
			self.btn.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
		}
	}
	else if(self.alignmentSegment == segment) {
		if(segment.selectedSegmentIndex == 0) {
			self.btn.alignment = kButtonAlignmentImageLeft;
		}
		else if(segment.selectedSegmentIndex == 1) {
			self.btn.alignment = kButtonAlignmentLabelLeft;
		}
		else if(segment.selectedSegmentIndex == 2) {
			self.btn.alignment = kButtonAlignmentImageTop;
		}
		else {
			self.btn.alignment = kButtonAlignmentLabelTop;
		}
	}
    else {
        [self.btn setGap:[[segment titleForSegmentAtIndex:segment.selectedSegmentIndex] intValue]];
    }
    
    printSubviews(self.btn);

}

- (IBAction)toggleSwitch:(id)sender {
    UISwitch *sw = (UISwitch *)sender;
    if(sw.on)
        self.btn.alignment = kButtonAlignmentLabelTop;
    else
        self.btn.alignment = kButtonAlignmentImageTop;
}

@end
