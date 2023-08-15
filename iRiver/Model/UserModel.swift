struct Profile: Codable {
    let birthday: String
    let country: String?
    let email: String?
    let gender: String
    let invitation_code: String
    let invited_by_code: String
    let level: Int
    let phone: Int
    let uid: String
    let username: String
}

struct EQ: Codable {
    let ENGANCE_HEAVY: Int
    let ENGANCE_HIGH: Int
    let ENGANCE_LOW: Int
    let ENGANCE_MIDDLE: Int
    let EQ_DISTORTION: Int
    let EQ_HEAVY: Int
    let EQ_HIGH: Int
    let EQ_LOW: Int
    let EQ_MIDDLE: Int
    let EQ_ZIP: Int
    let SPATIAL_AUDIO: String
    let STYLE: String
    let _14kHZ: Int
    let _230HZ: Int
    let _4kHZ: Int
    let _60HZ: Int
    let _910HZ: Int
    let uid: String
}

struct Setting: Codable {
    let AUDIO_AUTO_PLAY: Int
    let AUDIO_QUALITY: String
    let LANGUAGE: String
    let SHOW_MODAL: String
    let WIFI_AUTO_DOWNLOAD: Int
    let uid: String
}

struct UserSettings: Codable {
    let profile: Profile
    let eq: EQ
    let setting: Setting
}
