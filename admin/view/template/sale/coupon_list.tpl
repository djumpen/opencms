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
      <div class="pull-right"><a href="<?php echo $insert; ?>" class="btn btn-primary "><i class="fa fa-plus"></i> <?php echo $button_insert; ?></a>
        <div class="btn-group">
          <button type="button" class="btn btn-danger dropdown-toggle " data-toggle="dropdown"><i class="fa fa-trash-o"></i> <?php echo $button_delete; ?> <i class="fa fa-caret-down"></i></button>
          <ul class="dropdown-menu pull-right">
            <li><a onclick="$('#form-coupon').submit();"><?php echo $button_delete; ?></a></li>
          </ul>
        </div>
      </div>
      <h1 class="panel-title"><i class="fa fa-list"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-coupon">
        <div class="table-responsive">
          <table class="table table-striped table-bordered table-hover">
            <thead>
              <tr>
                <td width="1" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                <td class="text-left"><?php if ($sort == 'cd.name') { ?>
                  <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
                  <?php } ?></td>
                <td class="text-left width-10"><?php if ($sort == 'c.code') { ?>
                  <a href="<?php echo $sort_code; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_code; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_code; ?>"><?php echo $column_code; ?></a>
                  <?php } ?></td>
                <td class="text-right width-10"><?php if ($sort == 'c.discount') { ?>
                  <a href="<?php echo $sort_discount; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_discount; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_discount; ?>"><?php echo $column_discount; ?></a>
                  <?php } ?></td>
                <td class="text-left width-10"><?php if ($sort == 'c.date_start') { ?>
                  <a href="<?php echo $sort_date_start; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_start; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_date_start; ?>"><?php echo $column_date_start; ?></a>
                  <?php } ?></td>
                <td class="text-left width-10"><?php if ($sort == 'c.date_end') { ?>
                  <a href="<?php echo $sort_date_end; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_end; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_date_end; ?>"><?php echo $column_date_end; ?></a>
                  <?php } ?></td>
                <td class="text-left width-10"><?php if ($sort == 'c.status') { ?>
                  <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                  <?php } ?></td>
                <td class="text-right"><?php echo $column_action; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php if ($coupons) { ?>
              <?php foreach ($coupons as $coupon) { ?>
              <tr>
                <td class="text-center"><?php if ($coupon['selected']) { ?>
                  <input type="checkbox" name="selected[]" value="<?php echo $coupon['coupon_id']; ?>" checked="checked" />
                  <?php } else { ?>
                  <input type="checkbox" name="selected[]" value="<?php echo $coupon['coupon_id']; ?>" />
                  <?php } ?></td>
                <td class="text-left"><?php echo $coupon['name']; ?></td>
                <td class="text-left"><?php echo $coupon['code']; ?></td>
                <td class="text-right"><?php echo $coupon['discount']; ?></td>
                <td class="text-left"><?php echo $coupon['date_start']; ?></td>
                <td class="text-left"><?php echo $coupon['date_end']; ?></td>
                <td class="text-left"><span<?php echo ($this->language->get('text_disabled') == $coupon['status'])?' class="label label-warning"':' class="label label-primary"'; ?>><?php echo $coupon['status']; ?></span></td>
                <td class="text-right"><?php foreach ($coupon['action'] as $action) { ?>
                  <a href="<?php echo $action['href']; ?>" data-toggle="tooltip" title="<?php echo $action['text']; ?>" class="btn btn-primary"><i class="fa fa-edit"></i> <?php echo $action['text']; ?></a>
                  <?php } ?></td>
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
<?php echo $footer; ?>