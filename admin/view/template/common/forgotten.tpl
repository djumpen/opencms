<?php echo $header; ?>
<div id="content" class="jumbotron">
  <div class="row">
    <div class="col-xs-offset-4 col-xs-4">
      <div class="panel panel-default">
        <div class="panel-heading">
          <div class="panel-title"><i class="fa fa-lock fa-lg"></i> <?php echo $heading_title; ?></div>
        </div>
        <div class="panel-body">
          <?php if ($error_warning) { ?>
          <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
          </div>
          <?php } ?>
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
        	<p><?php echo $text_email; ?></p>
		<div class="form-group">
			<div class="input-group">
           			<input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" required />
					<span class="input-group-btn">
						<span class="btn btn-info" type="button"><i class="fa fa-envelope fa-lg"></i></span>
					</span>
			</div>

		</div>

        		<div class="text-right"><div class="btn-group"><button type="submit" class="btn btn-primary"><i class="fa fa-check"></i> <?php echo $button_reset; ?></button>
        			<a href="<?php echo $cancel; ?>" class="btn btn-success"><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a>
				</div>
			</div>
      		</form>
        </div>
      </div>
    </div>
  </div>
</div><script type="text/javascript"><!--
	$(document).ready(function() {
	$('form input[name="email"]').focus();
});
//--></script>

<?php echo $footer; ?>