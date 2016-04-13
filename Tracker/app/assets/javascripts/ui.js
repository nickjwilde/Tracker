function homes_ajax(id){
  $.post('homes',
          {
            id: id
          },
          function(data){
            $("#home-results").html(data);
          }
  );
  $.post('parade_notes',
  	{
	   id: id
	},
	function(data){
		$('#parade-notes').html(data);
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
  $.post('home_notes',
	  {
	  	home_id: id
	  },
		function(data){
			$('#home-notes').html(data);
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
	var photographer_notes = $('textarea#photographer-notes').val();

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
				swag: swag,
				photographer_notes: photographer_notes
			},
			function(data){
				$('#update-results').html(data);
			}
		);
}

function addevent(){
	var name = $('#event-name').val();
	var city = $('#event-city').val();
	var state = $('#event-state option:selected').val();
	var start_date = $('#event-start-date').val();
	var end_date = $('#event-end-date').val();
	var notes = $('#event-notes').val();

	$.post('addevent',
		{
			name: name,
			city: city,
			state: state,
			start_date: start_date,
			end_date: end_date,
			notes: notes
		},
		function(data){
			$('#record-added-dialog').dialog({
			title: 'Record Added Successsfuly',
			buttons: {
			"Okay": function(){
					$(this).dialog('close');
				}
			}
			});
			$('#record-added-dialog').dialog('open');
		});
}

function addphotographer(){
	var first_name = $('#photographer-first-name').val();
	var last_name = $('#photographer-last-name').val();
	var email = $('#photographer-email').val();
	var phone = $('#photographer-phone').val();
	var notes = $('#photographer-notes').val();

	$.post('addphotographer',
		{
			first_name: first_name,
			last_name: last_name,
			email: email,
			phone: phone,
			notes: notes
		},
		function(data){
			$('#record-added-dialog').dialog({
			title: 'Record Added Successsfuly',
			buttons: {
			"Okay": function(){
					$(this).dialog('close');
				}
			}
			});
			$('#record-added-dialog').dialog('open');
		});
}

function addproject(){
	var home_number = $('#home-num').val();
	var builder_id = $('#home-builder option:selected').val();
	var home_name = $('#home-name').val();
	var address = $('#home-address').val();
	var city = $('#home-city').val();
	var state = $('#home-state').val();
	var zip = $('#home-zip').val();
	var photographer_id = $('#home-photographer').val();
	var event_id = $('#home-event').val();
	var notes = $('#home-notes').val();

	$.post('addproject',
		{
			home_number: home_number,
			builder_id: builder_id,
			home_name: home_name,
			address: address,
			city: city,
			state: state,
			zip: zip,
			photographer_id: photographer_id,
			event_id: event_id,
			notes: notes
		},
		function(data){
			$('#record-added-dialog').dialog({
			title: 'Record Added Successsfuly',
			buttons: {
			"Okay": function(){
					$(this).dialog('close');
				}
			}
			});
			$('#record-added-dialog').dialog('open');
		});
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
			$('#parade-notes').html('');
			$('#parade-notes').css('display','block');
			$('#home-notes').html('');
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
			$('#home-notes').html('');
			$('#parade-notes').css('display','block');
		}else{
			$(this).addClass("selected");
			$('#home-results .column-header').slideUp(1000);
			$('#home-results .entry').not(this).slideUp(1000);
			$('#parade-notes').css('display','none');
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
	
	//handle saving of event notes
	$(document).on('submit','#save-parade-notes',function(e){
		e.preventDefault();
		var notes = $('textarea#parade-notes').val();
		var parade_id = $('.entry.selected').data('parade-id');
		$.post('update_parade_notes',
			{
				notes: notes,
				parade_id: parade_id
			},
			function(data){
				$('#parade-notes-success').html(data);
				$('#parade-notes-success').fadeOut(2000);
			}
		);
		$('#parade-notes-success').html('');
		$('#parade-notes-success').fadeIn(1);
	});

	//handle saving of project notes
	$(document).on('submit','#save-home-notes',function(e){
		e.preventDefault();
		var notes = $('textarea#home-notes').val();
		var home_id = $('.home-column .entry.selected').data('home-id');
		$.post('update_home_notes',
			{
				notes: notes,
				home_id: home_id
			},
			function(data){
				$('#home-notes-success').html(data);
				$('#home-notes-success').fadeOut(2000);
			}
		);
		$('#home-notes-success').html('');
		$('#home-notes-success').fadeIn(1);
	});

	//handle update order form
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
	
	//handle adding event
	$('#addeventform').submit(function(e){
		e.preventDefault();
		addevent();
		return false;
	});
	
	//handle adding photographer
	$('#addphotographerform').submit(function(e){
		e.preventDefault();
		addphotographer();
		return false;
	});

	//handle adding project
	$('#addprojectform').submit(function(e){
		e.preventDefault();
		addproject();
		return false;
	});

	//Stack menu when collapsed
	$('#menu-collapse').on('show.bs.collapse', function() {
		$('.nav-pills').addClass('nav-stacked');
   	});

	//Unstack menu when not collapsed
	$('#menu-collapse').on('hide.bs.collapse', function() {
	    $('.nav-pills').removeClass('nav-stacked');
	});

});
