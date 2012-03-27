//
//  TBParticleExplosion.h
//  Toss Blocks
//
//  Created by Connor on 1/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface TBParticleExplosion : CCParticleExplosion {
	
}

+ (id) explosionWithColor:(NSString *)c;
- (id) initExplosionWithColor:(NSString *)c;

@end
