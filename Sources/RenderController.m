//
//  RenderController.m
//  SmithShop
//
//  Created by 玩火的水妖精 on 2021/7/6.
//

@import MetalKit;

#import "RenderController.h"
#import "ShaderTypes.h"

@implementation RenderController
{
    vector_uint2 _viewportSize;
    
    id<MTLDevice> _device;
    
    id<MTLCommandQueue> _commandQueue;
    
    id<MTLRenderPipelineState> _renderPipelineState;
}

- (nonnull instancetype) initWithMetalKitView: (MTKView *) mtkView
{
    self = [super init];
    if (self)
    {
        _device = mtkView.device;
        
        id<MTLLibrary> defaultLibrary = [_device newDefaultLibrary];
        
        id<MTLFunction> vertexFunction = [defaultLibrary newFunctionWithName: @"vertexShader"];
        id<MTLFunction> fragmentFunction = [defaultLibrary newFunctionWithName: @"fragmentShader"];
        
        MTLRenderPipelineDescriptor* renderPipelineStateDescriptor = [[MTLRenderPipelineDescriptor alloc] init];
        renderPipelineStateDescriptor.label = @"Main Render Pipeline State";
        renderPipelineStateDescriptor.vertexFunction = vertexFunction;
        renderPipelineStateDescriptor.fragmentFunction = fragmentFunction;
        renderPipelineStateDescriptor.colorAttachments[0].pixelFormat = mtkView.colorPixelFormat;
        
        NSError* error;
        _renderPipelineState = [_device newRenderPipelineStateWithDescriptor: renderPipelineStateDescriptor error: &error];
        if (_renderPipelineState == nil)
        {
            NSLog(@"Create Render Pipeline State failed.");
            exit(EXIT_FAILURE);
        }
        
        _commandQueue = [_device newCommandQueue];
    }
    return self;
}

/// Called whenever the view needs to render a frame.
- (void) drawInMTKView: (MTKView *) view
{
    static const Vertex triangleVertices[] =
    {
        { {  140, -140 }, { 1, 0, 0, 1 } },
        { { -140, -140 }, { 0, 1, 0, 1 } },
        { {    0,  140 }, { 0, 0, 1, 1 } },
    };
    
    id<MTLCommandBuffer> commandBuffer = [_commandQueue commandBuffer];
    
    MTLRenderPassDescriptor* renderPassDescriptor = view.currentRenderPassDescriptor;
    if (renderPassDescriptor == nil)
    {
        NSLog(@"Read current render pass descriptor failed.");
        exit(EXIT_FAILURE);
    }
        
    id<MTLRenderCommandEncoder> renderCommandEncoder = [commandBuffer renderCommandEncoderWithDescriptor: renderPassDescriptor];
    renderCommandEncoder.label = @"Main Render Command Encoder";
    
    [renderCommandEncoder setViewport: (MTLViewport){ 0, 0, _viewportSize.x, _viewportSize.y, 0, 1 }];
    
    [renderCommandEncoder setRenderPipelineState: _renderPipelineState];
    
    [renderCommandEncoder setVertexBytes: triangleVertices length: sizeof(triangleVertices) atIndex: VertexInputIndexVertices];
    
    [renderCommandEncoder setVertexBytes: &_viewportSize length: sizeof(_viewportSize) atIndex: VertexInputIndexViewportSize];
    
    [renderCommandEncoder drawPrimitives: MTLPrimitiveTypeTriangle vertexStart: 0 vertexCount: 3];

    [renderCommandEncoder endEncoding];
    
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
    _viewportSize.x = size.width;
    _viewportSize.y = size.height;
}

@end
