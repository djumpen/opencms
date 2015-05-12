<?php echo $header; ?>
<div id="content" class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h1 class="panel-title"><i class="fa fa-bar-chart-o"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <form class="form-horizontal">
        <div class="well">
          <div class="row">
            <div class="col-xs-5">
              <div class="form-group">
                <label class="col-xs-2 control-label" for="input-date-start"><?php echo $entry_date_start; ?></label>
                <div class="col-xs-10">
                  <input name="filter_date_start" value="<?php echo $filter_date_start; ?>" id="input-date-start" class="form-control datepicker" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-xs-2 control-label" for="input-date-end"><?php echo $entry_date_end; ?></label>
                <div class="col-xs-10">
                  <input name="filter_date_end" value="<?php echo $filter_date_end; ?>" id="input-date-end" class="form-control datepicker" />
                </div>
              </div>
            </div>
            <div class="col-xs-5">
              <div class="form-group">
                <label class="col-xs-2 control-label" for="input-customer"><?php echo $entry_customer; ?></label>
                <div class="col-xs-10">
                  <input type="text" name="filter_customer" value="<?php echo $filter_customer; ?>" id="input-customer" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-xs-2 control-label" for="input-ip"><?php echo $entry_ip; ?></label>
                <div class="col-xs-10">
                  <input type="text" name="filter_ip" value="<?php echo $filter_ip; ?>" id="input-ip" class="form-control" />
                </div>
              </div>
            </div>
            <div class="col-xs-2">
              <button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
            </div>
          </div>
        </div>
      </form>
      <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover">
          <thead>
            <tr>
              <td class="text-left"><?php echo $column_customer; ?></td>
              <td class="text-left"><?php echo $column_action; ?></td>
              <td class="text-left"><?php echo $column_ip; ?></td>
              <td class="text-left"><?php echo $column_date_added; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($activities) { ?>
            <?php foreach ($activities as $activity) { ?>
            <tr>
              <td class="text-left"><?php echo $activity['customer']; ?></td>
              <td class="text-left"><?php echo $activity['action']; ?></td>
              <td class="text-left"><?php echo $activity['ip']; ?></td>
              <td class="text-left"><?php echo $activity['date_added']; ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="text-center" colspan="4"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </div>
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
	url = 'index.php?route=report/customer_activity&token=<?php echo $token; ?>';
	
	var filter_customer = $('input[name=\'filter_customer\']').val();
	
	if (filter_customer) {
		url += '&filter_customer=' + encodeURIComponent(filter_customer);
	}
	var filter_ip = $('input[name=\'filter_ip\']').val();
	
	if (filter_ip) {
		url += '&filter_ip=' + encodeURIComponent(filter_ip);
	}
	
	var filter_date_start = $('input[name=\'filter_date_start\']').val();
	
	if (filter_date_start) {
		url += '&filter_date_start=' + encodeURIComponent(filter_date_start);
	}

	var filter_date_end = $('input[name=\'filter_date_end\']').val();
	
	if (filter_date_end) {
		url += '&filter_date_end=' + encodeURIComponent(filter_date_end);
	}

	location = url;
});
//--></script> 
<?php echo $footer; ?>