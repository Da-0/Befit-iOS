//
//  SizeCheckVC.swift
//  Befit
//
//  Created by 이충신 on 11/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//
//  Product.Storyboard
//  2) 웹 뷰에 띄울 사이즈 체크 비교 팝업 뷰 VC
//  (+ 브랜드 자사 홈페이지 띄어주는 용도)

import UIKit


class SizeCheckVC: UIViewController {
    
    var keyboardDismissGesture : UITapGestureRecognizer?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var originalImage: UIImageView!
    @IBOutlet weak var sizeCheckView: UIView!
    
    @IBOutlet weak var noClosetView: UIControl!
    
    //내 비교 상품 리스트(옷장)
    var myClosetList: [Closet]?
    var comparableList: [SizeCheck] = []
    var realKey: [String] = []
    var bodyPart: BodyPart?

    //선택한 상품 정보
    var productInfo: Product?
    var productSizeList: [String] = []
    @IBOutlet weak var productNameLB: UILabel!
    @IBOutlet weak var productSizeLB: UILabel!
    
    //Picker, TF, PageControl, PercentBar
    let pickerView = UIPickerView()
    @IBOutlet weak var productTF: UITextField!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var percentBG: UIImageView!
    @IBOutlet weak var percentage: UILabel!
    @IBOutlet weak var percentStack: UIStackView!
    var circleGraph: CircleGraph?
    
    //상품 사이즈 정보 LB 관련
    @IBOutlet weak var LB0Stack: UIStackView!
    @IBOutlet var LB0Array: [UILabel]!
    @IBOutlet var LB1Array: [UILabel]!
    @IBOutlet var LB2Array: [UILabel]!
    @IBOutlet weak var labelView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
        initPickerWithTF()
        collectionView.delegate = self;
        collectionView.dataSource = self;
        print("선택한 상품의 전체 정보")
        print(productInfo)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initProducutInfo()
        network()
    }
    
    func initProducutInfo(){
        
        //1) 뷰의 시작점에서 현재 선택한 상품의 사이즈 종류를 Export.
        guard let sizeSorted = productInfo?.measure1?.toJSON().keys.sorted(by: { (first, second) -> Bool in
            if let firstVal = sortedDic[first], let secondVal = sortedDic[second] {
                if firstVal < secondVal { return true }
                else { return false }
            }
            return first < second
        })else {return}
        
         productSizeList = Array(sizeSorted)
        
        
        //2) 선택한 상품의 이름을 설정
        productNameLB.text = productInfo?.name
        
        //3) 페이지 컨트롤의 수는 선택한 상품의 사이즈 갯수
        pageControl.numberOfPages = productSizeList.count
    }
    
    
    func network(){
        
        //선택한 상품의 카테고리 인덱스를 파악하여 해당 카테고리의 정보들을 불러온다.
        GetClosetListService.shared.showClosetList(idx: (productInfo?.product_category_index)!) { (res) in

            self.myClosetList = res.data
            
            //1) 옷장에 데이터가 없는 경우(등록 유도 뷰)
            if res.data == nil {
                self.noClosetView.isHidden = false
            }
                
            //2) 옷장에 데이터가 있는 경우
            else {
                // Original Image 설정
                SizeCheckService.shared.showSizeCheck(closetIdx: res.data?[0].closet_idx!, productIdx: self.productInfo?.idx!, productSize: self.productSizeList.first) { (res) in
                    self.originalImage.imageFromUrl(res.data?.my_url, defaultImgPath: "")
                    if res.data?.my_url == nil {
                        self.simpleAlert(title: "ERROR!", message: "상품의 사이즈 데이터가 없어 비교가 불가합니다!")
                    }
                }
            }
            
        }
        
    }
    
    @IBAction func okBtn(_ sender: Any) {
        self.removeAnimate();
    }
    

    @IBAction func enrollClosetAction(_ sender: Any) {
      
        let sizeInfoVC2 = Storyboard.shared().myPage.instantiateViewController(withIdentifier: "SizeInfoVC2")as! SizeInfoVC2
        sizeInfoVC2.categoryIdx = productInfo?.product_category_index!
        sizeInfoVC2.enrollNewCloset = true
        sizeInfoVC2.categoryName = "slacks"
        self.present(sizeInfoVC2, animated: true) {
            self.removeAnimate();
        }
       
    }
    
   
    

}


extension SizeCheckVC: UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        guard let closet = myClosetList else {return 0}
        return closet.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        guard let closet = myClosetList else {return ""}
        return closet[row].name
    }

    
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
    
    ///MARK: - Select Picker
    @objc func selectedPicker(){
        
        let row = pickerView.selectedRow(inComponent: 0)
       
        self.sizeCheckNetwork(row)
        self.valueSetting(0)
        
        labelView.isHidden = false
        collectionView.contentOffset.x = 0
        pageControl.currentPage = 0
        collectionView.isScrollEnabled = true
        percentStack.isHidden = false
        collectionView.reloadData()
        self.view.endEditing(true)
    }
    

}

