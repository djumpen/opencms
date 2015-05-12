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
        <button type="submit" form="form-country" class="btn btn-primary "><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-country" class="form-horizontal">
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
          <div class="col-xs-10">
            <input type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="form-control" />
            <?php if ($error_name) { ?>
            <div class="text-danger"><?php echo $error_name; ?></div>
            <?php } ?>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-iso-code-2"><?php echo $entry_iso_code_2; ?></label>
          <div class="col-xs-10">
            <input type="text" name="iso_code_2" value="<?php echo $iso_code_2; ?>" id="input-iso-code-2" class="form-control" />
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-iso-code-3"><?php echo $entry_iso_code_3; ?></label>
          <div class="col-xs-10">
            <input type="text" name="iso_code_3" value="<?php echo $iso_code_3; ?>" id="input-iso-code-3" class="form-control" />
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-address-format"><?php echo $entry_address_format; ?> </label>
          <div class="col-xs-10">
            <textarea name="address_format" rows="5" id="input-address-format" class="form-control"><?php echo $address_format; ?></textarea>
	</div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label"><?php echo $entry_postcode_required; ?></label>
          <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($postcode_required == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="postcode_required" value="1" <?php if ($postcode_required == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($postcode_required == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="postcode_required" value="0" <?php if ($postcode_required == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
          <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($status == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="status" value="1" <?php if ($status == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_enabled; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($status == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="status" value="0" <?php if ($status == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_disabled; ?>
  			</label>
		</div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>