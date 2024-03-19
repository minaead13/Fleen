//
//  HomeViewModel.swift
//  Fleen
//
//  Created by Mina Eid on 04/02/2024.
//

import UIKit

class HomeViewModel {
    
    var isLoading : Observable<Bool> = Observable(false)
    var adsCellDataSource : Observable<[addsCellViewModel]> = Observable(nil)
    var filterCellDataSource : Observable<[filterCellViewModel]> = Observable(nil)
    var productsCellDataSource : Observable<[productsCellViewModel]> = Observable(nil)
    var dataSource : Home?
    

    
    func numberOfBannersRows(in section : Int) -> Int {
        return adsCellDataSource.value?.count ?? 0
    }
    
    func numberOfFilterRows(in section : Int) -> Int {
        return filterCellDataSource.value?.count ?? 0
    }
    
    func numberOfProductssRows(in section : Int) -> Int {
        return productsCellDataSource.value?.count ?? 0
    }
    
    func getHomeData(viewController : UIViewController, page : Int = 1, keyword : String = "" , category : String = "" , successCallback: (() -> Void)? = nil ){
        
        self.isLoading.value = true
        
        var parameters: [String: Any] = ["page": page]
            
        if !keyword.isEmpty {
            parameters["keyword"] = keyword
        }
            
        if !category.isEmpty {
            parameters["category"] = category
        }
        
        NetworkManager.instance.request(Endpoints.homeURL, parameters: parameters, method: .get, type: Home.self, viewController: viewController) { [weak self] (data) in
            self?.success(data: data, successCallback: successCallback)
        }
    }
    
    private func success(data: BaseModel<Home>? , successCallback: (() -> Void)?) {
        if data != nil {
            self.isLoading.value = false
            dataSource = data?.data
            successCallback?()
            mapCellData()
        } else {
            self.isLoading.value = false
        }
    }
    
    func mapCellData(){
        self.adsCellDataSource.value = self.dataSource?.banners.compactMap({ addsCellViewModel(banners: $0)})
        self.filterCellDataSource.value = self.dataSource?.categories.compactMap({ filterCellViewModel(filter : $0)})
        let newProducts = self.dataSource?.products.data?.compactMap({ productsCellViewModel(products: $0) }) ?? []
            self.productsCellDataSource.value = (self.productsCellDataSource.value ?? []) + newProducts
    }
    
    func retriveMovie(with id : Int) -> productsDatum? {
        guard let products = dataSource?.products.data?.first(where: { $0.id == id }) else {
            return nil
        }
        return products
    }
    
    func getCartCount(viewController : UIViewController, api_response: @escaping (BaseModel<CountModel>?) -> Void) {
        NetworkManager.instance.request(Endpoints.countURL, parameters: nil, method: .get, type: CountModel.self, viewController: viewController) { [weak self] (data) in
            self?.successCartCount(data: data , api_response: api_response)
        }
    }
    
    private func successCartCount(data: BaseModel<CountModel>? , api_response: @escaping (BaseModel<CountModel>?) -> Void) {
        if data != nil {
            self.isLoading.value = false
            api_response(data)
        } else {
            self.isLoading.value = false
        }
    }
}
