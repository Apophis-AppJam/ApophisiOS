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
    
    
    
    //MARK:- Constraint Part

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
        
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: .allowUserInteraction) {
            
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
        
        
        /// 1,2,3 선택지 있다고 가정
        
        
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
        NotificationCenter.default.post(name: NSNotification.Name("receivedUserSelect"), object:
                                            selectList[indexPath.row])
        
        
     
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
}
