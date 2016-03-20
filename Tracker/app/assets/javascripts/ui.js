$(document).ready(function(){
	$('#event-column .entry').click(function(){
		if($(this).hasClass("selected")){
			$(this).removeClass("selected");
			$('#event-column .column-header').fadeTo(1000,1);
			$('#event-column .entry').not(this).slideDown(1000);
		}else{
			$(this).addClass("selected");
			$('#event-column .column-header').fadeTo(1000,0);
			$('#event-column .entry').not(this).slideUp(1000);
		}
  });
	$('#home-column .entry').click(function(){
		if($(this).hasClass("selected")){
			$(this).removeClass("selected");
			$('#home-column .column-header').slideDown(1000);
			$('#home-column .entry').not(this).slideDown(1000);
		}else{
			$(this).addClass("selected");
			$('#home-column .column-header').slideUp(1000);
			$('#home-column .entry').not(this).slideUp(1000);
		}
	});
});