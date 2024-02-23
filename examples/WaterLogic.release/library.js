libraryData =
{
  "_bitmaps/barrel": {
    "type": "bitmap",
    "version": "2.3.0",
    "linkedClass": "",
    "ext": "png",
    "textureAtlas": null
  },
  "_bitmaps/barrel3D": {
    "type": "bitmap",
    "version": "2.3.0",
    "linkedClass": "",
    "ext": "png",
    "textureAtlas": null
  },
  "_bitmaps/barrels": {
    "type": "bitmap",
    "version": "2.3.0",
    "linkedClass": "",
    "ext": "png",
    "textureAtlas": null
  },
  "_bitmaps/bucket": {
    "type": "bitmap",
    "version": "2.3.0",
    "linkedClass": "",
    "ext": "png",
    "textureAtlas": null
  },
  "_bitmaps/floor": {
    "type": "bitmap",
    "version": "2.3.0",
    "linkedClass": "",
    "ext": "jpg",
    "textureAtlas": null
  },
  "_bitmaps/trash": {
    "type": "bitmap",
    "version": "2.3.0",
    "linkedClass": "",
    "ext": "png",
    "textureAtlas": null
  },
  "_bitmaps/wall": {
    "type": "bitmap",
    "version": "2.3.0",
    "linkedClass": "",
    "ext": "jpg",
    "textureAtlas": null
  },
  "_buttons/Back": {
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
        "type": "mask",
        "visible": true,
        "locked": true,
        "keyFrames": [
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": [
              {
                "type": "text",
                "name": "",
                "x": -32.25,
                "y": -18.8,
                "regX": 0,
                "regY": 0,
                "width": 64.4,
                "height": 39,
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
                    "characters": "BACK",
                    "fillColor": "#000000",
                    "align": "left",
                    "size": 28,
                    "style": "",
                    "family": "Impact",
                    "strokeSize": 0,
                    "strokeColor": "#000000",
                    "kerning": true,
                    "letterSpacing": 0,
                    "lineSpacing": 2
                  }
                ]
              }
            ]
          }
        ]
      },
      {
        "name": "Layer 2",
        "type": "normal",
        "visible": true,
        "locked": true,
        "parentIndex": 0,
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
                    "type": "linear",
                    "colors": [
                      "#FF0000",
                      "#FFEC69"
                    ],
                    "ratios": [
                      0,
                      1
                    ],
                    "x0": 0.5,
                    "y0": 10.55,
                    "x1": 0.5,
                    "y1": -8.45
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M39.5,-15.45L-38.5,-15.45L-38.5,14.55L39.5,14.55L39.5,-15.45"
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
  "_buttons/btnBack": {
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
            "duration": 3,
            "motionTween": null,
            "elements": [
              {
                "type": "instance",
                "libraryItem": "_buttons/Back",
                "name": "",
                "x": 0.4,
                "y": -0.25,
                "regX": 28.4,
                "regY": 9.95,
                "blendMode": "normal",
                "meshParams": 0,
                "filters": [
                  {
                    "name": "GlowFilter",
                    "params": {
                      "alpha": 100,
                      "blurX": 2,
                      "blurY": 2,
                      "color": "#000000",
                      "inner": false,
                      "knockout": false,
                      "quality": 2,
                      "strength": 200
                    }
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
                    "color": "#000000"
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M42.7,15.05L42.7,-15.95L-41.85,-15.95L-41.85,15.05L42.7,15.05"
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
  "_buttons/btnNext": {
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
            "duration": 3,
            "motionTween": null,
            "elements": [
              {
                "type": "instance",
                "libraryItem": "_buttons/Next",
                "name": "",
                "x": -0.05,
                "y": 1.05,
                "matrix": [
                  1.15655517578125,
                  0,
                  0,
                  1.15655517578125
                ],
                "regX": 35.75,
                "regY": 9.9,
                "blendMode": "normal",
                "meshParams": 0,
                "filters": [
                  {
                    "name": "GlowFilter",
                    "params": {
                      "alpha": 100,
                      "blurX": 2,
                      "blurY": 2,
                      "color": "#000000",
                      "inner": false,
                      "knockout": false,
                      "quality": 2,
                      "strength": 200
                    }
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
                    "color": "#000000"
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M-49.9,-13.65L-49.9,14L48.2,14L48.2,-13.65L-49.9,-13.65"
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
  "_buttons/btnRules": {
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
            "duration": 3,
            "motionTween": null,
            "elements": [
              {
                "type": "instance",
                "libraryItem": "_buttons/Rules",
                "name": "",
                "x": 1.9,
                "y": 0.45,
                "regX": 0.5,
                "regY": 0.25,
                "blendMode": "normal",
                "meshParams": 0,
                "filters": [
                  {
                    "name": "GlowFilter",
                    "params": {
                      "alpha": 100,
                      "blurX": 2,
                      "blurY": 2,
                      "color": "#000000",
                      "inner": false,
                      "knockout": false,
                      "quality": 2,
                      "strength": 200
                    }
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
                    "color": "#000000"
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M38.1,-15.95L-38.15,-15.95L-38.15,15.05L38.1,15.05L38.1,-15.95"
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
  "_buttons/btnStart": {
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
            "duration": 3,
            "motionTween": null,
            "elements": [
              {
                "type": "instance",
                "libraryItem": "_buttons/Start",
                "name": "",
                "x": 1,
                "y": 1.45,
                "regX": 0.5,
                "regY": 0.25,
                "blendMode": "normal",
                "meshParams": 0,
                "filters": [
                  {
                    "name": "GlowFilter",
                    "params": {
                      "alpha": 100,
                      "blurX": 2,
                      "blurY": 2,
                      "color": "#000000",
                      "inner": false,
                      "knockout": false,
                      "quality": 2,
                      "strength": 200
                    }
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
                    "color": "#000000"
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M60.92,-13.03L-28.11,-13.03L-28.11,26.16L60.92,26.16L60.92,-13.03"
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
  "_buttons/Next": {
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
        "type": "mask",
        "visible": true,
        "locked": true,
        "keyFrames": [
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": [
              {
                "type": "text",
                "name": "",
                "x": -28.75,
                "y": -18.8,
                "regX": 0,
                "regY": 0,
                "width": 57.4,
                "height": 39,
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
                    "characters": "NEXT",
                    "fillColor": "#000000",
                    "align": "left",
                    "size": 28,
                    "style": "",
                    "family": "Impact",
                    "strokeSize": 0,
                    "strokeColor": "#000000",
                    "kerning": true,
                    "letterSpacing": 0,
                    "lineSpacing": 2
                  }
                ]
              }
            ]
          }
        ]
      },
      {
        "name": "Layer 2",
        "type": "normal",
        "visible": true,
        "locked": true,
        "parentIndex": 0,
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
                    "type": "linear",
                    "colors": [
                      "#FF0000",
                      "#FFEC69"
                    ],
                    "ratios": [
                      0,
                      1
                    ],
                    "x0": 0.5,
                    "y0": 10.55,
                    "x1": 0.5,
                    "y1": -8.45
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M39.5,-15.45L-38.5,-15.45L-38.5,14.55L39.5,14.55L39.5,-15.45"
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
  "_buttons/Rules": {
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
        "type": "mask",
        "visible": true,
        "locked": true,
        "keyFrames": [
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": [
              {
                "type": "text",
                "name": "",
                "x": -36.25,
                "y": -18.8,
                "regX": 0,
                "regY": 0,
                "width": 71.4,
                "height": 39,
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
                    "characters": "RULES",
                    "fillColor": "#000000",
                    "align": "left",
                    "size": 28,
                    "style": "",
                    "family": "Impact",
                    "strokeSize": 0,
                    "strokeColor": "#000000",
                    "kerning": true,
                    "letterSpacing": 0,
                    "lineSpacing": 2
                  }
                ]
              }
            ]
          }
        ]
      },
      {
        "name": "Layer 2",
        "type": "normal",
        "visible": true,
        "locked": true,
        "parentIndex": 0,
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
                    "type": "linear",
                    "colors": [
                      "#FF0000",
                      "#FFEC69"
                    ],
                    "ratios": [
                      0,
                      1
                    ],
                    "x0": 0.5,
                    "y0": 10.55,
                    "x1": 0.5,
                    "y1": -8.45
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M39.5,14.55L39.5,-15.45L-38.5,-15.45L-38.5,14.55L39.5,14.55"
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
  "_buttons/Start": {
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
        "type": "mask",
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
                "x": -35,
                "y": -18.8,
                "regX": 0,
                "regY": 0,
                "width": 96.93333435058594,
                "height": 52,
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
                    "characters": "START",
                    "fillColor": "#000000",
                    "align": "left",
                    "size": 38,
                    "style": "",
                    "family": "Impact",
                    "strokeSize": 0,
                    "strokeColor": "#000000",
                    "kerning": true,
                    "letterSpacing": 0,
                    "lineSpacing": 2
                  }
                ]
              }
            ]
          }
        ]
      },
      {
        "name": "Layer 2",
        "type": "normal",
        "visible": true,
        "locked": false,
        "parentIndex": 0,
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
                    "type": "linear",
                    "colors": [
                      "#FF0000",
                      "#FFEC69"
                    ],
                    "ratios": [
                      0,
                      1
                    ],
                    "x0": 13.0160226552894,
                    "y0": 21.1436493918649,
                    "x1": 13.0160226552894,
                    "y1": -4.83440313594741
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M64.57,26.62L64.57,-14.41L-38.5,-14.41L-38.5,26.62L64.57,26.62"
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
  "_sounds/sndBucket": {
    "type": "sound",
    "version": "2.3.0",
    "linkage": "bucket",
    "ext": "wav"
  },
  "_sounds/sndMusic": {
    "type": "sound",
    "version": "2.3.0",
    "linkage": "music",
    "ext": "wav"
  },
  "_sounds/sndTap": {
    "type": "sound",
    "version": "2.3.0",
    "linkage": "tap",
    "ext": "wav"
  },
  "_sounds/sndTrash": {
    "type": "sound",
    "version": "2.3.0",
    "linkage": "trash",
    "ext": "wav"
  },
  "_sounds/sndWater": {
    "type": "sound",
    "version": "2.3.0",
    "linkage": "water",
    "ext": "wav"
  },
  "_splash/splash": {
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
        "name": "Barrels",
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
                "libraryItem": "_bitmaps/barrels",
                "name": "",
                "x": -283.05,
                "y": 19.9,
                "matrix": [
                  0.491775512695313,
                  0,
                  0,
                  0.491775512695313
                ],
                "regX": 152.4,
                "regY": 137.6,
                "blendMode": "normal",
                "meshParams": 0
              },
              {
                "type": "instance",
                "libraryItem": "_bitmaps/barrels",
                "name": "",
                "x": 138.7,
                "y": -15.15,
                "matrix": [
                  0.608108520507813,
                  0,
                  0,
                  0.608108520507813
                ],
                "regX": 152.35,
                "regY": 137.45,
                "blendMode": "normal",
                "meshParams": 0
              }
            ]
          }
        ]
      },
      {
        "name": "Barrel3D",
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
                "libraryItem": "_bitmaps/barrel3D",
                "name": "",
                "x": -218.75,
                "y": -113.9,
                "matrix": [
                  0.608688354492188,
                  0,
                  0,
                  0.608688354492188
                ],
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
        "name": "Floor",
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
                "libraryItem": "_bitmaps/floor",
                "name": "",
                "x": -264,
                "y": 150.05,
                "matrix": [
                  1,
                  0,
                  0,
                  0.565582275390625
                ],
                "regX": 260,
                "regY": 41.55,
                "blendMode": "normal",
                "meshParams": 0
              }
            ]
          }
        ]
      },
      {
        "name": "Wall",
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
                "libraryItem": "_bitmaps/wall",
                "name": "",
                "x": -260,
                "y": -195,
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
  },
  "_splash/title": {
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
        "name": "Layer 5",
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
                "libraryItem": "_splash/titleInner",
                "name": "",
                "x": 19.142490205922,
                "y": 16.7865039535363,
                "matrix": [
                  0.99269243278113,
                  0.120672009592458,
                  -0.120672009592458,
                  0.99269243278113
                ],
                "regX": 78.25,
                "regY": 19.45,
                "blendMode": "normal",
                "meshParams": 0,
                "filters": [
                  {
                    "name": "GlowFilter",
                    "params": {
                      "alpha": 100,
                      "blurX": 3,
                      "blurY": 3,
                      "color": "#000000",
                      "inner": false,
                      "knockout": false,
                      "quality": 2,
                      "strength": 300
                    }
                  }
                ]
              }
            ]
          }
        ]
      }
    ]
  },
  "_splash/titleInner": {
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
        "type": "mask",
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
                "x": 12.65,
                "y": 0,
                "regX": 0,
                "regY": 0,
                "width": 285.1357421875,
                "height": 76,
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
                    "characters": "Water Logic",
                    "fillColor": "#626262",
                    "align": "left",
                    "size": 58,
                    "style": "",
                    "family": "Impact",
                    "strokeSize": 0,
                    "strokeColor": "#000000",
                    "kerning": true,
                    "letterSpacing": 0,
                    "lineSpacing": 2
                  }
                ]
              }
            ]
          }
        ]
      },
      {
        "name": "Layer 4",
        "type": "normal",
        "visible": true,
        "locked": false,
        "parentIndex": 0,
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
                    "type": "linear",
                    "colors": [
                      "#FF0000",
                      "#FFEC69"
                    ],
                    "ratios": [
                      0,
                      1
                    ],
                    "x0": 153.992537313433,
                    "y0": 64.4333333333333,
                    "x1": 153.992537313433,
                    "y1": 23.2666666666667
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M296.49,73.1L296.49,8.1L11.49,8.1L11.49,73.1L296.49,73.1"
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
  "background": {
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
                "type": "instance",
                "libraryItem": "wall",
                "name": "",
                "regX": 260,
                "regY": 195,
                "blendMode": "normal",
                "meshParams": 0
              },
              {
                "type": "instance",
                "libraryItem": "_bitmaps/barrels",
                "name": "",
                "x": 351.7,
                "y": 241.2,
                "matrix": [
                  0.368423461914063,
                  0,
                  0,
                  0.368423461914063
                ],
                "regX": 152.55,
                "regY": 137.6,
                "blendMode": "normal",
                "meshParams": 0
              },
              {
                "type": "instance",
                "libraryItem": "_bitmaps/floor",
                "name": "",
                "x": 1.45,
                "y": 343,
                "matrix": [
                  1,
                  0,
                  0,
                  0.565582275390625
                ],
                "regX": 260,
                "regY": 41.55,
                "blendMode": "normal",
                "meshParams": 0
              },
              {
                "type": "instance",
                "libraryItem": "_bitmaps/barrels",
                "name": "",
                "x": 185.2,
                "y": 240.35,
                "matrix": [
                  0.368423461914063,
                  0,
                  0,
                  0.368423461914063
                ],
                "regX": 152.5,
                "regY": 137.65,
                "blendMode": "normal",
                "meshParams": 0
              }
            ]
          }
        ]
      }
    ]
  },
  "barrel": {
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
            "duration": 2,
            "motionTween": null,
            "elements": [
              {
                "type": "instance",
                "libraryItem": "_bitmaps/barrel",
                "name": "",
                "x": 1.95,
                "y": -5,
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
  },
  "bucket": {
    "type": "movieclip",
    "version": "2.3.0",
    "linkedClass": "McBucket",
    "autoPlay": false,
    "loop": false,
    "likeButton": false,
    "exportAsSpriteSheet": false,
    "textureAtlas": null,
    "layers": [
      {
        "name": "neck",
        "type": "normal",
        "visible": true,
        "locked": true,
        "keyFrames": [
          {
            "label": "",
            "duration": 101,
            "motionTween": null,
            "elements": [
              {
                "type": "instance",
                "libraryItem": "neck",
                "name": "mcNeck",
                "x": 0,
                "y": -65,
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
        "name": "text",
        "type": "normal",
        "visible": true,
        "locked": true,
        "keyFrames": [
          {
            "label": "",
            "duration": 101,
            "motionTween": null,
            "elements": [
              {
                "type": "text",
                "name": "tfLabel",
                "x": -21.6,
                "y": -29.1,
                "regX": 0,
                "regY": 0,
                "width": 44.2,
                "height": 26.35,
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
                    "characters": "00/00",
                    "fillColor": "#FFFFFF",
                    "align": "center",
                    "size": 16,
                    "style": "",
                    "family": "Arial",
                    "strokeSize": 0,
                    "strokeColor": "#000000",
                    "kerning": true,
                    "letterSpacing": 0,
                    "lineSpacing": 2
                  }
                ]
              }
            ]
          }
        ]
      },
      {
        "name": "waterMask",
        "type": "mask",
        "visible": true,
        "locked": true,
        "keyFrames": [
          {
            "label": "",
            "duration": 100,
            "motionTween": {
              "tweenType": "motion",
              "motionTweenEasing": 0,
              "motionTweenOrientToPath": false,
              "motionTweenRotateCount": 0,
              "motionTweenRotateCountX": 0,
              "motionTweenRotateCountY": 0,
              "motionTweenDirectionalLightRotateCountX": 0,
              "motionTweenDirectionalLightRotateCountY": 0
            },
            "elements": [
              {
                "type": "instance",
                "libraryItem": "bucketWaterMask",
                "name": "",
                "x": -18,
                "y": -1.35,
                "regX": 18.5,
                "regY": 15.9,
                "blendMode": "normal",
                "meshParams": 0
              }
            ]
          },
          {
            "label": "",
            "duration": 1,
            "motionTween": {
              "tweenType": "motion",
              "motionTweenEasing": 0,
              "motionTweenOrientToPath": false,
              "motionTweenRotateCount": 0,
              "motionTweenRotateCountX": 0,
              "motionTweenRotateCountY": 0,
              "motionTweenDirectionalLightRotateCountX": 0,
              "motionTweenDirectionalLightRotateCountY": 0
            },
            "elements": [
              {
                "type": "instance",
                "libraryItem": "bucketWaterMask",
                "name": "",
                "x": -18,
                "y": -57.3,
                "regX": 18.5,
                "regY": 15.9,
                "blendMode": "normal",
                "meshParams": 0
              }
            ]
          }
        ]
      },
      {
        "name": "water",
        "type": "normal",
        "visible": true,
        "locked": true,
        "parentIndex": 2,
        "keyFrames": [
          {
            "label": "",
            "duration": 101,
            "motionTween": null,
            "elements": [
              {
                "type": "instance",
                "libraryItem": "bucketInner",
                "name": "mcForeColor",
                "x": 1.25,
                "y": -36.75,
                "regX": 18,
                "regY": 15,
                "blendMode": "normal",
                "meshParams": 0,
                "colorEffect": {
                  "type": "advanced",
                  "alphaMultiplier": 0.859375,
                  "redMultiplier": 0.8203125,
                  "greenMultiplier": 0.8203125,
                  "blueMultiplier": 0.8203125,
                  "alphaOffset": 0,
                  "redOffset": 0,
                  "greenOffset": 46,
                  "blueOffset": 46
                }
              }
            ]
          }
        ]
      },
      {
        "name": "bounding box",
        "type": "normal",
        "visible": true,
        "locked": true,
        "keyFrames": [
          {
            "label": "",
            "duration": 101,
            "motionTween": null,
            "elements": [
              {
                "type": "instance",
                "libraryItem": "bucketBox",
                "name": "mcBox",
                "x": -25,
                "y": -65,
                "regX": 21,
                "regY": 32.5,
                "blendMode": "normal",
                "meshParams": 0,
                "colorEffect": {
                  "type": "alpha",
                  "value": 0
                }
              }
            ]
          }
        ]
      },
      {
        "name": "highlighting",
        "type": "normal",
        "visible": true,
        "locked": true,
        "keyFrames": [
          {
            "label": "",
            "duration": 101,
            "motionTween": null,
            "elements": [
              {
                "type": "instance",
                "libraryItem": "bucketInner",
                "name": "mcForeColor",
                "x": 1.25,
                "y": -36.75,
                "regX": 18,
                "regY": 15,
                "blendMode": "normal",
                "meshParams": 0,
                "colorEffect": {
                  "type": "tint",
                  "color": "#FF0000",
                  "multiplier": 0.18
                }
              }
            ]
          }
        ]
      },
      {
        "name": "bucket",
        "type": "normal",
        "visible": true,
        "locked": true,
        "keyFrames": [
          {
            "label": "",
            "duration": 101,
            "motionTween": null,
            "elements": [
              {
                "type": "instance",
                "libraryItem": "bucketInner",
                "name": "",
                "x": 1.3,
                "y": -36.65,
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
  },
  "bucketBox": {
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
                "type": "shape",
                "regX": 0,
                "regY": 0,
                "fills": [
                  {
                    "type": "solid",
                    "color": "#00FF00"
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M54.5,-0.5L-1.05,-0.5L-1.05,63L54.5,63L54.5,-0.5"
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
  "bucketInner": {
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
                "type": "instance",
                "libraryItem": "_bitmaps/bucket",
                "name": "",
                "x": -28.75,
                "y": -37.4,
                "matrix": [
                  0.575485229492188,
                  0,
                  0,
                  0.575485229492188
                ],
                "regX": 49.95,
                "regY": 64.9,
                "blendMode": "normal",
                "meshParams": 0
              }
            ]
          }
        ]
      }
    ]
  },
  "bucketWaterMask": {
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
                "type": "shape",
                "regX": 0,
                "regY": 0,
                "fills": [
                  {
                    "type": "solid",
                    "color": "#FF0000"
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M50.05,56.8L50.05,0L-12.95,0L-12.95,56.8L50.05,56.8"
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
  "game": {
    "type": "movieclip",
    "version": "2.3.0",
    "linkedClass": "Game",
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
            "elements": []
          }
        ]
      }
    ]
  },
  "musicButton": {
    "type": "movieclip",
    "version": "2.3.0",
    "linkedClass": "MusicButton",
    "autoPlay": false,
    "loop": false,
    "likeButton": false,
    "exportAsSpriteSheet": false,
    "textureAtlas": null,
    "layers": [
      {
        "name": "Layer 2",
        "type": "normal",
        "visible": true,
        "locked": false,
        "keyFrames": [
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": []
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
                "strokes": [
                  {
                    "type": "solid",
                    "color": "#000000",
                    "thickness": 2,
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
                      "edges": "M25.9,4.35L5.5,26.65"
                    }
                  ],
                  "polygons": []
                }
              }
            ]
          }
        ]
      },
      {
        "name": "Layer 3",
        "type": "normal",
        "visible": true,
        "locked": false,
        "keyFrames": [
          {
            "label": "",
            "duration": 2,
            "motionTween": null,
            "elements": [
              {
                "type": "shape",
                "regX": 0,
                "regY": 0,
                "fills": [
                  {
                    "type": "solid",
                    "color": "#000000"
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M25.6,9.5C25.6,8.45,24.9,7.75C24.15,7,23.1,7L16.5,7C15.45,7,14.75,7.75C14,8.45,14,9.5L14,9.75L14,10L14,19.03C13.68,19,13.35,19C10.95,19,9.25,20.1C7.6,21.2,7.6,22.75C7.6,24.3,9.25,25.4C10.95,26.5,13.35,26.5C15.75,26.5,17.35,25.4C19.05,24.3,19.05,22.75C19.05,22.31,18.9,21.9L19,21.9L19,12L23.1,12C24.15,12,24.9,11.3C25.6,10.55,25.6,9.5"
                        }
                      ]
                    }
                  ]
                }
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
            "duration": 2,
            "motionTween": null,
            "elements": [
              {
                "type": "shape",
                "regX": 0,
                "regY": 0,
                "fills": [
                  {
                    "type": "solid",
                    "color": "rgba(255,255,255,0.298039215686275)"
                  },
                  {
                    "type": "solid",
                    "color": "rgba(255,255,255,0.4)"
                  }
                ],
                "strokes": [
                  {
                    "type": "solid",
                    "color": "#000000",
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
                      "edges": "M30.88,22C30.08,23.99,28.7,25.75C28.07,26.55,27.33,27.3C22.63,31.98,16,31.98C9.39,31.98,4.73,27.3C3.97,26.55,3.33,25.75C1.37,23.29,0.55,20.35C-0.01,18.28,0,15.98C-0.01,13.7,0.55,11.65C1.64,7.75,4.73,4.68C9.39,-0.02,16,-0.02C22.63,-0.02,27.33,4.68C29.71,7.06,30.88,9.95C32,12.73,32,15.98C32,19.22,30.88,22"
                    }
                  ],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M30.88,22C32,19.22,32,15.98C32,12.73,30.88,9.95C29.71,7.06,27.33,4.68C22.63,-0.02,16,-0.02C9.39,-0.02,4.73,4.68C1.64,7.75,0.55,11.65C-0.01,13.7,0,15.98C-0.01,18.28,0.55,20.35C1.37,23.29,3.33,25.75C3.97,26.55,4.73,27.3C9.39,31.98,16,31.98C22.63,31.98,27.33,27.3C28.07,26.55,28.7,25.75C30.08,23.99,30.88,22"
                        },
                        {
                          "edges": "M12,10C9.73,11.28,8,13.18C7.37,13.83,6.8,14.65C5.85,16.03,4.9,17.35C4.83,17.39,4.73,17.38C4.13,17.39,3.53,17.35C3.33,17.2,3.2,17C2.95,16.75,2.75,16.45C2.7,7.61,10.23,3.43C12.8,2.02,15.6,2.13C21.26,1.85,19.68,6.85C19.33,8.08,18.23,8.15C14.97,8.4,12.25,9.85L12,10"
                        }
                      ]
                    },
                    {
                      "fillIndex": 1,
                      "contours": [
                        {
                          "edges": "M12,10L12.25,9.85C14.97,8.4,18.23,8.15C19.33,8.08,19.68,6.85C21.26,1.85,15.6,2.13C12.8,2.02,10.23,3.43C2.7,7.61,2.75,16.45C2.95,16.75,3.2,17C3.33,17.2,3.53,17.35C4.13,17.39,4.73,17.38C4.83,17.39,4.9,17.35C5.85,16.03,6.8,14.65C7.37,13.83,8,13.18C9.73,11.28,12,10"
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
  "neck": {
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
            "elements": []
          }
        ]
      }
    ]
  },
  "scene": {
    "type": "movieclip",
    "version": "2.3.0",
    "linkedClass": "Scene",
    "autoPlay": false,
    "loop": false,
    "likeButton": false,
    "exportAsSpriteSheet": false,
    "textureAtlas": null,
    "layers": [
      {
        "name": "Label",
        "type": "normal",
        "visible": true,
        "locked": false,
        "keyFrames": [
          {
            "label": "Origin",
            "duration": 1,
            "motionTween": null,
            "elements": [
              {
                "type": "shape"
              }
            ]
          },
          {
            "label": "Rules",
            "duration": 1,
            "motionTween": null,
            "elements": []
          },
          {
            "label": "Game",
            "duration": 1,
            "motionTween": null,
            "elements": []
          },
          {
            "label": "Win",
            "duration": 1,
            "motionTween": null,
            "elements": []
          },
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": []
          }
        ]
      },
      {
        "name": "Code",
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
              }
            ]
          },
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": []
          },
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": []
          },
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": []
          },
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": []
          }
        ]
      },
      {
        "name": "Hud",
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
                "libraryItem": "_buttons/btnStart",
                "name": "btGotoGame",
                "x": 357.499999999992,
                "y": 181.549999999999,
                "matrix": [
                  0.854268770962739,
                  -0.107794152331484,
                  0.107794152331499,
                  0.854268770962861
                ],
                "regX": 0,
                "regY": 0,
                "blendMode": "normal",
                "meshParams": 0
              },
              {
                "type": "instance",
                "libraryItem": "_buttons/btnRules",
                "name": "btRules",
                "x": 366.25,
                "y": 234.4,
                "matrix": [
                  0.993637084960938,
                  0.112625122070313,
                  -0.112625122070313,
                  0.993637084960938
                ],
                "regX": 0,
                "regY": 0,
                "blendMode": "normal",
                "meshParams": 0
              }
            ]
          },
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": [
              {
                "type": "instance",
                "libraryItem": "_buttons/btnBack",
                "name": "btGotoOrigin",
                "x": 120.65,
                "y": 345.65,
                "regX": 0,
                "regY": 0,
                "blendMode": "normal",
                "meshParams": 0
              },
              {
                "type": "text",
                "name": "",
                "x": 47.8,
                "y": 57.65,
                "regX": 0,
                "regY": 0,
                "width": 426.8916015625,
                "height": 268,
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
                    "characters": "You have to get specified\nwater volume in each bucket.\n",
                    "fillColor": "#00FFFF",
                    "align": "center",
                    "size": 17,
                    "style": "bold",
                    "family": "Comic Sans MS",
                    "strokeSize": 0,
                    "strokeColor": "#000000",
                    "kerning": true,
                    "letterSpacing": 0,
                    "lineSpacing": 2
                  },
                  {
                    "characters": "\n",
                    "fillColor": "#FFFF00",
                    "align": "center",
                    "size": 17,
                    "style": "bold",
                    "family": "Comic Sans MS",
                    "strokeSize": 0,
                    "strokeColor": "#000000",
                    "kerning": true,
                    "letterSpacing": 0,
                    "lineSpacing": 2
                  },
                  {
                    "characters": "You may do next:\n   1) fill whole bucket from the tap;\n   2) fallout all water from the bucket;\n   3) transfuse water from one bucket to another.",
                    "fillColor": "#FFFF00",
                    "align": "left",
                    "size": 17,
                    "style": "bold",
                    "family": "Comic Sans MS",
                    "strokeSize": 0,
                    "strokeColor": "#000000",
                    "kerning": true,
                    "letterSpacing": 0,
                    "lineSpacing": 2
                  },
                  {
                    "characters": "\n",
                    "fillColor": "#6699FF",
                    "align": "left",
                    "size": 17,
                    "style": "bold",
                    "family": "Comic Sans MS",
                    "strokeSize": 0,
                    "strokeColor": "#000000",
                    "kerning": true,
                    "letterSpacing": 0,
                    "lineSpacing": 2
                  },
                  {
                    "characters": "\n",
                    "fillColor": "#6699FF",
                    "align": "center",
                    "size": 17,
                    "style": "bold",
                    "family": "Comic Sans MS",
                    "strokeSize": 0,
                    "strokeColor": "#000000",
                    "kerning": true,
                    "letterSpacing": 0,
                    "lineSpacing": 2
                  },
                  {
                    "characters": "Click on the bucket to get it.\nMove mouse with bucket and\nclick again to do something else.",
                    "fillColor": "#00FFFF",
                    "align": "center",
                    "size": 17,
                    "style": "bold",
                    "family": "Comic Sans MS",
                    "strokeSize": 0,
                    "strokeColor": "#000000",
                    "kerning": true,
                    "letterSpacing": 0,
                    "lineSpacing": 2
                  }
                ]
              },
              {
                "type": "instance",
                "libraryItem": "_buttons/btnStart",
                "name": "btGotoGame",
                "x": 385.5,
                "y": 340.747959183677,
                "matrix": [
                  0.735443971701841,
                  0,
                  0,
                  0.750000000000001
                ],
                "regX": 0,
                "regY": 0,
                "blendMode": "normal",
                "meshParams": 0
              },
              {
                "type": "text",
                "name": "",
                "x": 213.341204630291,
                "y": 7.85,
                "matrix": [
                  2.01708984375,
                  0,
                  0,
                  2.01708984375
                ],
                "regX": 72,
                "regY": 8.4,
                "width": 47.18333435058594,
                "height": 27,
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
                    "characters": "RULES",
                    "fillColor": "#FF9900",
                    "align": "center",
                    "size": 18,
                    "style": "",
                    "family": "Impact",
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
                "type": "instance",
                "libraryItem": "musicButton",
                "name": "",
                "x": 481,
                "y": 11,
                "regX": 15,
                "regY": 16,
                "blendMode": "normal",
                "meshParams": 0
              },
              {
                "type": "text",
                "name": "",
                "x": 26,
                "y": 14.65,
                "regX": 0,
                "regY": 0,
                "width": 63,
                "height": 31,
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
                    "characters": "Level",
                    "fillColor": "#FFFFFF",
                    "align": "center",
                    "size": 23,
                    "style": "bold",
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
                "name": "tfLevel",
                "x": 93,
                "y": 14.65,
                "regX": 0,
                "regY": 0,
                "width": 42.6,
                "height": 31,
                "selectable": true,
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
                    "characters": "000",
                    "fillColor": "#FFFFFF",
                    "align": "left",
                    "size": 23,
                    "style": "bold",
                    "family": "Arial",
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
                "type": "instance",
                "libraryItem": "_buttons/btnNext",
                "name": "btNextLevel",
                "x": 260.1,
                "y": 298.25,
                "matrix": [
                  1.0517578125,
                  0,
                  0,
                  1.0517578125
                ],
                "regX": 0,
                "regY": 0,
                "blendMode": "normal",
                "meshParams": 0
              },
              {
                "type": "text",
                "name": "",
                "x": 135.95,
                "y": 74.5,
                "matrix": [
                  1,
                  0,
                  0,
                  1.11320495605469
                ],
                "regX": 0,
                "regY": 0,
                "width": 248.1,
                "height": 152,
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
                    "characters": "Success!\n\n",
                    "fillColor": "#FFFF00",
                    "align": "center",
                    "size": 29,
                    "style": "",
                    "family": "Impact",
                    "strokeSize": 0,
                    "strokeColor": "#000000",
                    "kerning": true,
                    "letterSpacing": 0,
                    "lineSpacing": 2
                  },
                  {
                    "characters": "Task was not simple,\nbut you was smart!",
                    "fillColor": "#00FFFF",
                    "align": "center",
                    "size": 29,
                    "style": "",
                    "family": "Impact",
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
                "type": "instance",
                "libraryItem": "_buttons/btnNext",
                "name": "",
                "x": 260.1,
                "y": 302.3,
                "regX": 0,
                "regY": 0,
                "blendMode": "normal",
                "meshParams": 0
              },
              {
                "type": "text",
                "name": "",
                "x": 130.05,
                "y": 72.85,
                "regX": 0,
                "regY": 0,
                "width": 259.9,
                "height": 176,
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
                    "characters": "All tasks are done!",
                    "fillColor": "#00FF00",
                    "align": "center",
                    "size": 34,
                    "style": "",
                    "family": "Impact",
                    "strokeSize": 0,
                    "strokeColor": "#000000",
                    "kerning": true,
                    "letterSpacing": 0,
                    "lineSpacing": 2
                  },
                  {
                    "characters": "\n",
                    "fillColor": "#FFCC00",
                    "align": "center",
                    "size": 34,
                    "style": "",
                    "family": "Impact",
                    "strokeSize": 0,
                    "strokeColor": "#000000",
                    "kerning": true,
                    "letterSpacing": 0,
                    "lineSpacing": 2
                  },
                  {
                    "characters": "\nYou are smart\nand clever!",
                    "fillColor": "#FFFF00",
                    "align": "center",
                    "size": 34,
                    "style": "",
                    "family": "Impact",
                    "strokeSize": 0,
                    "strokeColor": "#000000",
                    "kerning": true,
                    "letterSpacing": 0,
                    "lineSpacing": 2
                  }
                ]
              }
            ]
          }
        ]
      },
      {
        "name": "Movie",
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
                "libraryItem": "_splash/title",
                "name": "",
                "x": 148.283540372671,
                "y": -10.2478260869565,
                "regX": 0,
                "regY": 0,
                "blendMode": "normal",
                "meshParams": 0
              }
            ]
          },
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": []
          },
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": [
              {
                "type": "instance",
                "libraryItem": "trash",
                "name": "mcTrash",
                "x": 97,
                "y": 228.4,
                "regX": 75,
                "regY": 15,
                "blendMode": "normal",
                "meshParams": 0
              },
              {
                "type": "instance",
                "libraryItem": "game",
                "name": "game",
                "regX": 0,
                "regY": 0,
                "blendMode": "normal",
                "meshParams": 0
              },
              {
                "type": "text",
                "name": "tfTask",
                "x": 26,
                "y": 65.3,
                "regX": 0,
                "regY": 0,
                "width": 473.8,
                "height": 128.65,
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
                    "characters": "Task",
                    "fillColor": "#FFFF00",
                    "align": "left",
                    "size": 18,
                    "style": "bold",
                    "family": "Arial Black",
                    "strokeSize": 1,
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
            "elements": []
          },
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": []
          }
        ]
      },
      {
        "name": "Fon",
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
                "libraryItem": "_splash/splash",
                "name": "",
                "x": 260,
                "y": 195.2,
                "regX": 16.2,
                "regY": 15.1,
                "blendMode": "normal",
                "meshParams": 0
              }
            ]
          },
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": [
              {
                "type": "instance",
                "libraryItem": "_splash/splash",
                "name": "",
                "x": 260,
                "y": 195,
                "regX": 16.2,
                "regY": 15.1,
                "blendMode": "normal",
                "meshParams": 0,
                "colorEffect": {
                  "type": "brightness",
                  "value": -0.31
                }
              }
            ]
          },
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": [
              {
                "type": "instance",
                "libraryItem": "background",
                "name": "",
                "regX": 217.75,
                "regY": 193.95,
                "blendMode": "normal",
                "meshParams": 0,
                "colorEffect": {
                  "type": "brightness",
                  "value": -0.1
                }
              },
              {
                "type": "instance",
                "libraryItem": "tap",
                "name": "mcTap",
                "x": 451.4,
                "y": 214.35,
                "regX": -1.05,
                "regY": -0.5,
                "blendMode": "normal",
                "meshParams": 0
              }
            ]
          },
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": [
              {
                "type": "instance",
                "libraryItem": "wall",
                "name": "",
                "regX": 260,
                "regY": 195,
                "blendMode": "normal",
                "meshParams": 0,
                "colorEffect": {
                  "type": "tint",
                  "color": "#333333",
                  "multiplier": 0.2
                },
                "filters": [
                  {
                    "name": "BoxBlurFilter",
                    "params": {
                      "blurX": 10,
                      "blurY": 10,
                      "quality": 3
                    }
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
                "type": "instance",
                "libraryItem": "wall",
                "name": "",
                "regX": 260,
                "regY": 195,
                "blendMode": "normal",
                "meshParams": 0,
                "colorEffect": {
                  "type": "tint",
                  "color": "#333333",
                  "multiplier": 0.2
                },
                "filters": [
                  {
                    "name": "BoxBlurFilter",
                    "params": {
                      "blurX": 10,
                      "blurY": 10,
                      "quality": 3
                    }
                  }
                ]
              }
            ]
          }
        ]
      }
    ]
  },
  "tap": {
    "type": "movieclip",
    "version": "2.3.0",
    "linkedClass": "",
    "autoPlay": false,
    "loop": false,
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
                "type": "instance",
                "libraryItem": "barrel",
                "name": "mcKran",
                "x": 275,
                "y": -134,
                "matrix": [
                  -0.999969482421875,
                  0,
                  0,
                  0.949966430664063
                ],
                "regX": 0,
                "regY": 0.05,
                "blendMode": "normal",
                "meshParams": 0
              }
            ]
          },
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": [
              {
                "type": "instance",
                "libraryItem": "barrel",
                "name": "mcKran",
                "x": 275,
                "y": -134,
                "matrix": [
                  -1,
                  0,
                  0,
                  0.949996948242188
                ],
                "regX": 93,
                "regY": 59.5,
                "blendMode": "normal",
                "meshParams": 0,
                "colorEffect": {
                  "type": "tint",
                  "color": "#FF0000",
                  "multiplier": 0.18
                }
              }
            ]
          },
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": [
              {
                "type": "instance",
                "libraryItem": "barrel",
                "name": "mcKran",
                "x": 275,
                "y": -134,
                "matrix": [
                  -1,
                  0,
                  0,
                  0.949996948242188
                ],
                "regX": 93,
                "regY": 59.5,
                "blendMode": "normal",
                "meshParams": 0
              },
              {
                "type": "instance",
                "libraryItem": "waterFromTap",
                "name": "",
                "x": 179.6,
                "y": -17.55,
                "regX": -178.55,
                "regY": 30.55,
                "blendMode": "normal",
                "meshParams": 0,
                "colorEffect": {
                  "type": "advanced",
                  "alphaMultiplier": 1,
                  "redMultiplier": 1,
                  "greenMultiplier": 1,
                  "blueMultiplier": 1,
                  "alphaOffset": -113,
                  "redOffset": 0,
                  "greenOffset": 0,
                  "blueOffset": 0
                }
              }
            ]
          }
        ]
      }
    ]
  },
  "trash": {
    "type": "movieclip",
    "version": "2.3.0",
    "linkedClass": "",
    "autoPlay": false,
    "loop": false,
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
                "type": "instance",
                "libraryItem": "trashInner",
                "name": "",
                "x": -80,
                "y": 78,
                "regX": 89,
                "regY": 36.45,
                "blendMode": "normal",
                "meshParams": 0
              }
            ]
          },
          {
            "label": "",
            "duration": 1,
            "motionTween": null,
            "elements": [
              {
                "type": "instance",
                "libraryItem": "trashInner",
                "name": "",
                "x": -80,
                "y": 78,
                "regX": 89,
                "regY": 36.45,
                "blendMode": "normal",
                "meshParams": 0,
                "colorEffect": {
                  "type": "tint",
                  "color": "#FF0000",
                  "multiplier": 0.18
                }
              }
            ]
          }
        ]
      }
    ]
  },
  "trashInner": {
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
                "type": "instance",
                "libraryItem": "_bitmaps/trash",
                "name": "",
                "x": 5.4,
                "y": -9.75,
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
  },
  "wall": {
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
        "name": "Layer 2",
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
                "libraryItem": "_bitmaps/wall",
                "name": "",
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
            "elements": []
          }
        ]
      }
    ]
  },
  "waterFromTap": {
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
            "duration": 4,
            "motionTween": null,
            "elements": [
              {
                "type": "shape",
                "regX": 0,
                "regY": 0,
                "fills": [
                  {
                    "type": "radial",
                    "colors": [
                      "#A4D9FF",
                      "#043EFF"
                    ],
                    "ratios": [
                      0,
                      1
                    ],
                    "cx": -179.05,
                    "cy": 30,
                    "r": 8,
                    "fx": -179.05,
                    "fy": 30
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M-183.6,41.9L-175.65,42L-176.85,18.15L-182.1,18.15L-183.6,41.9"
                        }
                      ]
                    }
                  ]
                }
              }
            ]
          },
          {
            "label": "",
            "duration": 5,
            "motionTween": null,
            "elements": [
              {
                "type": "shape",
                "regX": 0,
                "regY": 0,
                "fills": [
                  {
                    "type": "radial",
                    "colors": [
                      "#A4D9FF",
                      "#043EFF"
                    ],
                    "ratios": [
                      0,
                      1
                    ],
                    "cx": -178.15,
                    "cy": 29.75,
                    "r": 8.25,
                    "fx": -178.15,
                    "fy": 29.75
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M-183.6,41.9L-174.5,41.9C-173.63,30.03,-176.85,18.15L-182.1,18.15C-180.7,30.03,-183.6,41.9"
                        }
                      ]
                    }
                  ]
                }
              }
            ]
          },
          {
            "label": "",
            "duration": 5,
            "motionTween": null,
            "elements": [
              {
                "type": "shape",
                "regX": 0,
                "regY": 0,
                "fills": [
                  {
                    "type": "radial",
                    "colors": [
                      "#A4D9FF",
                      "#043EFF"
                    ],
                    "ratios": [
                      0,
                      1
                    ],
                    "cx": -180.55,
                    "cy": 30,
                    "r": 8.21631513074404,
                    "fx": -180.55,
                    "fy": 30
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M-176.2,42.3C-179.33,30.81,-177.65,18.2L-181.8,18.03C-182.4,29.94,-184.4,41.55L-176.2,42.3"
                        }
                      ]
                    }
                  ]
                }
              }
            ]
          },
          {
            "label": "",
            "duration": 5,
            "motionTween": null,
            "elements": [
              {
                "type": "shape",
                "regX": 0,
                "regY": 0,
                "fills": [
                  {
                    "type": "radial",
                    "colors": [
                      "#A4D9FF",
                      "#043EFF"
                    ],
                    "ratios": [
                      0,
                      1
                    ],
                    "cx": -180.9,
                    "cy": 29.5,
                    "r": 8.30403040494317,
                    "fx": -180.9,
                    "fy": 29.5
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M-185.27,41.55L-177.05,42.3C-179.73,30.02,-176.57,18.45L-181.8,18.03C-185.84,29.51,-185.27,41.55"
                        }
                      ]
                    }
                  ]
                }
              }
            ]
          },
          {
            "label": "",
            "duration": 5,
            "motionTween": null,
            "elements": [
              {
                "type": "shape",
                "regX": 0,
                "regY": 0,
                "fills": [
                  {
                    "type": "radial",
                    "colors": [
                      "#A4D9FF",
                      "#043EFF"
                    ],
                    "ratios": [
                      0,
                      1
                    ],
                    "cx": -180.55,
                    "cy": 29.85,
                    "r": 8.49191994168902,
                    "fx": -180.55,
                    "fy": 29.85
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M-185.27,41.55L-177.35,42.3C-179.33,30.81,-177.65,18.2L-181.8,18.03C-182.4,29.94,-185.27,41.55"
                        }
                      ]
                    }
                  ]
                }
              }
            ]
          },
          {
            "label": "",
            "duration": 5,
            "motionTween": null,
            "elements": [
              {
                "type": "shape",
                "regX": 0,
                "regY": 0,
                "fills": [
                  {
                    "type": "radial",
                    "colors": [
                      "#A4D9FF",
                      "#043EFF"
                    ],
                    "ratios": [
                      0,
                      1
                    ],
                    "cx": -178.4,
                    "cy": 30,
                    "r": 8.6209048501948,
                    "fx": -178.4,
                    "fy": 30
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M-183.6,41.9L-175.1,41.9C-173.63,30.03,-176.85,18.15L-182.1,18.15C-180.7,30.03,-183.6,41.9"
                        }
                      ]
                    }
                  ]
                }
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
                    "type": "radial",
                    "colors": [
                      "#A4D9FF",
                      "#043EFF"
                    ],
                    "ratios": [
                      0,
                      1
                    ],
                    "cx": -179.05,
                    "cy": 30,
                    "r": 8,
                    "fx": -179.05,
                    "fy": 30
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M-183.6,41.9L-175.65,42L-176.85,18.15L-182.1,18.15L-183.6,41.9"
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