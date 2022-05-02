//
//  BetFormViewController.swift
//  FitUpiOSApp
//
//  Created by Anthony Sherrill on 29.04.22.
//

import UIKit

class BetFormViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var betActionPicker: UIPickerView!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var durationPicker: UIDatePicker!
    @IBOutlet weak var betValueTextField: UITextField!
    @IBOutlet weak var saveBetButton: UIButton!
    
    var activities: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        betActionPicker.dataSource = self
        betActionPicker.delegate = self
        
        activities = ["Jumping Jacks", "Push Up", "Pull Ups"]
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activities[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
       {
            // use the row to get the selected row from the picker view
            // using the row extract the value from your datasource (array[row])
        }
    
    @IBAction func saveBetButtonTapped(_ sender: Any) {
        
        let timeFormater = DateFormatter()
        let dateFormater = DateFormatter()
        
        timeFormater.dateFormat = "HH:mm"
        dateFormater.dateFormat = "dd.MM.YYYY"
        
        let time = timeFormater.string(from: timePicker.date)
        let day = dateFormater.string(from: durationPicker.date)
        
        let pickedActivity = activities[betActionPicker.selectedRow(inComponent: 0)]
        print("Activity: \(pickedActivity), Time: \(time), Until: \(day), Money: \(betValueTextField.text ?? "0" )")
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
