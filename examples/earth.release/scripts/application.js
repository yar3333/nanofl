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

/***/ "./src/MySceneClass.ts":
/*!*****************************!*\
  !*** ./src/MySceneClass.ts ***!
  \*****************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   MySceneClass: () => (/* binding */ MySceneClass)\n/* harmony export */ });\n/* harmony import */ var _nanofl_code__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./nanofl-code */ \"./src/nanofl-code.ts\");\n\nclass MySceneClass extends _nanofl_code__WEBPACK_IMPORTED_MODULE_0__.base.MySceneClass {\n    init() {\n        createjs.Ticker.timingMode = createjs.Ticker.RAF_SYNCHED;\n        //this.txtRenderer.text = this.myEarth.renderer instanceof js.three.WebGLRenderer) ? \"WebGL\" : \"Canvas\";\n        //this.txtRenderer.textRuns[0].family = \"Times\";\n    }\n    onEnterFrame() {\n        this.myEarth.rotationY += 0.5;\n        this.txtFPS.text = Math.round(createjs.Ticker.getMeasuredFPS()) + \"\";\n    }\n}\n\n\n//# sourceURL=webpack://window/./src/MySceneClass.ts?");

/***/ }),

/***/ "./src/application.ts":
/*!****************************!*\
  !*** ./src/application.ts ***!
  \****************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   MySceneClass: () => (/* reexport safe */ _MySceneClass__WEBPACK_IMPORTED_MODULE_0__.MySceneClass)\n/* harmony export */ });\n/* harmony import */ var _MySceneClass__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./MySceneClass */ \"./src/MySceneClass.ts\");\n\n\n\n//# sourceURL=webpack://window/./src/application.ts?");

/***/ }),

/***/ "./src/nanofl-code.ts":
/*!****************************!*\
  !*** ./src/nanofl-code.ts ***!
  \****************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   Sounds: () => (/* binding */ Sounds),\n/* harmony export */   base: () => (/* binding */ base)\n/* harmony export */ });\n// This file is autogenerated by NanoFL\n/// <reference types='nanofl-ts' />\nvar base;\n(function (base) {\n    class MySceneClass extends nanofl.MovieClip {\n        constructor() {\n            super(nanofl.Player.library.getItem(\"scene\"));\n        }\n        get txtRenderer() { return this.getChildByName(\"txtRenderer\"); }\n        get txtFPS() { return this.getChildByName(\"txtFPS\"); }\n        get myEarth() { return this.getChildByName(\"myEarth\"); }\n    }\n    base.MySceneClass = MySceneClass;\n})(base || (base = {}));\nclass Sounds {\n}\n\n\n//# sourceURL=webpack://window/./src/nanofl-code.ts?");

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