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
        <button type="submit" form="form-google-tools" class="btn btn-primary "><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-google-tools" class="form-horizontal">

  <div class="form-group">
                        <label class="col-xs-2 control-label" for="input-google_api"><?php echo $text_google_api_code; ?></label>
                        <div class="col-xs-10">
                           <input type="text" name="google_api_code" value="<?php echo $google_api_code; ?>" placeholder="" id="input-google_api" class="form-control" />
                           <span class="help-block"><?php echo $help_google_api_code; ?></span>
                        </div>
                     </div>
                     <div class="form-group">
                        <label class="col-xs-2 control-label" for="input-google_profile_id"><?php echo $text_google_profile_id; ?></label>
                        <div class="col-xs-10">
                           <input type="text" name="google_profile_id" value="<?php echo $google_profile_id; ?>" placeholder="" id="input-google_profile_id" class="form-control" />
                        </div>
                     </div>
					 </form>
      </div>
  </div>
</div>
<?php echo $footer; ?>