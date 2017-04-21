//
//  ViewController.m
//  RetroFaces
//
//  Created by Apple on 21/04/17.
//  Copyright © 2017 Armor. All rights reserved.
//

#import "ViewController.h"
#import "SummaryViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = true;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)btnSmileyPressed:(UIButton *)sender
{
    sender.imageView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    
    [UIView animateWithDuration:2.0 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:3.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        sender.imageView.transform = CGAffineTransformIdentity;
    } completion:nil];

    
    switch (sender.tag) {
        case 101:
        {
            // DISLIKED
            NSInteger count = [[NSUserDefaults standardUserDefaults] integerForKey:@"DISLIKED"];
            [[NSUserDefaults standardUserDefaults]setInteger:count+1 forKey:@"DISLIKED"];
        }
            break;
            
        case 102:
        {
            // NEUTRAL
            NSInteger count = [[NSUserDefaults standardUserDefaults] integerForKey:@"NEUTRAL"];
            [[NSUserDefaults standardUserDefaults]setInteger:count+1 forKey:@"NEUTRAL"];
        }
            break;
            
        case 103:
        {
            // LIKED
            NSInteger count = [[NSUserDefaults standardUserDefaults] integerForKey:@"LIKED"];
            [[NSUserDefaults standardUserDefaults]setInteger:count+1 forKey:@"LIKED"];
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)btnInfoPressed:(id)sender
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SummaryViewController* SummaryViewControllerObj = [storyboard instantiateViewControllerWithIdentifier:@"SummaryViewController"];
    [self presentViewController:SummaryViewControllerObj animated:true completion:^{
        
    }];
}
@end
