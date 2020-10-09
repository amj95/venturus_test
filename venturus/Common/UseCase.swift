//
//  UseCase.swift
//  venturus
//
//  Created by antonio marcos on 08/10/20.
//

import Foundation

protocol RequestValuesProtocol{}
protocol ResponseValueProtocol{}

protocol UseCase{
    func executeUseCase(requestValues: RequestValuesProtocol, onComplete: @escaping (ResponseValueProtocol) -> Void, onError: @escaping (Constants.ComunicationError) -> Void)
}
