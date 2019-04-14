//
//  SpaceWarsScene.m
//  SimpleSK
//
//  Created by Justin on 2019/4/7.
//  Copyright © 2019 swcm. All rights reserved.
//

#import "SpaceWarsScene.h"
#import "MainMenuScene.h"
#import "CApp.h"

#define RockCount 10
#define StatePlaying 1
#define StateStop 0

@implementation SpaceWarsScene
{
    BOOL isReady;
    SKSpriteNode *spaceship;
    SKSpriteNode *rocks[RockCount];
    CGFloat rockSpeed[RockCount];
    CGPoint touchBeganPoint; //開始觸摸的位置
    CGPoint spaceshipPoint; //用於記錄太空船的位置
    int gameState;
}

-(void)creatNodes
{
    for(int i=0; i<RockCount; i++)
    {
        rockSpeed[i] = arc4random()%3 +1; //速度1~3
        //iPad加倍
        if(gDeviceType == DT_IPAD)
        {
            rockSpeed[i]*=2;
        }
    }
    //根據設備類型設置
    CGSize baseSize = CGSizeMake(64,64);
    if(gDeviceType == DT_IPAD)
    {
        baseSize = CGSizeMake(128, 128);
    }
    
    SKTexture *tt = [SKTexture textureWithImageNamed:@"Spaceship.png"];
    spaceship = [SKSpriteNode spriteNodeWithTexture:tt size:baseSize];
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
    
    rocks[0] = [SKSpriteNode spriteNodeWithTexture:ttrock1 size:CGSizeMake(baseSize.width/2, baseSize.height/2)];
    [self addChild:rocks[0]];
    
    NSArray *rockArr = @[ttrock1,ttrock2,ttrock3,ttrock4,ttrock5,ttrock6,ttrock7,ttrock8];
    SKAction *ani = [SKAction animateWithTextures:rockArr timePerFrame:0.2];
    SKAction *repeatAni = [SKAction repeatActionForever:ani];
    [rocks[0] runAction:repeatAni];
    
    //更多的小行星
    for(int i=1; i<RockCount; i++)
    {
        rocks[i] = [rocks[0] copy];
        rocks[i].xScale = rocks[i].yScale = (arc4random()%4+6)/10.0;
        [self addChild:rocks[i]];
    }
}

- (void)nodesPosition
{
    //初始化位置
    spaceship.position = CGPointMake(self.size.width/2, self.size.height/4);
    int minY = (int)(self.size.height*0.7);
    for(int i=0;i<RockCount;i++)
    {
        rocks[i].position = CGPointMake(arc4random()%(int)self.size.width, arc4random()%300+minY);
    }
}

- (void)didMoveToView:(SKView *)view
{
    if(!isReady)
    {
        [self creatNodes];
        [self nodesPosition];
        isReady = YES;
        
    }
}

-(void)update:(NSTimeInterval)currentTime
{
    //如果不是在遊戲，就什麼也不執行
    if(gameState == StateStop) return;
    
    for(int i=0;i<RockCount;i++)
    {
        //碰撞測試
        if([self collisionCheck:spaceship.frame withRect:rocks[i].frame])
        {
            gameState = StateStop;
            [self nodesPosition];
            return;
        }
        //往下移動
        rocks[i].position = CGPointMake(rocks[i].position.x, rocks[i].position.y-rockSpeed[i]);
        
        //底部消失
        if(rocks[i].position.y<0-rocks[i].size.height)
        {
            rocks[i].position = CGPointMake(arc4random()%(int)self.size.width,arc4random()%100+self.size.height);
        }
    }
}

//圓心碰撞檢測法
- (BOOL) collisionCheck:(CGRect)rect1 withRect:(CGRect)rect2
{
    //兩圓半徑
    CGFloat r1 = rect1.size.width/2;
    CGFloat r2 = rect2.size.width/2;
    //兩圓圓心座標
    CGPoint coc1 = CGPointMake(rect1.origin.x+r1,rect1.origin.y+r1);
    CGPoint coc2 = CGPointMake(rect2.origin.x+r2,rect2.origin.y+r2);
    
    //圓心距離
    CGFloat xx = coc1.x - coc2.x; //直角橫向邊長
    CGFloat yy = coc1.y - coc2.y; //直角豎向邊長
    CGFloat distance = sqrt(xx*xx+yy*yy); //三角形斜邊 即圓心距離
    return (distance<(r1+r2)*0.75);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for(UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        if(gameState == StateStop)
        {
            gameState = StatePlaying;
        }
        touchBeganPoint = location;
        spaceshipPoint = spaceship.position;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for(UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        CGFloat xOffset = location.x - touchBeganPoint.x;
        CGFloat yOffset = location.y - touchBeganPoint.y;
        //太空船的位置
        CGFloat curX = spaceshipPoint.x+xOffset;
        CGFloat curY = spaceshipPoint.y+yOffset;
        CGFloat ssSize_2 = spaceship.size.width/2;
        if(curX<ssSize_2)
        {
            curX = ssSize_2;
        }
        else if (curX>self.size.width-ssSize_2)
        {
            curX = self.size.width - ssSize_2;
        }
        if(curY<ssSize_2)
        {
            curY = ssSize_2;
        }
        else if (curY>self.size.height - ssSize_2)
        {
            curY = self.size.height - ssSize_2;
        }
        spaceship.position = CGPointMake(curX, curY);
    }
}
@end
