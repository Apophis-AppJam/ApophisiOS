//
//  yukyungLabViewController.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2020/12/30.
//

import UIKit

class yukyungLabViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameReturnLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        textFieldShouldReturn(nameTextField)

        // Do any additional setup after loading the view.
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

extension yukyungLabViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ String: UITextField) -> Bool {

        nameTextField.delegate = self
        
        guard let name = nameTextField.text else { return false }
        
        self.nameReturnLabel.text = " 그사람의 이름은 " + name + ( self.splitText(text: name) ? "이야" : "야" )
        
        return true
    }
    
    //이름 뒤에 오는 조사 판별
    func splitText(text: String) -> Bool {
        
        guard let text = text.last else { return false }

            let val = UnicodeScalar(String(text))?.value

            guard let value = val else { return false }

            let z = (value - 0xac00) % 28
        
        if z == 0 {
            print("이야")
            return false
        }
        return true
        
    }
    
}



