//
//  FlowTabbarPresenter.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import Foundation

class FlowTabbarPresenter: FlowTabbarViewOutput, FlowTabbarInteractorOutput {

    weak var view: FlowTabbarViewInput!
    weak var coordinator: FlowTabbarCoordinatorOutput!
    var interactor: FlowTabbarInteractorInput!
}
