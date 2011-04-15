// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){

  $(':checkbox.estimated_payment_checker').live('click', function(event) {
    if (this.checked) {
        this.checked = false
        jQuery.fancybox({
          'showNavArrows' : false,
          'scrolling'		  : 'no',
        	'titleShow'		  : false,
          'href'          : $(this).attr('href')
        });
    }
  })
});