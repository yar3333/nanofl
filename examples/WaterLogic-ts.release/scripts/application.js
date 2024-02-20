/*
 * ATTENTION: The "eval" devtool has been used (maybe by default in mode: "development").
 * This devtool is neither made for production nor for readable output files.
 * It uses "eval()" calls to create a separate source file in the browser devtools.
 * If you are trying to read the output file, select a different devtool (https://webpack.js.org/configuration/devtool/)
 * or disable the default devtool with "devtool: false".
 * If you are looking for production-ready output files, see mode: "production" (https://webpack.js.org/configuration/mode/).
 */
/******/ (() => { // webpackBootstrap
/******/ 	// runtime can't be in strict mode because a global variable is assign and maybe created.
/******/ 	var __webpack_modules__ = ({

/***/ "./src/BaseBucket.ts":
/*!***************************!*\
  !*** ./src/BaseBucket.ts ***!
  \***************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   BaseBucket: () => (/* binding */ BaseBucket)\n/* harmony export */ });\nclass BaseBucket {\n    constructor(total, mc) {\n        this.fill = 0;\n        this.total = total;\n        this.mc = mc;\n    }\n    setFill(v) { }\n    getNeckPos() { return new createjs.Point(this.mc.x, this.mc.y); }\n}\n\n\n//# sourceURL=webpack://window/./src/BaseBucket.ts?");

/***/ }),

