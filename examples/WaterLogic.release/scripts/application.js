/******/ (() => { // webpackBootstrap
/******/ 	// runtime can't be in strict mode because a global variable is assign and maybe created.
/******/ 	var __webpack_modules__ = ({

/***/ "./src/Bucket.ts":
/*!***********************!*\
  !*** ./src/Bucket.ts ***!
  \***********************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   Bucket: () => (/* binding */ Bucket)
/* harmony export */ });
/* harmony import */ var _WaterContainer__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./WaterContainer */ "./src/WaterContainer.ts");
/* harmony import */ var _McBucket__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./McBucket */ "./src/McBucket.ts");
/* harmony import */ var _autogen__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./autogen */ "./src/autogen.ts");



class Bucket extends _WaterContainer__WEBPACK_IMPORTED_MODULE_0__.WaterContainer {
    constructor(parent, total, x) {
        super(total, new _McBucket__WEBPACK_IMPORTED_MODULE_1__.McBucket());
        this.fallProcessPhase = 0; // 0 - nothing to do
        // 1 - moving to preffered position
        // 2 - rotation forward
        // 3 - waiting water to fall out
        // 4 - rotation backward
        // 5 - moving to mouse position
        this.fillProcessDest = null;
        this.fillProcessFallFrame = 0;
        parent.addChild(this.mc);
        this.mc.x = x;
        this.mc.y = 345;
        this.mc.scaleX = this.mc.scaleY = Math.sqrt(total) * 40 / 100;
        this.setFill(0);
        this.activate(false);
    }
    activate(act) {
        var mcForeColor = this.mc.mcForeColor;
        mcForeColor.visible = act;
    }
    getNeckPos() {
        var mcNeck = this.mc.mcNeck;
        return new createjs.Point(this.mc.x + mcNeck.x * this.mc.scaleX, this.mc.y + mcNeck.y * this.mc.scaleY);
    }
    setFill(v) {
        this._fill = v;
        this.mc.tfLabel.text = this.fill + "/" + this.total;
        this.mc.gotoAndStop(Math.round(this.fill / this.total * 100));
    }
    fallToBucket(dest) {
        var freeDest = dest.total - dest.fill;
        if (freeDest > this.fill) {
            dest.setFill(dest.fill + this.fill);
            this.setFill(0);
        }
        else {
            dest.setFill(dest.total);
            this.setFill(this.fill - freeDest);
        }
    }
    // начинает анимированный процесс переливание из текущей бутыли в заданную
    startFallToBucketProcess(dest) {
        if (this.fallProcessPhase != 0) {
            console.log("StartFallProcess error 1");
            return;
        }
        this.fallProcessPhase = 1;
        this.fillProcessDest = dest;
        this.fillProcessFallFrame = 0;
    }
    // должна вызываться на каждом кадре, пока процесс переливания идёт
    // (если будет вызвана когда процесс уже закончен - ничего страшного)
    // возвращает - закончен ли процесс переливания
    // mouseDX, mouseDY - смещение для последней фазы
    fallProcessStep(mouseDX, mouseDY) {
        if (this.fallProcessPhase == 0)
            return true;
        if (this.fallProcessPhase == 1) {
            var destNeck = this.fillProcessDest.getNeckPos();
            var b = this.mc.mcBox.getBounds();
            var mustPos = new createjs.Point(destNeck.x + b.height * this.mc.scaleY, destNeck.y);
            if (this.moveStepTo(mustPos, 6))
                this.fallProcessPhase++;
        }
        else if (this.fallProcessPhase == 2) {
            if (this.fill == 0 || this.fillProcessDest.fill == this.fillProcessDest.total)
                this.fallProcessPhase++;
            else {
                if (this.mc.rotation > -90)
                    this.mc.rotation -= 4;
                else
                    this.fallProcessPhase++;
            }
        }
        else if (this.fallProcessPhase == 3) {
            if (this.fill == 0 || this.fillProcessDest.fill == this.fillProcessDest.total)
                this.fallProcessPhase++;
        }
        else if (this.fallProcessPhase == 4) {
            if (this.mc.rotation < 0)
                this.mc.rotation += 4;
            else
                this.fallProcessPhase++;
        }
        else if (this.fallProcessPhase == 5) {
            var r = this.moveStepTo(new createjs.Point(this.mc.stage.mouseX + mouseDX, this.mc.stage.mouseY + mouseDY), 10);
            if (r == true)
                this.fallProcessPhase = 0;
            return r;
        }
        if ((this.fallProcessPhase == 2 && this.mc.rotation < -40) || this.fallProcessPhase == 3) {
            this.fillProcessFallFrame++;
            if (this.fillProcessFallFrame % 7 == 6) {
                if (this.fill > 0 && this.fillProcessDest.fill < this.fillProcessDest.total) {
                    this.setFill(this.fill - 1);
                    this.fillProcessDest.setFill(this.fillProcessDest.fill + 1);
                    _autogen__WEBPACK_IMPORTED_MODULE_2__.Sounds.water();
                }
            }
        }
        return false;
    }
    moveStepTo(dest, step) {
        var dx = dest.x - this.mc.x;
        var dy = dest.y - this.mc.y;
        var len = Math.sqrt(dx * dx + dy * dy);
        if (len < step) {
            this.mc.x = dest.x;
            this.mc.y = dest.y;
            return true;
        }
        else {
            this.mc.x += dx / len * step;
            this.mc.y += dy / len * step;
            return false;
        }
    }
}


