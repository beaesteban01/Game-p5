//
//  ResultViewController.swift
//  Game-p5
//
//  Created by Beatriz Esteban on 20/11/2018.
//  Copyright © 2018 Beatriz Esteban. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var miRespuesta: String!
    var id = Int()
    var answer = [Ans]()
    var result = Bool()
    
    var url = String()
    var id2 = Int()
    @IBOutlet weak var resultLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(miRespuesta)
        print(id)
        
        getAnswer()
    }
    
    func getAnswer() {
        let QUIZ_URL_BASE = "https://quiz2019.herokuapp.com/api/quizzes/\(id)/check?token=f5a309efa8fb3aa59ec3&answer="
        let query = "\(miRespuesta ?? "")"
        
        
        if miRespuesta.contains(" "){
            if let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                let pageURL = "\(QUIZ_URL_BASE)\(escapedQuery)"
                print(pageURL)
                self.url = pageURL
                
            }
        } else {
            let pageURL = "\(QUIZ_URL_BASE)\(miRespuesta ?? "")"
            print(pageURL)
            
            self.url = pageURL
        }
        
        guard let url2 = URL(string: url) else {
            print ("error de mas arriba")
            return
        }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url2){
                let decoder = JSONDecoder()
                if let ansDic = try? decoder.decode(Ans.self, from: data){
                    //self.answer = ansDic
                    print(ansDic)
                    self.id2 = ansDic.quizId
                    print("result id:",self.id2)
                    self.result = ansDic.result
                    print("result bool:",self.result)
                    
                    self.comprobar()
                    
                } else {
                    print("errorrrrrr")
                }
            }
        }
    }
    
    func comprobar() {
        DispatchQueue.main.async {
            if self.result == true {
                self.resultLabel.text = "CORRECTA"
            } else {
                self.resultLabel.text = "ERRÓNEA"
            }
        }
    }
    
}
