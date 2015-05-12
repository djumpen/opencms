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
        <button type="submit" form="form-order" formaction="<?php echo $invoice; ?>" formtarget="_blank" class="btn btn-info "><i class="fa fa-print"></i> <?php echo $button_invoice; ?></button>
        <a href="<?php echo $insert; ?>" class="btn btn-primary "><i class="fa fa-plus"></i> <?php echo $button_insert; ?></a>
        <div class="btn-group">
          <button type="button" class="btn btn-danger dropdown-toggle " data-toggle="dropdown"><i class="fa fa-trash-o"></i> <?php echo $button_delete; ?> <i class="fa fa-caret-down"></i></button>
          <ul class="dropdown-menu pull-right">
            <li><a onclick="$('#form-order').submit();"><?php echo $button_delete; ?></a></li>
          </ul>
        </div>
      </div>
      <h1 class="panel-title"><i class="fa fa-list"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-order">
        <div class="table-responsive">
          <table class="table table-striped table-bordered table-hover">
            <thead>
              <tr>
                <td width="1" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                <td class="text-right width-10"><?php if ($sort == 'o.order_id') { ?>
                  <a href="<?php echo $sort_order; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_order_id; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_order; ?>"><?php echo $column_order_id; ?></a>
                  <?php } ?></td>
                <td class="text-left width-11"><?php if ($sort == 'customer') { ?>
                  <a href="<?php echo $sort_customer; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_customer; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_customer; ?>"><?php echo $column_customer; ?></a>
                  <?php } ?></td>
                <td class="text-left width-11"><?php if ($sort == 'status') { ?>
                  <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                  <?php } ?></td>
                <td class="text-right width-10"><?php if ($sort == 'o.total') { ?>
                  <a href="<?php echo $sort_total; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_total; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_total; ?>"><?php echo $column_total; ?></a>
                  <?php } ?></td>
                <td class="text-left"><?php if ($sort == 'o.date_added') { ?>
                  <a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
                  <?php } ?></td>
                <td class="text-left"><?php if ($sort == 'o.date_modified') { ?>
                  <a href="<?php echo $sort_date_modified; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_modified; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_date_modified; ?>"><?php echo $column_date_modified; ?></a>
                  <?php } ?></td>
                <td class="text-right width-20"><?php echo $column_action; ?></td>
              </tr>
            </thead>
            <tbody>
              <tr class="filter">
                <td></td>
                <td align="right"><input type="text" name="filter_order_id" value="<?php echo $filter_order_id; ?>" class="form-control" /></td>
                <td><input type="text" name="filter_customer" value="<?php echo $filter_customer; ?>" class="form-control" /></td>
                <td><select name="filter_order_status_id" class="form-control">
                    <option value="*"></option>
                    <?php if ($filter_order_status_id == '0') { ?>
                    <option value="0" selected="selected"><?php echo $text_missing; ?></option>
                    <?php } else { ?>
                    <option value="0"><?php echo $text_missing; ?></option>
                    <?php } ?>
                    <?php foreach ($order_statuses as $order_status) { ?>
                    <?php if ($order_status['order_status_id'] == $filter_order_status_id) { ?>
                    <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
                <td align="right"><input type="text" name="filter_total" value="<?php echo $filter_total; ?>" class="form-control" /></td>
                <td><input name="filter_date_added" value="<?php echo $filter_date_added; ?>" class="form-control datepicker" /></td>
                <td><input name="filter_date_modified" value="<?php echo $filter_date_modified; ?>" class="form-control datepicker" /></td>
                <td align="right"><button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button></td>
              </tr>
<?php

foreach ($order_statuses as $order_status) {
	if ($order_status['order_status_id'] == $this->config->get('config_order_status_id')) {
		$pending = $order_status['name'];
	} elseif ($order_status['order_status_id'] == $this->config->get('config_complete_status_id')) {
		$complete = $order_status['name'];
	}
}

?>
              <?php if ($orders) { ?>
              <?php foreach ($orders as $order) { ?>
              <tr<?php echo ($order['status'] == $complete) ? ' class="success"' : ''; ?>>
                <td class="text-center"><?php if ($order['selected']) { ?>
                  <input type="checkbox" name="selected[]" value="<?php echo $order['order_id']; ?>" checked="checked" />
                  <?php } else { ?>
                  <input type="checkbox" name="selected[]" value="<?php echo $order['order_id']; ?>" />
                  <?php } ?></td>
                <td class="text-left">
                	<?php echo $order['order_id']; ?>
                	<span style="float: right;" data-toggle="tooltip" data-html="true" title="
                		<?php foreach($order['products'] as $product){?>
                			<?php echo $product['name'];?><br>
                		<?php } ?>">
                		<i class="fa fa-shopping-cart fa-lg"></i>
                	</span>
                </td>
                <td class="text-left"><?php echo $order['customer']; ?></td>
                <td class="text-left"><?php echo $order['status']; ?><span class="label pull-right <?php print isset($order['comments_quantity']) && $order['comments_quantity'] > 0 ? 'label-warning' : 'label-success';?>" data-toggle="tooltip" title="Количество комменариев"><?php print isset($order['comments_quantity'])?$order['comments_quantity']:0;?></span></td>
                <td class="text-right"><?php echo $order['total']; ?></td>
                <td class="text-left"><?php echo $order['date_added']; ?></td>
                <td class="text-left"><?php echo $order['date_modified']; ?></td>
                <td class="text-right"><div class="btn-group"><?php foreach ($order['action'] as $action) { ?>

		               	<a href="<?php echo $action['href']; ?>" data-toggle="tooltip" title="<?php echo $action['text']; ?>" class="btn<?php $text_edit = $this->language->get('text_edit'); if ( isset($text_edit) && $text_edit == $action['text'] ){ echo " btn-success";$icon = "fa fa-edit"; }else{ echo ($order['status'] == $complete) ? ' btn-primary"' : ' btn-warning';$icon = "fa fa-eye"; } ?>"><i class="<?php echo $icon; ?>"></i> <?php echo $action['text']; ?></a>



                  <?php } ?></div></td>
              </tr>
              <?php } ?>
              <?php } else { ?>
              <tr>
                <td class="text-center" colspan="8"><?php echo $text_no_results; ?></td>
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
$('#button-filter').on('click', function() {
	url = 'index.php?route=sale/order&token=<?php echo $token; ?>';
	
	var filter_order_id = $('input[name=\'filter_order_id\']').val();
	
	if (filter_order_id) {
		url += '&filter_order_id=' + encodeURIComponent(filter_order_id);
	}
	
	var filter_customer = $('input[name=\'filter_customer\']').val();
	
	if (filter_customer) {
		url += '&filter_customer=' + encodeURIComponent(filter_customer);
	}
	
	var filter_order_status_id = $('select[name=\'filter_order_status_id\']').val();
	
	if (filter_order_status_id != '*') {
		url += '&filter_order_status_id=' + encodeURIComponent(filter_order_status_id);
	}	

	var filter_total = $('input[name=\'filter_total\']').val();

	if (filter_total) {
		url += '&filter_total=' + encodeURIComponent(filter_total);
	}	
	
	var filter_date_added = $('input[name=\'filter_date_added\']').val();
	
	if (filter_date_added) {
		url += '&filter_date_added=' + encodeURIComponent(filter_date_added);
	}
	
	var filter_date_modified = $('input[name=\'filter_date_modified\']').val();
	
	if (filter_date_modified) {
		url += '&filter_date_modified=' + encodeURIComponent(filter_date_modified);
	}
				
	location = url;
});
//--></script> 
<script type="text/javascript"><!--
$('input[name=\'filter_customer\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=sale/customer/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',			
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['customer_id']
					}
				}));
			}
		});
	},
	'select': function(item) {
		$('input[name=\'filter_customer\']').val(item['label']);
	}	
});
//--></script> 
<?php echo $footer; ?>