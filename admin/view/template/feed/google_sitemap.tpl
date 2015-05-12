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
  <div class="panel panel-default">
    <div class="panel-heading">
      <div class="pull-right">
        <button type="submit" form="form-google-sitemap" class="btn btn-primary "><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-google-sitemap" class="form-horizontal">
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
          <div class="col-xs-10">
                <div class="btn-group" data-toggle="buttons">
  			<label class="btn btn-primary<?php if ($google_sitemap_status == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="google_sitemap_status" id="input-status" <?php if ($google_sitemap_status == 1) { ?>checked<?php } ?>> <?php echo $text_enabled; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($google_sitemap_status == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="google_sitemap_status" id="input-status" <?php if ($google_sitemap_status == 0) { ?>checked<?php } ?>> <?php echo $text_disabled; ?>
  			</label>
		</div>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-data-feed"><?php echo $entry_data_feed; ?></label>
          <div class="col-xs-10">
            <textarea rows="5" readonly="readonly" id="input-data-feed" class="form-control"><?php echo $data_feed; ?></textarea>
          </div>
        </div>
        <?php foreach ($extra_languages as $extra_language) { ?>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-data-feed"><?php echo $entry_data_feed.' (for '.$extra_language['name'].')'; ?></label>
          <div class="col-xs-10">
            <textarea rows="5" readonly="readonly" id="input-data-feed" class="form-control"><?php echo HTTP_CATALOG . 'index.php?route=feed/google_sitemap_extra&language='.$extra_language['code']; ?></textarea>
          </div>
        </div>
        <?php } ?>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>