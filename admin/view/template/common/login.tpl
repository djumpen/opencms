<?php echo $header; ?>
<div id="content" class="jumbotron">
  <div class="row">
    <div class="col-xs-offset-4 col-xs-4">
      <div class="panel panel-default">
        <div class="panel-heading">
          <div class="panel-title"><i class="fa fa-lock fa-lg"></i> <?php echo $text_login; ?></div>
        </div>
        <div class="panel-body">
          <?php if ($success) { ?>
          <div class="alert alert-success"><i class="fa fa-check-square-o"></i> <?php echo $success; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
          </div>
          <?php } ?>
          <?php if ($error_warning) { ?>
          <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
          </div>
          <?php } ?>
          <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
            <div class="form-group">
              <div class="input-group">
                <input type="text" name="username" value="<?php echo $username; ?>" placeholder="<?php echo $entry_username; ?>" id="input-username" class="form-control" required />
		<span class="input-group-btn">
			<span class="btn btn-info" type="button"><i class="fa fa-user fa-lg"></i></span>
		</span>
              </div>
            </div>
            <div class="form-group">
              <div class="input-group">
                <input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" required />
		<span class="input-group-btn">
			<span class="btn btn-info" type="button"><i class="fa fa-lock fa-lg"></i></span>
		</span>
              </div>
            </div>
            <div class="text-right"><div class="btn-group">
              <button type="submit" class="btn btn-primary"><i class="fa fa-sign-in"></i> <?php echo $button_login; ?></button>
              <?php if ($forgotten) { ?>
               <a class="btn btn-info" href="<?php echo $forgotten; ?>"><i class="fa fa-info-circle"></i> <?php echo $text_forgotten; ?></a>
              <?php } ?>
		</div>
            </div>
            <?php if ($redirect) { ?>
            <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
            <?php } ?>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
	$(document).ready(function() {
	$('form input[name="username"]').focus();
});
//--></script><?php echo $footer; ?>