/***/ }),

/***/ "./src/Game.ts":
/*!*********************!*\
  !*** ./src/Game.ts ***!
  \*********************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   Game: () => (/* binding */ Game)
/* harmony export */ });
/* harmony import */ var _autogen__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./autogen */ "./src/autogen.ts");
/* harmony import */ var _WaterContainer__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./WaterContainer */ "./src/WaterContainer.ts");
/* harmony import */ var _Bucket__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./Bucket */ "./src/Bucket.ts");



class Game extends _autogen__WEBPACK_IMPORTED_MODULE_0__.base.Game {
    constructor() {
        super(...arguments);
        this.level = 0;
        this.buckets = new Array();
        this.carry = null;
        this.action = 0; // what to do with "carry" if user release it
        // 0 - nothing
        // 1-4 - see gameMode
        this.fallTo = null;
        this.gameMode = 0; // 0 - waiting to user
        // 1 - tansfuse water from "carry" into "fallTo"
        // 2 - filling "carry" from tap
        // 3 - falling out from carry to trash
        // 4 - moving bucket to floor
        this.tapWaiting = 0; // tick counter
        this.fillBeforeTrash = 0;
    }
    init() {
        this.parent.stop();
        this.level = this.parent.level;
        this.parent.tfLevel.text = this.level + "";
        switch (this.level) {
            case 1:
                this.parent.tfTask.text = "You need to measure 4 litres of water,\nusing two buckets of 5 and 7 litres.\nUse barrel (at the right) for filling buckets.\nTo make buckets empty, use trash (at the left).";
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 5, 220));
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 7, 320));
                break;
            case 2:
                this.parent.tfTask.text = "You need to measure 1 liter of water.";
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 3, 180));
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 6, 280));
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 8, 380));
                break;
            case 3:
                this.parent.tfTask.text = "You need to measure 1 liter of water.";
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 3, 220));
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 5, 320));
                break;
            case 4:
                this.parent.tfTask.text = "You need to got 1 liter of water in any two buckets.";
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 3, 180));
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 4, 280));
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 6, 380));
                break;
            case 5:
                this.parent.tfTask.text = "You need to got 6 litres of water in bigger bucket,\n4 liters in 5-bucket and 4 litres in 8-bucket.";
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 3, 180));
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 5, 250));
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 8, 320));
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 12, 400));
                break;
            case 6:
                this.parent.tfTask.text = "You need to got 2 liter of water in any three buckets.";
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 3, 180));
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 3, 250));
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 8, 320));
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 11, 400));
                break;
            case 7:
                this.parent.tfTask.text = "You need to got 1 liter of water in any two buckets..";
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 2, 180));
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 3, 280));
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 9, 380));
                break;
            case 8:
                this.parent.tfTask.text = "You need to got 1 liter of water in small three buckets.";
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 5, 180));
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 7, 250));
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 9, 320));
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 11, 400));
                break;
            case 9:
                this.parent.tfTask.text = "You need to fill buckets on increase:\nsmallest bust be empty, next must contain 1 liter,\nnext - 2 litres and bigger - 3 litres.";
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 7, 180));
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 11, 250));
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 13, 320));
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 17, 400));
                break;
            case 10:
                this.parent.tfTask.text = "You must to got 18 litres in 19-bucket and 5 litres in 6-bucket.";
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 2, 180));
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 6, 280));
                this.buckets.push(new _Bucket__WEBPACK_IMPORTED_MODULE_2__.Bucket(this, 19, 380));
                break;
        }
    }
    onEnterFrame() {
        switch (this.gameMode) {
            case 0:
                if (this.checkWin()) {
                    this.parent.level++;
                    this.parent.gotoAndStop("Win");
                }
                break;
            case 1: // transfuse water from current bucket to another
                this.fallTo.activate(false);
                if (this.carry.fallProcessStep(this.carryDX, this.carryDY)) {
                    this.gameMode = 0;
                    this.selectAction();
                }
                break;
            case 2: // filling bucket from tap
                if (this.carry.fill < this.carry.total) {
                    if (this.parent.mcTap.currentFrame != 2)
                        this.parent.mcTap.gotoAndStop(2);
                    this.tapWaiting++;
                    if (this.tapWaiting % 10 == 9) {
                        this.carry.setFill(this.carry.fill + 1);
                        _autogen__WEBPACK_IMPORTED_MODULE_0__.Sounds.tap();
                        _autogen__WEBPACK_IMPORTED_MODULE_0__.Sounds.water();
                    }
                }
                else // bucket is full
                 {
                    this.parent.mcTap.gotoAndStop(0);
                    if (this.carry.moveStepTo(new createjs.Point(this.stage.mouseX + this.carryDX, this.stage.mouseY + this.carryDY), 10)) {
                        this.tapWaiting = 0;
                        this.gameMode = 0;
                        this.selectAction();
                    }
                }
                break;
            case 3: // fall out to trash
                if (this.carry.fallProcessStep(this.carryDX, this.carryDY)) {
                    this.gameMode = 0;
                    this.selectAction();
                }
                else {
                    if (this.fillBeforeTrash > 0 && this.carry.fill < this.fillBeforeTrash) {
                        this.fillBeforeTrash = this.carry.fill;
                        _autogen__WEBPACK_IMPORTED_MODULE_0__.Sounds.trash();
                    }
                }
                break;
            case 4: // moving bucket to the ground
                if (this.carry.moveStepTo(new createjs.Point(this.carry.mc.x, 345), 6)) {
                    this.carry = null;
                    this.gameMode = 0;
                    this.selectAction();
                }
                break;
        }
    }
    onMouseDown(e) {
        if (this.gameMode != 0)
            return;
        if (this.carry == null) // nothing carried
         {
            for (let i = 0; i < this.buckets.length; i++) {
                var pos = this.buckets[i].mc.globalToLocal(e.stageX, e.stageY);
                if (this.buckets[i].mc.hitTest(pos.x, pos.y)) {
                    this.carry = this.buckets[i];
                    this.carryDX = this.buckets[i].mc.x - e.stageX;
                    this.carryDY = this.buckets[i].mc.y - e.stageY;
                    // move bucket to the front
                    for (let j = 0; j < this.buckets.length; j++) {
                        if (this.getChildIndex(this.buckets[j].mc) > this.getChildIndex(this.carry.mc)) {
                            this.swapChildren(this.buckets[j].mc, this.carry.mc);
                        }
                    }
                    console.log("carry " + new createjs.Point(this.carry.mc.x, this.carry.mc.y));
                    console.log("neck " + this.carry.getNeckPos());
                    break;
                }
            }
        }
        else // user have bucket
         {
            this.gameMode = this.action;
            if (this.gameMode == 1) {
                this.carry.startFallToBucketProcess(this.fallTo);
            }
            else if (this.gameMode == 2) {
                this.tapWaiting = 0;
                this.carry.mc.x = this.parent.mcTap.x;
            }
            else if (this.gameMode == 3) {
                this.fillBeforeTrash = this.carry.fill;
                const trash = new _WaterContainer__WEBPACK_IMPORTED_MODULE_1__.WaterContainer(1000, this.parent.mcTrash);
                this.carry.startFallToBucketProcess(trash);
            }
        }
    }
    onMouseUp(e) {
        if (this.gameMode != 0)
            return;
    }
    onMouseMove(e) {
        if (this.gameMode != 0)
            return;
        this.selectAction();
        if (this.carry != null) {
            this.carry.mc.x = e.stageX + this.carryDX;
            this.carry.mc.y = e.stageY + this.carryDY;
        }
    }
    selectAction() {
        this.action = 0;
        if (this.carry == null)
            return;
        var carryNeckPos = this.carry.getNeckPos();
        // want to fill from tap?
        if (Math.abs(carryNeckPos.x - this.parent.mcTap.x) < this.carry.mc.scaleX * 8
            && carryNeckPos.y - this.parent.mcTap.y > -5
            && carryNeckPos.y - this.parent.mcTap.y < 40) {
            this.action = 2;
            this.parent.mcTap.gotoAndStop(1);
            return;
        }
        this.parent.mcTap.gotoAndStop(0);
        // want to fall out to trash?
        if (this.carry.mc.x < 165 && this.carry.mc.y <= 350) {
            this.action = 3;
            this.parent.mcTrash.gotoAndStop(1);
            return;
        }
        this.parent.mcTrash.gotoAndStop(0);
        // want to transfuse to another bucket?
        var bucket = this.findNearestBucket();
        if (this.carry.mc.getTransformedBounds().intersects(bucket.mc.getTransformedBounds())) {
            this.action = 1;
            this.fallTo = bucket;
            bucket.activate(true);
            for (const bucket of this.buckets)
                if (bucket != this.fallTo)
                    bucket.activate(false);
        }
        else {
            for (const bucket of this.buckets)
                bucket.activate(false);
        }
        // want to release bucket (move to floor)
        if (this.action == 0) {
            this.action = 4;
        }
    }
    findNearestBucket() {
        var bestBot = null;
        var bestDist = 1e10;
        for (const b of this.buckets) {
            if (b == this.carry)
                continue;
            var dx = this.carry.mc.x - b.mc.x;
            var dy = this.carry.mc.y - b.mc.y;
            var dist = Math.sqrt(dx * dx + dy * dy);
            if (dist < bestDist) {
                bestBot = b;
                bestDist = dist;
            }
        }
        return bestBot;
    }
    checkWin() {
        switch (this.level) {
            case 1: return this.buckets[0].fill == 4 || this.buckets[1].fill == 4;
            case 2: return this.buckets[0].fill == 1 || this.buckets[1].fill == 1 || this.buckets[2].fill == 1;
            case 3: return this.buckets[0].fill == 1 || this.buckets[1].fill == 1;
            case 4: return this.buckets.filter(bucket => bucket.fill == 1).length >= 2;
            case 5: return this.buckets[1].fill == 4 && this.buckets[2].fill == 4 && this.buckets[3].fill == 6;
            case 6: return this.buckets.filter(bucket => bucket.fill == 2).length >= 3;
            case 7: return this.buckets.filter(bucket => bucket.fill == 1).length >= 2;
            case 8: return this.buckets[0].fill == 1 && this.buckets[1].fill == 1 && this.buckets[2].fill == 1;
            case 9: return this.buckets[0].fill == 0 && this.buckets[1].fill == 1 && this.buckets[2].fill == 2 && this.buckets[3].fill == 3;
            case 10: return this.buckets[1].fill == 5 && this.buckets[2].fill == 18;
        }
        return false;
    }
}


