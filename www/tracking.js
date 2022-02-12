

function ImpacTracking() {}

ImpacTracking.prototype.trackingState = function(successCallback) {
    cordova.exec(successCallback, null, 'ImpacTracking', 'trackingState', []);
}

ImpacTracking.prototype.requestTracking = function(successCallback, errorCallback,info) {
    var infoString=undefined;
    if(info!==undefined&&info!==null)
        infoString=JSON.stringify(info);
    cordova.exec(successCallback, errorCallback, 'ImpacTracking', 'requestTracking', [infoString]);
}

ImpacTracking.install = function() {
    if (!window.plugins) {
        window.plugins = {};
    }
    window.plugins.impacTracking = new ImpacTracking();
    return window.plugins.impacTracking;
}
cordova.addConstructor(ImpacTracking.install);
