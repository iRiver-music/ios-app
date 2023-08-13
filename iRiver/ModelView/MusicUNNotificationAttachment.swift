import UserNotifications

import UserNotifications
import UserNotifications

import UserNotifications

func sendSongNotification(songURL: URL, musicTitle: String) {
    // 获取封面图片的URL
    guard let coverImageURL = Bundle.main.url(forResource: "song_cover", withExtension: "jpg") else {
        print("无法获取封面图片的URL")
        return
    }
    
    // 创建UNNotificationAttachment对象
    guard let attachment = try? UNNotificationAttachment(identifier: "coverImage", url: coverImageURL, options: nil) else {
        print("无法创建通知附件")
        return
    }
    
    // 创建通知内容
    let content = UNMutableNotificationContent()
    content.title = "歌曲通知"
    content.body = "正在播放：\(musicTitle)"
    
    // 将封面图片附件添加到通知内容中
    content.attachments = [attachment]
    
    // 创建通知触发条件
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    
    // 创建通知请求
    let request = UNNotificationRequest(identifier: "songNotification", content: content, trigger: trigger)
    
    // 将通知请求添加到通知中心
    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("添加通知请求失败：\(error)")
        } else {
            print("通知请求添加成功")
        }
    }
}

func updateSongNotification(title: String, body: String, coverImageName: String) {
    // 创建UNNotificationContent对象
    let updatedContent = UNMutableNotificationContent()
    updatedContent.title = title
    updatedContent.body = body
    
    // 获取封面图片的URL
    guard let updatedCoverImageURL = Bundle.main.url(forResource: coverImageName, withExtension: "jpg") else {
        print("无法获取更新后的封面图片的URL")
        return
    }
    
    // 创建UNNotificationAttachment对象
    guard let updatedAttachment = try? UNNotificationAttachment(identifier: "updatedCoverImage", url: updatedCoverImageURL, options: nil) else {
        print("无法创建更新后的通知附件")
        return
    }
    
    // 将更新后的封面图片附件添加到通知内容中
    updatedContent.attachments = [updatedAttachment]
    
    // 创建通知触发条件
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    
    // 创建新的通知请求
    let updatedRequest = UNNotificationRequest(identifier: "songNotification", content: updatedContent, trigger: trigger)
    
    // 先取消之前的通知请求
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["songNotification"])
    
    // 将更新后的通知请求添加到通知中心
    UNUserNotificationCenter.current().add(updatedRequest) { error in
        if let error = error {
            print("更新通知请求失败：\(error)")
        } else {
            print("通知请求更新成功")
        }
    }
}
