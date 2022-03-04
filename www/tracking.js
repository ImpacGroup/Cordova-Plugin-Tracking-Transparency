

function ImpacTracking() {}

ImpacTracking.prototype.trackingStatus = function(successCallback) {
    cordova.exec(successCallback, null, 'ImpacTracking', 'trackingStatus', []);
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
