//
//  MovieDetailViewModel.swift
//  LogitechChallenge
//
//  Created by Anurag on 21/12/18.
//  Copyright © 2018 Anurag. All rights reserved.
//

class MovieDetailViewModel {
    
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func imageUrl() -> String {
        return movie.Poster ?? movie.PosterWithWhitespace ?? ""
    }

    func movieDetails() -> String {
        var detail = "Title: " + movie.Title + "\n\n"
        
        if let yr = movie.Year {
            detail = detail + "Year: \(yr)" + "\n\n"
        }
        if let rate = movie.Rated {
            detail = detail + "Rated: \(rate)" + "\n\n"
        }
        if let release = movie.Released {
            detail = detail + "Released: \(release)" + "\n\n"
        }
        if let run = movie.Runtime {
            detail = detail + "Runtime: \(run)" + "\n\n"
        }
        if let gen = movie.Genre {
            detail = detail + "Genre: \(gen)" + "\n\n"
        }
        if let dir = movie.Director {
            detail = detail + "Director: \(dir)" + "\n\n"
        }
        if let riter = movie.Writer {
            detail = detail + "Writer: \(riter)" + "\n\n"
        }
        if let act = movie.Actors {
            detail = detail + "Actors: \(act)" + "\n\n"
        }
        if let plot = movie.Plot {
            detail = detail + "Plot: \(plot)" + "\n\n"
        }
        if let lan = movie.Language {
            detail = detail + "Language: \(lan)" + "\n\n"
        }
        if let con = movie.Country {
            detail = detail + "Country: \(con)" + "\n\n"
        }
        if let aw = movie.Awards {
            detail = detail + "Awards: \(aw)" + "\n\n"
        }

        return detail
    }

}

