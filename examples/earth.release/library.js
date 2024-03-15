libraryData =
{
  "earth": {
    "type": "mesh",
    "version": "2.3.0",
    "linkedClass": "",
    "textureAtlas": null,
    "renderAreaSize": 256,
    "loadLights": false
  },
  "scene": {
    "type": "movieclip",
    "version": "2.3.0",
    "linkedClass": "MySceneClass",
    "autoPlay": true,
    "loop": true,
    "layers": [
      {
        "name": "2D",
        "type": "normal",
        "visible": true,
        "locked": false,
        "keyFrames": [
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": [
              {
                "type": "shape"
              },
              {
                "type": "text",
                "name": "",
                "x": 2,
                "y": 2,
                "matrix": [
                  1.00352300629871,
                  0,
                  0,
                  1
                ],
                "regX": 0,
                "regY": 0,
                "width": 97.54296875,
                "height": 18,
                "selectable": false,
                "border": false,
                "newTextFormat": {
                  "characters": "",
                  "fillColor": "#000000",
                  "align": "left",
                  "size": 12,
                  "style": "",
                  "family": "Times",
                  "strokeSize": 0,
                  "strokeColor": "#000000",
                  "kerning": true,
                  "letterSpacing": 0,
                  "lineSpacing": 2
                },
                "textRuns": [
                  {
                    "characters": "ThreeJS Renderer:",
                    "fillColor": "#000000",
                    "align": "left",
                    "size": 11,
                    "style": "",
                    "family": "Arial",
                    "strokeSize": 0,
                    "strokeColor": "#000000",
                    "kerning": true,
                    "letterSpacing": 0,
                    "lineSpacing": 2
                  }
                ]
              },
              {
                "type": "text",
                "name": "txtRenderer",
                "x": 98,
                "y": 2,
                "matrix": [
                  1.12302728755,
                  0,
                  0,
                  1
                ],
                "regX": 0,
                "regY": 0,
                "width": 121.1,
                "height": 18,
                "selectable": false,
                "border": false,
                "newTextFormat": {
                  "characters": "",
                  "fillColor": "#000000",
                  "align": "left",
                  "size": 11,
                  "style": "",
                  "family": "Arial",
                  "strokeSize": 0,
                  "strokeColor": "#000000",
                  "kerning": true,
                  "letterSpacing": 0,
                  "lineSpacing": 2
                },
                "textRuns": []
              },
              {
                "type": "text",
                "name": "",
                "x": 450,
                "y": 2,
                "matrix": [
                  1.02439022007476,
                  0,
                  0,
                  1
                ],
                "regX": 0,
                "regY": 0,
                "width": 28.44921875,
                "height": 18,
                "selectable": false,
                "border": false,
                "newTextFormat": {
                  "characters": "",
                  "fillColor": "#000000",
                  "align": "left",
                  "size": 12,
                  "style": "",
                  "family": "Times",
                  "strokeSize": 0,
                  "strokeColor": "#000000",
                  "kerning": true,
                  "letterSpacing": 0,
                  "lineSpacing": 2
                },
                "textRuns": [
                  {
                    "characters": "FPS:",
                    "fillColor": "#000000",
                    "align": "left",
                    "size": 11,
                    "style": "",
                    "family": "Arial",
                    "strokeSize": 0,
                    "strokeColor": "#000000",
                    "kerning": true,
                    "letterSpacing": 0,
                    "lineSpacing": 2
                  }
                ]
              },
              {
                "type": "text",
                "name": "txtFPS",
                "x": 477,
                "y": 2,
                "matrix": [
                  0.99503219806479,
                  0,
                  0,
                  1
                ],
                "regX": 0,
                "regY": 0,
                "width": 36.1797337513453,
                "height": 18,
                "selectable": false,
                "border": false,
                "newTextFormat": {
                  "characters": "",
                  "fillColor": "#000000",
                  "align": "left",
                  "size": 11,
                  "style": "",
                  "family": "Arial",
                  "strokeSize": 0,
                  "strokeColor": "#000000",
                  "kerning": true,
                  "letterSpacing": 0,
                  "lineSpacing": 2
                },
                "textRuns": []
              }
            ]
          }
        ]
      },
      {
        "name": "3D",
        "type": "normal",
        "visible": true,
        "locked": false,
        "keyFrames": [
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": [
              {
                "type": "shape"
              },
              {
                "type": "instance",
                "libraryItem": "earth",
                "name": "myEarth",
                "x": 260,
                "y": 190,
                "regX": 0,
                "regY": 0,
                "meshParams": {
                  "rotationX": 0,
                  "rotationY": 0,
                  "cameraFov": 70,
                  "ambientLightColor": "#E0E0E0",
                  "directionalLightColor": "#808080",
                  "directionalLightRotationX": 0,
                  "directionalLightRotationY": 0
                }
              }
            ]
          }
        ]
      }
    ]
  }
}