/***/ "./src/Bucket.ts":
/*!***********************!*\
  !*** ./src/Bucket.ts ***!
  \***********************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   Bucket: () => (/* binding */ Bucket)\n/* harmony export */ });\n/* harmony import */ var _BaseBucket__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./BaseBucket */ \"./src/BaseBucket.ts\");\n/* harmony import */ var _McBucket__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./McBucket */ \"./src/McBucket.ts\");\n/* harmony import */ var _autogen__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./autogen */ \"./src/autogen.ts\");\n\n\n\nclass Bucket extends _BaseBucket__WEBPACK_IMPORTED_MODULE_0__.BaseBucket {\n    constructor(baseMovie, total, x) {\n        super(total, new _McBucket__WEBPACK_IMPORTED_MODULE_1__.McBucket());\n        this.fallProcessPhase = 0; // 0 - nothing to do\n        // 1 - moving to preffered position\n        // 2 - rotation forward\n        // 3 - waiting water to fall out\n        // 4 - rotation backward\n        // 5 - moving to mouse position\n        this.fillProcessDest = null;\n        this.fillProcessFallFrame = 0;\n        this.baseMovie = baseMovie;\n        baseMovie.addChild(this.mc);\n        this.mc.x = x;\n        this.mc.y = 345;\n        this.mc.scaleX = this.mc.scaleY = Math.sqrt(total) * 40 / 100;\n        this.setFill(0);\n        this.activate(false);\n    }\n    activate(act) {\n        var mcForeColor = this.mc.getChildByName(\"mcForeColor\");\n        mcForeColor.visible = act;\n    }\n    getNeckPos() {\n        var mcNeck = this.mc.getChildByName(\"mcNeck\");\n        return new createjs.Point(this.mc.x + mcNeck.x * this.mc.scaleX, this.mc.y + mcNeck.y * this.mc.scaleY);\n    }\n    setFill(v) {\n        this.fill = v;\n        this.mc.getChildByName(\"tfLabel\").text = this.fill + \"/\" + this.total;\n        this.mc.gotoAndStop(Math.round(this.fill / this.total * 100));\n    }\n    fallToBucket(dest) {\n        var freeDest = dest.total - dest.fill;\n        if (freeDest > this.fill) {\n            dest.setFill(dest.fill + this.fill);\n            this.setFill(0);\n        }\n        else {\n            dest.setFill(dest.total);\n            this.setFill(this.fill - freeDest);\n        }\n    }\n    // начинает анимированный процесс переливание из текущей бутыли в заданную\n    startFallToBucketProcess(dest) {\n        if (this.fallProcessPhase != 0) {\n            console.log(\"StartFallProcess error 1\");\n            return;\n        }\n        this.fallProcessPhase = 1;\n        this.fillProcessDest = dest;\n        this.fillProcessFallFrame = 0;\n    }\n    // должна вызываться на каждом кадре, пока процесс переливания идёт\n    // (если будет вызвана когда процесс уже закончен - ничего страшного)\n    // возвращает - закончен ли процесс переливания\n    // mouseDX, mouseDY - смещение для последней фазы\n    fallProcessStep(mouseDX, mouseDY) {\n        if (this.fallProcessPhase == 0)\n            return true;\n        if (this.fallProcessPhase == 1) {\n            var thisNeck = this.getNeckPos();\n            var destNeck = this.fillProcessDest.getNeckPos();\n            var b = this.mc.getChildByName(\"mcBox\").getBounds();\n            var mustPos = new createjs.Point(destNeck.x + b.height * this.mc.scaleY, destNeck.y);\n            if (this.moveStepTo(mustPos, 6))\n                this.fallProcessPhase++;\n        }\n        else if (this.fallProcessPhase == 2) {\n            if (this.fill == 0 || this.fillProcessDest.fill == this.fillProcessDest.total)\n                this.fallProcessPhase++;\n            else {\n                if (this.mc.rotation > -90)\n                    this.mc.rotation -= 4;\n                else\n                    this.fallProcessPhase++;\n            }\n        }\n        else if (this.fallProcessPhase == 3) {\n            if (this.fill == 0 || this.fillProcessDest.fill == this.fillProcessDest.total)\n                this.fallProcessPhase++;\n        }\n        else if (this.fallProcessPhase == 4) {\n            if (this.mc.rotation < 0)\n                this.mc.rotation += 4;\n            else\n                this.fallProcessPhase++;\n        }\n        else if (this.fallProcessPhase == 5) {\n            var r = this.moveStepTo(new createjs.Point(this.mc.stage.mouseX + mouseDX, this.mc.stage.mouseY + mouseDY), 10);\n            if (r == true)\n                this.fallProcessPhase = 0;\n            return r;\n        }\n        if ((this.fallProcessPhase == 2 && this.mc.rotation < -40) || this.fallProcessPhase == 3) {\n            this.fillProcessFallFrame++;\n            if (this.fillProcessFallFrame % 7 == 6) {\n                if (this.fill > 0 && this.fillProcessDest.fill < this.fillProcessDest.total) {\n                    this.setFill(this.fill - 1);\n                    this.fillProcessDest.setFill(this.fillProcessDest.fill + 1);\n                    _autogen__WEBPACK_IMPORTED_MODULE_2__.Sounds.water();\n                }\n            }\n        }\n        return false;\n    }\n    moveStepTo(dest, step) {\n        var dx = dest.x - this.mc.x;\n        var dy = dest.y - this.mc.y;\n        var len = Math.sqrt(dx * dx + dy * dy);\n        if (len < step) {\n            this.mc.x = dest.x;\n            this.mc.y = dest.y;\n            return true;\n        }\n        else {\n            this.mc.x += dx / len * step;\n            this.mc.y += dy / len * step;\n            return false;\n        }\n    }\n}\n\n\n//# sourceURL=webpack://window/./src/Bucket.ts?");

/***/ }),

