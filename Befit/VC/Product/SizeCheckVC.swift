//
//  SizeCheckVC.swift
//  Befit
//
//  Created by 이충신 on 11/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//
//  웹 뷰에 띄울 사이즈 체크 비교 팝업 뷰

import UIKit

class SizeCheckVC: UIViewController {
    
    //이미지 비교 스크롤을 위한 CollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var originalImage: UIImageView!
    @IBOutlet weak var sizeCheckView: UIView!
    
    //상품 선택
    @IBOutlet weak var productTF: UITextField!
    let pickerView = UIPickerView()
    
    //내 비교 상품 리스트
    var myProductList: [Closet] = []
    var keyboardDismissGesture : UITapGestureRecognizer?
    
    //하단 페이지 컨트롤(갯수는 동적으로 변경)
    @IBOutlet weak var pageControl: UIPageControl!
    
    //데모 모델
    var demo = ["유니클로 JK오버핏 L" , "라퍼지스토어 790EMC M", "87MM SeoulEdition M"]
    
    //서버통신에 필요한 Idx
    var productInfo: Product?
    var productIdx: Int?
    var closetIdx: Int?
    var productSize: String?
    var categoryIdx: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPickerWithTF()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate();
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        network()
    }
    
    func network(){
        
        SizeCheckService.shared.showSizeCheck(closetIdx: closetIdx, productIdx: productIdx, productSize: productSize) { (res) in
            
            
    
        }
        
    }

    
    
    @IBAction func okBtn(_ sender: Any) {
        self.removeAnimate();
    }
    
    
    
    
    
}


extension SizeCheckVC: UIPickerViewDelegate,UIPickerViewDataSource{
    
    func initPickerWithTF() {
        
        pickerView.delegate = self;
        pickerView.dataSource = self;
        productTF.delegate = self;
        
        let bar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(selectedPicker))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        bar.setItems([flexible, doneButton], animated: true)
        bar.sizeToFit()
        
        productTF.addTarget(self, action: #selector(selectedPicker), for: .touchUpInside)
        productTF.delegate = self;
        productTF.inputAccessoryView = bar
        productTF.inputView = pickerView
    }
    

    @objc func selectedPicker(){
        let row = pickerView.selectedRow(inComponent: 0)
        productTF.text = demo[row]
        //myProductList[row].name
        view.endEditing(true)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
        return demo.count
        //return myProductList.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return demo[row]
       //return myProductList[row].name
    }
    
    
}



extension SizeCheckVC {
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
}




extension SizeCheckVC: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    
    
}



extension SizeCheckVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //사이즈의 수에 따라 수가 달라짐 ((EX) S,M,L == 3)
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MySizeCheckCVCell", for: indexPath) as! MySizeCheckCVCell
        
        
        return cell
    }

    
}
