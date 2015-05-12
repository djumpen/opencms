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
	<h1 class="panel-title"><i class="fa fa-list"></i> <?php echo $heading_title; ?></h1>
    </div>

    <div class="panel-body">
      <form action="" method="post" enctype="multipart/form-data" id="form-return">
        <div class="table-responsive">
          <table class="table table-striped table-bordered table-hover">
          <thead>
              <tr>
                  <td width="10" class="left">
                      <?php if ($sort == 'or.order_recurring_id'): ?>
                          <a href="<?php echo $sort_order_recurring ?>" class="<?php echo strtolower($order) ?>"><?php echo $entry_order_recurring; ?></a>
                      <?php else: ?>
                          <a href="<?php echo $sort_order_recurring ?>"><?php echo $entry_order_recurring; ?></a>
                      <?php endif;  ?>
                  </td>
                  <td width="80" class="center">
                      <?php if ($sort == 'or.order_id'): ?>
                          <a href="<?php echo $sort_order ?>" class="<?php echo strtolower($order) ?>"><?php echo $entry_order_id; ?></a>
                      <?php else: ?>
                          <a href="<?php echo $sort_order ?>"><?php echo $entry_order_id; ?></a>
                      <?php endif;  ?>    
                  </td>
                  <td class="left">
                      <?php if ($sort == 'or.profile_reference'): ?>
                          <a href="<?php echo $sort_payment_reference ?>" class="<?php echo strtolower($order) ?>"><?php echo $entry_payment_reference; ?></a>
                      <?php else: ?>
                          <a href="<?php echo $sort_payment_reference ?>"><?php echo $entry_payment_reference; ?></a>
                      <?php endif;  ?>
                  </td>
                  <td class="left">
                      <?php if ($sort == 'customer'): ?>
                          <a href="<?php echo $sort_customer ?>" class="<?php echo strtolower($order) ?>"><?php echo $entry_customer ?></a>
                      <?php else: ?>
                          <a href="<?php echo $sort_customer ?>"><?php echo $entry_customer ?></a>
                      <?php endif;  ?>
                  <td class="left">
                      <?php if ($sort == 'or.created'): ?>
                          <a href="<?php echo $sort_created ?>" class="<?php echo strtolower($order) ?>"><?php echo $entry_date_created ?></a>
                      <?php else: ?>
                          <a href="<?php echo $sort_created ?>"><?php echo $entry_date_created ?></a>
                      <?php endif;  ?>
                  </td>
                  <td class="left">
                      <?php if ($sort == 'or.status'): ?>
                          <a href="<?php echo $sort_status ?>" class="<?php echo strtolower($order) ?>"><?php echo $entry_status; ?></a>
                      <?php else: ?>
                          <a href="<?php echo $sort_status ?>"><?php echo $entry_status; ?></a>
                      <?php endif;  ?>
                  </td>
                  <td class="right"><?php echo $entry_action; ?></td>
              </tr>
          </thead>
          <tbody>
              <tr class="filter">
                  <td class="left"><input type="text" name="filter_order_recurring_id" size="4" value="<?php echo $filter_order_recurring_id ?>"  class="form-control"/></td>                  
                  <td class="center"><input type="text" name="filter_order_id" size="4" value="<?php echo $filter_order_id ?>" class="form-control" /></td>                  
                  <td class="left"><input type="text" name="filter_payment_reference" value="<?php echo $filter_payment_reference ?>" class="form-control" /></td>                  
                  <td class="left"><input type="date" name="filter_customer" value="<?php echo $filter_customer ?>" class="form-control" /></td>                  
                  <td class="left"><input type="date" name="filter_created" value="<?php echo $filter_created ?>" class="form-control" /></td>                  
                  <td class="left">
                      <select name="filter_status" class="form-control">
                          <?php foreach($statuses as $status => $text): ?>
                            <?php if ($filter_status == $status): ?>
                                <option value="<?php echo $status ?>" selected="selected"><?php echo $text ?></option>
                            <?php else: ?>
                                <option value="<?php echo $status ?>"><?php echo $text ?></option>
                            <?php endif; ?>
                          <?php endforeach; ?>
                      </select>
                  </td>                  
                  <td class="right"><button type="button" onclick="filter()" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $text_filter; ?></button></td>                  
              </tr>
            <?php if ($profiles) { ?>
            <?php foreach ($profiles as $profile) { ?>
            <tr>
                <td class="left"><?php echo $profile['order_recurring_id'] ?></td>
                <td class="center"><a href="<?php echo $profile['order_link'] ?>"><?php echo $profile['order_id'] ?></a></td>
                <td class="left"><?php echo $profile['profile_reference'] ?></td>
                <td class="left"><?php echo $profile['customer'] ?></td>
                <td class="left"><?php echo $profile['date_created'] ?></td>
                <td class="left"><span<?php echo ($this->language->get('text_disabled') == $profile['status'])?' class="label label-warning"':' class="label label-primary"'; ?>><?php echo $profile['status'] ?></span></td>
                <td class="right"><?php foreach ($profile['action'] as $action): ?>
                    <a href="<?php echo $action['href']; ?>" data-toggle="tooltip" title="<?php echo $action['text']; ?>" class="btn<?php $text_edit = $this->language->get('text_edit'); if ( isset($text_edit) && $text_edit == $action['text'] ){ echo " btn-success";$icon = "fa fa-edit"; }else{ echo " btn-primary";$icon = "fa fa-eye"; } ?>"><i class="<?php echo $icon; ?>"></i> <?php echo $action['text']; ?></a>
                    <?php endforeach; ?>
                </td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="8"><?php echo $text_no_results; ?></td>
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
function filter() {
	url = 'index.php?route=sale/recurring&token=<?php echo $token; ?>';
	
	var filter_order_recurring_id = $('input[name=\'filter_order_recurring_id\']').attr('value');
	
	if (filter_order_recurring_id) {
		url += '&filter_order_recurring_id=' + encodeURIComponent(filter_order_recurring_id);
	}
	
	var filter_order_id = $('input[name=\'filter_order_id\']').attr('value');
	
	if (filter_order_id) {
		url += '&filter_order_id=' + encodeURIComponent(filter_order_id);
	}
	
	var filter_payment_reference = $('input[name=\'filter_payment_reference\']').attr('value');
	
	if (filter_payment_reference) {
		url += '&filter_payment_reference=' + encodeURIComponent(filter_payment_reference);
	}
	
	var filter_customer = $('input[name=\'filter_customer\']').attr('value');
	
	if (filter_customer) {
		url += '&filter_customer=' + encodeURIComponent(filter_customer);
	}
	
	var filter_created = $('input[name=\'filter_created\']').attr('value');
	
	if (filter_created != '') {
		url += '&filter_created=' + encodeURIComponent(filter_created);
	}	
	
	var filter_status = $('select[name=\'filter_status\']').attr('value');
	
	if (filter_status != '0') {
		url += '&filter_status=' + encodeURIComponent(filter_status);
	}	
				
	location = url;
}

$('#form input').keydown(function(e) {
	if (e.keyCode == 13) {
		filter();
	}
});

$(document).ready(function() {
	$('.date').datepicker({dateFormat: 'yy-mm-dd'});
});

//--></script>
<?php echo $footer; ?>