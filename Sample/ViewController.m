//
//  ViewController.m
//  Sample
//
//  Created by Pham Hoang Leon 13/3/14.
//  Copyright (c) 2014 namanhams. All rights reserved.
//

#import "ViewController.h"
#import "VerticalAlignButton.h"
#import "UILabel+Font.h"
#import "NSMutableAttributedString+DefaultFont.h"
#import <CoreText/CoreText.h>

#define UIEdgeInsetsLog(insets) NSLog(@"%@", NSStringFromUIEdgeInsets(insets))

void printSubviews(UIView *view) {
    NSLog(@"%@", view);
    for(int i = 0; i < view.subviews.count; i++)
        printSubviews(view.subviews[i]);
}

@interface ViewController ()

@property (nonatomic, strong) IBOutlet VerticalAlignButton *btn;
@property (nonatomic, strong) IBOutlet UITextField *fieldVGap;
@property (nonatomic, strong) IBOutlet UISegmentedControl *horizontalSegment;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.btn.labelOnTop = true;
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
}

- (IBAction)segmentChanged:(id)sender {
    UISegmentedControl *segment = (UISegmentedControl *) sender;
    if(self.horizontalSegment == segment) {
        if(segment.selectedSegmentIndex == 0) { // Left
            self.btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
        else if(segment.selectedSegmentIndex == 1) { // Center
            self.btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
        else if(segment.selectedSegmentIndex == 2) { // Right
            self.btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
        else { // Fill
            self.btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
        }
    }
    else {
        [self.btn setVerticalGap:[[segment titleForSegmentAtIndex:segment.selectedSegmentIndex] intValue]];
    }
    
    printSubviews(self.btn);

}

- (IBAction)toggleSwitch:(id)sender {
    UISwitch *sw = (UISwitch *)sender;
    if(sw.on)
        self.btn.labelOnTop = true;
    else
        self.btn.labelOnTop = false;
}

@end
