libraryData =
{
  "$groups/00000001-018EF668-0000163F-18C0-834A": {
    "type": "movieclip",
    "version": "2.4.0",
    "elements": [
      {
        "type": "shape",
        "regX": 0,
        "regY": 0,
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
              "edges": "M55.5,-35L-55.5,35"
            }
          ],
          "polygons": []
        }
      }
    ]
  },
  "$groups/00000002-018EF669-000024D7-E433-51F2": {
    "type": "movieclip",
    "version": "2.4.0",
    "elements": [
      {
        "type": "shape",
        "regX": 0,
        "regY": 0,
        "fills": [
          {
            "type": "solid",
            "color": "#f9b233"
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
              "edges": "M-92,-66.5L-92,66.5L92,66.5L92,-66.5L-92,-66.5"
            }
          ],
          "polygons": [
            {
              "fillIndex": 0,
              "contours": [
                {
                  "edges": "M-92,-66.5L-92,66.5L92,66.5L92,-66.5L-92,-66.5"
                }
              ]
            }
          ]
        }
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
        "name": "Label",
        "type": "normal",
        "visible": true,
        "locked": false,
        "keyFrames": [
          {
            "elements": [
              {
                "type": "instance",
                "libraryItem": "$groups/00000002-018EF669-000024D7-E433-51F2",
                "name": "",
                "x": 298.5,
                "y": 223.5,
                "regX": 0,
                "regY": 0
              },
              {
                "type": "instance",
                "libraryItem": "$groups/00000001-018EF668-0000163F-18C0-834A",
                "name": "",
                "x": 232,
                "y": 171,
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