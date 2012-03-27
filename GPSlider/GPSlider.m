//
//  GPSlider.m
//  GPSlider
//
//  Created by Caleb Wren + Connor on 6/1/10.
//  Copyright 2010 Wrensation + Web-Geeks. All rights reserved.
//

#import "GPSlider.h"

@implementation GPSlider
@synthesize rail, knob, knobsel, isDragging, active, width, min, max, type, value;

+(id) sliderWithRail:(NSString *)r knob:(NSString *)k {
	return [[[self alloc] initSliderWithRail:r knob:k] autorelease];
}

-(id) initSliderWithRail:(NSString *)r knob:(NSString *)k {
	if ((self = [super init])) {
		self.isTouchEnabled = YES;
		isDragging = NO;
		active = YES;
		rail = r;
		knob = k;
		knobsel = k;
		knobs = [CCSprite spriteWithFile:knob];
		rails = [CCSprite spriteWithFile:rail];
		[self addChild:knobs z:1];
		[self addChild:rails z:0];
		width = rails.boundingBox.size.width;
		spritesheet = NO;
		type = kSliderHorizontal;
		min = 0;
		max = 100;
	}
	return self;
}
+(id) sliderWithRailFrame:(NSString *)r knobFrame:(NSString *)k {
	return [[[self alloc] initSliderWithRail:r knob:k] autorelease];
}
-(id) initSliderWithRailFrame:(NSString *)r knobFrame:(NSString *)k{
	if ((self = [super init])) {
		isDragging = NO;
		active = YES;
		rail = r;
		knob = k;
		knobsel = k;
		knobs = [CCSprite spriteWithSpriteFrameName:knob];
		rails = [CCSprite spriteWithSpriteFrameName:rail];
		[self addChild:knobs z:1];
		[self addChild:rails z:0];
		width = rails.boundingBox.size.width;
		spritesheet = YES;
		type = kSliderHorizontal;
		min = 0;
		max = 100;
	}
	return self;
}
-(void) setScale:(float)sca {
	knobs.scale = sca;
	rails.scale = sca;
	width = rails.boundingBox.size.width;
}
-(void) setPosition:(CGPoint)pos {
	knobs.position = pos;
	rails.position = pos;
	[self setValue:value];
}
-(void) setRotation:(float)rot {
	
}
-(void) setValue:(float)val {
	if (type == kSliderHorizontal) {
		knobs.position = ccp((rails.position.x - (width-16) / 2) + val * ((width-16) / (max - min)), rails.position.y);
		value = (((max - min) / 100) * (100 - ((((rails.position.x - knobs.position.x) + (width-16) / 2) / width) * 100))) + min; 
	}
	else if (type == kSliderVertical) {
		knobs.position = ccp(rails.position.x, (rails.position.y - (width-16) / 2) + val * (width-16) / (max - min));
		value = (((max - min) / 100) * (100 - ((((rails.position.y - knobs.position.y) + (width-16) / 2) / width) * 100))) + min; 
	}
}
-(void) setType:(kSliderTypes)typ {
	type = typ;
	if (type == kSliderHorizontal) {
		knobs.rotation = 0;
		rails.rotation = 0;
	}
	if (type == kSliderVertical) {
		knobs.rotation = 90;
		rails.rotation = 90;
	}
	[self setValue:value];
}
-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if (active) {
		for (UITouch *touch in touches) {
			CGPoint location = [touch locationInView:[touch view]];
			location = [[CCDirector sharedDirector] convertToGL:location];
			if (type == kSliderHorizontal && location.x > (rails.position.x - (width-16) / 2) && location.x < (rails.position.x + (width-16) / 2) + 5 && location.y > rails.position.y - rails.boundingBox.size.height / 2 && location.y < rails.position.y + rails.boundingBox.size.height / 2) {
				t = (int)touch;
				isDragging = YES;
				
				if (!spritesheet) {
					knobs.texture = [[CCTextureCache sharedTextureCache] addImage:knobsel];
				}
				else {
					CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:knobsel];
					[knobs setDisplayFrame:frame];
				}
				
				knobs.position = ccp(location.x, rails.position.y);
				value = (100 - ((((rails.position.x - knobs.position.x) + (width-16) / 2) / (width-16)) * 100)); 
				
			}
//			if (type == kSliderVertical && location.y > (rails.position.y - (width-16)/2) && location.y < (rails.position.y + (width-16)/2) && location.x > rails.position.x - rails.boundingBox.size.width / 2 && location.x < rails.position.x + rails.boundingBox.size.width / 2) {
//				t = (int)touch;
//				isDragging = YES;
//				
//				if (!spritesheet) {
//					knobs.texture = [[CCTextureCache sharedTextureCache] addImage:knobsel];
//				}
//				else {
//					CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:knobsel];
//					[knobs setDisplayFrame:frame];
//				}
//				
//				knobs.position = ccp(rails.position.x, location.y);
//				value = (((max - min) / 100) * (100 - ((((rails.position.y - knobs.position.y) + (width-16)/2) / (width-16)) * 100))) + min; 
//			}
		}
	}
}
-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	if (active) {
		for (UITouch *touch in touches) {
			CGPoint location = [touch locationInView:[touch view]];
			location = [[CCDirector sharedDirector] convertToGL:location];
			if (type == kSliderHorizontal && (int)touch == t && location.x > (rails.position.x - (width-16)/2) && location.x < (rails.position.x + (width-16)/2)) {
				
				knobs.position = ccp(location.x, knobs.position.y);
				value = (100 - ((((rails.position.x - knobs.position.x) + (width-16) / 2) / (width-16)) * 100)); 
				if (value < min) {
					value = min;
				}
				if (value > max) {
					value = max;
				}
			}
			else if (type == kSliderHorizontal && (int)touch == t && location.x > (rails.position.x + (width-16) / 2)) {
				value = max; 
				knobs.position = ccp((rails.position.x + (width-16)/2), rails.position.y);
			}
			else if (type == kSliderHorizontal && (int)touch == t && location.x < (rails.position.x - (width-16) / 2)) {
				value = min;
				knobs.position = ccp((rails.position.x - (width-16)/2), rails.position.y);
			}
			
//			if (type == kSliderVertical && (int)touch == t && location.y > (rails.position.y - (width-16)/2) && location.y < (rails.position.y + (width-16)/2)) {
//				knobs.position = ccp(rails.position.x, location.y);
//				value = (((max - min) / 100) * (100 - ((((rails.position.y - knobs.position.y) + (width-16) / 2) / (width-16)) * 100))) + min; 
//				if (value < min) {
//					value = min;
//				}
//				if (value > max) {
//					value = max;
//				}
//			}
//			else if (type == kSliderVertical && (int)touch == t && location.y > (rails.position.y + width/2)) {
//				value = max; 
//				knobs.position = ccp(rails.position.x, (rails.position.y + (width-16)/2));
//			}
//			else if (type == kSliderVertical && (int)touch == t && location.y < (rails.position.y - width/2)) {
//				value = min;
//				knobs.position = ccp(rails.position.x, (rails.position.y - (width-16)/2));
//			}
		}
	}
}
-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	if (active) {
		for (UITouch *touch in touches) {
			if ((int)touch == t) {
				t = -1;
				isDragging = NO;
				if (!spritesheet) {
					knobs.texture = [[CCTextureCache sharedTextureCache] addImage:knob];
				}
				else {
					CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:knob];
					[knobs setDisplayFrame:frame];
				}
			}
		}
	}
}
-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
	if (active) {
		for (UITouch *touch in touches) {
			if ((int)touch == t) {
				t = -1;
				isDragging = NO;
				if (!spritesheet) {
					knobs.texture = [[CCTextureCache sharedTextureCache] addImage:knob];
				}
				else {
					CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:knob];
					[knobs setDisplayFrame:frame];
				}
			}
		}
	}
}
-(void) setTransparency:(float)trans {
	if (trans > 0 && trans <= 255) {
		knobs.opacity = trans;
		rails.opacity = trans;
		active = YES;
	}
	else if (trans < 0) {
		NSLog(@"Transparency must be greater than 0.");
	}
	else if (trans == 0) {
		knobs.opacity = 0;
		rails.opacity = 0;
	}
	else if (trans > 255) {
		NSLog(@"Transparency must be less than or equal to 255.");
	}
}
-(void) show {
	knobs.opacity = 255;
	rails.opacity = 255;
	active = YES;
}
-(void) hide {
	knobs.opacity = 0;
	rails.opacity = 0;
	active = NO;
}
-(void) dealloc {
	[super dealloc];
}

@end
