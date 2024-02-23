libraryData =
{
  "myButton": {
    "type": "movieclip",
    "version": "2.3.0",
    "linkedClass": "",
    "autoPlay": true,
    "loop": true,
    "likeButton": true,
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
                "type": "text",
                "name": "",
                "x": -23.5,
                "y": -20.8,
                "regX": 0,
                "regY": 0,
                "width": 47,
                "height": 42,
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
                    "characters": "up",
                    "fillColor": "#000099",
                    "align": "left",
                    "size": 34,
                    "style": "bold",
                    "family": "Times New Roman",
                    "strokeSize": 0,
                    "strokeColor": "#000000",
                    "kerning": true,
                    "letterSpacing": 0,
                    "lineSpacing": 2
                  }
                ]
              }
            ]
          },
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": [
              {
                "type": "text",
                "name": "",
                "x": -36.5,
                "y": -20.8,
                "regX": 0,
                "regY": 0,
                "width": 75.5,
                "height": 42,
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
                    "characters": "over",
                    "fillColor": "#000099",
                    "align": "left",
                    "size": 34,
                    "style": "bold",
                    "family": "Times New Roman",
                    "strokeSize": 0,
                    "strokeColor": "#000000",
                    "kerning": true,
                    "letterSpacing": 0,
                    "lineSpacing": 2
                  }
                ]
              }
            ]
          },
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": [
              {
                "type": "text",
                "name": "",
                "x": -45.5,
                "y": -20.8,
                "regX": 0,
                "regY": 0,
                "width": 86.5,
                "height": 42,
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
                    "characters": "down",
                    "fillColor": "#000099",
                    "align": "center",
                    "size": 34,
                    "style": "bold",
                    "family": "Times New Roman",
                    "strokeSize": 0,
                    "strokeColor": "#000000",
                    "kerning": true,
                    "letterSpacing": 0,
                    "lineSpacing": 2
                  }
                ]
              }
            ]
          },
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
                    "color": "#000099"
                  }
                ],
                "strokes": [
                  {
                    "type": "solid",
                    "color": "#01407E",
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
                      "edges": "M27.5,-48.3L27.5,53.7L-28.5,53.7L-28.5,-48.3L27.5,-48.3"
                    }
                  ],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M27.5,-48.3L-28.5,-48.3L-28.5,53.7L27.5,53.7L27.5,-48.3"
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
                "libraryItem": "myButton",
                "name": "",
                "x": 273.45,
                "y": 187.3,
                "regX": 0,
                "regY": 0,
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