/***/ }),

/***/ "./src/McBucket.ts":
/*!*************************!*\
  !*** ./src/McBucket.ts ***!
  \*************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   McBucket: () => (/* binding */ McBucket)
/* harmony export */ });
/* harmony import */ var _autogen__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./autogen */ "./src/autogen.ts");

class McBucket extends _autogen__WEBPACK_IMPORTED_MODULE_0__.base.McBucket {
}


/***/ }),

/***/ "./src/MusicButton.ts":
/*!****************************!*\
  !*** ./src/MusicButton.ts ***!
  \****************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   MusicButton: () => (/* binding */ MusicButton)
/* harmony export */ });
/* harmony import */ var _autogen__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./autogen */ "./src/autogen.ts");

class MusicButton extends _autogen__WEBPACK_IMPORTED_MODULE_0__.base.MusicButton {
    init() {
        this.cursor = "pointer";
        this.musicOn();
    }
    onMouseUp(e) {
        if (this.getBounds().contains(e.localX, e.localY)) {
            if (this.currentFrame == 1)
                this.musicOn();
            else
                this.musicOff();
        }
    }
    musicOn() {
        this.gotoAndStop(0);
        this.soundLoop = new nanofl.SeamlessSoundLoop(_autogen__WEBPACK_IMPORTED_MODULE_0__.Sounds.music());
        this.addEventListener("removed", () => this.soundLoop.stop());
    }
    musicOff() {
        this.gotoAndStop(1);
        this.soundLoop.stop();
    }
}