extension SizeCheckVC {
    
    
    //1) 사이즈 체크 정보 통신 구현부
    func sizeCheckNetwork(_ row: Int){
        
        guard let myCloset = myClosetList?[row] else {return}
        productTF.text = myCloset.name
        comparableList.removeAll()
        
        //사이즈 종류 별로 각각 비교결과 값을 가져오는 부분
        for size in productSizeList {
            
            let runLoop = CFRunLoopGetCurrent() //Synchronous하게 받아오기 위해 사용.
            
            SizeCheckService.shared.showSizeCheck(closetIdx: myCloset.closet_idx!, productIdx: productInfo?.idx!, productSize: size) { (result) in
                
                if result.message == "옷 사이즈 비교 불가능" {
                    self.removeAnimate();
                    self.simpleAlert("ERROR", "옷 사이즈 비교가 불가능 합니다!", completion: { (alert) in
                        self.removeAnimate();
                    })
                }
               
                else {
                    print("\n<" + size + " Size와의 비교 결과>")
                    print(result.data)
                    self.comparableList.append(result.data!)
        
                    let keys = Array((result.data?.measure?.toJSON().keys)!)
                    
                    let sortedKeys = keys.sorted(by: { (first, second) -> Bool in
                        
                        switch (first, second) {
                            case ("totalLength", _ ) :
                                return true
                            case (_ ,"totalLength") :
                                return false
                        default: break
                        }
                        return first < second
                    })
                    
                    self.realKey = sortedKeys
                }
            
                CFRunLoopStop(runLoop)//Stop Loop
            }
            
            CFRunLoopRun()//Run Loop
        }
        
        //LB0의 항목들을 설정
        for (idx, key) in self.realKey.enumerated() {
            
            switch key {
                case "totalLength": bodyPart = .total
                case "chestSection": bodyPart = .chest
                case "shoulderWidth": bodyPart = .shoulder
                case "sleeveLength": bodyPart = .sleeve
                case "waistSection": bodyPart = .waist
                case "thighSection": bodyPart = .thigh
                case "crotch": bodyPart = .crotch
                case "dobladillosSection": bodyPart = .dobla
                default: return
            }
            LB0Array[idx].text = bodyPart?.rawValue
            
        }
        
        
    }
    
    
    //2) 수치 레이블에 값을 설정하는 부분
    func valueSetting(_ row: Int){
    
        guard let keys = comparableList[row].measure?.toJSON().keys else {return}
        guard let values = comparableList[row].measure?.toJSON().values else {return}
        
        if keys.count == 3 {
            LB0Stack.spacing = 30
            LB0Array[3].isHidden = true
            LB1Array[3].isHidden = true
            LB2Array[3].isHidden = true
            LB0Array[4].isHidden = true
            LB1Array[4].isHidden = true
            LB2Array[4].isHidden = true
        }
        if keys.count == 4 {
            LB0Stack.spacing = 15
            LB0Array[3].isHidden = false
            LB1Array[3].isHidden = false
            LB2Array[3].isHidden = false
            LB0Array[4].isHidden = true
            LB1Array[4].isHidden = true
            LB2Array[4].isHidden = true
        }
        if keys.count == 5 {
            LB0Stack.spacing = 5
            LB0Array[3].isHidden = false
            LB1Array[3].isHidden = false
            LB2Array[3].isHidden = false
            LB0Array[4].isHidden = false
            LB1Array[4].isHidden = false
            LB2Array[4].isHidden = false
        }
        
        self.productSizeLB.text = productSizeList[row]
        guard let measureDic = productInfo?.measure1?.toJSON() else {return}
        let realDic = measureDic[productSizeList[row]] as! [String : String]
        
        for (idx, value) in values.enumerated() {
            
            let val = value as! String
            
            //1) LB1Array 설정
            if val == "0" {
                LB1Array[idx].text  = "딱맞음"
            }
            else if val.first == "-" {
                LB1Array[idx].text = val.dropFirst() + "cm 작음"
            }
            else {
                LB1Array[idx].text = val + "cm 큼"
            }
            
            //2) LB2Array 설정
            LB2Array[idx].text = realDic[realKey[idx]]! + "cm"
            
        }
        
        guard let percent = comparableList[row].percent else {return}
        self.percentage.text = percent + "%"
        circleGraph = CircleGraph(percentBG, percent)
        circleGraph?.animateCircle()
        

    }
    
    
}



extension SizeCheckVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productSizeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let row = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MySizeCheckCVCell", for: indexPath) as! MySizeCheckCVCell
        
        if comparableList.count > 0 {
            cell.sizeCheckImg.imageFromUrl(comparableList[row].compare_url, defaultImgPath: "")
        }

        return cell
    }
    
    
    //Mark: - Detect Page changing
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let row =  Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        pageControl.currentPage = row
        
        self.productSizeLB.text = productSizeList[row]
        self.valueSetting(row)

    }
    
}


//MARK: - CollectionView Layout
extension SizeCheckVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 323, height: 225)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    

}


//MARK: - PopUp Animation
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



//MARK: - Out view touch
extension SizeCheckVC: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}