/***/ "./src/Game.ts":
/*!*********************!*\
  !*** ./src/Game.ts ***!
  \*********************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   Game: () => (/* binding */ Game)\n/* harmony export */ });\n/* harmony import */ var _autogen__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./autogen */ \"./src/autogen.ts\");\n/* harmony import */ var _BaseBucket__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./BaseBucket */ \"./src/BaseBucket.ts\");\n/* harmony import */ var _Bucket__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./Bucket */ \"./src/Bucket.ts\");\n/* harmony import */ var _Globals__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./Globals */ \"./src/Globals.ts\");\n\n\n\n\nclass Game extends _autogen__WEBPACK_IMPORTED_MODULE_0__.base.Game {\n    constructor() {\n        super(...arguments);\n        this.level = 0;\n        this.g = 1; // physic constant\n        this.midX = 520 / 2;\n        this.midY = 390 / 2;\n        this.buckets = new Array();\n        this.carry = null;\n        this.action = 0; // what to do with \"carry\" if user release it\n        // 0 - nothing\n        // 1-4 - see gameMode\n        this.fallTo = null;\n        this.gameMode = 0; // 0 - waiting to user\n        // 1 - tansfuse water from \"carry\" into \"fallTo\"\n        // 2 - filling \"carry\" from tap\n        // 3 - falling out from carry to trash\n        // 4 - moving bucket to floor\n        this.fallIntoBucketPhase = 0; // 0 - rotation for falling\n        // 1 - going to original position\n        this.tapWaiting = 0; // tick counter\n        this.fillBeforeTrash = 0;\n    }\n    init() {\n        this.parent.stop();\n        this.mcTap = this.parent.getChildByName(\"mcTap\");\n        this.mcTrash = this.parent.getChildByName(\"mcTrash\");\n        this.level = _Globals__WEBPACK_IMPORTED_MODULE_3__.Globals.level;\n        this.parent.getChildByName(\"tfLevel\").text = this.level + \"\";\n        var tfTask = this.parent.getChildByName(\"tfTask\");\n        switch (this.level) {\n            case 1:\n                tfTask.text = \"You need to measure 4 litres of water,\\nusing two buckets of 5 and 7 litres.\\nUse barrel (at the right) for filling buckets.\\nTo make buckets empty, use trash (at the left).\";\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 5, 220));\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 7, 320));\n            case 2:\n                tfTask.text = \"You need to measure 1 liter of water.\";\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 3, 180));\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 6, 280));\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 8, 380));\n            case 3:\n                tfTask.text = \"You need to measure 1 liter of water.\";\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 3, 220));\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 5, 320));\n            case 4:\n                tfTask.text = \"You need to got 1 liter of water in any two buckets.\";\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 3, 180));\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 4, 280));\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 6, 380));\n            case 5:\n                tfTask.text = \"You need to got 6 litres of water in bigger bucket,\\n4 liters in 5-bucket and 4 litres in 8-bucket.\";\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 3, 180));\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 5, 250));\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 8, 320));\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 12, 400));\n            case 6:\n                tfTask.text = \"You need to got 2 liter of water in any three buckets.\";\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 3, 180));\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 3, 250));\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 8, 320));\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 11, 400));\n            case 7:\n                tfTask.text = \"You need to got 1 liter of water in any two buckets..\";\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 2, 180));\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 3, 280));\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 9, 380));\n            case 8:\n                tfTask.text = \"You need to got 1 liter of water in small three buckets.\";\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 5, 180));\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 7, 250));\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 9, 320));\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 11, 400));\n            case 9:\n                tfTask.text = \"You need to fill buckets on increase:\\nsmallest bust be empty, next must contain 1 liter,\\nnext - 2 litres and bigger - 3 litres.\";\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 7, 180));\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 11, 250));\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 13, 320));\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 17, 400));\n            case 10:\n                tfTask.text = \"You must to got 18 litres in 19-bucket and 5 litres in 6-bucket.\";\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 2, 180));\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 6, 280));\n                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 19, 380));\n        }\n    }\n    onEnterFrame() {\n        switch (this.gameMode) {\n            case 0:\n                if (this.checkWin())\n                    this.parent.gotoAndStop(\"Win\");\n            case 1: // transfuse water from current bucket to another\n                this.fallTo.activate(false);\n                if (this.carry.fallProcessStep(this.carryDX, this.carryDY)) {\n                    this.gameMode = 0;\n                    this.selectAction();\n                }\n            case 2: // filling bucket from tap\n                if (this.carry.fill < this.carry.total) {\n                    if (this.mcTap.currentFrame != 2)\n                        this.mcTap.gotoAndStop(2);\n                    this.tapWaiting++;\n                    if (this.tapWaiting % 10 == 9) {\n                        this.carry.setFill(this.carry.fill + 1);\n                        _autogen__WEBPACK_IMPORTED_MODULE_0__.Sounds.tap();\n                        _autogen__WEBPACK_IMPORTED_MODULE_0__.Sounds.water();\n                    }\n                }\n                else // bucket is full\n                 {\n                    this.mcTap.gotoAndStop(0);\n                    if (this.carry.moveStepTo(new createjs.Point(this.stage.mouseX + this.carryDX, this.stage.mouseY + this.carryDY), 10)) {\n                        this.tapWaiting = 0;\n                        this.gameMode = 0;\n                        this.selectAction();\n                    }\n                }\n            case 3: // fall out to trash\n                if (this.carry.fallProcessStep(this.carryDX, this.carryDY)) {\n                    this.gameMode = 0;\n                    this.selectAction();\n                }\n                else {\n                    if (this.fillBeforeTrash > 0 && this.carry.fill < this.fillBeforeTrash) {\n                        this.fillBeforeTrash = this.carry.fill;\n                        _autogen__WEBPACK_IMPORTED_MODULE_0__.Sounds.trash();\n                    }\n                }\n            case 4: // moving bucket to the ground\n                if (this.carry.moveStepTo(new createjs.Point(this.carry.mc.x, 345), 6)) {\n                    this.carry = null;\n                    this.gameMode = 0;\n                    this.selectAction();\n                }\n        }\n    }\n    onMouseDown(e) {\n        if (this.gameMode != 0)\n            return;\n        if (this.carry == null) // nothing carried\n         {\n            for (let i = 0; i < this.buckets.length; i++) {\n                var pos = this.buckets[i].mc.globalToLocal(e.stageX, e.stageY);\n                if (this.buckets[i].mc.hitTest(pos.x, pos.y)) {\n                    this.carry = this.buckets[i];\n                    this.carryDX = this.buckets[i].mc.x - e.stageX;\n                    this.carryDY = this.buckets[i].mc.y - e.stageY;\n                    // move bucket to the front\n                    for (let j = 0; j < this.buckets.length; j++) {\n                        if (this.getChildIndex(this.buckets[j].mc) > this.getChildIndex(this.carry.mc)) {\n                            this.swapChildren(this.buckets[j].mc, this.carry.mc);\n                        }\n                    }\n                    console.log(\"carry \" + new createjs.Point(this.carry.mc.x, this.carry.mc.y));\n                    console.log(\"neck \" + this.carry.getNeckPos());\n                    break;\n                }\n            }\n        }\n        else // user have bucket\n         {\n            this.gameMode = this.action;\n            if (this.gameMode == 1)\n                this.carry.startFallToBucketProcess(this.fallTo);\n            else if (this.gameMode == 2) {\n                this.tapWaiting = 0;\n                this.carry.mc.x = this.mcTap.x;\n            }\n            else if (this.gameMode == 3) {\n                this.fillBeforeTrash = this.carry.fill;\n                var sliv = new _BaseBucket__WEBPACK_IMPORTED_MODULE_1__.BaseBucket(1000, this.mcTrash);\n                this.carry.startFallToBucketProcess(sliv);\n            }\n        }\n    }\n    onMouseUp(e) {\n        if (this.gameMode != 0)\n            return;\n    }\n    onMouseMove(e) {\n        if (this.gameMode != 0)\n            return;\n        this.selectAction();\n        if (this.carry != null) {\n            this.carry.mc.x = e.stageX + this.carryDX;\n            this.carry.mc.y = e.stageY + this.carryDY;\n        }\n    }\n    selectAction() {\n        this.action = 0;\n        if (this.carry == null)\n            return;\n        var carryNeckPos = this.carry.getNeckPos();\n        // want to fill from tap?\n        if (Math.abs(carryNeckPos.x - this.mcTap.x) < this.carry.mc.scaleX * 8 && carryNeckPos.y - this.mcTap.y > -5 && carryNeckPos.y - this.mcTap.y < 40) {\n            this.action = 2;\n            this.mcTap.gotoAndStop(1);\n            return;\n        }\n        this.mcTap.gotoAndStop(0);\n        // want to fall out to trash?\n        if (this.carry.mc.x < 165 && this.carry.mc.y <= 350) {\n            this.action = 3;\n            this.mcTrash.gotoAndStop(1);\n            return;\n        }\n        this.mcTrash.gotoAndStop(0);\n        // want to transfuse to another bucket?\n        var bucket = this.findNearestBucket();\n        if (this.carry.mc.getTransformedBounds().intersects(bucket.mc.getTransformedBounds())) {\n            this.action = 1;\n            this.fallTo = bucket;\n            bucket.activate(true);\n            for (const bucket of this.buckets)\n                if (bucket != this.fallTo)\n                    bucket.activate(false);\n        }\n        else {\n            for (const bucket of this.buckets)\n                bucket.activate(false);\n        }\n        // want to release bucket (move to floor)\n        if (this.action == 0) {\n            this.action = 4;\n        }\n    }\n    findNearestBucket() {\n        var bestBot = null;\n        var bestDist = 1e10;\n        for (const b of this.buckets) {\n            if (b == this.carry)\n                continue;\n            var dx = this.carry.mc.x - b.mc.x;\n            var dy = this.carry.mc.y - b.mc.y;\n            var dist = Math.sqrt(dx * dx + dy * dy);\n            if (dist < bestDist) {\n                bestBot = b;\n                bestDist = dist;\n            }\n        }\n        return bestBot;\n    }\n    checkWin() {\n        switch (this.level) {\n            case 1: return this.buckets[0].fill == 4 || this.buckets[1].fill == 4;\n            case 2: return this.buckets[0].fill == 1 || this.buckets[1].fill == 1 || this.buckets[2].fill == 1;\n            case 3: return this.buckets[0].fill == 1 || this.buckets[1].fill == 1;\n            case 4: return this.buckets.filter(bucket => bucket.fill == 1).length >= 2;\n            case 5: return this.buckets[1].fill == 4 && this.buckets[2].fill == 4 && this.buckets[3].fill == 6;\n            case 6: return this.buckets.filter(bucket => bucket.fill == 2).length >= 3;\n            case 7: return this.buckets.filter(bucket => bucket.fill == 1).length >= 2;\n            case 8: return this.buckets[0].fill == 1 && this.buckets[1].fill == 1 && this.buckets[2].fill == 1;\n            case 9: return this.buckets[0].fill == 0 && this.buckets[1].fill == 1 && this.buckets[2].fill == 2 && this.buckets[3].fill == 3;\n            case 10: return this.buckets[1].fill == 5 && this.buckets[2].fill == 18;\n        }\n        return false;\n    }\n}\n\n\n//# sourceURL=webpack://window/./src/Game.ts?");

