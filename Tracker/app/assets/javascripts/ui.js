function homes_ajax(id){
  $.post('homes',
          {
            id: id
          },
          function(data){
            $("#home-results").html(data);
          }
  );
}

function order_ajax(id){
  $.post('order_details',
          {
            home_id: id
          },
          function(data){
            $("#order-results").html(data);
          }
  );
}

function update_order_ajax(){
	$.post('update_order',
			{
				//data variables here
			},
			function(data){
				//update modal here
				//and show modal.
				$('#update-results').html(data);
			}
		);

}

$(document).ready(function(){
	//handle event selection
	$('#event-column .entry').click(function(){
    		var parade_id = $(this).data("parade-id");

    		if($(this).hasClass("selected")){
			$(this).removeClass("selected");
			$('#event-column .column-header').fadeTo(1000,1);
			$('#event-column .entry').not(this).slideDown(1000);
      			$('#home-results').html('');
      			$('#order-results').html('');
		}else{
			$(this).addClass("selected");
			$('#event-column .column-header').fadeTo(1000,0);
			$('#event-column .entry').not(this).slideUp(1000);
      			homes_ajax(parade_id);
      		}
});
	//handle home selection
	$(document).on('click','.home-column .entry',function(){
		var home_id = $(this).data("home-id");
		if($(this).hasClass("selected")){
			$(this).removeClass("selected");
			$('#home-results .column-header').slideDown(1000);
			$('#home-results .entry').not(this).slideDown(1000);
			$('#order-results').html('');
		}else{
			$(this).addClass("selected");
			$('#home-results .column-header').slideUp(1000);
			$('#home-results .entry').not(this).slideUp(1000);
			order_ajax(home_id)
		}
	});
	//handle checks and x's on status elements
	$(document).on('click','.status-icon i',function(){
		if($(this).hasClass('fa-check')){
			$(this).removeClass('fa-check');
			$(this).addClass('fa-times');
			$(this).siblings('input').val('false');
		}else{
			$(this).removeClass('fa-times');
			$(this).addClass('fa-check');
			$(this).parent('.status-icon').data();
			$(this).siblings('input').val('true');
		}
	});
	//handle swag package
	$(document).on('click','.swag i',function(){
		if($(this).hasClass('fa-check')){
			$(this).removeClass('fa-check');
			$(this).addClass('fa-times');
			$(this).siblings('input').val('false');
		}else{
			$(this).removeClass('fa-times');
			$(this).addClass('fa-check');
			$(this).siblings('input').val('true');
		}
	});
	$('#confirmation-dialog').dialog({
			autoOpen: false,
			modal: true
	});

	$(document).on('click','#update-order',function(e){
		alert('Are you sure you want to update the record');	
		$('#confirmation-dialog').dialog({
			buttons: {
			"Confirm": update_order_ajax(),
			"Cancel": function(){
				$(this).dialog('close');
				}
			}
		});
		$('#confirmation-dialog').dialog('open');
	});
});
