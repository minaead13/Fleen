//
//  OrderDetailsViewModel.swift
//  Fleen
//
//  Created by Mina Eid on 25/02/2024.
//

import UIKit

class OrderDetailsViewModel {
    
    var orderDetails : TotalOrders
    var id : Int
    var dataSource : OrderDetailsModel?
    var isLoading : Observable<Bool> = Observable(false)
    var totalOrdersCellDataSource : Observable<[CartCellViewModel]> = Observable(nil)
    
    init(orderDetails: TotalOrders) {
        self.orderDetails = orderDetails
        self.id = orderDetails.id.orEmpty
    }
    
    
    func numberOftotalOrdersRows(in section : Int) -> Int {
        return totalOrdersCellDataSource.value?.count ?? 0
    }
    
    func getOrderDetailsData(viewController : UIViewController, id : Int , api_response: @escaping (BaseModel<OrderDetailsModel>?) -> Void ){
        self.isLoading.value = true
        let url = Endpoints.orderDetailsURL + "/\(id)"
        NetworkManager.instance.request(url, parameters: nil, method: .get, type: OrderDetailsModel.self, viewController: viewController) { [weak self] (data) in
            self?.success(data: data, api_response: api_response)
        }
    }
    
    private func success(data: BaseModel<OrderDetailsModel>? , api_response: @escaping (BaseModel<OrderDetailsModel>?) -> Void) {
        if data != nil {
            self.isLoading.value = false
            dataSource = data?.data
            api_response(data)
            mapCellData()
        } else {
            self.isLoading.value = false
        }
    }
    
    func mapCellData(){
        self.totalOrdersCellDataSource.value = self.dataSource?.items?.compactMap({ CartCellViewModel(cart: $0)})
    }
    
    
    func reorder(viewController : UIViewController, id : Int , successCallback: (() -> Void)? = nil){
        self.isLoading.value = true
        let url = Endpoints.reorderURL + "/\(id)"
        NetworkManager.instance.request(url, parameters: nil, method: .get, type: addToCart.self, viewController: viewController) { [weak self] (data) in
            self?.successs(data: data, successCallback: successCallback)
        }
    }
    
    private func successs(data: BaseModel<addToCart>? , successCallback: (() -> Void)?) {
        if data != nil {
            self.isLoading.value = false
            successCallback?()
        } else {
            self.isLoading.value = false
        }
    }

}
