//
//  MainMenuScene.m
//  SimpleSK
//
//  Created by Justin on 2019/4/3.
//  Copyright © 2019 swcm. All rights reserved.
//

#import "MainMenuScene.h"
#import "FirstScene.h"
#import "CApp.h"
#import "PlayScene.h"
#import "SpaceWarsScene.h"

@implementation MainMenuScene
{
    SKLabelNode *menuFirst;
    SKLabelNode *menuPlay;
    SKLabelNode *menuSpaceWar;
}

- (void)didMoveToView:(SKView *)view
{
    menuFirst = [SKLabelNode labelNodeWithText:@"FirstScene"];
    menuFirst.position = CGPointMake(gScreenSize.width/2,gScreenSize.height-60);
    menuFirst.fontName = @"Chalkduster";
    menuFirst.fontSize = 26;
    menuFirst.fontColor = [SKColor greenColor];
    [self addChild:menuFirst];
    
    menuPlay = [SKLabelNode labelNodeWithText:@"Play Scene"];
    menuPlay.position = CGPointMake(gScreenSize.width/2,menuFirst.frame.origin.y-60);
    menuPlay.fontName = @"Chalkduster";
    menuPlay.fontSize = 26;
    menuPlay.fontColor = [SKColor yellowColor];
    [self addChild:menuPlay];
    
    menuSpaceWar = [SKLabelNode labelNodeWithText:@"Space Wars"];
    menuSpaceWar.position = CGPointMake(gScreenSize.width/2,menuPlay.frame.origin.y-60);
    menuSpaceWar.fontName = @"Chalkduster";
    menuSpaceWar.fontSize = 26;
    menuSpaceWar.fontColor = [SKColor redColor];
    [self addChild:menuSpaceWar];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for(UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"NCShowAlert" object:nil];
        SKTransition *tran = [SKTransition doorwayWithDuration:1];
        if(CGRectContainsPoint(menuFirst.frame, location))
        {
            FirstScene *scene = [FirstScene sceneWithSize:self.size];
            [self.view presentScene:scene transition:tran];
        }
        else if (CGRectContainsPoint(menuPlay.frame, location))
        {
            PlayScene *scene = [PlayScene sceneWithSize:self.size];
            [self.view presentScene:scene transition:tran];
        }
        else if (CGRectContainsPoint(menuSpaceWar.frame, location))
        {
            SpaceWarsScene *scene = [SpaceWarsScene sceneWithSize:self.size];
            scene.backgroundColor = [SKColor blackColor];
            [self.view presentScene:scene transition:tran];
        }
    }
}

@end
