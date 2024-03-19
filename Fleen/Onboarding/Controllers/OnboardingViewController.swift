//
//  OnboardingViewController.swift
//  Fleen
//
//  Created by Mina Eid on 14/01/2024.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var skipBtn: UIButton!
    
    var slides :[OnboardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageController.currentPage = currentPage
            if currentPage == slides.count - 1 {
              rightBtn.setImage(UIImage(named: "rigthArrow"), for: .normal)
            } else {
                rightBtn.setImage(UIImage(named: "arrow.righ"), for: .normal)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setCollectionView()
        setData()
        setUI()
        
        
    }
    
    private func setCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        let cellNib2 = UINib(nibName: "OnBoardingCollectionViewCell", bundle: nil)
        collectionView.register(cellNib2, forCellWithReuseIdentifier: "cell")
        pageController.semanticContentAttribute = .forceLeftToRight
        collectionView.semanticContentAttribute = .forceLeftToRight
    }
    
    private func setData() {
        slides = [OnboardingSlide(title: "عنوان الصفحه" , image: UIImage(named: "on1")!, subTitle: "ببساطة نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى) ويُستخدم في صناعات المطابع ودور النشر. كان لوريم إيبسوم"),
                  OnboardingSlide(title: "عنوان الصفحه", image: UIImage(named: "on2")! , subTitle: "ببساطة نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى) ويُستخدم في صناعات المطابع ودور النشر. كان لوريم إيبسوم"),OnboardingSlide(title: "عنوان الصفحه ",  image: UIImage(named: "on3")!, subTitle: "ببساطة نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى) ويُستخدم في صناعات المطابع ودور النشر. كان لوريم إيبسوم")]
    }
    
    private func setUI(){
        rightBtn.setTitle("", for: .normal)
        skipBtn.titleLabel?.font = UIFont(name: "DMSans18pt-Regular", size: 16)
        skipBtn.setTitle("Skip".localized, for: .normal)
        
    }
    
    @IBAction func rightBtnClicked(_ sender: Any) {
        
        if currentPage == slides.count - 1 {
            
            let mobileVC = self.storyboard?.instantiateViewController(withIdentifier: "MobileViewController") as! MobileViewController
            let navController = UINavigationController(rootViewController: mobileVC)
            navController.modalPresentationStyle = .fullScreen
            UserDefaults.standard.hasOnboarded = true
            present(navController, animated: true, completion: nil)
            
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    @IBAction func leftBtnClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MobileViewController") as! MobileViewController
        UserDefaults.standard.hasOnboarded = true
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }

}

extension OnboardingViewController : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnBoardingCollectionViewCell
        cell.config(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
}


