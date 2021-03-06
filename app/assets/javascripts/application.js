// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require jquery-fileupload/basic
//= require tag-it
//= require jquery.rangeslider.min
//= require underscore
//= require underscore.string
//= require handlebars
//= require bootstrap-datepicker
//= require markdown
//= require jquery.tinysort
//= require bootstrap-collapse
//= require bootstrap-filestyle

$(".datepicker").datepicker({format: "yyyy-mm-dd", forceParse: false}).
  on('changeDate', function(ev) {
    $(ev.currentTarget).datepicker('hide')
  });
$('body').on('click', '#submit-button, .submit-btn', function() {
  $(this).closest('form').submit();
  return false;
});
$('.menu-icon').on('click', function() {
  $('.menu').toggleClass('open')
});

$('body').on('click','a:not(.js)', function() {
  window.location = $(this).attr('href');
  return false;
});
