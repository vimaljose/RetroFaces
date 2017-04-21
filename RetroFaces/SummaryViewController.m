//
//  SummaryViewController.m
//  RetroFaces
//
//  Created by Apple on 21/04/17.
//  Copyright © 2017 Armor. All rights reserved.
//

#import "SummaryViewController.h"
#define FONT_BOLD @"ProximaNova-Semibold"
#define FONT_THIN @"ProximaNovaT-Thin"

@interface SummaryViewController ()

@end

@implementation SummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _btnReset.titleLabel.font = [UIFont fontWithName:FONT_BOLD size:20];
    _lblTitle.font = [UIFont fontWithName:FONT_BOLD size:20];
    [self setValuesToButtons];
    [self setupResetButton];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = false;
}

-(void)viewDidAppear:(BOOL)animated
{
    for (UIButton * btn in self.btnSmileys)
    {
        [self centerVerticallyWithPadding:10 andTheButton:btn];
        btn.titleLabel.font = [UIFont fontWithName:FONT_BOLD size:26];
    }
    // animation
    UIButton * btn = (UIButton *)[self.view viewWithTag:101];
    [self animateButton:btn];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  Buttons

-(void)animateButton:(UIButton *)sender
{
    sender.imageView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    sender.titleLabel.transform = CGAffineTransformMakeScale(0.9, 0.9);
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:3.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        sender.imageView.transform = CGAffineTransformIdentity;
        sender.titleLabel.transform = CGAffineTransformIdentity;
        sender.alpha = 1.0;
    } completion:^(BOOL finished) {
        if (finished)
        {
            UIButton * btn = (UIButton *)[self.view viewWithTag:sender.tag+1];
            if (btn)
            {
                [self animateButton:btn];
            }
            
        }
    }];
}

#pragma mark -  Reset Button

-(void)setupResetButton
{
    [self applyGradient:self.btnReset andTopColor:[UIColor colorWithRed:0.8157 green:0.4471 blue:0.0471 alpha:1.0] andMiddleColor:[UIColor colorWithRed:0.9255 green:0.7882 blue:0.1176 alpha:1.0] andBottomColor:[UIColor colorWithRed:0.9647 green:0.9216 blue:0.1569 alpha:1.0]];
}

-(void)applyGradient:(UIView*)view andTopColor:(UIColor *)topColor andMiddleColor:(UIColor *)MiddleColor andBottomColor:(UIColor *)BottomColor
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[MiddleColor CGColor],(id)[BottomColor CGColor],nil];
    UIBezierPath *maskPath = [UIBezierPath
                              bezierPathWithRoundedRect:self.btnReset.bounds
                              byRoundingCorners:(UIRectCornerTopLeft| UIRectCornerTopRight)
                              cornerRadii:CGSizeMake(20, 20)
                              ];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.btnReset.bounds;
    maskLayer.path = maskPath.CGPath;
    gradient.mask = maskLayer;
    [view.layer insertSublayer:gradient atIndex:0];
    
}

#pragma mark - set Status Bar

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault; // preferred style
}

- (BOOL)prefersStatusBarHidden
{
    return NO; // your own visibility code
}


#pragma mark -  set values to button
-(void)setValuesToButtons
{
    for (UIButton * btn in self.btnSmileys)
    {
        switch (btn.tag) {
            case 101:
            {
                // DISLIKED
                NSInteger count = [[NSUserDefaults standardUserDefaults] integerForKey:@"DISLIKED"];
                [self setTextToButton:count andTheString:@"Disliked" andTheButton:btn];
                
            }
                break;
                
            case 102:
            {
                // NEUTRAL
                NSInteger count = [[NSUserDefaults standardUserDefaults] integerForKey:@"NEUTRAL"];
                [self setTextToButton:count andTheString:@"Neutral" andTheButton:btn];
            }
                break;
                
            case 103:
            {
                // LIKED
                NSInteger count = [[NSUserDefaults standardUserDefaults] integerForKey:@"LIKED"];
                [self setTextToButton:count andTheString:@"Liked" andTheButton:btn];
            }
                break;
                
            default:
                break;
        }
    }

}

-(void)setTextToButton:(NSInteger)count andTheString:(NSString *)strStatus andTheButton:(UIButton *)button
{
    NSMutableAttributedString *titleText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld\n%@",(long)count,strStatus]];
    
    [titleText addAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:FONT_BOLD size:26] forKey:NSFontAttributeName] range:NSMakeRange(0, [NSString stringWithFormat:@"%ld",(long)count].length)];
    
    [titleText addAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:FONT_BOLD size:16] forKey:NSFontAttributeName] range:[[NSString stringWithFormat:@"%ld\n%@",(long)count,strStatus] rangeOfString:strStatus]];
    
    // Set the attributed string as the buttons' title text
    [button setAttributedTitle:titleText forState:UIControlStateNormal];
}
#pragma mark - Vertical adjustment of UIButton

- (void)centerVerticallyWithPadding:(float)padding andTheButton:(UIButton *)button
{
    button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    // get the size of the elements here for readability
    CGSize imageSize = button.imageView.frame.size;
    CGSize titleSize = button.titleLabel.frame.size;
    float staticValue = 20;
    // lower the text and push it left to center it
    button.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height   + padding) + staticValue, 0.0);
    
    // raise the image and push it right to center it
    button.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + padding) + staticValue, 0.0 + staticValue, 0.0 + staticValue, -    titleSize.width + staticValue);

}

#pragma mark - Actions

- (IBAction)btnClosePressed:(UIButton *)sender
{
    [self dismissViewControllerAnimated:true completion:^{
        
    }];
}
- (IBAction)btnResetPressed:(UIButton *)sender
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"DISLIKED"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"NEUTRAL"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"LIKED"];
    [self setValuesToButtons];
}
@end
