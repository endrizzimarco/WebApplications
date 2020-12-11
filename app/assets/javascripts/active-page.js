// Make active view lighter color on navbar
$(document).on('turbolinks:load', function(){
  var loc = window.location.pathname;

  $('.navbar-nav li').find('a').each(function() {
    if ($(this).attr('href') == loc) {
      $(this).prop('id', 'current');
    }
  })
});