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
    <button type="button" form="form-backup" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h1 class="panel-title"><i class="fa fa-exchange"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <form action="<?php echo $restore; ?>" method="post" enctype="multipart/form-data" id="form-backup" class="form-horizontal">
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-import"><?php echo $entry_restore; ?></label>

				<div class="input-group col-xs-10">
					<input type="text" class="form-control" readonly>
					<span class="input-group-btn">
						<span class="btn btn-primary btn-file">
							Browse <input type="file" name="import" id="input-import" multiple>
						</span><button type="submit" class="btn btn-info"><i class="fa fa-upload"></i> <?php echo $button_restore; ?></button>
					</span>
				</div>






        </div>


       <!-- <div class="row">
          <div class="col-xs-12">
            <button type="submit" class="btn btn-info"><i class="fa fa-upload"></i> <?php echo $button_restore; ?></button>
          </div>
        </div>-->
      </form>
      <form action="<?php echo $backup; ?>" method="post" enctype="multipart/form-data" id="backup" class="form-horizontal">
        <div class="form-group">
          <label class="col-xs-2 control-label"><?php echo $entry_backup; ?></label>
          <div class="col-xs-10">
            <div class="well">
              <?php foreach ($tables as $table) { ?>
              <div class="checkbox">
                <label>
                  <input type="checkbox" name="backup[]" value="<?php echo $table; ?>" checked="checked" />
                  <?php echo $table; ?></label>
              </div>
              <?php } ?>
            </div>
            <a class="btn btn-success" onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> <a class="btn btn-success" onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a> <button type="submit" class="btn btn-info"><i class="fa fa-download"></i> <?php echo $button_backup; ?></button></div>
        </div>
      </form>
    </div>
  </div>
</div>
<script>
		$(document)
			.on('change', '.btn-file :file', function() {
				var input = $(this),
				numFiles = input.get(0).files ? input.get(0).files.length : 1,
				label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
				input.trigger('fileselect', [numFiles, label]);
		});
		
		$(document).ready( function() {
			$('.btn-file :file').on('fileselect', function(event, numFiles, label) {
				
				var input = $(this).parents('.input-group').find(':text'),
					log = numFiles > 1 ? numFiles + ' files selected' : label;
				
				if( input.length ) {
					input.val(log);
				} else {
					if( log ) alert(log);
				}
				
			});
		});		
	</script>
<?php echo $footer; ?>