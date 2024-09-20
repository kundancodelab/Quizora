//
//  HomeViewController.swift
//  QuizApp
//
//  Created by Kundan ios dev  on 07/08/24.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    @IBAction func distapStartButton(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "QuizViewController") as? QuizViewController {
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
            
    }
    

}
