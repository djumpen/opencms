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
            <li><a onclick="$('#form-review').submit();"><?php echo $button_delete; ?></a></li>
          </ul>
        </div>
      </div>
      <h1 class="panel-title"><i class="fa fa-list"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-review">
        <div class="table-responsive">
          <table class="table table-striped table-bordered table-hover">
            <thead>
              <tr>
                <td width="1" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                <td class="text-left"><?php if ($sort == 'pd.name') { ?>
                  <a href="<?php echo $sort_product; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_product; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_product; ?>"><?php echo $column_product; ?></a>
                  <?php } ?></td>
                <td class="text-left width-10"><?php if ($sort == 'r.author') { ?>
                  <a href="<?php echo $sort_author; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_author; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_author; ?>"><?php echo $column_author; ?></a>
                  <?php } ?></td>
                <td class="text-right width-10"><?php if ($sort == 'r.rating') { ?>
                  <a href="<?php echo $sort_rating; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_rating; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_rating; ?>"><?php echo $column_rating; ?></a>
                  <?php } ?></td>
                <td class="text-left width-10"><?php if ($sort == 'r.status') { ?>
                  <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                  <?php } ?></td>
                <td class="text-left width-10"><?php if ($sort == 'r.date_added') { ?>
                  <a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
                  <?php } ?></td>
                <td class="text-right"><?php echo $column_action; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php if ($reviews) { ?>
              <?php foreach ($reviews as $review) { ?>
              <tr>
                <td class="text-center"><?php if ($review['selected']) { ?>
                  <input type="checkbox" name="selected[]" value="<?php echo $review['review_id']; ?>" checked="checked" />
                  <?php } else { ?>
                  <input type="checkbox" name="selected[]" value="<?php echo $review['review_id']; ?>" />
                  <?php } ?></td>
                <td class="text-left"><?php echo $review['name']; ?></td>
                
                <td class="text-left">
                <?php echo $review['author']; ?>
    		    <?php if ($review['purchased'] == 1) { ?><img src="../image/man-with-cart2.png" alt="<?php echo $review['author']; ?> купил(а) этот товар в нашем магазине" title="<?php echo $review['author']; ?> купил(а) этот товар в нашем магазине" /><?php } ?>
                <?php if ($review['addimage']) { ?><img src="../image/addimage.png" alt="<?php echo $review['author']; ?> добавил(а) фотографию к отзыву" title="<?php echo $review['author']; ?> добавил(а) фотографию к отзыву" /><?php } ?>
                <?php if ($review['html_status'] == 1) { ?><img src="../image/html_status.png" alt="html включен" title="html включен" /><?php } ?>
			    </td>
			    <td class="text-right">
			    <?php R_stars::show('rating', $review['rating']); ?>
			    </td>
                
                <td class="text-left"><span<?php echo ($this->language->get('text_disabled') == $review['status'])?' class="label label-warning"':' class="label label-primary"'; ?>><?php echo $review['status']; ?></span></td>
                <td class="text-left"><?php echo $review['date_added']; ?></td>
                <td class="text-right"><?php foreach ($review['action'] as $action) { ?>
                  <a href="<?php echo $action['href']; ?>" data-toggle="tooltip" title="<?php echo $action['text']; ?>" class="btn <?php $text_disabled = $this->language->get('text_disabled'); if ( isset($text_disabled) && $text_disabled == $review['status'] ){ echo " btn-warning"; }else{ echo " btn-primary"; } ?>"><i class="fa fa-edit"></i> <?php echo $action['text']; ?></a>
                  <?php } ?></td>
              </tr>
              <?php } ?>
              <?php } else { ?>
              <tr>
                <td class="text-center" colspan="7"><?php echo $text_no_results; ?></td>
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