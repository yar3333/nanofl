libraryData =
{
  "letter": {
    "type": "movieclip",
    "version": "2.3.0",
    "linkedClass": "",
    "autoPlay": true,
    "loop": true,
    "likeButton": false,
    "exportAsSprite": false,
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
                "type": "shape",
                "regX": 0,
                "regY": 0,
                "fills": [
                  {
                    "type": "solid",
                    "color": "#FFFFFF"
                  },
                  {
                    "type": "solid",
                    "color": "#000000"
                  }
                ],
                "strokes": [
                  {
                    "type": "solid",
                    "color": "#7C0101",
                    "thickness": 1,
                    "caps": "round",
                    "joints": "round",
                    "miterLimit": 3,
                    "ignoreScale": false
                  }
                ],
                "figure": {
                  "edges": [
                    {
                      "strokeIndex": 0,
                      "edges": "M-104.95,-61.5L105,-61.5L105,61.5L-104.95,61.5L-104.95,-61.5"
                    }
                  ],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M22.45,-15.1C22.45,-21.75,18.4,-26.55C14.35,-31.3,8.55,-33.1C2.7,-34.9,-9.5,-34.9L-37.5,-34.9L-37.5,-32.8L-34.6,-32.8C-30.25,-32.8,-28.05,-30.3C-26.45,-28.45,-26.45,-21.3L-26.45,28.35C-26.45,34.95,-27.65,36.65C-29.8,39.85,-34.6,39.85L-37.5,39.85L-37.5,41.9L-4.6,41.9L-4.6,39.85L-7.6,39.85C-11.85,39.85,-14.05,37.35C-15.65,35.5,-15.65,28.35L-15.65,6L-7.6,6L18.4,41.9L38.9,41.9L38.9,39.85C32.8,39.2,28.7,36.65C24.85,34.2,19.35,26.6L3.5,4.55C13.25,2.35,17.8,-2.8C22.45,-8.05,22.45,-15.1"
                        },
                        {
                          "edges": "M9.7,-14.4C9.7,-7.05,4.1,-2.25C-1.5,2.5,-12.45,2.5L-15.65,2.45L-15.65,-29.5C-9.75,-30.6,-6.75,-30.6C0.65,-30.6,5.2,-26.05C9.7,-21.55,9.7,-14.4"
                        }
                      ]
                    },
                    {
                      "fillIndex": 1,
                      "contours": [
                        {
                          "edges": "M-104.95,-61.5L-104.95,61.5L105,61.5L105,-61.5L-104.95,-61.5"
                        },
                        {
                          "edges": "M22.45,-15.1C22.45,-8.05,17.8,-2.8C13.25,2.35,3.5,4.55L19.35,26.6C24.85,34.2,28.7,36.65C32.8,39.2,38.9,39.85L38.9,41.9L18.4,41.9L-7.6,6L-15.65,6L-15.65,28.35C-15.65,35.5,-14.05,37.35C-11.85,39.85,-7.6,39.85L-4.6,39.85L-4.6,41.9L-37.5,41.9L-37.5,39.85L-34.6,39.85C-29.8,39.85,-27.65,36.65C-26.45,34.95,-26.45,28.35L-26.45,-21.3C-26.45,-28.45,-28.05,-30.3C-30.25,-32.8,-34.6,-32.8L-37.5,-32.8L-37.5,-34.9L-9.5,-34.9C2.7,-34.9,8.55,-33.1C14.35,-31.3,18.4,-26.55C22.45,-21.75,22.45,-15.1"
                        }
                      ]
                    },
                    {
                      "fillIndex": 1,
                      "contours": [
                        {
                          "edges": "M9.7,-14.4C9.7,-21.55,5.2,-26.05C0.65,-30.6,-6.75,-30.6C-9.75,-30.6,-15.65,-29.5L-15.65,2.45L-12.45,2.5C-1.5,2.5,4.1,-2.25C9.7,-7.05,9.7,-14.4"
                        }
                      ]
                    }
                  ]
                }
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
    "exportAsSprite": false,
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
                "libraryItem": "letter",
                "name": "ins1",
                "x": 127,
                "y": 79.5,
                "regX": 0,
                "regY": 0,
                "blendMode": "normal",
                "meshParams": 0
              },
              {
                "type": "instance",
                "libraryItem": "letter",
                "name": "ins2",
                "x": 391.95,
                "y": 86.55,
                "matrix": [
                  0.965927124023438,
                  -0.258804321289063,
                  0.258804321289063,
                  0.965927124023438
                ],
                "regX": 0,
                "regY": 0,
                "blendMode": "normal",
                "meshParams": 0
              },
              {
                "type": "instance",
                "libraryItem": "letter",
                "name": "ins3",
                "x": 105,
                "y": 222.55,
                "matrix": [
                  0.467147827148438,
                  0,
                  0,
                  0.467147827148438
                ],
                "regX": 0,
                "regY": 0,
                "blendMode": "normal",
                "meshParams": 0
              },
              {
                "type": "instance",
                "libraryItem": "letter",
                "name": "ins4",
                "x": 265.95,
                "y": 224.1,
                "matrix": [
                  0.45123291015625,
                  -0.120895385742188,
                  0.120895385742188,
                  0.45123291015625
                ],
                "regX": 0,
                "regY": 0,
                "blendMode": "normal",
                "meshParams": 0
              },
              {
                "type": "instance",
                "libraryItem": "letter",
                "name": "ins4",
                "x": 426.85,
                "y": 268.65,
                "matrix": [
                  0.5777587890625,
                  -0.816177368164063,
                  0.816177368164063,
                  0.5777587890625
                ],
                "regX": 68.65,
                "regY": 37.2,
                "blendMode": "normal",
                "meshParams": 0
              }
            ]
          }
        ]
      }
    ]
  }
}