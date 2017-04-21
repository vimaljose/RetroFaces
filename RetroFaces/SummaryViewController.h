//
//  SummaryViewController.h
//  RetroFaces
//
//  Created by Apple on 21/04/17.
//  Copyright © 2017 Armor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummaryViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnSmileys;
- (IBAction)btnClosePressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnReset;
- (IBAction)btnResetPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;


@end
