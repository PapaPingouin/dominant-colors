// takes a snapshot of the website

var args = require('system').args;
var url  = args[1];

//url = 'http://www.facebook.com'

console.log("url - " + url);
var page = require('webpage').create();
page.settings.viewportSize = { width: 1920, height: 1280 };

page.open(url, function (status) {
 if (status !== 'success') {
   console.log('Unable to load url @' + url);
   phantom.exit();
    } else {
        window.setTimeout(function () {
            page.render('screenshot.png');
            phantom.exit();
        }, 2000);
    }
});

