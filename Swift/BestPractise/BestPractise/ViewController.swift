//
//  ViewController.swift
//  BestPractise
//
//  Created by songgeb on 2018/6/1.
//  Copyright © 2018年 Songgeb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  private var fileLineReader: FileLineReader?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let fileURL = Bundle.main.url(forResource: "BigFile", withExtension: "txt")
    fileLineReader = FileLineReader(fileURL: fileURL!)
    fileLineReader?.readLine(perLine: { (lineNumber, content) in
      print("\(lineNumber),\(content)")
    }, completion: {
      print("end")
    })
  }


}

