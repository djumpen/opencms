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
    <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    <div class="buttons">
        <a onclick="$('#form').submit();" class="btn btn-success"><?php echo $button_save; ?></a>
        <a onclick="location = '<?php echo $cancel; ?>';" class="btn btn-danger"><?php echo $button_cancel; ?></a>
    </div>
  </div>
   <div class="panel-body">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <table id="module" class="table table-striped table-bordered table-hover">
        <tr>
          <td><span class="required">*</span> <?php echo $entry_folder; ?></td>
          <td>
            <?php echo DIR_IMAGE."data/";?><input class="form-control" type="text" name="multiimageuploader_folder" value="<?php echo $multiimageuploader_folder;?>"/>
            <?php if ($error_folder) { ?>
            <span class="error"><?php echo $error_folder; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><?php echo $entry_segmet; ?></td>
          <td>
           <select class="form-control" name="multiimageuploader_segment">
            <option value="" <?php if (!$multiimageuploader_segment){ echo " selected";}?>><?php echo $entry_segmet_by_none;?></option>
            <option value="date" <?php if ($multiimageuploader_segment == "date"){ echo " selected";}?>><?php echo $entry_segmet_by_date;?></option>
           </select>
           </td>
        </tr>
        <tr>
          <td><?php echo $entry_delete_def_image; ?></td>
          <td>
           <select class="form-control" name="multiimageuploader_deletedef">
            <option value="0" <?php if (!$multiimageuploader_deletedef){ echo " selected";}?>><?php echo $text_no;?></option>
            <option value="1" <?php if ($multiimageuploader_deletedef){ echo " selected";}?>><?php echo $text_yes;?></option>
           </select>
           </td>
        </tr>

      </table>
     
    </form>
  </div>
</div>

<?php echo $footer; ?>