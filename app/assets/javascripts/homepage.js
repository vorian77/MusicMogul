$(function(){
  var $container = $('.contestants-list');

  $container.imagesLoaded( function(){
    $container.masonry({
      itemSelector : '.contestant-entry',
      columnWidth : 240
    });
  });

  $('.tooltip').tooltipsy();
});
