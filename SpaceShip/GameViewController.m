//
//  GameViewController.m
//  SimpleSK
//
//  Created by 黃昱翔 on 2019/3/28.
//  Copyright © 2019 swcm. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //項目初始化
    deviceInit();
    
    // Load the SKScene from 'GameScene.sks'
    //GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    FirstScene *scene = [FirstScene sceneWithSize:CGSizeMake(320, 568)];
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:scene];
    
    skView.showsFPS = YES; //是否顯示每秒的幀數
    skView.showsNodeCount = YES; //是否顯示節點數量
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAlertAction:) name:@"NCShowAlert" object:nil];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)showAlertAction:(NSNotification *)notification
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    
    if(gDeviceType == DT_IPAD)
    {
        UIPopoverPresentationController *pop = alert.popoverPresentationController;
        pop.sourceView = self.view;
        CGRect r = alert.accessibilityFrame;
        pop.sourceRect = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, r.size.width, r.size.height);
    }
    [self presentViewController:alert animated:YES completion:nil];
}

@end
