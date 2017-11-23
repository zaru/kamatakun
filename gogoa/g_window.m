#include "g_window.h"

#include <stdlib.h>
#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

int window_width;
int window_height;
int godzilla_width = 300;
int godzilla_height = 200;

void *NewWindow()
{

  NSWindow* window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, 1000, 1000)
                                            styleMask:NSTitledWindowMask
                                            backing:NSBackingStoreBuffered defer:NO];

  [window setFrame:[[NSScreen mainScreen] visibleFrame] display:YES];
  [window setOpaque:NO];
  [window setHasShadow:NO];
  window.backgroundColor = [NSColor clearColor];
  window.titlebarAppearsTransparent = YES;
  window.titleVisibility = NSWindowTitleHidden;
  window.showsToolbarButton = NO;
  window.styleMask = NSBorderlessWindowMask;

  window_width = window.frame.size.width;
  window_height = window.frame.size.height;

  return window;
}

void MakeKeyAndOrderFront(void *self) {
  NSWindow *window = self;
  [window makeKeyAndOrderFront:nil];

  NSView *view = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, window_width, window_height)];
  [view setWantsLayer:YES];
  view.layer.backgroundColor = [[NSColor redColor] CGColor];

  int rand = arc4random_uniform(2);

  BOOL isFlip = (rand == 0) ? YES : NO;

  NSMutableArray *iconImages = [[NSMutableArray alloc] init];
  // NSString *name = isFlip ? @"kf" : @"k";
  int name = isFlip ? 20 : 10;

  for (int i=1; i<=2; i++) {
    // NSString *imagePath = [NSString stringWithFormat:@"/Users/zaru/xcode/godzilla-sample/godzilla-sample/%@%d.png", name, i];
    // NSImage *image = [[NSImage alloc] initWithContentsOfFile:imagePath];

    // char *filename = [[NSString stringWithFormat:@"%s%d", name, i] UTF8String];
    // NSURL *url = [NSURL URLWithString: [NSString stringWithCString: GetResources(@"f1") encoding:NSUTF8StringEncoding]];

    int filename = name + i;
    // char *filename = [[NSString stringWithFormat:@"%s%d", name, i] UTF8String];
    // NSString *filename = [NSString stringWithFormat:@"%s%d", name, i];
    NSURL *url = [NSURL URLWithString: GetResources(filename)];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    NSImage *image = [[NSImage alloc] initWithData:imageData];
    [iconImages addObject:(id)image];
  }

  CALayer *layer = [CALayer layer];
  CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
  [animation setCalculationMode:kCAAnimationDiscrete];
  [animation setDuration:0.5f];
  [animation setRepeatCount:HUGE_VALF];
  [animation setValues:iconImages];

  [layer setFrame:NSMakeRect(0, 0, godzilla_width, godzilla_height)];
  layer.bounds = NSMakeRect(0, 0, godzilla_width, godzilla_height);

  [layer addAnimation:animation forKey:@"contents"];
  [view setLayer:[CALayer layer]];
  [view setWantsLayer:YES];
  [view.layer addSublayer:layer];

  [CATransaction begin];
  [CATransaction setCompletionBlock:^{
  }];

  CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position.x"];
  if (isFlip) {
    animation1.fromValue = @0.0f;
    animation1.toValue = [NSNumber numberWithFloat: window_width];
  } else {
    animation1.fromValue = [NSNumber numberWithFloat: window_width];
    animation1.toValue = [NSNumber numberWithFloat: 0 - godzilla_width];
  }

  CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position.y"];
  animation2.fromValue = @0.0f;
  animation2.toValue = @100.0f;
  animation2.beginTime = 1.0;
  animation2.duration = 0.2;
  animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

  CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"position.y"];
  animation3.fromValue = @100.0f;
  animation3.toValue = @0.0f;
  animation3.beginTime = 1.2;
  animation3.duration = 0.3;
  animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];

  CAAnimationGroup *group = [CAAnimationGroup animation];
  group.duration = 5.0;
  group.repeatCount = HUGE_VALF;
  group.removedOnCompletion = NO;
  group.fillMode = kCAFillModeForwards;

  // 逆再生オプション
  //group.autoreverses = YES;

  group.animations = @[animation1, animation2, animation3];
  [view.layer addAnimation:group forKey:@"group-animation-test"];
  [CATransaction commit];

  [window.contentView addSubview:view];
}
