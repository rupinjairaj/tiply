//
//  ViewController.swift
//  Prework
//
//  Created by Rupin Jairaj on 04/01/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var billAmountTextField: UITextField!
    @IBOutlet var tipAmountLabel: UILabel!
    @IBOutlet var tipControl: UISegmentedControl!
    @IBOutlet var splitCountLabel: UILabel!
    @IBOutlet var incrementButton: UIButton!
    @IBOutlet var decrementButton: UIButton!
    @IBOutlet var tipPercentageLabel: UILabel!
    let defaults = UserDefaults.standard
    
    let tipPercentageKeys = ["tip1", "tip2", "tip3"]
    let BILL_TOTAL_KEY = "BillTotalKey";
    let SPLIT_TOTAL_KEY = "SplitTotalKey";
    let LAST_SAVED_TIME = "LastSavedTime";
    
    let tipPercentages = [0.15, 0.18, 0.2]
    @IBAction func setTipPercentage(_ sender: Any) {
          tipPercentageLabel.text =
        String(format: "%d%%", Int(defaults.integer(forKey: tipPercentageKeys[tipControl.selectedSegmentIndex])))
        calculateTip()
    }
    
    @IBAction func textEditingChanged(_ sender: Any) {
        calculateTip()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tip Calculator"
        
        defaults.register(defaults: [
            "tip1": Int(tipPercentages[0]*100),
            "tip2": Int(tipPercentages[1]*100),
            "tip3": Int(tipPercentages[2]*100)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let storedDate = defaults.object(forKey: LAST_SAVED_TIME) as? Date {
            let diff = Calendar.current.dateComponents([.minute], from: storedDate, to: Date())
            let minutes = diff.minute ?? 1
            print(minutes)
            if minutes >= 10 {
                let zeroedValue = String(format: "%.2f", getFormattedAmount(tipAmount: 0.0))
                billAmountTextField.text = zeroedValue
                tipAmountLabel.text = zeroedValue
            } else {
                billAmountTextField.text = defaults.string(forKey: BILL_TOTAL_KEY)
                tipAmountLabel.text = defaults.string(forKey: SPLIT_TOTAL_KEY)
            }
        }
        
        billAmountTextField.becomeFirstResponder()
        tipControl.setTitle(String(format: "%d%%", defaults.integer(forKey: tipPercentageKeys[0])), forSegmentAt: 0)
        tipControl.setTitle(String(format: "%d%%", defaults.integer(forKey: tipPercentageKeys[1])), forSegmentAt: 1)
        tipControl.setTitle(String(format: "%d%%", defaults.integer(forKey: tipPercentageKeys[2])), forSegmentAt: 2)
        tipPercentageLabel.text =
      String(format: "%d%%", Int(defaults.integer(forKey: tipPercentageKeys[tipControl.selectedSegmentIndex])))
        calculateTip()
    }
    
    @IBAction func decrementSplitCount(_ sender: Any) {
        let splitCount = Int(splitCountLabel.text!) ?? 1
        let splitCnt = (splitCount-1) > 0 ? splitCount-1 : 1
        splitCountLabel.text = String(format: "%d", splitCnt)
        calculateTip()
    }
    
    @IBAction func incrementSplitCount(_ sender: Any) {
        let splitCount = Int(splitCountLabel.text!) ?? 1
        let splitCnt = splitCount+1
        splitCountLabel.text = String(format: "%d", splitCnt)
        calculateTip()
    }
    
    func calculateTip() {
        let bill = Double(billAmountTextField.text!) ?? 0
        let tipPercentage = defaults.integer(forKey: tipPercentageKeys[tipControl.selectedSegmentIndex])
        let tip = Double(bill * Double(tipPercentage)/100.0)
        let total = (bill + tip) / (Double(splitCountLabel.text!) ?? 1)
        tipAmountLabel.text = getFormattedAmount(tipAmount: total)
        saveState()
    }
    
    func saveState() {
        let date = Date()
        defaults.set(date, forKey: LAST_SAVED_TIME)
        defaults.set(billAmountTextField.text, forKey: BILL_TOTAL_KEY)
        defaults.set(splitCountLabel.text, forKey: SPLIT_TOTAL_KEY)
    }
    
    func getFormattedAmount(tipAmount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter.string(from: tipAmount as NSNumber)!
    }

}
