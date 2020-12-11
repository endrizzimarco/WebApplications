// All javascript related to 'show' view of movies

$(document).on('turbolinks:load', function(){
  // Star rating plugin by Washington Botelho
  $('#ratyjs').raty({
  path: '/assets/',
  half: true,
  number: 10,
  space: false,
  scoreName: 'user_rating'
  });
  
  // Show review scores as stars
  $('.ratyscore').raty({
    path: '/assets',
    readOnly: true,
    half: true,
    number: 10,
    space: true,
    score: function() {
      return $(this).attr('score')
    }
  })

  // Makes raty stars appear on button click
  $('button.btn').click(function(){
    $('#addmovie').toggle();
    $('button.btn').toggle();
  })

  // Makes edit bar appear on button click
  $('#edit').click(function(){
    $('#changeRating').toggle();
  })

  // Buttons disappear to prevent multiple submits while loading
  $('.submit').click(function(){
    $('.submit').toggle();
  })

  // Toggle between movie details and reviews
  $('.toggle').click(function(){
    $('#movieDetails').toggle();
    $('#reviews').toggle();
  })

  // Handles show more/less cast
  $('#show').click(function(){
    var text = 'Show less'
    if ($(this).html() == 'Show less') {
      var text = 'Show more'
    }
    $('.morecast').toggle();
    $(this).html(text);
  })
});