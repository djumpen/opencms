<?php echo $header; ?>
<div id="content" class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="panel panel-default">
    <div class="panel-heading">
      <div class="pull-right"><a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-info-circle"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <ul class="nav nav-tabs">
        <li class="active"><a href="#tab-return" data-toggle="tab"><?php echo $tab_return; ?></a></li>
        <li><a href="#tab-product" data-toggle="tab"><?php echo $tab_product; ?></a></li>
        <li><a href="#tab-history" data-toggle="tab"><?php echo $tab_history; ?></a></li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane active" id="tab-return">
          <table class="table table-striped table-bordered">
            <tr>
              <td><?php echo $text_return_id; ?></td>
              <td><?php echo $return_id; ?></td>
            </tr>
            <?php if ($order) { ?>
            <tr>
              <td><?php echo $text_order_id; ?></td>
              <td><a href="<?php echo $order; ?>"><?php echo $order_id; ?></a></td>
            </tr>
            <?php } else { ?>
            <tr>
              <td><?php echo $text_order_id; ?></td>
              <td><?php echo $order_id; ?></td>
            </tr>
            <?php } ?>
            <tr>
              <td><?php echo $text_date_ordered; ?></td>
              <td><?php echo $date_ordered; ?></td>
            </tr>
            <?php if ($customer) { ?>
            <tr>
              <td><?php echo $text_customer; ?></td>
              <td><a href="<?php echo $customer; ?>"><?php echo $firstname; ?> <?php echo $lastname; ?></a></td>
            </tr>
            <?php } else { ?>
            <tr>
              <td><?php echo $text_customer; ?></td>
              <td><?php echo $firstname; ?> <?php echo $lastname; ?></td>
            </tr>
            <?php } ?>
            <tr>
              <td><?php echo $text_email; ?></td>
              <td><?php echo $email; ?></td>
            </tr>
            <tr>
              <td><?php echo $text_telephone; ?></td>
              <td><?php echo $telephone; ?></td>
            </tr>
            <?php if ($return_status) { ?>
            <tr>
              <td><?php echo $text_return_status; ?></td>
              <td id="return-status"><?php echo $return_status; ?></td>
            </tr>
            <?php } ?>
            <tr>
              <td><?php echo $text_date_added; ?></td>
              <td><?php echo $date_added; ?></td>
            </tr>
            <tr>
              <td><?php echo $text_date_modified; ?></td>
              <td><?php echo $date_modified; ?></td>
            </tr>
          </table>
        </div>
        <div class="tab-pane" id="tab-product">
          <table class="table table-striped table-bordered">
            <tr>
              <td><?php echo $text_product; ?></td>
              <td><?php echo $product; ?></td>
            </tr>
            <tr>
              <td><?php echo $text_model; ?></td>
              <td><?php echo $model; ?></td>
            </tr>
            <tr>
              <td><?php echo $text_quantity; ?></td>
              <td><?php echo $quantity; ?></td>
            </tr>
            <tr>
              <td><?php echo $text_return_reason; ?></td>
              <td><?php echo $return_reason; ?></td>
            </tr>
            <tr>
              <td><?php echo $text_opened; ?></td>
              <td><?php echo $opened; ?></td>
            </tr>
            <tr>
              <td><?php echo $text_return_action; ?></td>
            <td><select name="return_action_id" class="form-control">
                <option value="0"></option>
                <?php foreach ($return_actions as $return_action) { ?>
                <?php if ($return_action['return_action_id'] == $return_action_id) { ?>
                <option value="<?php echo $return_action['return_action_id']; ?>" selected="selected"><?php echo $return_action['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $return_action['return_action_id']; ?>"><?php echo $return_action['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
            </tr>
            <?php if ($comment) { ?>
            <tr>
              <td><?php echo $text_comment; ?></td>
              <td><?php echo $comment; ?></td>
            </tr>
            <?php } ?>
          </table>
        </div>
        <div class="tab-pane form-horizontal" id="tab-history">
          <div id="history"></div>
          <br />
          <div class="form-group">
            <label class="col-xs-2 control-label" for="input-return-action"><?php echo $text_return_action; ?></label>
            <div class="col-xs-10">
              <select name="return_action_id" id="input-return-action" class="form-control">
                <option value="0"></option>
                <?php foreach ($return_actions as $return_action) { ?>
                <?php if ($return_action['return_action_id'] == $return_action_id) { ?>
                <option value="<?php echo $return_action['return_action_id']; ?>" selected="selected"><?php echo $return_action['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $return_action['return_action_id']; ?>"><?php echo $return_action['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-xs-2 control-label" for="input-return-status"><?php echo $entry_return_status; ?></label>
            <div class="col-xs-10">
              <select name="return_status_id" id="input-return-status" class="form-control">
                <?php foreach ($return_statuses as $return_status) { ?>
                <?php if ($return_status['return_status_id'] == $return_status_id) { ?>
                <option value="<?php echo $return_status['return_status_id']; ?>" selected="selected"><?php echo $return_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $return_status['return_status_id']; ?>"><?php echo $return_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-xs-2 control-label" for="input-notify"><?php echo $entry_notify; ?></label>
            <div class="col-xs-10">
              <input type="checkbox" name="notify" value="1" id="input-notify" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-xs-2 control-label" for="input-comment"><?php echo $entry_comment; ?></label>
            <div class="col-xs-10">
              <textarea name="comment" rows="8" id="input-comment" class="form-control"></textarea>
            </div>
          </div>
          <div class="text-right">
            <button id="button-history" class="btn btn-primary"><i class="fa fa-plus-circle"></i> <?php echo $button_add_history; ?></button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('select[name=\'return_action_id\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=sale/return/action&token=<?php echo $token; ?>&return_id=<?php echo $return_id; ?>',
		type: 'post',
		dataType: 'json',
		data: 'return_action_id=' + this.value,
		beforeSend: function() {
			$('.success, .warning, .attention').remove();
			
			$('.panel').before('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		success: function(json) {
			$('.success, .warning, .attention').remove();
			
			if (json['error']) {
				$('.panel').before('<div class="warning" style="display: none;">' + json['error'] + '</div>');
				
				$('.warning').fadeIn('slow');
			}
			
			if (json['success']) {
				$('.panel').before('<div class="success" style="display: none;">' + json['success'] + '</div>');
				
				$('.success').fadeIn('slow');
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
});

$('#history').delegate('ul.pagination a', 'click', function() {
	$('#history').load(this.href);
	
	return false;
});			

$('#history').load('index.php?route=sale/return/history&token=<?php echo $token; ?>&return_id=<?php echo $return_id; ?>');

$('#button-history').on('click', function() {
	$.ajax({
		url: 'index.php?route=sale/return/history&token=<?php echo $token; ?>&return_id=<?php echo $return_id; ?>',
		type: 'post',
		dataType: 'html',
		data: 'return_status_id=' + encodeURIComponent($('select[name=\'return_status_id\']').val()) + '&notify=' + encodeURIComponent($('input[name=\'notify\']').attr('checked') ? 1 : 0) + '&append=' + encodeURIComponent($('input[name=\'append\']').attr('checked') ? 1 : 0) + '&comment=' + encodeURIComponent($('textarea[name=\'comment\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-history').attr('disabled', true);
			$('#history').prepend('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-history').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(html) {
			$('#history').html(html);
			
			$('textarea[name=\'comment\']').val(''); 
			
			$('#return-status').html($('select[name=\'return_status_id\'] option:selected').text());
		}
	});
});
//--></script>
<?php echo $footer; ?>