$(document).ready(function(){
  $('#welcome_message').delay(1000).fadeIn(1000);
  $('#profile_header').delay(1000).fadeIn(1000);
  $('#profile_picture').delay(1150).fadeIn(1000);
  $('#profile_information').delay(1300).fadeIn(1000);
  $('#profile_logout').delay(1450).fadeIn(1000);
  $('#profile_pages_buttons').delay(1600).fadeIn(1000);
  $('#profile_follows').delay(1750).fadeIn(1000);
  $('#profile_commits').delay(1900).fadeIn(1000);

  $('#welcome_message').click(function(){
    $('#welcome_button').fadeIn(1000);
  });
});
