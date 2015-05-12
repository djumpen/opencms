<?php echo $header; ?>
<div id="content" class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if (isset($error['error_warning'])) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error['error_warning']; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  <?php } ?>
  <div class="panel panel-default">
    <div class="panel-heading">
      <div class="pull-right">
        <button type="submit" onclick="$('#form').submit();" form="form-authorizenet-aim" class="btn btn-primary "><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>


          <div class="panel-body">

            <ul class="nav nav-tabs">

                <li class="active"><a href="#tab-api-details" data-toggle="tab"><?php echo $tab_api_details; ?></a></li>
                <li><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                <li><a href="#tab-status" data-toggle="tab"><?php echo $tab_order_status; ?></a></li>
                <li><a href="#tab-customise" data-toggle="tab"><?php echo $tab_customise; ?></a></li>
            </ul>

            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
<div class="tab-content">

                <div class="tab-pane active" id="tab-api-details">
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_username"><?php echo $entry_username; ?></label>
            <div class="col-xs-10">
                 <input type="text" name="pp_express_username" value="<?php echo $pp_express_username; ?>" class="form-control" />
			<?php if (isset($error['username'])) { ?>
				<span class="text-error"><?php echo $error['username']; ?></span>
			<?php } ?>
		</div>
	</div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_password"><?php echo $entry_password; ?></label>
            <div class="col-xs-10">
		<input type="text" name="pp_express_password" value="<?php echo $pp_express_password; ?>" class="form-control"/>
		<?php if (isset($error['password'])) { ?>
			<span class="text-error"><?php echo $error['password']; ?></span>
		<?php } ?>
		</div>
	</div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_signature"><?php echo $entry_signature; ?></label>
            <div class="col-xs-10">
		<input type="text" name="pp_express_signature" value="<?php echo $pp_express_signature; ?>" class="form-control"/>
                                <?php if (isset($error['signature'])) { ?>
                                <span class="text-error"><?php echo $error['signature']; ?></span>
                                <?php } ?>
                            </div>
                        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_ipn"><?php echo $text_ipn; ?></label>
            <div class="col-xs-10">
			<input type="text" name="pp_ipn" value="<?php echo $text_ipn_url; ?>" class="form-control"/>
                        </div>
                    </div>
                </div>

                <div class="tab-pane" id="tab-general">
                    	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_test"><?php echo $entry_test; ?></label>
            <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($pp_express_test == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="pp_express_test" id="pp_express_profile_cancel_status" value="1" <?php if ($pp_express_test == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($pp_express_test == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="pp_express_test" id="pp_express_profile_cancel_status" value="0" <?php if ($pp_express_test == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
                            </div>
                        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_debug"><?php echo $entry_debug; ?></label>
            <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($pp_express_debug == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="pp_express_debug" id="pp_express_profile_cancel_status" value="1" <?php if ($pp_express_debug == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($pp_express_debug == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="pp_express_debug" id="pp_express_profile_cancel_status" value="0" <?php if ($pp_express_debug == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
                            </div>
                        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_method"><?php echo $entry_method; ?></label>
            <div class="col-xs-10">
                                <select name="pp_express_method" class="form-control">
                                    <option value="Sale" <?php  echo (($pp_express_method == '' || $pp_express_method == 'Sale') ? 'selected="selected"' : ''); ?>><?php echo $text_sale; ?></option>
                                    <option value="Authorization" <?php echo ($pp_express_method == 'Authorization' ? 'selected="selected"' : ''); ?>><?php echo $text_authorization; ?></option>
                                </select>
                            </div>
                        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_total"><?php echo $entry_total; ?></label>
            <div class="col-xs-10">
			<input type="text" name="pp_express_total" value="<?php echo $pp_express_total; ?>" class="form-control" />
                        </div>
                        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_geo_zone_id"><?php echo $entry_geo_zone; ?></label>
            <div class="col-xs-10">
                                <select name="pp_express_geo_zone_id" class="form-control">
                                    <option value="0"><?php echo $text_all_zones; ?></option>
                                    <?php foreach ($geo_zones as $geo_zone) { ?>
                                    <?php if ($geo_zone['geo_zone_id'] == $pp_express_geo_zone_id) { ?>
                                    <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                                    <?php } else { ?>
                                    <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                                    <?php } ?>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_currency"><?php echo $entry_currency; ?></label>
            <div class="col-xs-10">
                                <select name="pp_express_currency" class="form-control">
                                    <?php foreach($currency_codes as $code){ ?>
                                        <option <?php if($code == $pp_express_currency){ echo 'selected'; } ?>><?php echo $code; ?></option>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_status"><?php echo $entry_status; ?></label>
            <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($pp_express_status == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="pp_express_status" id="pp_express_profile_cancel_status" value="1" <?php if ($pp_express_status == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_enabled; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($pp_express_status == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="pp_express_status" id="pp_express_profile_cancel_status" value="0" <?php if ($pp_express_status == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_disabled; ?>
  			</label>
		</div>
                            </div>
                        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_sort_order"><?php echo $entry_sort_order; ?></label>
            <div class="col-xs-10">
		<input type="text" name="pp_express_sort_order" value="<?php echo $pp_express_sort_order; ?>" class="form-control"/></td>
             </div>
	</div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_profile_cancel_status"><?php echo $entry_profile_cancellation ?></label>
            <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($pp_express_profile_cancel_status == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="pp_express_profile_cancel_status" id="pp_express_profile_cancel_status" value="1" <?php if ($pp_express_profile_cancel_status == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_enabled; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($pp_express_profile_cancel_status == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" nname="pp_express_profile_cancel_status" id="pp_express_profile_cancel_status" value="0" <?php if ($pp_express_profile_cancel_status == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_disabled; ?>
  			</label>
		</div>
                           </div>
                        </div>

                </div>
                <div class="tab-pane" id="tab-status">
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_canceled_reversal_status_id"><?php echo $entry_canceled_reversal_status; ?></label>
            <div class="col-xs-10">
                                <select name="pp_express_canceled_reversal_status_id" class="form-control">
                                    <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $pp_express_canceled_reversal_status_id) { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_canceled_reversal_status_id"><?php echo $entry_completed_status; ?></label>
            <div class="col-xs-10">
                                <select name="pp_express_completed_status_id" class="form-control">
                                    <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $pp_express_completed_status_id) { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_canceled_reversal_status_id"><?php echo $entry_denied_status; ?></label>
            <div class="col-xs-10">
                                <select name="pp_express_denied_status_id" class="form-control">
                                    <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $pp_express_denied_status_id) { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_expired_status_id"><?php echo $entry_expired_status; ?></label>
            <div class="col-xs-10">
                                <select name="pp_express_expired_status_id" class="form-control">
                                    <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $pp_express_expired_status_id) { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_failed_status_id"><?php echo $entry_failed_status; ?></label>
            <div class="col-xs-10">
                                <select name="pp_express_failed_status_id" class="form-control">
                                    <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $pp_express_failed_status_id) { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_pending_status_id"><?php echo $entry_pending_status; ?></label>
            <div class="col-xs-10">
                                <select name="pp_express_pending_status_id" class="form-control">
                                    <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $pp_express_pending_status_id) { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_pending_status_id"><?php echo $entry_processed_status; ?></label>
            <div class="col-xs-10">
                                <select name="pp_express_processed_status_id" class="form-control">
                                    <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $pp_express_processed_status_id) { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_refunded_status_id"><?php echo $entry_refunded_status; ?></label>
            <div class="col-xs-10">
                                <select name="pp_express_refunded_status_id" class="form-control">
                                    <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $pp_express_refunded_status_id) { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_refunded_status_id"><?php echo $entry_reversed_status; ?></label>
            <div class="col-xs-10">
                                <select name="pp_express_reversed_status_id" class="form-control">
                                    <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $pp_express_reversed_status_id) { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_voided_status_id"><?php echo $entry_voided_status; ?></label>
            <div class="col-xs-10">
                                <select name="pp_express_voided_status_id" class="form-control">
                                    <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $pp_express_voided_status_id) { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>

                </div>

                <div class="tab-pane" id="tab-customise">
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_allow_note"><?php echo $entry_allow_notes; ?></label>
            <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($pp_express_allow_note == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="pp_express_allow_note" id="pp_express_profile_cancel_status" value="1" <?php if ($pp_express_allow_note == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_enabled; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($pp_express_allow_note == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="pp_express_allow_note" id="pp_express_profile_cancel_status" value="0" <?php if ($pp_express_allow_note == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_disabled; ?>
  			</label>
		</div>
                            </div>
                        </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-image"><?php echo $entry_logo; ?></label>
              <div class="col-xs-10"><img src="<?php echo $thumb; ?>" alt="" class="img-thumbnail" id="thumb" />
                <input type="hidden" name="pp_express_logo" value="<?php echo $pp_express_logo; ?>" id="image" />
                <br />
                <br />
                <div class="btn-group">
                  <button onclick="image_upload('image', 'thumb');" class="btn btn-info" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog"><span class="fa fa-pencil"></span> <?php echo $text_browse; ?></button>
                  <button type="button" onclick="$(this).parent().parent().find('img').attr('src', '<?php echo $no_image; ?>'); $(this).parent().parent().find('input').attr('value', '');return false;" class="btn btn-danger"><span class="fa fa-trash-o"></span> <?php echo $text_clear; ?></button>
                </div>
              </div>
            </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_border_colour"><?php echo $entry_border_colour; ?></label>
            <div class="col-xs-10">
		<input type="color" name="pp_express_border_colour" value="<?php echo $pp_express_border_colour; ?>" class="form-control"/>
                        </div>
                        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_header_colour"><?php echo $entry_header_colour; ?></label>
            <div class="col-xs-10">
		<input type="color" name="pp_express_header_colour" value="<?php echo $pp_express_header_colour; ?>" class="form-control"/>
                        </div>
                        </div>
	<div class="form-group required">
          <label class="col-xs-2 control-label" for="pp_express_page_colour"><?php echo $entry_page_colour; ?></label>
            <div class="col-xs-10">
		<input type="color" name="pp_express_page_colour" value="<?php echo $pp_express_page_colour; ?>" class="form-control"/>
                        </div>
                    </div>
                </div>
</div>
            </form>
        </div>
    </div>
</div>
 <div class="modal fade" id="dialog" data-field="" data-thumb="">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title"><?php echo $text_image_manager; ?></h4>
        </div>
        <div class="modal-body">
         <iframe id="fm-iframe" style="display:block; border:0; padding:0; margin:0; width:100%; height:360px; overflow:auto;"></iframe>
        </div>
        <div class="modal-footer">
	    <a href="#" id="dialog-confirm" class="btn btn-success hide"><i class="fa fa-thumbs-up"></i> Confirm</a>
	    <a href="#" class="btn btn-success" data-dismiss="modal" aria-hidden="true">Close</a>
        </div>
      </div>
    </div>
  </div>

<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>
<script type="text/javascript"><!--
function image_upload(field, thumb) {

	$('#dialog').attr('data-field', field);
	$('#dialog').attr('data-thumb', thumb);
	$('#dialog #fm-iframe').attr('src', 'index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field));
};

	$(document.body).on('show.bs.modal', '#dialog', function () {
		$(this).find('#dialog-confirm').addClass('hide');
	});

	$(document.body).on('hidden.bs.modal', '#dialog', function () {
		var field = $(this).attr('data-field');
		var thumb = $(this).attr('data-thumb');

		if ($('#' + field).attr('value')) {
			$.ajax({
				url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()),
				dataType: 'text',
				success: function(data) {
					$('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '">');
				}
			});
		}
		$('#dialog').attr('data-field', '');
		$('#dialog').attr('data-thumb', '');
		$('#dialog #fm-iframe').attr('src', '');
	});
    //--></script>
<?php echo $footer; ?> 