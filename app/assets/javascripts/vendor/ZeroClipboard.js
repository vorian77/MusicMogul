/*!
 * zeroclipboard
 * The Zero Clipboard library provides an easy way to copy text to the clipboard using an invisible Adobe Flash movie, and a JavaScript interface.
 * Copyright 2012 Jon Rohan, James M. Greene, .
 * Released under the MIT license
 * http://jonrohan.github.com/ZeroClipboard/
 * v1.1.0
 */(function() {
    "use strict";
    var ZeroClipboard = {};
    ZeroClipboard.Client = function(query) {
        if (ZeroClipboard._client) return ZeroClipboard._client;
        this.handlers = {};
        if (ZeroClipboard.detectFlashSupport()) this.bridge();
        if (query) this.glue(query);
        ZeroClipboard._client = this;
    };
    function _elementMouseOver() {
        ZeroClipboard._client.setCurrent(this);
    }
    ZeroClipboard.Client.prototype.glue = function(query) {
        function _addEventHandler(element, method, func) {
            if (element.addEventListener) {
                element.addEventListener(method, func, false);
            } else if (element.attachEvent) {
                element.attachEvent(method, func);
            }
        }
        var elements = ZeroClipboard.$(query);
        for (var i = 0; i < elements.length; i++) {
            _addEventHandler(elements[i], "mouseover", _elementMouseOver);
        }
    };
    ZeroClipboard.Client.prototype.unglue = function(query) {
        function _removeEventHandler(element, method, func) {
            if (element.removeEventListener) {
                element.removeEventListener(method, func, false);
            } else if (element.detachEvent) {
                element.detachEvent(method, func);
            }
        }
        var elements = ZeroClipboard.$(query);
        for (var i = 0; i < elements.length; i++) {
            _removeEventHandler(elements[i], "mouseover", _elementMouseOver);
        }
    };
    ZeroClipboard.Client.prototype.bridge = function() {
        this.htmlBridge = ZeroClipboard.$("#global-zeroclipboard-html-bridge");
        if (this.htmlBridge.length) {
            this.htmlBridge = this.htmlBridge[0];
            this.flashBridge = document["global-zeroclipboard-flash-bridge"];
            return;
        }
        function noCache(path) {
            return (path.indexOf("?") >= 0 ? "&" : "?") + "nocache=" + (new Date).getTime();
        }
        var html = '    <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" id="global-zeroclipboard-flash-bridge" width="100%" height="100%">       <param name="movie" value="' + ZeroClipboard.moviePath + noCache(ZeroClipboard.moviePath) + '"/>       <param name="allowScriptAccess" value="always" />       <param name="scale" value="exactfit">       <param name="loop" value="false" />       <param name="menu" value="false" />       <param name="quality" value="best" />       <param name="bgcolor" value="#ffffff" />       <param name="wmode" value="transparent"/>       <param name="flashvars" value="id=1"/>       <embed src="' + ZeroClipboard.moviePath + noCache(ZeroClipboard.moviePath) + '"         loop="false" menu="false"         quality="best" bgcolor="#ffffff"         width="100%" height="100%"         name="global-zeroclipboard-flash-bridge"         allowScriptAccess="always"         allowFullScreen="false"         type="application/x-shockwave-flash"         wmode="transparent"         pluginspage="http://www.macromedia.com/go/getflashplayer"         flashvars="id=1&width=100&height=100"         scale="exactfit">       </embed>     </object>';
        this.htmlBridge = document.createElement("div");
        this.htmlBridge.id = "global-zeroclipboard-html-bridge";
        this.htmlBridge.setAttribute("class", "global-zeroclipboard-container");
        this.htmlBridge.setAttribute("data-clipboard-ready", false);
        this.htmlBridge.style.position = "absolute";
        this.htmlBridge.style.left = "-9999px";
        this.htmlBridge.style.top = "-9999px";
        this.htmlBridge.style.width = "15px";
        this.htmlBridge.style.height = "15px";
        this.htmlBridge.style.zIndex = "9999";
        this.htmlBridge.innerHTML = html;
        document.body.appendChild(this.htmlBridge);
        this.flashBridge = document["global-zeroclipboard-flash-bridge"];
    };
    ZeroClipboard.Client.prototype.resetBridge = function() {
        this.htmlBridge.style.left = "-9999px";
        this.htmlBridge.style.top = "-9999px";
        this.htmlBridge.removeAttribute("title");
        this.htmlBridge.removeAttribute("data-clipboard-text");
        ZeroClipboard.currentElement.removeClass("zeroclipboard-is-active");
        delete ZeroClipboard.currentElement;
    };
    ZeroClipboard.Client.prototype.ready = function() {
        return !!this.htmlBridge.getAttribute("data-clipboard-ready");
    };
    function _getCursor(el) {
        var y = el.style.cursor;
        if (el.currentStyle) y = el.currentStyle.cursor; else if (window.getComputedStyle) y = document.defaultView.getComputedStyle(el, null).getPropertyValue("cursor");
        if (y == "auto") {
            var possiblePointers = [ "a" ];
            for (var i = 0; i < possiblePointers.length; i++) {
                if (el.tagName.toLowerCase() == possiblePointers[i]) {
                    return "pointer";
                }
            }
        }
        return y;
    }
    ZeroClipboard.Client.prototype.setCurrent = function(element) {
        ZeroClipboard.currentElement = element;
        this.reposition();
        if (element.getAttribute("data-clipboard-text")) {
            this.setText(element.getAttribute("data-clipboard-text"));
        }
        if (element.getAttribute("title")) {
            this.setTitle(element.getAttribute("title"));
        }
        if (_getCursor(element) == "pointer") {
            this.setHandCursor(true);
        } else {
            this.setHandCursor(false);
        }
    };
    ZeroClipboard.Client.prototype.reposition = function() {
        var pos = ZeroClipboard.getDOMObjectPosition(ZeroClipboard.currentElement);
        this.htmlBridge.style.top = pos.top + "px";
        this.htmlBridge.style.left = pos.left + "px";
        this.htmlBridge.style.width = pos.width + "px";
        this.htmlBridge.style.height = pos.height + "px";
        this.htmlBridge.style.zIndex = pos.zIndex + 1;
        this.setSize(pos.width, pos.height);
    };
    ZeroClipboard.Client.prototype.setText = function(newText) {
        if (newText && newText !== "") {
            this.htmlBridge.setAttribute("data-clipboard-text", newText);
            if (this.ready()) this.flashBridge.setText(newText);
        }
    };
    ZeroClipboard.Client.prototype.setTitle = function(newTitle) {
        if (newTitle && newTitle !== "") this.htmlBridge.setAttribute("title", newTitle);
    };
    ZeroClipboard.Client.prototype.setSize = function(width, height) {
        if (this.ready()) this.flashBridge.setSize(width, height);
    };
    ZeroClipboard.Client.prototype.setHandCursor = function(enabled) {
        if (this.ready()) this.flashBridge.setHandCursor(enabled);
    };
    ZeroClipboard.version = "1.1.0";
    ZeroClipboard.moviePath = "ZeroClipboard.swf";
    ZeroClipboard._client = null;
    ZeroClipboard.setMoviePath = function(path) {
        this.moviePath = path;
    };
    ZeroClipboard.destroy = function() {
        var query = ZeroClipboard.$("#global-zeroclipboard-html-bridge");
        if (!query.length) return;
        delete ZeroClipboard._client;
        var bridge = query[0];
        bridge.parentNode.removeChild(bridge);
    };
    ZeroClipboard.detectFlashSupport = function() {
        var hasFlash = false;
        try {
            if (new ActiveXObject("ShockwaveFlash.ShockwaveFlash")) {
                hasFlash = true;
            }
        } catch (error) {
            if (navigator.mimeTypes["application/x-shockwave-flash"]) {
                hasFlash = true;
            }
        }
        return hasFlash;
    };
    ZeroClipboard.dispatch = function(eventName, args) {
        ZeroClipboard._client.receiveEvent(eventName, args);
    };
    ZeroClipboard.Client.prototype.on = function(eventName, func) {
        var events = eventName.toString().split(/\s/g);
        for (var i = 0; i < events.length; i++) {
            eventName = events[i].toLowerCase().replace(/^on/, "");
            if (!this.handlers[eventName]) this.handlers[eventName] = [];
            this.handlers[eventName].push(func);
        }
        if (this.handlers.noflash && !ZeroClipboard.detectFlashSupport()) {
            this.receiveEvent("onNoFlash", null);
        }
    };
    ZeroClipboard.Client.prototype.addEventListener = function(eventName, func) {
        this.on(eventName, func);
    };
    ZeroClipboard.Client.prototype.receiveEvent = function(eventName, args) {
        eventName = eventName.toString().toLowerCase().replace(/^on/, "");
        switch (eventName) {
            case "load":
                if (args && parseFloat(args.flashVersion.replace(",", ".").replace(/[^0-9\.]/gi, "")) < 10) {
                    this.receiveEvent("onWrongFlash", {
                        flashVersion: args.flashVersion
                    });
                    return;
                }
                this.htmlBridge.setAttribute("data-clipboard-ready", true);
                break;
            case "mouseover":
                ZeroClipboard.currentElement.addClass("zeroclipboard-is-hover");
                break;
            case "mouseout":
                ZeroClipboard.currentElement.removeClass("zeroclipboard-is-hover");
                this.resetBridge();
                break;
            case "mousedown":
                ZeroClipboard.currentElement.addClass("zeroclipboard-is-active");
                break;
            case "mouseup":
                ZeroClipboard.currentElement.removeClass("zeroclipboard-is-active");
                break;
        }
        if (this.handlers[eventName]) {
            for (var idx = 0, len = this.handlers[eventName].length; idx < len; idx++) {
                var func = this.handlers[eventName][idx];
                if (typeof func == "function") {
                    func(this, args);
                } else if (typeof func == "string") {
                    window[func](this, args);
                }
            }
        }
    };
    ZeroClipboard.getDOMObjectPosition = function(obj) {
        var info = {
            left: 0,
            top: 0,
            width: obj.width ? obj.width : obj.offsetWidth,
            height: obj.height ? obj.height : obj.offsetHeight,
            zIndex: 9999
        };
        if (obj.style.zIndex) {
            info.zIndex = parseInt(element.style.zIndex, 10);
        }
        while (obj) {
            info.left += obj.offsetLeft;
            info.left += obj.style.borderLeftWidth ? parseInt(obj.style.borderLeftWidth, 10) : 0;
            info.top += obj.offsetTop;
            info.top += obj.style.borderTopWidth ? parseInt(obj.style.borderTopWidth, 10) : 0;
            obj = obj.offsetParent;
        }
        return info;
    };
    function elementWrapper(element) {
        if (!element || element.addClass) return element;
        element.addClass = function(value) {
            if (value && typeof value === "string") {
                var classNames = (value || "").split(/\s+/);
                var elem = this;
                if (elem.nodeType === 1) {
                    if (!elem.className) {
                        elem.className = value;
                    } else {
                        var className = " " + elem.className + " ", setClass = elem.className;
                        for (var c = 0, cl = classNames.length; c < cl; c++) {
                            if (className.indexOf(" " + classNames[c] + " ") < 0) {
                                setClass += " " + classNames[c];
                            }
                        }
                        elem.className = setClass.replace(/^\s+|\s+$/g, "");
                    }
                }
            }
            return this;
        };
        element.removeClass = function(value) {
            if (value && typeof value === "string" || value === undefined) {
                var classNames = (value || "").split(/\s+/);
                var elem = this;
                if (elem.nodeType === 1 && elem.className) {
                    if (value) {
                        var className = (" " + elem.className + " ").replace(/[\n\t]/g, " ");
                        for (var c = 0, cl = classNames.length; c < cl; c++) {
                            className = className.replace(" " + classNames[c] + " ", " ");
                        }
                        elem.className = className.replace(/^\s+|\s+$/g, "");
                    } else {
                        elem.className = "";
                    }
                }
            }
            return this;
        };
        return element;
    }
    ZeroClipboard.$ = function(query) {
        var ZeroClipboardSelect = function(s, n) {
            return n.querySelectorAll(s);
        }, result;
        if (typeof Sizzle === "function") {
            ZeroClipboardSelect = function(s, n) {
                return Sizzle.uniqueSort(Sizzle(s, n));
            };
        }
        if (typeof query === "string") {
            result = ZeroClipboardSelect(query, document);
            if (result.length === 0) result = [ document.getElementById(query) ];
        }
        var newresult = [];
        for (var i = 0; i < result.length; i++) {
            if (result[i] !== null) newresult.push(elementWrapper(result[i]));
        }
        return newresult;
    };
    if (typeof module !== "undefined") {
        module.exports = ZeroClipboard;
    } else {
        window.ZeroClipboard = ZeroClipboard;
    }
})();