/***/ }),

/***/ "./src/Globals.ts":
/*!************************!*\
  !*** ./src/Globals.ts ***!
  \************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   Globals: () => (/* binding */ Globals)\n/* harmony export */ });\nclass Globals {\n}\nGlobals.level = 1;\n\n\n//# sourceURL=webpack://window/./src/Globals.ts?");

/***/ }),

/***/ "./src/McBucket.ts":
/*!*************************!*\
  !*** ./src/McBucket.ts ***!
  \*************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   McBucket: () => (/* binding */ McBucket)\n/* harmony export */ });\n/* harmony import */ var _autogen__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./autogen */ \"./src/autogen.ts\");\n\nclass McBucket extends _autogen__WEBPACK_IMPORTED_MODULE_0__.base.McBucket {\n}\n\n\n//# sourceURL=webpack://window/./src/McBucket.ts?");

/***/ }),

/***/ "./src/MusicButton.ts":
/*!****************************!*\
  !*** ./src/MusicButton.ts ***!
  \****************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   MusicButton: () => (/* binding */ MusicButton)\n/* harmony export */ });\n/* harmony import */ var _autogen__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./autogen */ \"./src/autogen.ts\");\n\nclass MusicButton extends _autogen__WEBPACK_IMPORTED_MODULE_0__.base.MusicButton {\n    constructor() {\n        super();\n        this.cursor = \"pointer\";\n        this.musicOn();\n    }\n    onMouseUp(e) {\n        if (this.getBounds().contains(e.localX, e.localY)) {\n            if (this.currentFrame == 1)\n                this.musicOn();\n            else\n                this.musicOff();\n        }\n    }\n    musicOn() {\n        this.gotoAndStop(0);\n        this.soundLoop = new nanofl.SeamlessSoundLoop(_autogen__WEBPACK_IMPORTED_MODULE_0__.Sounds.music());\n        this.addEventListener(\"removed\", () => this.soundLoop.stop());\n    }\n    musicOff() {\n        this.gotoAndStop(1);\n        this.soundLoop.stop();\n    }\n}\n\n\n//# sourceURL=webpack://window/./src/MusicButton.ts?");

