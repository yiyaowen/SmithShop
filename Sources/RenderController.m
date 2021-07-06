//
//  RenderController.m
//  SmithShop
//
//  Created by 玩火的水妖精 on 2021/7/6.
//

@import MetalKit;

#import "RenderController.h"

@implementation RenderController
{
    id<MTLDevice> _device;
    
    id<MTLCommandQueue> _commandQueue;
}

- (nonnull instancetype) initWithMetalKitView: (MTKView *) mtkView
{
    self = [super init];
    if (self)
    {
        _device = mtkView.device;
        
        _commandQueue = [_device newCommandQueue];
    }
    return self;
}

/// Called whenever the view needs to render a frame.
- (void) drawInMTKView: (MTKView *) view
{
    MTLRenderPassDescriptor* renderPassDescriptor = view.currentRenderPassDescriptor;
    if (renderPassDescriptor == nil)
    {
        return;
    }
    
    id<MTLCommandBuffer> commandBuffer = [_commandQueue commandBuffer];
    
    id<MTLRenderCommandEncoder> commandEncoder = [commandBuffer renderCommandEncoderWithDescriptor: renderPassDescriptor];

    [commandEncoder endEncoding];
    
    // The setup here is a little different from DirectX:
    // In DirectX, a swap chain buffer can present its content after committing rendering commands,
    // which is also the common usage. In Metal, however, a different concept, MTLDrawable, is introduced.
    // It seems that the presenting of MTLDrawable is also one part of the rendering commands execution as
    // we can see presentDrawable:xxx is a method of MTLCommandBuffer instead of another independent object.
    // Anyway, the presenting of MTLDrawable should be called before the command buffer has committed.
    id<MTLDrawable> drawable = view.currentDrawable;
    [commandBuffer presentDrawable: drawable];
    
    [commandBuffer commit];
}

/// Called whenever the view resizes or changes orientation.
- (void) mtkView: (MTKView *) view drawableSizeWillChange: (CGSize) size
{
    // TODO
}

@end
