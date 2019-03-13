Shader "Custom/Sample" {
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
                float4 vertex : SV_POSITION;
            };

            appdata vert(appdata v) {
                return v;
            }

            [maxvertexcount(3)]
            void geom(triangle appdata input[3], inout TriangleStream<g2f> outStream) {
                [unroll]
                for (int i = 0; i < 3; i++) {
                    appdata v = input[i];
                    g2f o;
                    o.vertex = UnityObjectToClipPos(v.vertex);
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