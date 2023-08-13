import SwiftUI
import AVFoundation
import MediaPlayer

class MusicPlayer: ObservableObject {
    @EnvironmentObject var musicData: CurrentMusicData

    @Published var isPlaying = false
    @Published var isDone = false
    @Published var currentTime: TimeInterval = 0
    @Published var totalDuration: TimeInterval = 0.0
    

    @Published var songURL: URL?

    public var player: AVPlayer?
    private var timer: Timer?
    

    init() {
         // 初始化其他属性
     }
    
    
//    func getMusicData(songURL: URL?, imageURL: URL?, musicTitle: String?, musicArtist: String?) {
//           self.songURL = songURL
//
//           start()
//       }
//

    func start() {
//        if let data = songData {
//            if let fileURL = saveSongData(data) {
//                initializePlayer(with: fileURL)
//            }
//        }

        // 开始更新时间
        startUpdatingTime()
        
        //通知欄
//        if let songUrl = songUrl, let musicTitle = musicTitle {
//            sendSongNotification(songData: songUrl, musicTitle: musicTitle)
//        } else {
//            print("通知栏没有收到数据: \(musicTitle ?? "Unknown") \(String(describing: songUrl))")
//        }
        initializePlayer()
    }

    func togglePlayback() {
        if isPlaying {
            player?.pause()
        } else {
            player?.play()
        }
        isPlaying.toggle()
        //updateNowPlayingInfo()
    }
    
    func updateCurrentTime(_ currentTime: Double) {
        self.currentTime = currentTime
        seekToTime(currentTime)
    }
    
    private func seekToTime(_ time: Double) {
        guard let player = player else { return }
        let time = CMTime(seconds: time, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        player.seek(to: time)
       // updateNowPlayingInfo()
    }

    func startUpdatingTime() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            guard let player = self.player else { return }

            self.currentTime = player.currentTime().seconds
         //   self.updateNowPlayingInfo()
        }
    }
  
    func initializePlayer() {
        guard let songURL = songURL else {
          //  print("Error initializing player: Invalid URL " , songURL as Any)
             return
         }
        let playerItem = AVPlayerItem(url: songURL)
        player = AVPlayer(playerItem: playerItem)
        
        // Set the total duration
        if let duration = player?.currentItem?.asset.duration {
            totalDuration = TimeInterval(duration.value) / TimeInterval(duration.timescale)
            // 在这里使用totalDuration进行后续操作
        } else {
            // 处理无法获取持续时间的情况
        }
        
        // Observe the playback status of the player item
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidFinishPlaying(_:)), name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
//
//        player.pause()
//        isPlaying =false
        
        //updateNowPlayingInfo()
    }

    @objc private func playerItemDidFinishPlaying(_ notification: Notification) {
        // Song playback finished, you can perform the necessary actions here
        // For example, stop playback or reset the player
print("Song is done")
        isDone = true
        player?.pause()
        isPlaying = false

        // Remove the observer
        guard let playerItem = notification.object as? AVPlayerItem else {
            return
        }
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
     }
}
