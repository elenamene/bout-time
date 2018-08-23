//
//  eventsProvider.swift
//  bout-time
//
//  Created by Elena Meneghini on 10/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import Foundation
/*
struct SeriesProvider {
    var allSeries: [TVSeries] = [
        Series(title: "House of Cards", year: 2013, url: URL(string: "https://www.imdb.com/title/tt1856010/")!),
        Series(title: "Orange Is the New Black", year: 2013, url: URL(string: "https://www.imdb.com/title/tt2372162/")!),
        Series(title: "Game of Thrones", year: 2011, url: URL(string: "https://www.imdb.com/title/tt0944947/")!),
        Series(title: "Suits", year: 2011, url: URL(string: "https://www.imdb.com/title/tt1632701/")!),
        Series(title: "Grey's Anatomy", year: 2005, url: URL(string: "https://www.imdb.com/title/tt0413573")!),
        Series(title: "The Walking Dead", year: 2010, url: URL(string: "https://www.imdb.com/title/tt1520211")!),
        Series(title: "Friends", year: 1994, url: URL(string: "https://www.imdb.com/title/tt0108778/")!),
        Series(title: "American Horror Story", year: 2011, url: URL(string: "https://www.imdb.com/title/tt1844624/")!),
        Series(title: "Stranger Things", year: 2016, url: URL(string: "https://www.imdb.com/title/tt4574334/")!),
        Series(title: "Doctor Who", year: 2005, url: URL(string: "https://www.imdb.com/title/tt0436992/")!),
        Series(title: "How I Met Your Mother", year: 2005, url: URL(string: "https://www.imdb.com/title/tt0460649/")!),
        Series(title: "The Vampire Diaries", year: 2009, url: URL(string: "https://www.imdb.com/title/tt1405406/")!),
        Series(title: "Breaking Bad", year: 2008, url: URL(string: "https://www.imdb.com/title/tt0903747/")!),
        Series(title: "13 Reasons Why", year: 2017, url: URL(string: "https://www.imdb.com/title/tt1837492/")!),
        Series(title: "Black Mirror", year: 2011, url: URL(string: "https://www.imdb.com/title/tt2085059/")!),
        
        Series(title: "Sons of Anarchy", year: 2008, url: URL(string: "https://www.imdb.com/title/tt1124373/")!),
        Series(title: "Pretty Little Liars", year: 2010, url: URL(string: "https://www.imdb.com/title/tt1578873/")!),
        Series(title: "New Girl ", year: 2011, url: URL(string: "https://www.imdb.com/title/tt1826940/")!),
        Series(title: "House", year: 2004, url: URL(string: "https://www.imdb.com/title/tt0412142/")!),
        Series(title: "Lost", year: 2004, url: URL(string: "https://www.imdb.com/title/tt0411008/")!),
        Series(title: "Once Upon a Time", year: 2011, url: URL(string: "https://www.imdb.com/title/tt1843230/")!),
        Series(title: "The Crown", year: 2016, url: URL(string: "https://www.imdb.com/title/tt4786824/")!),
        Series(title: "Sherlock (UK)", year: 2010, url: URL(string: "https://www.imdb.com/title/tt1475582/")!),
        Series(title: "Homeland", year: 2011, url: URL(string: "https://www.imdb.com/title/tt1796960/")!),
        Series(title: "The Big Bang Theory", year: 2007, url: URL(string: "https://www.imdb.com/title/tt0898266/")!),
        Series(title: "Gotham", year: 2014, url: URL(string: "https://www.imdb.com/title/tt3749900/")!),
        Series(title: "Buffy the Vampire Slayer", year: 1996, url: URL(string: "https://www.imdb.com/title/tt0118276/")!),
        Series(title: "Jessica Jones", year: 2015, url: URL(string: "https://www.imdb.com/title/tt2357547/")!),
        Series(title: "The Simpsons", year: 1989, url: URL(string: "https://www.imdb.com/title/tt0096697/")!),
        Series(title: "True Blood", year: 2008, url: URL(string: "https://www.imdb.com/title/tt0844441/")!),
        Series(title: "ER", year: 1994, url: URL(string: "https://www.imdb.com/title/tt0108757/")!),
        Series(title: "The X-Files", year: 1993, url: URL(string: "https://www.imdb.com/title/tt0106179/")!),
        Series(title: "The Ranch", year: 2016, url: URL(string: "https://www.imdb.com/title/tt4998212/")!),
        Series(title: "Modern Family", year: 2009, url: URL(string: "https://www.imdb.com/title/tt1442437/")!),
        Series(title: "That '70s Show", year: 1998, url: URL(string: "https://www.imdb.com/title/tt0165598/")!),
        Series(title: "Glee", year: 2009, url: URL(string: "https://www.imdb.com/title/tt1327801/")!),
        Series(title: "One Tree Hill", year: 2003, url: URL(string: "https://www.imdb.com/title/tt0368530/")!),
        Series(title: "Star Trek: The Next Generation", year: 1987, url: URL(string: "https://www.imdb.com/title/tt0092455/")!),
        Series(title: "Star Wars: The Clone Wars", year: 2008, url: URL(string: "https://www.imdb.com/title/tt0458290/")!),
        Series(title: "Gossip Girl", year: 2007, url: URL(string: "https://www.imdb.com/title/tt0397442/")!),
        Series(title: "Desperate Housewives", year: 2004, url: URL(string: "https://www.imdb.com/title/tt0410975/")!),
        Series(title: "Iron Fist", year: 2017, url: URL(string: "https://www.imdb.com/title/tt3322310/")!),
        Series(title: "Law & Order ", year: 1990, url: URL(string: "https://www.imdb.com/title/tt0098844/")!),
        Series(title: "Gilmore Girls", year: 2000, url: URL(string: "https://www.imdb.com/title/tt0238784/")!),
        Series(title: "Dark", year: 2017, url: URL(string: "https://www.imdb.com/title/tt5753856/")!),
        Series(title: "Family Guy", year: 1998, url: URL(string: "https://www.imdb.com/title/tt0182576/")!),
        Series(title: "CSI: Crime Scene Investigation", year: 2000, url: URL(string: "https://www.imdb.com/title/tt0247082/")!),
        Series(title: "The Fresh Prince of Bel-Air", year: 1990, url: URL(string: "https://www.imdb.com/title/tt0098800/")!),
        Series(title: "Sex and the City", year: 1998, url: URL(string: "https://www.imdb.com/title/tt0159206/")!),
        Series(title: "South Park", year: 1997, url: URL(string: "https://www.imdb.com/title/tt0121955/")!),
        Series(title: "Grace and Frankie", year: 2015, url: URL(string: "https://www.imdb.com/title/tt3609352/")!),
        Series(title: "Star Trek: Voyager", year: 1995, url: URL(string: "https://www.imdb.com/title/tt0112178/")!),
        Series(title: "Will & Grace", year: 1998, url: URL(string: "https://www.imdb.com/title/tt0157246/")!),
        Series(title: "Star Trek: Deep Space Nine", year: 1993, url: URL(string: "https://www.imdb.com/title/tt0106145/")!),
        Series(title: "Shameless", year: 2004, url: URL(string: "https://www.imdb.com/title/tt0377260/")!),
        Series(title: "Weeds", year: 2005, url: URL(string: "https://www.imdb.com/title/tt0439100/")!),
        Series(title: "Beverly Hills, 90210", year: 1990, url: URL(string: "https://www.imdb.com/title/tt0098749/")!),
        Series(title: "The O.C.", year: 2003, url: URL(string: "https://www.imdb.com/title/tt0362359/")!),
        Series(title: "Star Trek", year: 1966, url: URL(string: "https://www.imdb.com/title/tt0060028")!),
        Series(title: "Orphan Black", year: 2013, url: URL(string: "https://www.imdb.com/title/tt2234222/")!),
        Series(title: "Futurama", year: 1999, url: URL(string: "https://www.imdb.com/title/tt0149460/")!),
        Series(title: "Dawson's Creek", year: 1998, url: URL(string: "https://www.imdb.com/title/tt0118300/")!),
        Series(title: "The Nanny", year: 1993, url: URL(string: "https://www.imdb.com/title/tt0106080")!),
        Series(title: "Scrubs", year: 2001, url: URL(string: "https://www.imdb.com/title/tt0285403/")!),
        Series(title: "2 Broke Girls", year: 2011, url: URL(string: "https://www.imdb.com/title/tt1845307/")!),
        Series(title: "Happy Days", year: 1974, url: URL(string: "https://www.imdb.com/title/tt0070992/")!),
        Series(title: "Misfits", year: 2009, url: URL(string: "https://www.imdb.com/title/tt1548850/")!),
        Series(title: "Keeping Up with the Kardashians", year: 2007, url: URL(string: "https://www.imdb.com/title/tt1086761/")!),
        Series(title: "Skins", year: 2007, url: URL(string: "https://www.imdb.com/title/tt0840196/")!),
        Series(title: "Love", year: 2016, url: URL(string: "https://www.imdb.com/title/tt4061080/")!),
        Series(title: "Baywatch", year: 1989, url: URL(string: "https://www.imdb.com/title/tt0096542/")!),
        Series(title: "The OA", year: 2016, url: URL(string: "https://www.imdb.com/title/tt4635282/")!),
        Series(title: "Ugly Betty", year: 2006, url: URL(string: "https://www.imdb.com/title/tt0805669/")!),
        Series(title: "Fawlty Towers", year: 1975, url: URL(string: "https://www.imdb.com/title/tt0072500/")!),
        Series(title: "The Jeffersons", year: 1975, url: URL(string: "https://www.imdb.com/title/tt0072519/")!),
        Series(title: "Ally McBeal", year: 1997, url: URL(string: "https://www.imdb.com/title/tt0118254/")!),
        Series(title: "Melrose Place", year: 1992, url: URL(string: "https://www.imdb.com/title/tt0103491/")!),
        Series(title: "Mr. Bean", year: 1990, url: URL(string: "https://www.imdb.com/title/tt0096657/")!),
        Series(title: "The Addams Family", year: 1964, url: URL(string: "https://www.imdb.com/title/tt0057729/")!),
        Series(title: "Don't Trust the B---- in Apartment 23", year: 2012, url: URL(string: "https://www.imdb.com/title/tt1819509/")!),
        Series(title: "Daria", year: 1997, url: URL(string: "https://www.imdb.com/title/tt0118298/")!),
        Series(title: "Beavis and Butt-Head", year: 1993, url: URL(string: "https://www.imdb.com/title/tt0105950/")!),
        Series(title: "Family Ties", year: 1982, url: URL(string: "https://www.imdb.com/title/tt0083413/")!),
        Series(title: "Law & Order", year: 1990, url: URL(string: "https://www.imdb.com/title/tt0098844/")!),
        Series(title: "The Flintstones", year: 1960, url: URL(string: "https://www.imdb.com/title/tt0053502/")!),
        Series(title: "Dexter", year: 2006, url: URL(string: "https://www.imdb.com/title/tt0773262/")!),
   ]
    
}


*/






