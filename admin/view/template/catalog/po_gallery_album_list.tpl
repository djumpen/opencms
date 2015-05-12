<?php echo $header; ?>
<div id="content" class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="panel panel-default">
    <div class="panel-heading">
      <div class="pull-right"><a href="<?php echo $insert; ?>" class="btn btn-primary "><i class="fa fa-plus"></i> <?php echo $button_insert; ?></a>
        <div class="btn-group">
          <button type="button" class="btn btn-danger dropdown-toggle " data-toggle="dropdown"><i class="fa fa-trash-o"></i> <?php echo $button_delete; ?> <i class="fa fa-caret-down"></i></button>
          <ul class="dropdown-menu pull-right">
            <li><a onclick="$('#form').submit();"><?php echo $button_delete; ?></a></li>
          </ul>
        </div>
      </div>
      <h1 class="panel-title"><i class="fa fa-list"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="table table-striped table-bordered table-hover">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
              <td class="left">Название альбома</td>
              <td class="left">Изображение</td>
              <td class="left">Просмотров</td>
              <td class="right">Порядок сортировки</td>
              <td class="right">Действие</td>
            </tr>
          </thead>
          <tbody>
            <?php if ($albums) { ?>
            <?php foreach ($albums as $album) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($album['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $album['album_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $album['album_id']; ?>" />
                <?php } ?></td>
                <td class="left"><?php echo $album['name']; ?></td>
                <td class="center"><img src="<?php echo $album['image']; ?>" style="border:1px solid #d1d1d1; padding:1px;" /></td>
                <td class="left"><?php echo $album['viewed']; ?></td>
                <td class="right"><?php echo $album['sort_order']; ?></td>
                <td class="right"><?php foreach ($album['action'] as $action) { ?>
                  <a  class="btn btn-primary" href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a>
                  <?php } ?></td>
                </tr>
                <?php } ?>
                <?php } else { ?>
                <tr>
                  <td class="center" colspan="4"><?php echo $text_no_results; ?></td>
                </tr>
                <?php } ?>
              </tbody>
            </table>
          </form>
        </div>
      </div>
    </div> 
    <?php echo $footer; ?>