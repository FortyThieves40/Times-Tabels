//
//  ViewController.swift
//  TimesTable
//
//  Created by carole lang on 10/24/16.
//  Copyright © 2016 Dana Young. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var currentSliderValue = 1
    
    // DANA: Bool states for action buttons
    var addSelected = false  //starts program out with adding displayed
    var subSelected = false
    var multSelected = false
    var divSelected = false
    
    //DANA: Class Var to change buttons back from red to blue when not selected
    var currentSelectedButton: UIBarButtonItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addButton(addOutlet)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 50
        
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "numCell")
        var numSentence: String = ""
        if addSelected == true, subSelected == false, multSelected == false, divSelected == false {  // add it
            numSentence =  "\(indexPath.row + 1) + \(currentSliderValue) = "
        }
        else if addSelected == false, subSelected == true, multSelected == false, divSelected == false{ // sub it
            numSentence =  "\(indexPath.row + 1) - \(currentSliderValue) = "
        }
        else if addSelected == false, subSelected == false, multSelected == true, divSelected == false{// mult it
            numSentence =  "\(indexPath.row + 1) x \(currentSliderValue) = "
        }
        else if addSelected == false, subSelected == false, multSelected == false, divSelected == true{// div it
            numSentence =  "\(indexPath.row + 1) ÷ \(currentSliderValue) = "
        }
        cell.textLabel!.text = numSentence
        return cell
    }
    
    
    @IBAction func sliderChange(_ sender: AnyObject){
        
        let localSliderValue = Int(slider.value)
        //print(localSliderValue)
        //print(currentSliderValue)
        if localSliderValue != currentSliderValue {
            tableData.reloadData()
            let randomColor = getRandomColor()
            displayLabel.textColor = randomColor
            
            if addSelected == true, subSelected == false, multSelected == false, divSelected == false { //add it
                displayLabel.text! = "\(localSliderValue)s Addition Tabels to 50!"
            }
            else if addSelected == false, subSelected == true, multSelected == false, divSelected == false { //sub it
                displayLabel.text! = "\(localSliderValue)s Subtraction Tabels to 50!"
            }
            else if addSelected == false, subSelected == false, multSelected == true, divSelected == false { // mult it
                displayLabel.text! = "\(localSliderValue)s Times Tabels to 50!"
            }
            else if addSelected == false, subSelected == false, multSelected == false, divSelected == true { //div it
                displayLabel.text! = "\(localSliderValue)s Division Tabels to 50!"
            }
            currentSliderValue = localSliderValue
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        //print("touch took places")
        var localNumExpression: String = ""
        if addSelected == true, subSelected == false, multSelected == false, divSelected == false { //add it
            localNumExpression = "\(indexPath.row + 1) + \(currentSliderValue) = \(((indexPath.row + 1) + currentSliderValue))"
            //print("inside selectAdd")
        }
        else if addSelected == false, subSelected == true, multSelected == false, divSelected == false { //add it
            localNumExpression = "\(indexPath.row + 1) - \(currentSliderValue) = \(((indexPath.row + 1) - currentSliderValue))"
            //print("inside selectSub")
        }
        else if addSelected == false, subSelected == false, multSelected == true, divSelected == false { //add it
            localNumExpression = "\(indexPath.row + 1) x \(currentSliderValue) = \(((indexPath.row + 1) * currentSliderValue))"
            //print("inside selectMult")
        }
        else if addSelected == false, subSelected == false, multSelected == false, divSelected == true { //add it
            let remainder: Int = (indexPath.row + 1) % currentSliderValue
            if remainder != 0 {
                localNumExpression = "\(indexPath.row + 1) ÷ \(currentSliderValue) = \(((indexPath.row + 1) / currentSliderValue)) with Remainder: \(remainder)"
                //print("inside selectDiv")
            }
            else{
                localNumExpression = "\(indexPath.row + 1) ÷ \(currentSliderValue) = \(((indexPath.row + 1) / currentSliderValue))"
            }
        }
        let cell = tableView.cellForRow(at: indexPath)
        cell!.textLabel!.text = localNumExpression
        var frame: CGRect = (cell?.textLabel?.frame)!
        let x = frame.origin.x - frame.width
        frame.origin.x = x
        //let y = frame.origin.y
        
        UIView.animate(withDuration: 1.25, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [.curveEaseIn], animations: {
            
            cell?.textLabel?.frame = frame
            cell?.textLabel?.textColor = self.getRandomColor()
            }, completion: nil)
        
    }
    @IBAction func addButton(_ sender: AnyObject) {
        
        let button1 = sender as? UIBarButtonItem
        print(sender)
        if (currentSelectedButton != nil) {
            currentSelectedButton!.tintColor = UIColor.blue
            button1!.tintColor = UIColor.red
            addSelected = true
            subSelected = false
            multSelected = false
            divSelected = false
            displayLabel.text! = "\(currentSliderValue)s Addition Tabels to 50!"
            tableData.reloadData()
            currentSelectedButton = button1
        }
        else
        {
            currentSelectedButton = button1
            button1!.tintColor = UIColor.red
            addSelected = true
            subSelected = false
            multSelected = false
            divSelected = false
            displayLabel.text! = "\(currentSliderValue)s Addition Tabels to 50!"
            tableData.reloadData()
        }
    }
    @IBAction func subButton(_ sender: AnyObject) {
        let button2 = sender as? UIBarButtonItem
        currentSelectedButton!.tintColor = UIColor.blue
        button2!.tintColor = UIColor.red
        addSelected = false
        subSelected = true
        multSelected = false
        divSelected = false
        displayLabel.text! = "\(currentSliderValue)s Subtraction Tabels to 50!"
        tableData.reloadData()
        currentSelectedButton = button2
    }
    @IBAction func multButton(_ sender: AnyObject) {
        let button3 = sender as? UIBarButtonItem
        currentSelectedButton!.tintColor = UIColor.blue
        button3!.tintColor = UIColor.red
        addSelected = false
        subSelected = false
        multSelected = true
        divSelected = false
        displayLabel.text! = "\(currentSliderValue)s Multiplication Tabels to 50!"
        tableData.reloadData()
        currentSelectedButton = button3
    }
    @IBAction func divButton(_ sender: AnyObject) {
        let button4 = sender as? UIBarButtonItem
        currentSelectedButton!.tintColor = UIColor.blue
        button4!.tintColor = UIColor.red
        addSelected = false
        subSelected = false
        multSelected = false
        divSelected = true
        displayLabel.text! = "\(currentSliderValue)s Division Tabels to 50!"
        tableData.reloadData()
        currentSelectedButton = button4
    }
    
    func getRandomColor() -> UIColor{
        
        var randomRed:CGFloat = CGFloat(drand48())
        
        var randomGreen:CGFloat = CGFloat(drand48())
        
        var randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    @IBOutlet weak var tableData: UITableView!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var addOutlet: UIBarButtonItem! //used to have addButton call self in viewDidLoad()
}

