//
//  QuestionViewController.swift
//  FEMO
//
//  Created by Marek Schmidt on 9/21/18.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func button1_TouchUpInside(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
    
    
    @IBAction func button2_TouchUpInside(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
    
    @IBAction func button3_TouchUpInside(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
    
    @IBAction func button4_TouchUpInside(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
