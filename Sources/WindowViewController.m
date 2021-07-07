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
    
    _mtkView.clearColor = MTLClearColorMake(0.08, 0.08, 0.08, 1.0);
    
    _renderController = [[RenderController alloc] initWithMetalKitView: _mtkView];
    if (_renderController == nil)
    {
        NSLog(@"Create Render Controller failed.");
        exit(EXIT_FAILURE);
    }
    
    [_renderController mtkView: _mtkView drawableSizeWillChange: _mtkView.drawableSize];
    
    _mtkView.delegate = _renderController;
}

@end
