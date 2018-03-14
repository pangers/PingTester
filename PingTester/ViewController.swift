//
//  ViewController.swift
//  PingTester
//
//  Created by James Pang on 14/3/18.
//  Copyright © 2018 Pangers. All rights reserved.
//

import UIKit
import PlainPing

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(viewTapped))
    }

    @objc func viewTapped() {
        view.endEditing(false)
    }
    
    @IBAction func pingTapped(_ sender: Any) {
        resultLabel.text = ""
        let hostname = textField.text ?? ""
        let pingText = "Pinging: \(hostname)\n"
        print(pingText)
        resultLabel.text = currentResultLabelText() + pingText
        PlainPing.ping(hostname, withTimeout: 2) { [unowned self] (timeElapsed, error) in
            if let error = error {
                let errorText = "error: \(error.localizedDescription)\n"
                print(errorText)
                self.resultLabel.text = self.currentResultLabelText() + errorText
            }
            
            if let latency = timeElapsed {
                let latencyText = "Latency (ms): \(latency)\n"
                print(latencyText)
                self.resultLabel.text = self.currentResultLabelText() + latencyText
            }
        }
    }
    
    func currentResultLabelText() -> String {
        return resultLabel.text ?? ""
    }
    
}

