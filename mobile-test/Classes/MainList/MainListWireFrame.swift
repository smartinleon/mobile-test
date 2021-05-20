//
//  MainListWireFrame.swift
//  mobile-test
//
//  Created by sergio.martin.leon on 19/05/2021.
//  
//

import Foundation
import UIKit

class MainListWireFrame: MainListWireFrameProtocol {
    
    class func createMainListModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "MainListNC")
        if let view = navController.children.first as? MainListView {
            let presenter: MainListPresenterProtocol & MainListInteractorOutputProtocol = MainListPresenter()
            let interactor: MainListInteractorInputProtocol & MainListRemoteDataManagerOutputProtocol = MainListInteractor()
            let localDataManager: MainListLocalDataManagerInputProtocol = MainListLocalDataManager()
            let remoteDataManager: MainListRemoteDataManagerInputProtocol = MainListRemoteDataManager()
            let wireFrame: MainListWireFrameProtocol = MainListWireFrame()

            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor

            return navController
        }
        return UIViewController()
    }
    
    func presentNewViewDetail(view: MainListViewProtocol, data: SuperheroEntity) {
        let newDetail = DetailWireFrame.createDetailModule(data: data)
        if let newView = view as? UIViewController {
            newView.navigationController?.pushViewController(newDetail, animated: true)
        }
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "MainList", bundle: Bundle.main)
    }
    
}