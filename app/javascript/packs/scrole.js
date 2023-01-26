/**
* Purchase a key from:
* https://alvarotrigo.com/multiScroll/pricing/
*/
$(function () {
$(document).ready(function() {
	$('#multiscroll').multiscroll({
    licenseKey: 'YOUR KEY HERE',

    sectionsColor: ['#ff5f45', '#0798ec', '#fc6c7c'],
    anchors: ['first', 'second', 'third'],
    menu: '#menu',
  });
});
});