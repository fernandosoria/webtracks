var track = (function(){
    var _wt_event = {
      name: "visit"
    }

    var _wt_request = new XMLHttpRequest();
    
    _wt_request.open("POST", "http://fernandosoria-webtracks.herokuapp.com/events.json", true);
    
    _wt_request.setRequestHeader('Content-Type', 'application/json');

    _wt_request.onreadystatechange = function() {
      console.log('track() request accepted!');
    };

    _wt_request.send(JSON.stringify(_wt_event));
});