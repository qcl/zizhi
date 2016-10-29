//
//  SecondViewController.m
//  zizhi-sample
//
//  Created by Qing-Cheng Li on 2016/10/10.
//  Copyright © 2016年 QCLS. All rights reserved.
//

#import "SecondViewController.h"

typedef NS_ENUM(NSUInteger, BananaViewState)
{
    BananaViewNormal,
    BananaViewMenu,
    BananaViewApprise,
};

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UILabel *appriseLabel;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIButton *appriseButton;
@property (weak, nonatomic) IBOutlet UIImageView *pokemonBackgroundView;

@property (assign, nonatomic) BananaViewState currentState;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.pokemonBackgroundView.image = [UIImage imageNamed:@"banana"];
    self.pokemonBackgroundView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(screenViewDidTap:)];
    [self.pokemonBackgroundView addGestureRecognizer:tap];

    [self.appriseButton setTitle:@" " forState:UIControlStateNormal];
    self.appriseButton.accessibilityLabel = @"apprise";

    [self.menuButton setTitle:@" " forState:UIControlStateNormal];
    self.menuButton.accessibilityLabel = @"menu";
    
    [self setState:BananaViewNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setState:BananaViewNormal];
}

- (void)setState:(BananaViewState)state
{
    self.currentState = state;
    switch (state) {
        case BananaViewMenu:
            self.appriseLabel.hidden = YES;
            self.menuButton.userInteractionEnabled = YES;
            self.menuButton.hidden = NO;
            self.appriseButton.hidden = NO;
            self.appriseButton.userInteractionEnabled = YES;
            self.pokemonBackgroundView.image = [UIImage imageNamed:@"menu"];
            break;
        case BananaViewApprise:
            self.appriseLabel.hidden = NO;
            self.menuButton.userInteractionEnabled = NO;
            self.menuButton.hidden = YES;
            self.appriseButton.hidden = YES;
            self.appriseButton.userInteractionEnabled = NO;
            self.pokemonBackgroundView.image = [UIImage imageNamed:@"apprise"];
            break;
        case BananaViewNormal:
        default:
            self.appriseLabel.hidden = YES;
            self.menuButton.userInteractionEnabled = YES;
            self.menuButton.hidden = NO;
            self.appriseButton.hidden = YES;
            self.appriseButton.userInteractionEnabled = NO;
            self.pokemonBackgroundView.image = [UIImage imageNamed:@"banana"];
            break;
    }
}

- (IBAction)appriseButtonDidTap:(id)sender
{
    //[self setState:BananaViewApprise];
}

- (IBAction)menuButtonDidTap:(id)sender
{
    if (self.currentState == BananaViewMenu) {
        [self setState:BananaViewNormal];
    } else {
        [self setState:BananaViewMenu];
    }
}

- (void)screenViewDidTap:(UIGestureRecognizer *)gestureRecognizer
{
    [self setState:BananaViewNormal];
}

@end
