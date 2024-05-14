libraryData =
{
  "LibraryItem 1": {
    "type": "movieclip",
    "version": "2.4.0",
    "linkedClass": "",
    "autoPlay": true,
    "loop": true,
    "layers": [
      {
        "name": "Layer 0",
        "type": "normal",
        "visible": true,
        "locked": false,
        "keyFrames": [
          {
            "elements": [
              {
                "type": "shape",
                "regX": 0,
                "regY": 0,
                "fills": [
                  {
                    "type": "solid",
                    "color": "green"
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M-70,-37.19L-70,9.19L70,9.19L70,-37.19L-70,-37.19"
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
  "LibraryItem 2": {
    "type": "movieclip",
    "version": "2.4.0",
    "linkedClass": "",
    "autoPlay": true,
    "loop": true,
    "layers": [
      {
        "name": "Layer 1",
        "type": "mask",
        "visible": true,
        "locked": true,
        "keyFrames": [
          {
            "elements": [
              {
                "type": "shape",
                "regX": 0,
                "regY": 0,
                "fills": [
                  {
                    "type": "solid",
                    "color": "#800000"
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M-88.09,-53.73L-88.09,22.36L-7.73,22.36L-7.73,-53.73L-88.09,-53.73"
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
        "name": "Layer 0",
        "type": "normal",
        "visible": true,
        "locked": true,
        "parentIndex": 0,
        "keyFrames": [
          {
            "elements": [
              {
                "type": "instance",
                "libraryItem": "LibraryItem 1",
                "name": "",
                "regX": 0,
                "regY": 0,
                "filters": [
                  {
                    "name": "BoxBlurFilter",
                    "params": {
                      "blurX": 20,
                      "blurY": 10,
                      "quality": "1"
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
  "LibraryItem 3": {
    "type": "movieclip",
    "version": "2.4.0",
    "linkedClass": "",
    "autoPlay": true,
    "loop": true,
    "layers": [
      {
        "name": "Layer 0",
        "type": "normal",
        "visible": true,
        "locked": false,
        "keyFrames": [
          {
            "elements": [
              {
                "type": "instance",
                "libraryItem": "LibraryItem 1",
                "name": "",
                "x": 0,
                "y": 14,
                "regX": 0,
                "regY": 0,
                "filters": [
                  {
                    "name": "BoxBlurFilter",
                    "params": {
                      "blurX": 20,
                      "blurY": 10,
                      "quality": "1"
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
  "scene": {
    "type": "movieclip",
    "version": "2.4.0",
    "linkedClass": "",
    "autoPlay": true,
    "loop": true,
    "layers": [
      {
        "name": "Layer 1",
        "type": "mask",
        "visible": true,
        "locked": true,
        "keyFrames": [
          {
            "elements": [
              {
                "type": "shape",
                "regX": 0,
                "regY": 0,
                "fills": [
                  {
                    "type": "solid",
                    "color": "#800000"
                  }
                ],
                "figure": {
                  "edges": [],
                  "polygons": [
                    {
                      "fillIndex": 0,
                      "contours": [
                        {
                          "edges": "M10.22,4.76L10.22,189.99L118.05,189.99L118.05,4.76L10.22,4.76"
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
        "name": "Layer 0",
        "type": "normal",
        "visible": true,
        "locked": true,
        "parentIndex": 0,
        "keyFrames": [
          {
            "elements": [
              {
                "type": "instance",
                "libraryItem": "LibraryItem 1",
                "name": "",
                "x": 132,
                "y": 69,
                "regX": 0,
                "regY": 0,
                "filters": [
                  {
                    "name": "BoxBlurFilter",
                    "params": {
                      "blurX": 20,
                      "blurY": 10,
                      "quality": "1"
                    }
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
            "elements": [
              {
                "type": "instance",
                "libraryItem": "LibraryItem 3",
                "name": "",
                "x": 131.5,
                "y": 142,
                "regX": 0,
                "regY": 0
              }
            ]
          }
        ]
      },
      {
        "name": "Layer 3",
        "type": "normal",
        "visible": true,
        "locked": true,
        "keyFrames": [
          {
            "elements": [
              {
                "type": "instance",
                "libraryItem": "LibraryItem 2",
                "name": "",
                "x": 126,
                "y": 252,
                "regX": 0,
                "regY": 0
              }
            ]
          }
        ]
      }
    ]
  }
}