<?php echo $header; ?>
<div id="content" class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="panel panel-default">
    <div class="panel-heading">
      <div class="pull-right">
        
        <a href="<?php echo $insert; ?>" class="btn  btn-primary"><i class="fa fa-plus"></i> <?php echo $button_insert; ?></a>
        <div class="btn-group">
          <button type="button" class="btn btn-danger dropdown-toggle " data-toggle="dropdown"><i class="fa fa-trash-o"></i> <?php echo $button_delete; ?> <i class="fa fa-caret-down"></i></button>
          <ul class="dropdown-menu pull-right">
            <li><a onclick="$('#form-voucher').submit();"><?php echo $button_delete; ?></a></li>
          </ul>
        </div>
      </div>
      <h1 class="panel-title"><i class="fa fa-list"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-voucher">
        <div class="table-responsive">
          <table class="table table-striped table-bordered table-hover">
            <thead>
              <tr>
                <td width="1" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                <td class="text-left width-10"><?php if ($sort == 'v.code') { ?>
                  <a href="<?php echo $sort_code; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_code; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_code; ?>"><?php echo $column_code; ?></a>
                  <?php } ?></td>
                <td class="text-left width-10"><?php if ($sort == 'v.from_name') { ?>
                  <a href="<?php echo $sort_from; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_from; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_from; ?>"><?php echo $column_from; ?></a>
                  <?php } ?></td>
                <td class="text-left width-10"><?php if ($sort == 'v.to_name') { ?>
                  <a href="<?php echo $sort_to; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_to; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_to; ?>"><?php echo $column_to; ?></a>
                  <?php } ?></td>
                <td class="text-right width-10"><?php if ($sort == 'v.amount') { ?>
                  <a href="<?php echo $sort_amount; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_amount; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_amount; ?>"><?php echo $column_amount; ?></a>
                  <?php } ?></td>
                <td class="text-left width-10"><?php if ($sort == 'theme') { ?>
                  <a href="<?php echo $sort_theme; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_theme; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_theme; ?>"><?php echo $column_theme; ?></a>
                  <?php } ?></td>
                <td class="text-left width-10"><?php if ($sort == 'v.status') { ?>
                  <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                  <?php } ?></td>
                <td class="text-left width-10"><?php if ($sort == 'v.date_added') { ?>
                  <a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
                  <?php } ?></td>
                <td class="text-right"><?php echo $column_action; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php if ($vouchers) { ?>
              <?php foreach ($vouchers as $voucher) { ?>
              <tr>
                <td class="text-center"><?php if ($voucher['selected']) { ?>
                  <input type="checkbox" name="selected[]" value="<?php echo $voucher['voucher_id']; ?>" checked="checked" />
                  <?php } else { ?>
                  <input type="checkbox" name="selected[]" value="<?php echo $voucher['voucher_id']; ?>" />
                  <?php } ?></td>
                <td class="text-left"><?php echo $voucher['code']; ?></td>
                <td class="text-left"><?php echo $voucher['from']; ?></td>
                <td class="text-left"><?php echo $voucher['to']; ?></td>
                <td class="text-right"><?php echo $voucher['amount']; ?></td>
                <td class="text-left"><?php echo $voucher['theme']; ?></td>
                <td class="text-left"><span<?php echo ($this->language->get('text_disabled') == $voucher['status'])?' class="label label-warning"':' class="label label-primary"'; ?>><?php echo $voucher['status']; ?></span></td>
                <td class="text-left"><?php echo $voucher['date_added']; ?></td>
                <td class="text-right"><div class="btn-group"><a class="btn btn-success" id="button-send-<?php echo $voucher['voucher_id']; ?>" onclick="sendVoucher('<?php echo $voucher['voucher_id']; ?>');"><i class="fa fa-envelope-alt"></i> <?php echo $text_send; ?></a> <?php foreach ($voucher['action'] as $action) { ?>
                  <a href="<?php echo $action['href']; ?>" data-toggle="tooltip" title="<?php echo $action['text']; ?>" class="btn btn-primary"><i class="fa fa-edit"></i> <?php echo $action['text']; ?></a>
                  <?php } ?></div></td>
              </tr>
              <?php } ?>
              <?php } else { ?>
              <tr>
                <td class="text-center" colspan="9"><?php echo $text_no_results; ?></td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
        </div>
      </form>
      <div class="row">
        <div class="col-xs-6 text-left"><?php 
if ($pagination){
$str = $pagination;

$str1 = str_replace('<div class="links">', '<ul class="pagination">', $str);
$str2 = str_replace('</div>', '</ul>', $str1);
$str3 = str_replace('<a', '<li><a', $str2);
$str4 = str_replace('</a>', '</a></li>', $str3);
$str5 = str_replace('<b>', '<li class="active"><a>', $str4);
$str6 = str_replace('</b>', '<span class="sr-only">(current)</span></a></li>', $str5);
$str7 = str_replace('&gt;|', '<i class="fa fa-angle-double-right"></i>', $str6);
$str8 = str_replace('&gt;', '<i class="fa fa-angle-right"></i>', $str7);
$str9 = str_replace('|&lt;', '<i class="fa fa-angle-double-left"></i>', $str8);
$str10 = str_replace('&lt;', '<i class="fa fa-angle-left"></i>', $str9);
$str11 = str_replace('....', '<li class="disabled"><span>....</span></li>', $str10);
echo $str11; 
}
?></div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
function sendVoucher(voucher_id) {

	$.ajax({
		url: 'index.php?route=sale/voucher/send&token=<?php echo $token; ?>&voucher_id=' + voucher_id,
		type: 'post',
		dataType: 'json',
		beforeSend: function() {
			$('#button-send-' +voucher_id+ ' i').replaceWith('<i class="fa fa-spinner fa-spin"></i>');
			$('#button-send-' +voucher_id).prop('disabled', true);
		},
		complete: function() {
			$('#button-send-' +voucher_id+ ' i').replaceWith('<i class="fa fa-envelope"></i>');
			$('#button-send-' +voucher_id).prop('disabled', false);
		},
		success: function(json) {
			if (json['error']) {
				$('.panel').before('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
			}
			
			if (json['success']) {
				$('.panel').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i>  ' + json['success'] + '</div>');
			}		
		}
	});
}
//--></script> 
<?php echo $footer; ?>