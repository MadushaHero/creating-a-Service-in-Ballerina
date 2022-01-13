
import ballerina/http;

type  ITunesSearchItem record {
  string trackName;
  string trackViewUrl;

};


type  ITunesSearchResult record {
   ITunesSearchItem[] results;

};

type Album record {|

string name;
string url;

|};


service /pickagift on new http:Listener(8080) {

   
    resource function get albums(string artistName) returns Album[]|error? {

    http:Client iTunes =  check new ("https://itunes.apple.com");
   
    ITunesSearchResult search = check iTunes->get(searchUrl(artistName));
   
    return from ITunesSearchItem i in search.results

    select {name: i.trackName, url: i.trackViewUrl};
        
    }
    
}

function searchUrl(string artistName ) returns  string{

   return "/search?term="+artistName+"&entity=musicVideo" ;
}



