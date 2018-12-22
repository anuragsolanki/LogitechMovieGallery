//
//  Movie.swift
//  LogitechChallenge
//
//  Created by Anurag on 21/12/18.
//  Copyright © 2018 Anurag. All rights reserved.
//

import UIKit

struct MovieArray: Codable {
    var movie: [Movie] = [Movie]()
    
    enum CodingKeys:String, CodingKey {
        case movie = "movies"
    }
}

struct Movie: Codable {
    let Title: String
    let Year: String?
    let Rated: String?
    let Released: String?
    let Runtime: String?
    let Genre: String?
    let Director: String?
    let Writer: String?
    let Actors: String?
    let Plot: String?
    let Language: String?
    let Country: String?
    let Awards: String?
    let Poster: String?
    var PosterWithWhitespace: String?
    
    enum CodingKeys: String, CodingKey {
        case Title, Year, Rated, Released, Runtime, Genre, Director, Writer, Actors, Plot, Language, Country, Awards, Poster, PosterWithWhitespace = "Poster "
    }
}
