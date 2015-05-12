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
        <button type="submit" form="form-customer-group" class="btn btn-primary "><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-customer-group" class="form-horizontal">
        <div class="form-group required">
          <label class="col-xs-2 control-label"><?php echo $entry_name; ?></label>
          <div class="col-xs-10">
            <?php foreach ($languages as $language) { ?>
            <div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
              <input type="text" name="customer_group_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($customer_group_description[$language['language_id']]) ? $customer_group_description[$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_name; ?>" class="form-control" />
            </div>
            <?php if (isset($error_name[$language['language_id']])) { ?>
            <div class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
            <?php } ?>
            <?php } ?>
          </div>
        </div>
        <?php foreach ($languages as $language) { ?>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-description<?php echo $language['language_id']; ?>"><?php echo $entry_description; ?></label>
          <div class="col-xs-10">
            <div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
              <textarea name="customer_group_description[<?php echo $language['language_id']; ?>][description]" rows="5" placeholder="<?php echo $entry_description; ?>" id="input-description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($customer_group_description[$language['language_id']]) ? $customer_group_description[$language['language_id']]['description'] : ''; ?></textarea>
            </div>
          </div>
        </div>
        <?php } ?>
        <div class="form-group">
          <label class="col-xs-2 control-label"><?php echo $entry_approval; ?></label>
          <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($approval == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="approval" id="input-status" value="1" <?php if ($approval == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($approval == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="approval" id="input-status" value="0" <?php if ($approval == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
             </div>
        </div>

        <div class="form-group">
          <label class="col-xs-2 control-label"><?php echo $entry_company_id_display; ?></label>
          <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($company_id_display == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="company_id_display" id="input-company_id_display" value="1" <?php if ($company_id_display == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($company_id_display == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="company_id_display" id="input-company_id_display" value="0" <?php if ($company_id_display == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
             </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label"><?php echo $entry_company_id_required; ?></label>
          <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($company_id_required == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="company_id_required" id="input-company_id_required" value="1" <?php if ($company_id_required == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($company_id_required == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="company_id_required" id="input-company_id_required" value="0" <?php if ($company_id_required == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
             </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label"><?php echo $entry_tax_id_display; ?></label>
          <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($tax_id_display == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="tax_id_display" id="input-tax_id_display" value="1" <?php if ($tax_id_display == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($tax_id_display == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="tax_id_display" id="input-tax_id_display" value="0" <?php if ($tax_id_display == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
             </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label"><?php echo $entry_tax_id_required; ?></label>
          <div class="col-xs-10">
		<div class="btn-group" data-toggle="buttons">

  			<label class="btn btn-primary<?php if ($tax_id_required == 1) { ?> active<?php } ?>">
    				<i class="fa fa-check"></i> <input type="radio" name="tax_id_required" id="input-tax_id_required" value="1" <?php if ($tax_id_required == 1) { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
  			</label>
  			<label class="btn btn-primary<?php if ($tax_id_required == 0) { ?> active<?php } ?>">
    				<i class="fa fa-times"></i> <input type="radio" name="tax_id_required" id="input-tax_id_required" value="0" <?php if ($tax_id_required == 0) { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
  			</label>
		</div>
             </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
          <div class="col-xs-10">
            <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>