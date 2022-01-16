//
//  SettingsViewController.swift
//  Prework
//
//  Created by Rupin Jairaj on 12/01/22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let tipPercentages = ["tip1", "tip2", "tip3"]
    let defaults = UserDefaults.standard
    @IBOutlet var customTip1: UITextField!
    @IBOutlet var customTip2: UITextField!
    @IBOutlet var customTip3: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customTip1.text = String(format: "%d", defaults.integer(forKey: tipPercentages[0]))
        customTip2.text = String(format: "%d", defaults.integer(forKey: tipPercentages[1]))
        customTip3.text = String(format: "%d", defaults.integer(forKey: tipPercentages[2]))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customTip1.becomeFirstResponder()
    }
    
    @IBAction func tip1EditingChanged(_ sender: Any) {
        let tip1 = Int(customTip1.text!) ?? 15
        defaults.set(tip1, forKey: tipPercentages[0])
    }
    
    @IBAction func tip2EditingChanged(_ sender: Any) {
        let tip2 = Int(customTip2.text!) ?? 18
        defaults.set(tip2, forKey: tipPercentages[1])
    }
    
    @IBAction func tip3EditingChanged(_ sender: Any) {
        let tip3 = Int(customTip3.text!) ?? 20
        defaults.set(tip3, forKey: tipPercentages[2])
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
