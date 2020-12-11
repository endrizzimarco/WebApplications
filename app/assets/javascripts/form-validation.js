//= require jquery.validate

// Handle client side validation of contact form 
$(document).on('turbolinks:load', function(){
  $('#contactForm').validate({
    // Validation rules
    rules: {
      name: 'required', 
      email: 'required email',
      message: 'required'
    },
    // Error messages
    messages: {
      name: 'Please insert your name',
      email: 'Please insert a valid email address',
      message: 'Please insert a message'
    },
    errorElement: "i",
    submitHandler: function(form) {
      form.submit();
    }
  })
});