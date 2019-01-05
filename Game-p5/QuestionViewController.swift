//
//  QuestionViewController.swift
//  Game-p5
//
//  Created by Beatriz Esteban on 20/11/2018.
//  Copyright © 2018 Beatriz Esteban. All rights reserved.
//

import UIKit

@IBDesignable
class QuestionViewController: UIViewController {
    var question = String()
    var id : Int!
   
    var quizId = Int()
    var tips = [String] ()
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UITextField!
    @IBOutlet weak var comprobarButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizId = id
        print(question, id, tips)
        questionLabel.text = question
    }
    
  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Show Result" {
            if let rvc = segue.destination as? ResultViewController {
                
            rvc.miRespuesta = answerLabel.text
            rvc.id = id
            print(id)
            print(answerLabel.text!)
            }
        }
        
        if segue.identifier == "Show Tips" {
            if let tvc = segue.destination as? TipsTableViewController {
                tvc.tips = tips
            }
        }
    }
}
