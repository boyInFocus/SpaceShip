//
//  PlayScene.m
//  SimpleSK
//
//  Created by Justin on 2019/4/6.
//  Copyright © 2019 swcm. All rights reserved.
//

#import "PlayScene.h"
#import "MainMenuScene.h"

@implementation PlayScene
{
    BOOL isReady;
    SKSpriteNode *spaceship;
}

-(void)didMoveToView:(SKView *)view
{
    if(!isReady)
    {
        spaceship = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship.png"];
        spaceship.size = CGSizeMake(64, 64);
        spaceship.position = CGPointMake(self.size.width/2,self.size.height/4);
        [self addChild:spaceship];
        
        SKSpriteNode *light = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(3,3)];
        light.zPosition = 9;
        SKAction *aHide = [SKAction fadeOutWithDuration:0.5];
        SKAction *aShow = [SKAction fadeInWithDuration:0.5];
        [light runAction:[SKAction repeatActionForever:[SKAction sequence:@[aHide,aShow]]]];
        [spaceship addChild:light];
        
        SKTexture *ttrock = [SKTexture textureWithImageNamed:@"planet.png"];
        SKTexture *ttrock1 = [SKTexture textureWithRect:CGRectMake(0, 0, 0.125, 1) inTexture:ttrock];
        SKTexture *ttrock2 = [SKTexture textureWithRect:CGRectMake(0.125, 0, 0.125, 1) inTexture:ttrock];
        SKTexture *ttrock3 = [SKTexture textureWithRect:CGRectMake(0.25, 0, 0.125, 1) inTexture:ttrock];
        SKTexture *ttrock4 = [SKTexture textureWithRect:CGRectMake(0.375, 0, 0.125, 1) inTexture:ttrock];
        SKTexture *ttrock5 = [SKTexture textureWithRect:CGRectMake(0.5, 0, 0.125, 1) inTexture:ttrock];
        SKTexture *ttrock6 = [SKTexture textureWithRect:CGRectMake(0.625, 0, 0.125, 1) inTexture:ttrock];
        SKTexture *ttrock7 = [SKTexture textureWithRect:CGRectMake(0.75, 0, 0.125, 1) inTexture:ttrock];
        SKTexture *ttrock8 = [SKTexture textureWithRect:CGRectMake(0.875, 0, 0.125, 1) inTexture:ttrock];
        
        SKSpriteNode *rock = [SKSpriteNode spriteNodeWithTexture:ttrock1 size:CGSizeMake(40, 40)];
        rock.position = CGPointMake(self.size.width*0.5, self.size.height*0.75);
        [self addChild:rock];
        
        NSArray *rockArr = @[ttrock1,ttrock2,ttrock3,ttrock4,ttrock5,ttrock6,ttrock7,ttrock8];
        SKAction *ani =  [SKAction animateWithTextures:rockArr timePerFrame:0.2];
        SKAction *repeatAni = [SKAction repeatActionForever:ani];
        [rock runAction:repeatAni];
        
        SKSpriteNode *rocks[3];
        int rockCount = 3;
        for(int i=0;i<rockCount;i++)
        {
            rocks[i] = [rock copy];
        }
        rocks[0].position = CGPointMake(self.size.width*0.25, self.size.height*0.75);
        rocks[1].position = CGPointMake(self.size.width*0.75, self.size.height*0.75);
        rocks[2].position = CGPointMake(self.size.width*0.5, self.size.height*0.6);
        for(int i=0;i<rockCount;i++)
        {
            [self addChild:rocks[i]];
        }
        
        isReady = YES;
    }
}
@end
