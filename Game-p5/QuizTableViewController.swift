//
//  QuizTableViewController.swift
//  Game-p5
//
//  Created by Beatriz Esteban on 20/11/2018.
//  Copyright © 2018 Beatriz Esteban. All rights reserved.
//

import UIKit

let GAME_URL = "https://quiz2019.herokuapp.com/api/quizzes?token=f5a309efa8fb3aa59ec3"

class QuizTableViewController: UITableViewController {
 
    var quizzes = [Quiz]()
    var images = [String: UIImage]()
    var Aux_URL = GAME_URL

    @IBOutlet weak var refreshQuizzes: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getQuizzes()
    }
    
    @IBAction func getQuizzes() {
        guard let url = URL(string: Aux_URL) else {
            print ("error de mas arriba")
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url){
                let decoder = JSONDecoder()
                if let gameDic = try? decoder.decode(Game.self, from: data){
                  
                    DispatchQueue.main.async {
                        self.quizzes = self.quizzes + gameDic.quizzes
                        
                        if gameDic.nextUrl != "" {
                            self.Aux_URL = gameDic.nextUrl
                        } else {
                            return
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(quizzes.count)
        return quizzes.count
       
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Quiz Cell", for: indexPath)

       let quizzes1 = quizzes[indexPath.row]
        cell.textLabel?.text = quizzes1.question
        
        if quizzes1.author?.username == nil {
            cell.detailTextLabel?.text = "Anónimo"
        } else {
        cell.detailTextLabel?.text = quizzes1.author?.username
        }
        
        let urlPhoto = quizzes1.attachment?.url
        
        if let image = images[urlPhoto!] {
            cell.imageView?.image = image
        } else {
            cell.imageView?.image = UIImage(named: "none")
            downloadImg(urlPhoto!, indexpath: indexPath)
        }
        return cell
    }
    
    func downloadImg(_ urls: String, indexpath: IndexPath){
        
        DispatchQueue.global().async {
            
            if let url = URL(string: urls) {
                if let data = try? Data(contentsOf: url){
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            // Guardar la imagen
                            self.images[urls] = image
                            
                            // Actualizar la celda
                            self.tableView.reloadRows(at: [indexpath], with: .fade)
                        }
                    }
                }
            }
        }
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Show Question" {
            if let sq = segue.destination as? QuestionViewController {
                if let cell = sender as? UITableViewCell,
                    let ip = tableView.indexPath(for: cell) {
                     let dic = quizzes[ip.row]
                    sq.question = dic.question
                    sq.id = dic.id
                    print("dic id",dic.id)
                    sq.tips = dic.tips
                }
            }
        }
    }
}
