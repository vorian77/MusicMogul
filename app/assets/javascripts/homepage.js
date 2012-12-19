$(function(){
  var $container = $('#contestant-photos');

  $container.imagesLoaded( function(){
    $container.masonry({
      itemSelector : '.photobox',
      columnWidth : 240
    });
  });

  $('.tooltip').tooltipsy();
});
