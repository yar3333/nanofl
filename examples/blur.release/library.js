libraryData =
{
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
        "name": "auto",
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
                    "color": "rgba(136,136,136,0.41791047)"
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M287.99,73.71C287.99,63.68,283.03,54.47C277.87,45.28,268.57,37.06C259.33,28.69,246.01,21.7C232.68,14.85,215.87,10.15C179.89,-0.71,141.75,0.05C103.54,0.82,71.87,10.15C40.46,19.31,20.18,35.96C0,52.32,0,73.71C0,83.57,4.89,92.94C9.85,102.1,19.34,110.35C28.66,118.72,41.99,125.55C55.31,132.53,71.87,137.24C108.02,147.79,146.24,147.35C184.39,146.44,215.87,137.24C247.53,128.09,267.71,111.45C287.99,94.93,287.99,73.71"
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
    "exportAsSpriteSheet": false,
    "textureAtlas": null,
    "layers": [
      {
        "name": "auto",
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
                "x": 32,
                "y": 25.97402597402595,
                "regX": 0,
                "regY": 0,
                "blendMode": "normal",
                "meshParams": 0,
                "filters": [
                  {
                    "name": "GaussianBlurFilterPlugin",
                    "params": {
                      "radius": 20
                    }
                  }
                ]
              },
              {
                "type": "instance",
                "libraryItem": "mc",
                "name": "",
                "x": 32,
                "y": 220,
                "regX": 0,
                "regY": 0,
                "blendMode": "normal",
                "meshParams": 0
              }
            ]
          }
        ]
      },
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
                    "color": "#77FF77"
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M0,0L0,400L350,400L350,0L0,0"
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
  }
}