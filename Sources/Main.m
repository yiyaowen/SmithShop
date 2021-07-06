//
//  Main.m
//  SmithShop
//
//  Created by 玩火的水妖精 on 2021/7/6.
//

@import Cocoa;

#import "AppDelegate.h"

int main(int argc, const char* argv[])
{
    NSApplication* app = [NSApplication sharedApplication];
    
    AppDelegate* delegate = [[AppDelegate alloc] init];
    app.delegate = delegate;
    
    [app run];
    
    return 0;
}