/***/ }),

/***/ "./src/Scene.ts":
/*!**********************!*\
  !*** ./src/Scene.ts ***!
  \**********************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   Scene: () => (/* binding */ Scene)\n/* harmony export */ });\n/* harmony import */ var _autogen__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./autogen */ \"./src/autogen.ts\");\n\nclass Scene extends _autogen__WEBPACK_IMPORTED_MODULE_0__.base.Scene {\n    constructor() {\n        super(...arguments);\n        this.lastInitFrame = null;\n    }\n    onEnterFrame() {\n        if (this.currentFrame != this.lastInitFrame) {\n            this.lastInitFrame = this.currentFrame;\n            this.addButtonHandler(\"btGotoGame\", () => this.gotoAndStop(\"Game\"));\n            this.addButtonHandler(\"btRules\", () => this.gotoAndStop(\"Rules\"));\n            this.addButtonHandler(\"btScores\", () => this.gotoAndStop(\"Scores\"));\n            this.addButtonHandler(\"btGotoOrigin\", () => this.gotoAndStop(\"Origin\"));\n        }\n    }\n    addButtonHandler(name, f) {\n        var bt = this.getChildByName(name);\n        if (bt != null)\n            bt.addEventListener(\"click\", () => f());\n    }\n}\n\n\n//# sourceURL=webpack://window/./src/Scene.ts?");

