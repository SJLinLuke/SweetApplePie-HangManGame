//
//  ViewController.swift
//  Demo - 5 甜蜜的ApplePie (HangMan)
//
//  Created by LukeLin on 2022/1/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var letterButtons: [UIButton]! {
        didSet {
            for letterButton in letterButtons {
                letterButton.layer.cornerRadius = 5
                letterButton.layer.masksToBounds = true
            }
        }
    }
    @IBOutlet var appleImage: [UIImageView]!
    @IBOutlet var answerLabel: UILabel! {
        didSet {
            answerLabel.layer.cornerRadius = 5
            answerLabel.layer.masksToBounds = true
        }
    }
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var gameoverLabel: UILabel! {
        didSet {
            gameoverLabel.layer.cornerRadius = 5
            gameoverLabel.layer.masksToBounds = true
        }
    }
    @IBOutlet var tryagainButton: UIButton! {
        didSet {
            tryagainButton.layer.cornerRadius = 5
            tryagainButton.layer.masksToBounds = true
        }
    }
    var totalwins = 0
    var totallose = 0
    var applecount = 0
    //用來儲存題目字串
    var words: [String] = ["apple", "account", "achieve", "activity", "childhood", "circus", "dialogue", "determine", "discovery", "educational", "election", "emergency", "fashion", "float", "friendship", "gas", "gamble", "graduate", "harbor", "heaven", "hometown", "humorous", "indeed", "jealous", "jewelry", "keyboard", "laundry", "lighthouse", "lobby", "manage", "meaningful", "medical", "microwave", "muscle", "nervous", "operator", "original", "password", "postpone", "quote", "rank", "receipt", "recorder", "release", "religion", "remove", "represent", "resource", "sensitive", "shadow", "ski", "spaghetti", "stormy", "summary", "switch", "temporary", "thankful", "tobacco", "trader", "tropical", "typical", "various", "victim", "wisdom", "yolk", "zone"]
    
    //用來儲存字串改為字母陣列
    var wordchractors: [String] = []
    
    //用來儲存猜過的單字
    var guesschractors: [String] = [] {
        didSet {
            answerLabel.text = guesschractors.joined(separator: " ")
        }
}
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //隱藏gameover及tryagain
        gameoverLabel.isHidden = true
        tryagainButton.isHidden = true
        
        //開始新遊戲
        startgame()
        
        //設定wins 及 loses
        scoreLabel.text = "WINS: \(totalwins), LOSES: \(totallose)"
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func buttonpress (_ sender: UIButton) {
        
        //按過的按鈕不能重複按
        sender.isEnabled = false
        sender.backgroundColor = .systemGray
        
        //設下比對布林值預設false
        var charinanswer: Bool = false
        
        //比對所按下的字母是否和答案有配對
        if let letter = sender.title(for: .normal)?.lowercased() {
            for (index, char) in wordchractors.enumerated() {
                if letter == char {
                    //比對成功
                    charinanswer = true
                    //顯示比對成功之字母
                    guesschractors[index] = letter
                    
                    //判斷已猜及答案是否相等如果相等顯示獲勝
                    if wordchractors == guesschractors {
                        win()
                     }
                    }
                   }
            //如果未獲勝就隱藏一顆蘋果,沒有蘋果就顯示失敗
            if !charinanswer {
                var index = applecount
                    appleImage[index].isHidden = true
                applecount += 1
            }
            
            if applecount == 7 {
                lose()
            }
            }
        }
        
    

    @IBAction func tryagainButtonpress (sender: UIButton) {
        updateUI()
        startgame()
    }
    
    func startgame() {
        
        //清空字母陣列
        wordchractors = []
        
        //清空已猜過的字母
        guesschractors = []
        
        //隨機挑選單字並轉為字母陣列
        let newtopic = words.randomElement()
        for char in newtopic! {
            wordchractors.append(String(char))
        
        //建立未猜出的底線陣列
            guesschractors = Array(repeating: "_" , count: wordchractors.count)
        
        }
    }
    
    func updateUI () {
        
        //更新分數標籤
        scoreLabel.text = "WINS: \(totalwins), LOSSES \(totallose)"
        
        //恢復字母顏色
        for button in letterButtons {
            button.isEnabled = true
            button.backgroundColor = .systemOrange
            
        //恢復蘋果
            for apple in appleImage {
                apple.isHidden = false
            }
        
        //隱藏gameover標籤及tryagain按鈕
            gameoverLabel.isHidden = true
            tryagainButton.isHidden = true
        
        }

    }
    
    func win () {
        totalwins += 1
        applecount = 0
        updateUI()
        
        startgame()
        
    }
    
    func lose() {
        
        //解開gameover標籤及tryagain按鈕的隱藏
        gameoverLabel.isHidden = false
        tryagainButton.isHidden = false
        
        totallose += 1
        applecount = 0
        
        
    }
    
}

