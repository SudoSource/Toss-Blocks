//
//  GPSlider.h
//  GPSlider
//
//  Created by Caleb Wren + Connor on 6/1/10.
//  Copyright 2010 Wrensation + Web-Geeks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum{
	kSliderHorizontal,
	kSliderVertical,
} kSliderTypes;

@interface GPSlider : CCLayer {
	NSString *rail, *knob, *knobsel;
	kSliderTypes type;
	CCSprite *rails, *knobs;
	float value, width, min, max;
	BOOL isDragging, active, spritesheet;
	int t;
}

@property (nonatomic, retain ,readonly)	NSString *rail, *knob;
@property (nonatomic,retain) NSString *knobsel;
@property (nonatomic) kSliderTypes type;
@property (nonatomic) float value, width, min, max;
@property (readonly) BOOL isDragging;
@property BOOL active;


+(id) sliderWithRail:(NSString *)r knob:(NSString *)k;
-(id) initSliderWithRail:(NSString *)r knob:(NSString *)k;
+(id) sliderWithRailFrame:(NSString *)r knobFrame:(NSString *)k;
-(id) initSliderWithRailFrame:(NSString *)r knobFrame:(NSString *)k;

-(void) hide;
-(void) show;
-(void) setTransparency:(float)trans;

@end
