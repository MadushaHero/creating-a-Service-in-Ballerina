
import ballerina/http;

type  ITunesSearchItem record {
  string trackName;
  string trackViewUrl;

};


type  ITunesSearchResult record {
   ITunesSearchItem[] results;

};


service /pickagift on new http:Listener(8080) {

    resource function get albums(string trackName) returns string|error? {

    http:Client iTunes =  check new ("https://itunes.apple.com");
   
    ITunesSearchResult search = check iTunes->get("/search?term=jack+johnson&entity=musicVideo");
   
    return (search.results[0].trackName);
        
    }
    
}



