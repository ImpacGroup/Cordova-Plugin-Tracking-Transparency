interface Plugins{
    impacTracking: ICordovaTrackingTransparency
}

interface ICordovaTrackingTransparency{
    trackingStatus: (callback: (result: CordovaTrackingTransparencyAuthStatus) => void) => void
    requestTracking: (callback: (result: boolean) => void, errorCallback: (error: any) => void,info?: ICordovaTrackingTransparencyInfo, ) => void
}

enum CordovaTrackingTransparencyAuthStatus{
    notDetermined = 0,
    restricted = 1,
    denied = 2,
    authorized = 3
}

interface ICordovaTrackingTransparencyInfo{
    primaryColor?:string; 
    secondaryColor?: string;
    onPrimaryColor?: string;
    onSecondaryColor?: string;
    title?: string;
    text?: string;
    reasons?: ICordovaTrackingTransparencyRequestReason;
    subText?: string;
    buttonTitle?: string;
}

interface ICordovaTrackingTransparencyRequestReason{
    text?: string;
    image?: string;
    tintImage?: boolean;
}