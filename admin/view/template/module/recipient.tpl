<?php echo $header; ?>

<div id="content" class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-sign"></i> <?php echo $error_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check"></i> <?php echo $success; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="panel panel-default">
    <div class="panel-heading">
      <div class="pull-right">
        <!--<button type="submit" form="form-recipient" class="btn btn-primary "><i class="icon-ok"></i> <?php echo $button_save; ?></button>-->
        <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
<!-- admin config -->
<?php if ($this->user->hasPermission('modify', 'setting/store')) { ?>
<form action="<?php echo $action_admin; ?>" method="post" enctype="multipart/form-data" id="form-admin-recipient" class="form-horizontal">
<div class="alert alert-warning">
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-admin-order-status"><?php echo $text_default_order_status; ?></label>
              <div class="col-xs-10">
                              <select name="config_shipped_status_id" class="form-control">
                <?php foreach ($order_statuses as $admin_statuses) { ?>
	                <option value="<?php echo $admin_statuses['order_status_id']; ?>"<?php if ( isset($config_shipped_status_id) && $config_shipped_status_id == $admin_statuses['order_status_id'] ) { echo ' selected';} ?>><?php echo $admin_statuses['name']; ?></option>
                <?php } ?>
              </select>
			<p class="help-block"><?php echo $entry_default_order_status; ?></p>
<button type="submit" form="form-admin-recipient" class="btn btn-primary"><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
              </div>
            </div>
</div>
</form>
<hr />
<?php } ?>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-recipient" class="form-horizontal">


            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-order-id"><?php echo $text_order_id; ?></label>
              <div class="col-xs-10">
                <?php if ($orders) { ?>
			<select name="order_id" id="select-order-id" class="form-control">
              		<?php foreach ($orders as $order) { ?>
				<option value="<?php echo $order['order_id']; ?>"><?php echo $order['order_id']; ?></option>
              		<?php } ?>
			</select>
			<p class="help-block"><?php echo $entry_order_id; ?></p>
		<?php } ?>
              </div>
            </div>
			<!-- show recipient and order info -->
			<div id="recipient"></div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-order-status"><?php echo $text_order_status; ?></label>
              <div class="col-xs-10">
                              <select name="order_status_id" class="form-control">
                <?php foreach ($order_statuses as $order_statuses) { ?>
	                <option value="<?php echo $order_statuses['order_status_id']; ?>"<?php if ( isset($config_shipped_status_id) && $config_shipped_status_id == $order_statuses['order_status_id'] ) { echo ' selected';} ?>><?php echo $order_statuses['name']; ?></option>
                <?php } ?>
              </select>
			<p class="help-block"><?php echo $entry_order_status; ?></p> 
              </div>
            </div>

                <input type="hidden" name="geolocation" value="" id="input-order-geo" class="form-control" />
                <input type="hidden" name="time" value="" id="input-sign-time" class="form-control" />
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-notify"><?php echo $text_notify; ?></label>
              <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">
		  <label class="btn btn-primary">
		    <i class="fa fa-check"></i> <input type="radio" name="notify" value="1" id="input-status" checked="checked"></label>
		  <label class="btn btn-warning">
		    <i class="fa fa-times"></i> <input type="radio" name="notify" value="0" id="input-status"></label>
		</div>
			<p class="help-block"><?php echo $entry_notify; ?></p>

           </div>
            </div>
<hr />
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-recipient-name"><?php echo $text_recipient_name; ?></label>
              <div class="col-xs-10">
                <input type="text" name="recipient-name" value="" id="input-recipient-name" class="form-control" />
			<p class="help-block"><?php echo $entry_recipient_name; ?></p>
              </div>
            </div>
	<div class="form-group">
              <label class="col-xs-2 control-label" for="input-recipient-name"><?php echo $text_recipient_signature; ?></label>
              <div class="col-xs-10"><button class="btn btn-primary" id="signature"><i class="fa fa-edit"></i> <?php echo $text_recipient; ?></button>
              </div>
            </div>


<!-- signature pad -->
  <div id="signature-pad" class="m-signature-pad hideCanvas">
    <div class="m-signature-pad--body">
      <canvas></canvas>
	<input type="hidden" id="output" name="output">
    </div>
    <div class="m-signature-pad--footer">
      <div class="description">
      	<a href="#" class="btn btn-warning clear" data-action="clear"><i class="fa fa-times"></i> <?php echo $text_clear; ?></a>
      	<button class="btn btn-primary save" id="form-recipient" data-action="save"><i class="fa fa-check"></i> <?php echo $button_save; ?></button> 
      	<a href="#" class="btn btn-danger" id="clear"><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a>
	</div>
    </div>
  </div>
<!-- signature pad -->


 <style>

        .hideCanvas{visibility:hidden;}
.m-signature-pad {
  position: fixed;
  font-size: 10px;
  width: 700px;
  height: 400px;
  top: 50%;
  left: 50%;
  margin-left: -350px;
  margin-top: -200px;
  border: 1px solid #e8e8e8;
  background-color: #fff;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.27), 0 0 40px rgba(0, 0, 0, 0.08) inset;
  border-radius: 4px;
		z-index:9999;
		-webkit-user-select: none;
		-moz-user-select: none;
		user-select: none;
}

