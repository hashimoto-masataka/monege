document.addEventListener("turbolinks:load", function(){
 if(document.getElementById('multiscroll')) {
	$('#multiscroll').multiscroll({
    sectionsColor: ['#ff5f45', '#0798ec', '#fc6c7c', '#fc6c7c', '#fc6c7c'],
    anchors: ['first', 'second', 'third', 'forth', 'fifth'],
  });
};
});
