$(document).on('turbolinks:load', function(){
  // Remember theme every time page loads 
  // Vanilla js should be faster for this
  if (localStorage.getItem('lightTheme') === 'false') {
    document.getElementsByTagName('body')[0].classList.toggle('dark-theme');
    document.getElementById('dark-toggle').innerHTML = 'Light Theme'
  }

  // Handles light/dark mode toggle
  $('#dark-toggle').on('click', function(){
    if ($(this).html() == 'Light Theme') {
      text = 'Dark Theme'
      light = true
    } 
    else {
      text = 'Light Theme'
      light = false
    }
    // Set theme in local storage
    localStorage.setItem('lightTheme', light)
    $('body').toggleClass('dark-theme');
    $(this).html(text);
  })
});