/***/ }),

/***/ "./src/Scene.ts":
/*!**********************!*\
  !*** ./src/Scene.ts ***!
  \**********************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   Scene: () => (/* binding */ Scene)
/* harmony export */ });
/* harmony import */ var _autogen__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./autogen */ "./src/autogen.ts");

class Scene extends _autogen__WEBPACK_IMPORTED_MODULE_0__.base.Scene {
    constructor() {
        super(...arguments);
        this.initFrame = null;
        this.level = 1;
    }
    onEnterFrame() {
        var _a, _b, _c, _d;
        if (this.currentFrame != this.initFrame) {
            this.initFrame = this.currentFrame;
            (_a = this.btGotoGame) === null || _a === void 0 ? void 0 : _a.addEventListener("click", () => this.gotoAndStop("Game"));
            (_b = this.btRules) === null || _b === void 0 ? void 0 : _b.addEventListener("click", () => this.gotoAndStop("Rules"));
            (_c = this.btGotoOrigin) === null || _c === void 0 ? void 0 : _c.addEventListener("click", () => this.gotoAndStop("Origin"));
            (_d = this.btNextLevel) === null || _d === void 0 ? void 0 : _d.addEventListener("click", () => this.gotoAndStop("Game"));
        }
    }
}


/***/ }),

