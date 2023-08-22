//
//  ViewController.swift
//  Counter
//
//  Created by Дмитрий Бучнев on 22.08.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countLable: UILabel!
    @IBOutlet weak var countPlusButton: UIButton!
    @IBOutlet weak var countMinusButton: UIButton!
    @IBOutlet weak var countRestartButton: UIButton!
    @IBOutlet weak var countHistory: UITextView!
    private var count = 0 {
        willSet (newValue) {
            countLable.text = "Значение счётчика: \(newValue)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countLable.text = "Значение счётчика: \(count)"
        countPlusButton.setTitle("+", for: .normal)
        countMinusButton.setTitle("-", for: .normal)
        countRestartButton.setTitle("restart", for: .normal)
        countPlusButton.tintColor = .red
        countMinusButton.tintColor = .blue
        countRestartButton.tintColor = .darkGray
        countHistory.text = "История изменений:\n"
        countHistory.isEditable = false
        countHistory.isScrollEnabled = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchPlusButton(_ sender: Any) {
        count += 1
        countHistory.text += "[\(getCurrentTime())]: значение изменено на +1 \n"
        scroll()
    }
    
    @IBAction func touchMinusButton(_ sender: Any) {
        if count > 0 {
            count -= 1
            countHistory.text += "[\(getCurrentTime())]: значение изменено на -1 \n"
        }
        else {
            countHistory.text += "[\(getCurrentTime())]: попытка уменьшить значение счётчика ниже 0 \n"
        }
        scroll()
    }
    
    @IBAction func touchRestartButton(_ sender: Any) {
        count = 0
        countHistory.text += "[\(getCurrentTime())]: значение сброшено\n"
        scroll()
    }
    
    private func getCurrentTime() -> String {
        var time = NSDate()
        var formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)            // указатель временной зоны относительно гринвича
        var formatteddate = formatter.string(from: time as Date)
        return "\(formatteddate)"
    }
    
    private func scroll() {
        let range = NSRange(location: countHistory.text.count - 1, length: 1)
        countHistory.scrollRangeToVisible(range)
    }
    
}

