
import UIKit
import XLPagerTabStrip

class SearchProductVC: UIViewController {
    
    let userDefault = UserDefaults.standard
    @IBOutlet weak var collectionView: UICollectionView!
    
    // product model 받아올 변수 선언
    var searchProductList:[Product]? = []
//    var searchProductList2: [Product]? = []
    var searchKeyword: String = ""
    
    @IBOutlet weak var noResultView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self;
        collectionView.dataSource = self;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let keyword = userDefault.string(forKey: "SearchKeyword") else {return}
        searchKeyword = keyword
        initSearchProductList1()
        //initSearchProductList2()
        
    }
    
    func initSearchProductList1(){
        
        print("입력한 검색어 " + searchKeyword)
        
        SearchProductService.shared.showSearchProductNew(keyword: self.searchKeyword) { (res) in
            guard let status = res.status else {return}
            
            if status == 200 {
                if res.data == nil {
                    self.noResultView.isHidden = false
                    self.collectionView.isHidden = true
                    }
                else{
                    self.noResultView.isHidden = true
                    self.collectionView.isHidden = false
                }
            }
            
            self.searchProductList = res.data
            self.collectionView.reloadData()
            
        }
        
    }
    
    func initSearchProductList2(){
        
        print("입력한 검색어 " + searchKeyword)
        
        SearchProductService.shared.showSearchProductPopular(keyword: self.searchKeyword) { (res) in
            guard let status = res.status else {return}
            
            self.searchProductList = res.data
            self.collectionView.reloadData()
            
        }
        
    }
    
    
}

extension SearchProductVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SearchCRV", for: indexPath as IndexPath) as! SearchCRV
            
            cell.backgroundColor =  #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
            cell.isUserInteractionEnabled = true
            cell.popularBtn.addTarget(self, action: #selector(popularReload), for: .touchUpInside)
            cell.newBtn.addTarget(self, action: #selector(newReload), for: .touchUpInside)
            return cell
            
        default:
            assert(false, "Unexpected element kind")
        }
        
    }
    
    
    
    @objc func newReload(){
        print("신상순으로 상품이 정렬 되었습니다!!")
        initSearchProductList1()
    }
    
    
    @objc func popularReload(){
        print("인기순으로 상품이 정렬 되었습니다!!")
        initSearchProductList2()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let product = searchProductList else {
            noResultView.isHidden = false
            return 0
        }
        
        return product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchProductCVCell", for: indexPath) as! SearchProductCVCell
        guard let product = searchProductList else {return cell}
        
        cell.brandName.text = product[indexPath.row].brand_Korean_name
        cell.productName.text =  product[indexPath.row].name
        cell.price.text = product[indexPath.row].price
        cell.productImg.imageFromUrl(product[indexPath.row].image_url, defaultImgPath: "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let searchProduct = searchProductList else {return}
        
        let productVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductVC")as! ProductVC
        productVC.address = searchProduct[indexPath.row].link
        productVC.brandName = searchProduct[indexPath.row].brand_English_name
        
        self.navigationController?.present(productVC, animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //iphone사이즈에 따라 동적으로 대응이 가능해진다.
        // let width: CGFloat = (self.collectionView.frame.width ) / 2 - 20
        // let height: CGFloat =  (self.collectionView.frame.height ) / 2 - 20
        
        return CGSize(width: 167, height: 239)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15)
    }
    
    
}


extension SearchProductVC: IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "상품")
    }
}
