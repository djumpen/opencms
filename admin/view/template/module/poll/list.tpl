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
            <h1 class="panel-title"><i class="fa fa-list"></i> <?php echo $heading_title; ?></h1>   
          <div>
              <a onclick="location = '<?php echo $module; ?>';" class="btn btn-primary"><span><?php echo $button_module; ?></span></a>
              <a onclick="location = '<?php echo $insert; ?>'" class="btn btn-success"><span><?php echo $button_insert; ?></span></a>
              <a onclick="$('#form').submit();" class="btn btn-danger"><span><?php echo $button_delete; ?></span></a>
          </div>
             
            </div>
    <div class="panel-body">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="table table-striped table-bordered table-hover">
          <thead>
            <tr>
              <td width="1" style="align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
              <td class="left"><?php echo $column_question; ?></td>
              <td class="right"><?php echo $column_status; ?></td>
              <td class="right"><?php echo $column_active; ?></td>
              <td class="right"><?php echo $column_date_added; ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($questions) { ?>
            <?php $class = 'odd'; ?>
            <?php foreach ($questions as $poll) { ?>
            <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
            <tr class="<?php echo $class; ?>">
              <td style="align: center;"><?php if ($poll['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $poll['poll_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $poll['poll_id']; ?>" />
                <?php } ?></td>
              <td class="left"><?php echo $poll['question']; ?></td>
              <td class="right"><?php echo $poll['status']; ?></td>
              <td class="right"><?php echo $poll['active']; ?></td>
              <td class="right"><?php echo $poll['date_added']; ?></td>
              <td class="right"><?php foreach ($poll['action'] as $action) { ?>
                <a href="<?php echo $action['href']; ?>" class="btn btn-primary"><?php echo $action['text']; ?></a>
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr class="even">
              <td class="center" colspan="6"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>
