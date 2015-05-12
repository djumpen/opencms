<?php echo $header; ?>
<div class="container">
  <div class="row">
    <div class="col-xs-<?php echo $cols; ?>">
      <h1><?php echo $heading_title; ?></h1>
      <p><?php echo $text_error; ?></p>
      <div class="buttons">
        <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
      </div>
     </div>
    </div>
</div>
<?php echo $footer; ?>