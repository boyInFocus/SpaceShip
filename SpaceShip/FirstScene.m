//
//  FirstScene.m
//  SimpleSK
//
//  Created by 黃昱翔 on 2019/3/31.
//  Copyright © 2019 swcm. All rights reserved.
//

#import "FirstScene.h"
#import "CApp.h"
#import "MainMenuScene.h"

@implementation FirstScene
{
    SKLabelNode *lbl;
    CGFloat speed;
    NSTimeInterval lastUpdateTime;
}

- (void)didMoveToView:(SKView *)view
{
//    self.backgroundColor = [SKColor darkGrayColor];
//    NSString *msg = [NSString stringWithFormat:@"設備類型(%i),屏幕尺寸(%.1f, %.1f)",gDeviceType,gScreenSize.width,gScreenSize.height];
//    //NSString *msg = [NSString stringWithFormat:@"Hello"];
//    lbl = [SKLabelNode labelNodeWithText:msg];
//    lbl.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
//    lbl.fontSize = 14;
//    [self addChild:lbl];
    
    
    
    CGSize bSize = CGSizeMake(gScreenSize.width,gScreenSize.height/2);
    SKSpriteNode *blueNode = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:bSize];
    blueNode.name = @"blue";
    blueNode.position = CGPointMake(gScreenSize.width/2,gScreenSize.height*0.75);
    [self addChild:blueNode];

    SKSpriteNode *greenNode = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:bSize];
    greenNode.name = @"green";
    greenNode.position = CGPointMake(gScreenSize.width/2, gScreenSize.height/4);
    [self addChild:greenNode];

    SKSpriteNode *redNode = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(50, 50)];
    redNode.name = @"red";
    [blueNode addChild:redNode];
    
    
    speed = 5;
    lbl = [SKLabelNode labelNodeWithText:@"Game Loop"];
    lbl.fontName = @"Chalkduster";
    lbl.position = CGPointMake(gScreenSize.width/2, gScreenSize.height/2);
    [self addChild:lbl];
}

- (void) update:(NSTimeInterval)currentTime
{
    if(currentTime - lastUpdateTime <0.033)
    {
        return; //將FPS設置為大約30
    }
    
    CGFloat lblHeightHalf = lbl.frame.size.height/2;
    if(lbl.position.y <= lblHeightHalf || lbl.position.y >= gScreenSize.height-lblHeightHalf)
    {
        speed = -speed;
    }
    lbl.position = CGPointMake(lbl.position.x, lbl.position.y+speed);
    
    lastUpdateTime = currentTime;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    for(UITouch *touch in touches)
//    {
//        CGPoint location = [touch locationInNode:self];
//        SKSpriteNode *redNode = (SKSpriteNode *)[self childNodeWithName:@"//red"];
//        SKSpriteNode *blueNode = (SKSpriteNode *)[self childNodeWithName:@"//blue"];
//        SKSpriteNode *greenNode = (SKSpriteNode *)[self childNodeWithName:@"//green"];
//        /*
//         /  : 指定會在節點樹的根節點下搜索
//         // : 會搜索整個節點樹
//         .. : 在當前節點的父節點中搜索
//         */
//        if(CGRectContainsPoint(blueNode.frame, location))
//        {
//            [redNode removeFromParent];
//            [blueNode addChild:redNode];
//        }
//        else if(CGRectContainsPoint(greenNode.frame, location))
//        {
//            [redNode removeFromParent];
//            [greenNode addChild:redNode];
//        }
//    }
    for(UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        SKTransition *tran = [SKTransition doorsCloseHorizontalWithDuration:1];
        MainMenuScene *scene = [MainMenuScene sceneWithSize:self.size];
        [self.view presentScene:scene transition:tran];
    }
}
@end