/***/ "./src/WaterContainer.ts":
/*!*******************************!*\
  !*** ./src/WaterContainer.ts ***!
  \*******************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   WaterContainer: () => (/* binding */ WaterContainer)
/* harmony export */ });
class WaterContainer {
    get fill() { return this._fill; }
    constructor(total, mc) {
        this._fill = 0;
        this.total = total;
        this.mc = mc;
    }
    setFill(v) { }
    getNeckPos() { return new createjs.Point(this.mc.x, this.mc.y); }
}


/***/ }),

/***/ "./src/autogen.ts":
/*!************************!*\
  !*** ./src/autogen.ts ***!
  \************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   Sounds: () => (/* binding */ Sounds),
/* harmony export */   base: () => (/* binding */ base)
/* harmony export */ });
// This file is autogenerated by NanoFL
/// <reference types='nanofl-ts' />
var base;
(function (base) {
    class McBucket extends nanofl.MovieClip {
        constructor() {
            super(nanofl.Player.library.getItem("bucket"));
        }
        get mcNeck() { return this.getChildByName("mcNeck"); }
        get tfLabel() { return this.getChildByName("tfLabel"); }
        get mcForeColor() { return this.getChildByName("mcForeColor"); }
        get mcBox() { return this.getChildByName("mcBox"); }
    }
    base.McBucket = McBucket;
    class Game extends nanofl.MovieClip {
        constructor() {
            super(nanofl.Player.library.getItem("game"));
        }
    }
    base.Game = Game;
    class MusicButton extends nanofl.MovieClip {
        constructor() {
            super(nanofl.Player.library.getItem("musicButton"));
        }
    }
    base.MusicButton = MusicButton;
    class Scene extends nanofl.MovieClip {
        constructor() {
            super(nanofl.Player.library.getItem("scene"));
        }
        get btGotoGame() { return this.getChildByName("btGotoGame"); }
        get btRules() { return this.getChildByName("btRules"); }
        get btGotoOrigin() { return this.getChildByName("btGotoOrigin"); }
        get tfLevel() { return this.getChildByName("tfLevel"); }
        get btNextLevel() { return this.getChildByName("btNextLevel"); }
        get mcTrash() { return this.getChildByName("mcTrash"); }
        get game() { return this.getChildByName("game"); }
        get tfTask() { return this.getChildByName("tfTask"); }
        get mcTap() { return this.getChildByName("mcTap"); }
    }
    base.Scene = Scene;
})(base || (base = {}));
class Sounds {
    static bucket(interrupt, delay, offset, loop, volume, pan) { return createjs.Sound.play("bucket", interrupt, delay, offset, loop, volume, pan); }
    static music(interrupt, delay, offset, loop, volume, pan) { return createjs.Sound.play("music", interrupt, delay, offset, loop, volume, pan); }
    static tap(interrupt, delay, offset, loop, volume, pan) { return createjs.Sound.play("tap", interrupt, delay, offset, loop, volume, pan); }
    static trash(interrupt, delay, offset, loop, volume, pan) { return createjs.Sound.play("trash", interrupt, delay, offset, loop, volume, pan); }
    static water(interrupt, delay, offset, loop, volume, pan) { return createjs.Sound.play("water", interrupt, delay, offset, loop, volume, pan); }
}


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
var __webpack_exports__ = {};
// This entry need to be wrapped in an IIFE because it need to be in strict mode.
(() => {
"use strict";
/*!****************************!*\
  !*** ./src/application.ts ***!
  \****************************/
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   Game: () => (/* reexport safe */ _Game__WEBPACK_IMPORTED_MODULE_0__.Game),
/* harmony export */   McBucket: () => (/* reexport safe */ _McBucket__WEBPACK_IMPORTED_MODULE_1__.McBucket),
/* harmony export */   MusicButton: () => (/* reexport safe */ _MusicButton__WEBPACK_IMPORTED_MODULE_2__.MusicButton),
/* harmony export */   Scene: () => (/* reexport safe */ _Scene__WEBPACK_IMPORTED_MODULE_3__.Scene)
/* harmony export */ });
/* harmony import */ var _Game__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./Game */ "./src/Game.ts");
/* harmony import */ var _McBucket__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./McBucket */ "./src/McBucket.ts");
/* harmony import */ var _MusicButton__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./MusicButton */ "./src/MusicButton.ts");
/* harmony import */ var _Scene__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./Scene */ "./src/Scene.ts");





})();

var __webpack_export_target__ = (window = typeof window === "undefined" ? {} : window);
for(var i in __webpack_exports__) __webpack_export_target__[i] = __webpack_exports__[i];
if(__webpack_exports__.__esModule) Object.defineProperty(__webpack_export_target__, "__esModule", { value: true });
/******/ })()
;