//
//  MainShaders.metal
//  SmithShop
//
//  Created by 玩火的水妖精 on 2021/7/7.
//

#include <metal_stdlib>

using namespace metal;

#include "ShaderTypes.h"

struct RasterizerData
{
    float4 position [[position]];
    
    float4 color;
};

vertex RasterizerData vertexShader(
    uint vertexID [[vertex_id]],
    constant Vertex* vertices [[buffer(VertexInputIndexVertices)]],
    constant vector_uint2* viewportSize [[buffer(VertexInputIndexViewportSize)]])
{
    RasterizerData out;
    
    float2 pixelSpacePosition = vertices[vertexID].position.xy;
    
    vector_float2 viewportSizeF = vector_float2(*viewportSize);
    
    out.position = vector_float4(0.0, 0.0, 0.0, 1.0);
    // An interesting problem:
    // According to Apple Metal documentation, the normalized device coordinates in Metal
    // range from left-bottom (-1.0, -1.0) to right-top (1.0, 1.0), which means the pixel
    // space position should be divided by half viewport size. However, it does not work
    // well. For example, vertex (0, 300) is not at the middle-top of a window (800, 600).
    // A temporary solution is simply divide the pixel space position by 4 rather than 2.
    //out.position.xy = pixelSpacePosition / (viewportSizeF / 2.0);
    out.position.xy = pixelSpacePosition / (viewportSizeF / 4.0);
    
    out.color = vertices[vertexID].color;
    
    return out;
}

fragment float4 fragmentShader(RasterizerData in [[stage_in]])
{
    return in.color;
}
