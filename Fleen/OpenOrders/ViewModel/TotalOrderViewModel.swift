//
//  TotalOrderViewModel.swift
//  Fleen
//
//  Created by Mina Eid on 22/02/2024.
//

import UIKit

class TotalOrderViewModel {
    
    var dataSource : OrdersModel?
    var isLoading : Observable<Bool> = Observable(false)
    var totalOrdersCellDataSource : Observable<[TotalOrdersCellViewModel]> = Observable(nil)
    
   
    func numberOftotalOrdersRows(in section : Int) -> Int {
        return totalOrdersCellDataSource.value?.count ?? 0
    }
    
    func getHomeData(viewController : UIViewController, status : String , page : Int = 1 , successCallback: (() -> Void)? = nil ){
        
        self.isLoading.value = true
        var parameters: [String: Any] = [
            "status": status,
            "page": page
        ]
            
        NetworkManager.instance.request(Endpoints.ordersURL, parameters: parameters, method: .get, type: OrdersModel.self, viewController: viewController) { [weak self] (data) in
            self?.success(data: data, successCallback: successCallback)
        }
    }
    
    private func success(data: BaseModel<OrdersModel>? , successCallback: (() -> Void)?) {
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
        self.totalOrdersCellDataSource.value = self.dataSource?.data?.compactMap({ TotalOrdersCellViewModel(totalOrders: $0)})
        
    }
    
    func retriveMovie(with id : Int) -> TotalOrders? {
        guard let orders = dataSource?.data?.first(where: { $0.id == id }) else {
            return nil
        }
        return orders
    }
    
}
