//
//  Day7TarotViewController.swift
//  Apophis_AppJam
//
//  Created by 최영재 on 2021/01/15.
//

import UIKit

class Day7TarotViewController: UIViewController {

    
    //MARK:- IBOutlet Part

    @IBOutlet var Day7TaroView: UIView!
    @IBOutlet weak var tarotCardCollectionView: UICollectionView!
    @IBOutlet weak var detailCompleteBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    //MARK:- Variable Part
    var tarotCellTouchCheck : [Bool] = [false, false, false, false, false, false, false, false, false]

    var backToTarotContent: backToTarotContentModel?
    
    var tarotDataBackCheck : [Bool] = [false, false, false, false, false, false, false, false, false]

    //MARK:- Constraint Part
    
    
    //MARK:- Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tarotCardCollectionView.delegate = self
        tarotCardCollectionView.dataSource = self
        addObserver()
        
        backBtn.isHidden = true

    }
    

    
    //MARK:- IBAction Part
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func completeBtnAction(_ sender: Any) {
        
        NotificationCenter.default.post(name: NSNotification.Name("tarotComplete"), object: nil)
        self.dismiss(animated: true, completion: nil)

    }
    

    
    
    
    //MARK:- default Setting Function Part
    func addObserver()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(tarotCardSellected), name: NSNotification.Name("tarotCardSellected"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(goToTarotDetail), name: NSNotification.Name("goToTarotDetail"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(backToTarot), name: NSNotification.Name("backToTarot"), object: nil)
        
        
        
        
    }
    
    //MARK:- @objc func 부분
    @objc func tarotCardSellected(notification : NSNotification)
    {
        let indexPath = notification.object as? Int ?? 0
      
        
        if !self.tarotCellTouchCheck[indexPath] {
    
        self.tarotCellTouchCheck[indexPath] = true
        
        }
        tarotCardCollectionView.reloadData()
        print(tarotCellTouchCheck)

    }
    
    @objc func goToTarotDetail(notification : NSNotification)
    {
        let indexPath = notification.object as? Int ?? 0
        let storyboard = UIStoryboard(name: "Day7", bundle: nil)

        guard let vc = storyboard.instantiateViewController(identifier: "Day7TarotDetailViewController") as? Day7TarotDetailViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.detailIndex = indexPath

        self.present(vc, animated: true, completion: nil)
        

    }
    
    @objc func backToTarot(notification : NSNotification)
    {
        backToTarotContent = (notification.object as? backToTarotContentModel)
        
        
        tarotDataBackCheck[backToTarotContent!.index] = true
        allDataCheck()
        print("타로 데이터 백 체킹",tarotDataBackCheck)
        tarotCardCollectionView.reloadData()
    }
    

    
    
    
    //MARK:- Function Part
    
    func allDataCheck(){
        var count: Int = 0
        for i in 0 ... tarotDataBackCheck.count-1{
            if tarotDataBackCheck[i] == true{
                count+=1
                print("카운트 몇이냐?", count)
                if count == 9{
                    print("카운트 다됐냐?", count)
                    detailCompleteBtn.isEnabled = true
                    detailCompleteBtn.setImage(UIImage(named: "frame16"), for: .normal)
                }
                else{
                    print("카운트 안됐냐??", count)
                    detailCompleteBtn.isEnabled = false
                    detailCompleteBtn.setImage(UIImage(named: "frame17"), for: .normal)                }
            }
        
        }
    }
    
}
    //MARK:- extension 부분

extension Day7TarotViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cardCell  = collectionView.dequeueReusableCell(withReuseIdentifier: Day7TarotCardCell.identifier, for: indexPath) as? Day7TarotCardCell else {
            return UICollectionViewCell()
        }
        
        
        cardCell.setTarot()
        if tarotCellTouchCheck[indexPath.row] == true
        {
            if tarotDataBackCheck[indexPath.row] == true {
                
                let contents = backToTarotContent?.contents
                let detainIndex = backToTarotContent?.index
                cardCell.getTarotContents(contents: contents!, idx: detainIndex!)
                cardCell.setCard(isTouched: true, index: indexPath.row, dataCheck: true)

            }
            else{
                cardCell.setCard(isTouched: true, index: indexPath.row, dataCheck: false)}
        }
        
        
        return cardCell
    }
}

extension Day7TarotViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 271/Day7TaroView.frame.width, height: 434/Day7TaroView.frame.height)
        var width = UIScreen.main.bounds.width
        var height = UIScreen.main.bounds.height
        return CGSize(width: width*(271/375), height: width*(434/375))
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 53, bottom: 0, right: 106)
    }
}
    

