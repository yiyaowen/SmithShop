//
//  AppDelegate.m
//  SmithShop
//
//  Created by 玩火的水妖精 on 2021/7/6.
//

#import "AppDelegate.h"
#import "WindowViewController.h"

@implementation AppDelegate
{
    NSWindow* _window;
}

- (void) applicationDidFinishLaunching: (NSNotification *) notification
{
    NSRect rect = NSMakeRect(100, 100, 800, 600);
    NSWindowStyleMask style = NSWindowStyleMaskClosable | NSWindowStyleMaskResizable | NSWindowStyleMaskTitled | NSWindowStyleMaskMiniaturizable;
    
    _window = [[NSWindow alloc] initWithContentRect: rect styleMask: style backing: NSBackingStoreBuffered defer: NO];
    
    MTKView* mtkView = [[MTKView alloc] initWithFrame: rect];
    
    WindowViewController* controller = [[WindowViewController alloc] init];
    controller.view = mtkView;
    
    _window.contentView = mtkView;
    _window.contentViewController = controller;
    
    [controller initRenderMatters];
    
    [_window makeKeyAndOrderFront: _window];
}

@end
