//
//  ViewController.swift
//  BestPractise
//
//  Created by songgeb on 2018/6/1.
//  Copyright © 2018年 Songgeb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var fileLineReader: FileLineReader?
    private var dataModels = ["FilelineReader", "RemoveDump", "ImageTransparent", "AppVersion", "DynamicCollectionViewCell"]
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wtfcell", for: indexPath)
        cell.textLabel?.text = dataModels[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataIndex = indexPath.row
        if dataIndex == 0 {
            //fileline reader
            filelineReaderTest()
        } else if dataIndex == 1 {
            //remove dup
            removeDupTest()
        } else if dataIndex == 2 {
            isImageTransparent()
        } else if dataIndex == 3 {
            //app version
            appversion()
        } else if dataIndex == 4 {
            gotoDynamicCollectionViewTest()
        }
    }
}

//MARK: private action
extension ViewController {
    private func filelineReaderTest() {
        let fileURL = Bundle.main.url(forResource: "BigFile", withExtension: "txt")
        fileLineReader = FileLineReader(fileURL: fileURL!)
        fileLineReader?.readLine(perLine: { (lineNumber, content) in
            print("\(lineNumber),\(content)")
        }, completion: {
            print("end")
        })
    }
    
    private func removeDupTest() {
        //let remover = RemoveDup(files: [url])
        //remover.start()
    }
    
    private func isImageTransparent() {
        //var image: UIImage
        //image.sb_isTransparent()
    }
    
    private func appversion() {
        print(Appversion.isNewVersionUser())
    }
    
    private func gotoDynamicCollectionViewTest() {
//        performSegue(withIdentifier: "dynamiccell", sender: self)
        let vc = DynamicCellViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

