libraryData =
{
  "bmp": {
    "type": "bitmap",
    "version": "2.3.0",
    "linkedClass": "",
    "ext": "png",
    "textureAtlas": null
  },
  "mc": {
    "type": "movieclip",
    "version": "2.3.0",
    "linkedClass": "",
    "autoPlay": true,
    "loop": true,
    "likeButton": false,
    "exportAsSpriteSheet": false,
    "textureAtlas": null,
    "layers": [
      {
        "name": "Layer 3",
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
                "type": "instance",
                "libraryItem": "bmp",
                "name": "",
                "matrix": [
                  0.701766967773438,
                  0,
                  0,
                  0.701766967773438
                ],
                "regX": 152.45,
                "regY": 137.6,
                "blendMode": "normal",
                "meshParams": 0
              }
            ]
          }
        ]
      }
    ]
  },
  "scene": {
    "type": "movieclip",
    "version": "2.3.0",
    "linkedClass": "",
    "autoPlay": true,
    "loop": true,
    "likeButton": false,
    "exportAsSpriteSheet": false,
    "textureAtlas": null,
    "layers": [
      {
        "name": "Layer 1",
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
                "libraryItem": "mc",
                "name": "",
                "matrix": [
                  0.467193603515625,
                  0,
                  0,
                  0.518234252929688
                ],
                "regX": 0,
                "regY": 0,
                "blendMode": "normal",
                "meshParams": 0,
                "filters": [
                  {
                    "name": "DropShadowFilter",
                    "params": {
                      "alpha": 100,
                      "angle": 77.5000028459121,
                      "blurX": 16,
                      "blurY": 16,
                      "color": "#009900",
                      "distance": 18,
                      "hideObject": true,
                      "inner": true,
                      "knockout": true,
                      "quality": 2,
                      "strength": 83
                    }
                  }
                ]
              },
              {
                "type": "instance",
                "libraryItem": "mc",
                "name": "ikNode_3",
                "x": 130,
                "y": 0,
                "matrix": [
                  0.467193603515625,
                  0,
                  0,
                  0.518234252929688
                ],
                "regX": 0,
                "regY": 0,
                "blendMode": "normal",
                "meshParams": 0,
                "filters": [
                  {
                    "name": "BoxBlurFilter",
                    "params": {
                      "blurX": 30,
                      "blurY": 30,
                      "quality": 3
                    }
                  }
                ]
              },
              {
                "type": "instance",
                "libraryItem": "mc",
                "name": "ikNode_1",
                "x": 260,
                "y": 0,
                "matrix": [
                  0.467193603515625,
                  0,
                  0,
                  0.518234252929688
                ],
                "regX": 0,
                "regY": 0,
                "blendMode": "normal",
                "meshParams": 0,
                "filters": [
                  {
                    "name": "GlowFilter",
                    "params": {
                      "alpha": 100,
                      "blurX": 8,
                      "blurY": 8,
                      "color": "#0000FF",
                      "inner": true,
                      "knockout": true,
                      "quality": 2,
                      "strength": 79
                    }
                  }
                ]
              },
              {
                "type": "instance",
                "libraryItem": "mc",
                "name": "ikNode_4",
                "x": 390,
                "y": 0,
                "matrix": [
                  0.467193603515625,
                  0,
                  0,
                  0.518234252929688
                ],
                "regX": 0,
                "regY": 0,
                "blendMode": "normal",
                "meshParams": 0,
                "filters": [
                  {
                    "name": "BevelFilter",
                    "params": {
                      "angle": "49.9999988616352",
                      "highlightColor": "#3300FF",
                      "shadowColor": "#FFFF99"
                    }
                  }
                ]
              },
              {
                "type": "instance",
                "libraryItem": "mc",
                "name": "",
                "x": 0,
                "y": 130,
                "matrix": [
                  0.467193603515625,
                  0,
                  0,
                  0.518234252929688
                ],
                "regX": 0,
                "regY": 0,
                "blendMode": "normal",
                "meshParams": 0,
                "filters": [
                  {
                    "name": "GradientGlowFilter",
                    "params": {
                      "type": "outer"
                    }
                  }
                ]
              },
              {
                "type": "instance",
                "libraryItem": "mc",
                "name": "ikNode_2",
                "x": 130,
                "y": 130,
                "matrix": [
                  0.467193603515625,
                  0,
                  0,
                  0.518234252929688
                ],
                "regX": 0,
                "regY": 0,
                "blendMode": "normal",
                "meshParams": 0,
                "filters": [
                  {
                    "name": "GradientBevelFilter",
                    "params": {}
                  }
                ]
              },
              {
                "type": "instance",
                "libraryItem": "mc",
                "name": "",
                "x": 260,
                "y": 130,
                "matrix": [
                  0.467193603515625,
                  0,
                  0,
                  0.518234252929688
                ],
                "regX": 0,
                "regY": 0,
                "blendMode": "normal",
                "meshParams": 0,
                "filters": [
                  {
                    "name": "AdjustColorFilter",
                    "params": {
                      "brightness": 19,
                      "contrast": 11,
                      "hue": 160,
                      "saturation": -44
                    }
                  }
                ]
              }
            ]
          }
        ]
      }
    ]
  }
}