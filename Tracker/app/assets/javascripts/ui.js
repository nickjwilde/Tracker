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
	var order_id = $('#order-id').val();
	var package_id = $('#package_id').val();
	var num_photos = $('#pkg').val();
	var raw_photos = $('#raw').val();
	var est_photos = $('#est').val();
	var final_photos = $('#final').val();
	var photographer_id = $('#photographer-dropdown option:selected').val();
	var old_photographer_id = $('#photographer-info').data('photographer-id');
	var swag = $('#swag').val();
	var photos_approved = $('#photos-approved').val();
	var photographer_paid = $('#photographer-paid').val();
	var quick_edit_upload = $('#quick-edit-upload').val();
	var assigned_to_editor = $('#assigned-to-editor').val();
	var final_edits_approve = $('#final-edits-approve').val();
	var final_crops = $('#crops').val();
	var final_edit_upload = $('#final-edit-upload').val();
	var home_id = $('#home-info').data('home-id');

	$.post('update_order',
			{
				order_id: order_id,
				package_id: package_id,
				num_photos: num_photos,
				raw_photos: raw_photos,
				est_photos: est_photos,
				final_photos: final_photos,
				photographer_id: photographer_id,
				photos_approved: photos_approved,
				photographer_paid: photographer_paid,
				quick_edit_upload: quick_edit_upload,
				assigned_to_editor: assigned_to_editor,
				final_edits_approve: final_edits_approve,
				final_crops: final_crops,
				final_edit_upload: final_edit_upload,
				home_id: home_id,
				swag: swag
			},
			function(data){
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
		e.preventDefault();
		$('#confirmation-dialog').dialog({
			title: 'Confirm Update',
			buttons: {
			"Confirm": function(){
					update_order_ajax();
					$(this).dialog('close');
					$('#update-results').fadeOut(1500);
				},
			"Cancel": function(){
					$(this).dialog('close');
				}
			}
		});
		$('#confirmation-dialog').dialog('open');
		$('#update-results').html('');
		$('#update-results').fadeIn(1);
	});
});
