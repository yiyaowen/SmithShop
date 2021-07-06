//
//  WindowViewController.m
//  SmithShop
//
//  Created by 玩火的水妖精 on 2021/7/6.
//

#import "RenderController.h"
#import "WindowViewController.h"

@implementation WindowViewController
{
    MTKView* _mtkView;
    
    RenderController* _renderController;
}

- (void) initRenderMatters
{
    _mtkView = (MTKView *)self.view;
    
    _mtkView.enableSetNeedsDisplay = YES;
    
    _mtkView.device = MTLCreateSystemDefaultDevice();
    
    _mtkView.clearColor = MTLClearColorMake(176 / 255.0, 196 / 255.0, 222 / 255.0, 1.0);
    
    _renderController = [[RenderController alloc] initWithMetalKitView: _mtkView];
    if (_renderController == nil)
    {
        NSLog(@"Create Render Controller failed.");
        return;
    }
    
    [_renderController mtkView: _mtkView drawableSizeWillChange: _mtkView.drawableSize];
    
    _mtkView.delegate = _renderController;
}

@end
