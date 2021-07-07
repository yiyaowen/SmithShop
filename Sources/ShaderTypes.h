//
//  ShaderTypes.h
//  SmithShop
//
//  Created by 玩火的水妖精 on 2021/7/7.
//

// Due to ShaderTypes.h would be included by other metal shader files that use
// C/C++ including grammer, a traditional including check should be added here.
#ifndef SHADER_TYPES_H
#define SHADER_TYPES_H

#include <simd/simd.h>

enum VertexInputIndex
{
    VertexInputIndexVertices = 0,
    VertexInputIndexViewportSize = 1,
};

typedef struct Vertex
{
    vector_float2 position;
    vector_float4 color;
} Vertex;

#endif
