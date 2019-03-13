Shader "Custom/Sample01" {
    SubShader {
        Pass {
            CGPROGRAM

            #pragma vertex vert
            #pragma geometry geom
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata {
                float4 vertex : POSITION;
            };

            struct g2f {
                float4 pos : SV_POSITION;
                float3 normal : TEXCOORD0;
            };

            appdata vert(appdata v) {
                return v;
            }

            [maxvertexcount(3)]
            void geom(triangle appdata input[3], inout TriangleStream<g2f> outStream) {
                float3 edge1 = (input[1].vertex.xyz - input[0].vertex.xyz);
                float3 edge2 = (input[2].vertex.xyz - input[0].vertex.xyz);
                float3 normal = normalize(cross(edge1, edge2));
                
                [unroll]
                for (int i = 0; i < 3; i++) {
                    appdata v = input[i];
                    g2f o;
                    o.pos = UnityObjectToClipPos(v.vertex);
                    o.normal = normal;
                    outStream.Append(o);
                }

                outStream.RestartStrip();
            }

            fixed4 frag(g2f i) : SV_Target {
                return float4(1, 0, 0, 1);
            }

            ENDCG
        }
    }
}