libraryData =
{
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
        "name": "Label",
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
                "libraryItem": "tweenBottle",
                "name": "",
                "x": 194.5,
                "y": 66,
                "matrix": [
                  0.544444444444392,
                  0,
                  0,
                  0.544444444444447
                ],
                "regX": 0,
                "regY": 0,
                "blendMode": "normal",
                "meshParams": 0
              },
              {
                "type": "instance",
                "libraryItem": "tweenLetter",
                "name": "",
                "x": 334,
                "y": 149.5,
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
  "tweenBottle": {
    "type": "movieclip",
    "version": "2.3.0",
    "linkedClass": "",
    "autoPlay": true,
    "loop": true,
    "likeButton": false,
    "exportAsSpriteSheet": false,
    "textureAtlas": "atlas_0",
    "layers": [
      {
        "name": "Layer 0",
        "type": "normal",
        "visible": true,
        "locked": false,
        "keyFrames": [
          {
            "label": "",
            "duration": 43,
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
                "libraryItem": "bottle",
                "name": "",
                "x": -327.5,
                "y": -104,
                "matrix": [
                  0.469964664310964,
                  0,
                  0,
                  0.469964664310954
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
                "libraryItem": "bottle",
                "name": "",
                "x": 90.0102040816157,
                "y": 397.285714285713,
                "matrix": [
                  1.86255725690352,
                  0,
                  0,
                  0.713780918727916
                ],
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
  "tweenLetter": {
    "type": "movieclip",
    "version": "2.3.0",
    "linkedClass": "",
    "autoPlay": true,
    "loop": true,
    "likeButton": false,
    "exportAsSpriteSheet": false,
    "textureAtlas": "atlas_0",
    "layers": [
      {
        "name": "Layer 0",
        "type": "normal",
        "visible": true,
        "locked": false,
        "keyFrames": [
          {
            "label": "",
            "duration": 49,
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
                "libraryItem": "letter",
                "name": "",
                "x": -220.525,
                "y": 166.5,
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
                "libraryItem": "letter",
                "name": "",
                "x": 52.475,
                "y": -68.5,
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