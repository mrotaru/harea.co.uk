$(function(){

  window.imageFader = function(opts) {

    var imgs = [];

    function timeout(index) {
      var toHide = index === 0 ? imgs.length-1 : index-1;
      imgs[toHide].hide();
      imgs[index].show();
      setTimeout(function() {  
        index = index === imgs.length-1 ? 0 : index+1;
        timeout(index);
      }, opts.delay);
    }

    $('.fader ul li').each(function(){
      imgs.push($(this));
      $(this).hide();
    });

    timeout(0);
  }

  imageFader({
    delay: 2000
  });

});
