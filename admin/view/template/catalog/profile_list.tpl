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
        <button type="submit" form="form-product" formaction="<?php echo $copy; ?>" class="btn btn-success "><i class="fa fa-copy"></i> <?php echo $button_copy; ?></button>
        <div class="btn-group">
          <button type="button" class="btn btn-danger dropdown-toggle " data-toggle="dropdown"><i class="fa fa-trash-o"></i> <?php echo $button_delete; ?> <i class="fa fa-caret-down"></i></button>
          <ul class="dropdown-menu pull-right">
            <li><a onclick="$('#form-product').submit();"><?php echo $button_delete; ?></a></li>
          </ul>
        </div>
      </div>
      <h1 class="panel-title"><i class="fa fa-list"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
    <div class="table-responsive">
          <table class="table table-striped table-bordered table-hover">
          <thead>
            <tr>        
                <td class="center" width="1"><input type="checkbox" onclick="$('input[name*=\'profile_ids\']').attr('checked', this.checked)" /></td>
                <td class="left"><?php echo $column_name ?></td>
                <td class="left"><?php echo $column_sort_order ?></td>
                <td class="right"><?php echo $column_action ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($profiles) { ?>
                <?php foreach ($profiles as $profile) { ?>
                <tr>
                    <td class="center"><input type="checkbox" name="profile_ids[]" value="<?php echo $profile['profile_id'] ?>" /></td>
                    <td class="left"><?php echo $profile['name'] ?></td>
                    <td class="left"><?php echo $profile['sort_order'] ?></td>
                    <td class="right">
                        <?php foreach ($profile['action'] as $action): ?>
                        <a href="<?php echo $action['href']; ?>" data-toggle="tooltip" title="<?php echo $action['name']; ?>" class="btn btn-primary"><i class="fa fa-edit"></i> <?php echo $action['name']; ?></a>
                        <?php endforeach;?>
                    </td>
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
      </form>
      <div class="row">
        <div class="text-left col-xs-6 "><?php 
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
echo $str10; 
}
?></div>
        <!--<div class="col-xs-6 text-right"><?php //echo $results; ?></div>-->
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>