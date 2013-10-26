// takes a snapshot of the website

url = 'http://www.facebook.com'
var page = require('webpage').create();
page.settings.viewportSize = { width: 1920, height: 1280 };

page.open(url, function (status) {
 if (status !== 'success') {
   console.log('Unable to load BBC!');
   phantom.exit();
    } else {
        window.setTimeout(function () {
            page.render('screenshot.png');
            phantom.exit();
        }, 2000);
    }
});

