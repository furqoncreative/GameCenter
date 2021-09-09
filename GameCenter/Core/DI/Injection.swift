//
//  Injection.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 31/08/21.
//

import Foundation
import RealmSwift
import CoreModule
import GameModule

final class Injection: NSObject {
    let realm = try! Realm()
    
    func provideGames<U: UseCase>() -> U where U.Request == Int, U.Response == [GameModel] {
        
        let locale = GetGamesLocaleDataSource(realm: realm)
        
        let remote = GetGamesRemoteDataSource(endpoint: Endpoints.Gets.games.url)
        
        let mapper = GamesMapper()
        
        let repository = GetGamesRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideGame<U: UseCase>() -> U where U.Request == Int, U.Response == GameModel {
        
        let locale = GetGamesLocaleDataSource(realm: realm)
        
        let remote = GetGameRemoteDataSource(endpoint: Endpoints.Gets.game.url, apiKey: API.apiKey)
        
        let mapper = GameMapper()
        
        let repository = GetGameRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideUpdateFavorite<U: UseCase>() -> U where U.Request == Int, U.Response == GameModel {
        
        let locale = GetFavoriteGamesLocaleDataSource(realm: realm)
        
        let mapper = GameMapper()
        
        let repository = UpdateFavoriteGameRepository(
            localeDataSource: locale,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideFavorite<U: UseCase>() -> U where U.Request == Int, U.Response == [GameModel] {
        let locale = GetFavoriteGamesLocaleDataSource(realm: realm)
        
        let mapper = GamesMapper()
        
        let repository = GetFavoriteRepository(
            localeDataSource: locale,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
}
