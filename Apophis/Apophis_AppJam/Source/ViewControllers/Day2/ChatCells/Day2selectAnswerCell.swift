//
//  Day2selectAnswerCell.swift
//  Apophis_AppJam
//
//  Created by 송지훈 on 2021/01/03.
//

import UIKit

class Day2selectAnswerCell: UITableViewCell {
    
    //MARK:- IBOutlet Part
    
    @IBOutlet weak var selectButtonCollectionView: UICollectionView!
    // 버튼들을 넣을 collectionView
    
    //MARK:- Variable Part
    
    var selectList : [String] = []
    var selectedBoolList : [Bool] = []
    var adjectiveCheck : Bool = false
    var selectWithErrorCheck : Bool = false
    var adjectiveBoolList : [Bool] = []
    
    
    //MARK:- Constraint Part
    
    @IBOutlet weak var adjectiveCollectionViewHeight: NSLayoutConstraint!
    
    //MARK:- Life Cycle Part
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        selectButtonCollectionView.delegate = self
        selectButtonCollectionView.dataSource = self
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    
    
    
    //MARK:- IBAction Part
    
    
    //MARK:- default Setting Function Part
    
    func setSelectList(selectList : [String])
    {
        adjectiveCheck = false
        selectWithErrorCheck = false

        adjectiveCollectionViewHeight.constant = 40
        
        selectedBoolList.removeAll()
        
        self.selectList = selectList
        
        if selectList.count > 0
        {
            for _ in 0 ... selectList.count - 1
            {
                selectedBoolList.append(false)
            }
            selectButtonCollectionView.backgroundColor = .clear
            
        }
        selectButtonCollectionView.alpha = 0
        
        
        
        selectButtonCollectionView.reloadData()
    }
    
    func setSelectWithError(selectList : [String])
    {
        adjectiveCheck = false
        selectWithErrorCheck = true
        adjectiveCollectionViewHeight.constant = 90
        
        selectButtonCollectionView.isScrollEnabled = false
        if let layout = selectButtonCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        selectedBoolList.removeAll()
        
        self.selectList = selectList
        
        if selectList.count > 0
        {
            for _ in 0 ... selectList.count - 1
            {
                selectedBoolList.append(false)
            }
            selectButtonCollectionView.backgroundColor = .clear
            
        }
        selectButtonCollectionView.alpha = 0
        
        
        
        selectButtonCollectionView.reloadData()
    }
    
    func setAdjectiveList(selectList : [String])
    {
        adjectiveCheck = true
        adjectiveCollectionViewHeight.constant = 210
        
        selectButtonCollectionView.isScrollEnabled = false
        if let layout = selectButtonCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
        
        selectedBoolList.removeAll()
        self.selectList = selectList
        
        if selectList.count > 0
        {
            for _ in 0 ... selectList.count - 1
            {
                selectedBoolList.append(false)
            }
            selectButtonCollectionView.backgroundColor = .clear
            
        }
        selectButtonCollectionView.alpha = 0
        selectButtonCollectionView.reloadData()
    }
    
    
    
    
    func loadingAnimate(index : Int)
    {
        
        UIView.animateKeyframes(withDuration: 0.25, delay: 0, options: .allowUserInteraction) {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1,animations: {
                
                self.selectButtonCollectionView.alpha = 1
                
            })
            
        } completion: { (_) in
        }
        
    }
    
    func showMessageWithNoAnimation()
    {
        self.selectButtonCollectionView.alpha = 1
    }
    
    
    
    
    //MARK:- Function Part
    
    
}

//MARK:- extension 부분
extension Day2selectAnswerCell : UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("선택 되었나?")
        /// 1,2,3 선택지 있다고 가정
        
        if !adjectiveCheck{
            if selectedBoolList[indexPath.row] == false
            {
                selectedBoolList[indexPath.row] = true
                
                for i in 0 ... selectedBoolList.count - 1
                {
                    if i == indexPath.row
                    {
                        continue
                    }
                    else
                    {
                        selectedBoolList[i] = false
                    }
                }
                self.selectButtonCollectionView.reloadData()
                
            }
            
            // 여기서 상위 뷰컨으로 유저가 선택한 메세지가 들어가야 합니다.
            if !selectWithErrorCheck {
            NotificationCenter.default.post(name: NSNotification.Name("receivedUserSelect"), object:
                                                selectList[indexPath.row])}
        else {
            NotificationCenter.default.post(name: NSNotification.Name("receivedSelectWithError"), object:
                                                selectList[indexPath.row])
        }
    }
        // 형용사 선택 부분
        else {
            // 형용사 선택할 때
         
                if selectedBoolList[indexPath.row] == false {
                    if (adjectiveBoolList.count<3){
                    selectedBoolList[indexPath.row] = true
                    adjectiveBoolList.append(true)
                   
                    self.selectButtonCollectionView.reloadData()
                    NotificationCenter.default.post(name: NSNotification.Name("receivedAdjectiveSelect"), object:
                                                        selectList[indexPath.row])
                }
            }
                // 형용사 선택 해제할 때
                else {
                    selectedBoolList[indexPath.row] = false
                    selectButtonCollectionView.backgroundColor = .clear
                    adjectiveBoolList.remove(at: adjectiveBoolList.count-1)
                    self.selectButtonCollectionView.reloadData()
                    NotificationCenter.default.post(name: NSNotification.Name("receivedAdjectiveUnselect"), object:
                                                        selectList[indexPath.row])
                }
                
            
        }
        
    }
}

extension Day2selectAnswerCell : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let selectCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Day2SelectListCollectionCell", for: indexPath) as? Day2SelectListCollectionCell else { return UICollectionViewCell() }
        
        selectCell.setSelectData(isSelected: selectedBoolList[indexPath.row],
                                 title: selectList[indexPath.row])
        
        return selectCell
    }
    
    
}

extension Day2selectAnswerCell : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let label = UILabel()
        label.text = selectList[indexPath.row]
        label.font = UIFont.gmarketFont(weight: .Medium, size: 14)
        label.sizeToFit()
        
        return CGSize(width: label.frame.width + 20, height: 34)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