/***/ }),

/***/ "./src/application.ts":
/*!****************************!*\
  !*** ./src/application.ts ***!
  \****************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   Game: () => (/* reexport safe */ _Game__WEBPACK_IMPORTED_MODULE_0__.Game),\n/* harmony export */   McBucket: () => (/* reexport safe */ _McBucket__WEBPACK_IMPORTED_MODULE_1__.McBucket),\n/* harmony export */   MusicButton: () => (/* reexport safe */ _MusicButton__WEBPACK_IMPORTED_MODULE_2__.MusicButton),\n/* harmony export */   Scene: () => (/* reexport safe */ _Scene__WEBPACK_IMPORTED_MODULE_3__.Scene)\n/* harmony export */ });\n/* harmony import */ var _Game__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./Game */ \"./src/Game.ts\");\n/* harmony import */ var _McBucket__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./McBucket */ \"./src/McBucket.ts\");\n/* harmony import */ var _MusicButton__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./MusicButton */ \"./src/MusicButton.ts\");\n/* harmony import */ var _Scene__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./Scene */ \"./src/Scene.ts\");\n\n\n\n\n\n\n//# sourceURL=webpack://window/./src/application.ts?");

/***/ }),

/***/ "./src/autogen.ts":
/*!************************!*\
  !*** ./src/autogen.ts ***!
  \************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   Sounds: () => (/* binding */ Sounds),\n/* harmony export */   base: () => (/* binding */ base)\n/* harmony export */ });\n// This file is autogenerated by NanoFL\n/// <reference types='nanofl-ts' />\nvar base;\n(function (base) {\n    class McBucket extends nanofl.MovieClip {\n        constructor() {\n            super(nanofl.Player.library.getItem(\"bucket\"));\n        }\n        get mcNeck() { return this.getChildByName(\"mcNeck\"); }\n        get tfLabel() { return this.getChildByName(\"tfLabel\"); }\n        get mcForeColor() { return this.getChildByName(\"mcForeColor\"); }\n        get mcBox() { return this.getChildByName(\"mcBox\"); }\n    }\n    base.McBucket = McBucket;\n    class Game extends nanofl.MovieClip {\n        constructor() {\n            super(nanofl.Player.library.getItem(\"game\"));\n        }\n    }\n    base.Game = Game;\n    class MusicButton extends nanofl.MovieClip {\n        constructor() {\n            super(nanofl.Player.library.getItem(\"musicButton\"));\n        }\n    }\n    base.MusicButton = MusicButton;\n    class Scene extends nanofl.MovieClip {\n        constructor() {\n            super(nanofl.Player.library.getItem(\"scene\"));\n        }\n        get btGotoGame() { return this.getChildByName(\"btGotoGame\"); }\n        get btRules() { return this.getChildByName(\"btRules\"); }\n        get btGotoOrigin() { return this.getChildByName(\"btGotoOrigin\"); }\n        get tfLevel() { return this.getChildByName(\"tfLevel\"); }\n        get mcTrash() { return this.getChildByName(\"mcTrash\"); }\n        get game() { return this.getChildByName(\"game\"); }\n        get tfTask() { return this.getChildByName(\"tfTask\"); }\n        get mcTap() { return this.getChildByName(\"mcTap\"); }\n    }\n    base.Scene = Scene;\n})(base || (base = {}));\nclass Sounds {\n    static bucket(interrupt, delay, offset, loop, volume, pan) { return createjs.Sound.play(\"bucket\", interrupt, delay, offset, loop, volume, pan); }\n    static music(interrupt, delay, offset, loop, volume, pan) { return createjs.Sound.play(\"music\", interrupt, delay, offset, loop, volume, pan); }\n    static tap(interrupt, delay, offset, loop, volume, pan) { return createjs.Sound.play(\"tap\", interrupt, delay, offset, loop, volume, pan); }\n    static trash(interrupt, delay, offset, loop, volume, pan) { return createjs.Sound.play(\"trash\", interrupt, delay, offset, loop, volume, pan); }\n    static water(interrupt, delay, offset, loop, volume, pan) { return createjs.Sound.play(\"water\", interrupt, delay, offset, loop, volume, pan); }\n}\n\n\n//# sourceURL=webpack://window/./src/autogen.ts?");

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		var cachedModule = __webpack_module_cache__[moduleId];
/******/ 		if (cachedModule !== undefined) {
/******/ 			return cachedModule.exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId](module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
/******/ 	/* webpack/runtime/define property getters */
/******/ 	(() => {
/******/ 		// define getter functions for harmony exports
/******/ 		__webpack_require__.d = (exports, definition) => {
/******/ 			for(var key in definition) {
/******/ 				if(__webpack_require__.o(definition, key) && !__webpack_require__.o(exports, key)) {
/******/ 					Object.defineProperty(exports, key, { enumerable: true, get: definition[key] });
/******/ 				}
/******/ 			}
/******/ 		};
/******/ 	})();
/******/ 	
/******/ 	/* webpack/runtime/hasOwnProperty shorthand */
/******/ 	(() => {
/******/ 		__webpack_require__.o = (obj, prop) => (Object.prototype.hasOwnProperty.call(obj, prop))
/******/ 	})();
/******/ 	
/******/ 	/* webpack/runtime/make namespace object */
/******/ 	(() => {
/******/ 		// define __esModule on exports
/******/ 		__webpack_require__.r = (exports) => {
/******/ 			if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 				Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 			}
/******/ 			Object.defineProperty(exports, '__esModule', { value: true });
/******/ 		};
/******/ 	})();
/******/ 	
/************************************************************************/
/******/ 	
/******/ 	// startup
/******/ 	// Load entry module and return exports
/******/ 	// This entry module can't be inlined because the eval devtool is used.
/******/ 	var __webpack_exports__ = __webpack_require__("./src/application.ts");
/******/ 	var __webpack_export_target__ = (window = typeof window === "undefined" ? {} : window);
/******/ 	for(var i in __webpack_exports__) __webpack_export_target__[i] = __webpack_exports__[i];
/******/ 	if(__webpack_exports__.__esModule) Object.defineProperty(__webpack_export_target__, "__esModule", { value: true });
/******/ 	
/******/ })()
;