.m-signature-pad--body {
  position: absolute;
  left: 20px;
  right: 20px;
  top: 20px;
  bottom: 60px;
  border: 1px solid #f4f4f4;
}

.m-signature-pad--body
  canvas {
    position: absolute;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    border-radius: 4px;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.02) inset;
    -moz-user-select: -moz-none;
    -webkit-user-select: none;
    -ms-user-select: none;
  }

.m-signature-pad--footer {
  position: absolute;
  left: 20px;
  right: 20px;
  bottom: 35px;
  height: 40px;
}

.m-signature-pad--footer
  .description {
    color: #C3C3C3;
    text-align: center;
    font-size: 1.2em;
    margin-top: 1.8em;
  }

.m-signature-pad--footer
  .button {
    position: absolute;
    bottom: 0;
  }

.m-signature-pad--footer
  .button.clear {
    left: 0;
  }

.m-signature-pad--footer
  .button.save {
    right: 0;
  }

@media screen and (max-width: 1024px) {
  .m-signature-pad {
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    width: auto;
    height: auto;
    min-width: 250px;
    min-height: 140px;
    margin: 5%;
  }
}

@media screen and (min-device-width: 768px) and (max-device-width: 1024px) {
  .m-signature-pad {
    margin: 5%;
  }
}

@media screen and (max-height: 320px) {
  .m-signature-pad--body {
    left: 0;
    right: 0;
    top: 0;
    bottom: 32px;
  }
  .m-signature-pad--footer {
    left: 20px;
    right: 20px;
    bottom: 4px;
    height: 28px;
  }
  .m-signature-pad--footer
    .description {
      font-size: 1em;
      margin-top: 1em;
    }
}

  </style>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript">

$(document).ready(function () {

/* Sign Location */
        var Geo={};

        if (navigator.geolocation) {
           navigator.geolocation.getCurrentPosition(success, error);
        }

        //Get the latitude and the longitude;
        function success(position) {
            Geo.lat = position.coords.latitude;
            Geo.lng = position.coords.longitude;
            populateHeader(Geo.lat, Geo.lng);
        }

        function error(){
            console.log("Geocoder failed");
        }

        function populateHeader(lat, lng){
		$('input[id="input-order-geo"]').val(lat + " " +lng);
        }

/* Signature */
var wrapper = document.getElementById("signature-pad"),
    clearButton = wrapper.querySelector("[data-action=clear]"),
    saveButton = wrapper.querySelector("[data-action=save]"),
    canvas = wrapper.querySelector("canvas"),
    output = document.getElementById("output"),
    signaturePad;

// Adjust canvas coordinate space taking into account pixel ratio,
// to make it look crisp on mobile devices.
// This also causes canvas to be cleared.
function resizeCanvas() {
    var ratio =  window.devicePixelRatio || 1;
    canvas.width = canvas.offsetWidth * ratio;
    canvas.height = canvas.offsetHeight * ratio;
    canvas.getContext("2d").scale(ratio, ratio);
}

window.onresize = resizeCanvas;
resizeCanvas();

signaturePad = new SignaturePad(canvas);

//document.addEventListener("touchend", function (event) {
//	output.value = signaturePad.toDataURL();
//});

clearButton.addEventListener("click", function (event) {
event.preventDefault();
    signaturePad.clear();
    output.value="";
});

saveButton.addEventListener("click", function (event) {
    if (signaturePad.isEmpty()) {
	event.preventDefault();
        alert("Please provide signature first.");
    } else {
	output.value = signaturePad.toDataURL();
    }
});



/* Recipient signature */

    $('#signature').on('click', function() {
	event.preventDefault();
	$('#signature-pad').removeClass( "hideCanvas" );
	});
    $('#clear').on('click', function() {
	event.preventDefault();
	$('#signature-pad').addClass( "hideCanvas" );
	});

});

/* show recipient info */

$(document).on('change', 'select[name=\'order_id\']', function(){
	$.ajax({
		url: 'index.php?route=module/recipient/recipientInfo&token=<?php echo $token; ?>&'+'order_id=' + encodeURIComponent($('select[name=\'order_id\']').val()),
		type: 'post',
		dataType: 'html',
		data: 'order_id=' + encodeURIComponent($('select[name=\'order_id\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('select #input-order-id').attr('disabled', true);
			$('#recipient').prepend('<div class="attention"><i class="fa fa-spinner fa-spin"></i></div>');
		},
		complete: function() {
			$('select #input-order-id').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(html) {
			$('#recipient').html(html);
		}
	});
});

// get signed time
var currentTime = new Date();
  var hours = currentTime.getHours();
  var minutes = currentTime.getMinutes();

  var suffix = "AM";
  if (hours >= 12) {
  suffix = "PM";
  hours = hours - 12;
  }
  if (hours == 0) {
  hours = 12;
  }

  if (minutes < 10)
  minutes = "0" + minutes

 $('input[id="input-sign-time"]').val(hours + ":" + minutes + " " + suffix);

</script>
<script type="text/javascript" src="view/assets/signature_pad.min.js"></script>


<?php echo $footer; ?>