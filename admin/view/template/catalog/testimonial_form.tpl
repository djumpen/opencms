<?php echo $header; ?>
<div id="content" class="container">
    <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li>
            <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        </li>
        <?php } ?>
    </ul>
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger">
        <i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
        <button type="button" class="close" data-dismiss="alert">
            &times;
        </button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h1 class="panel-title"><i class="fa fa-list"></i> <?php echo $heading_title; ?></h1>
            <div class="btn-group">
                <a onclick="$('#form').submit();" class="btn btn-success"><?php echo $button_save; ?></a>
                <a onclick="location = '<?php echo $cancel; ?>';" class="btn btn-danger"><?php echo $button_cancel; ?></a>
            </div>
        </div>
        <div class="panel-body">
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
                <div id="tab-general">
                    <ul class="nav nav-tabs" id="language">
                        <?php foreach ($languages as $language) { ?>
                          <li>
                            <a href="#language<?php echo $language['language_id']; ?>"  data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                          </li>
                        <?php }  ?>
                    <div class="tab-content"> 
                   <?php foreach ($languages as $language) { ?>
                    <div class="tab-pane " id="language<?php echo $language['language_id']; ?>"> 

                        <table class="table table-striped table-bordered table-hover">

                            <tr>
                                <td><?php echo $entry_title; ?></td>

                                <td>
                                <input type="text" class="form-control" name="testimonial_description[<?php echo $language['language_id']; ?>][title]" size="100" value="<?php echo isset($testimonial_description[$language['language_id']]) ? $testimonial_description[$language['language_id']]['title'] : ''; ?>" />
                            </tr>

                            <tr>
                                <td> <?php echo $entry_description; ?><span class="required">*</span></td>
                                <td>                                <textarea rows="10" cols="95" name="testimonial_description[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>"><?php echo isset($testimonial_description[$language['language_id']]) ? $testimonial_description[$language['language_id']]['description'] : ''; ?></textarea> <?php if (isset($error_description[$language['language_id']])) { ?> <span class="error"><?php echo $error_description[$language['language_id']]; ?></span> <?php } ?> </td>
                            </tr>

                        </table>

                    </div>
                     <?php } ?>
                    </div>
                </div>

                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <td> <?php echo $entry_name; ?></td>
                        <td>
                        <input type="text" class="form-control" name="name" value="<?php echo $name; ?>">
                        <?php if (isset($error_name)) { ?> <span class="error"><?php echo $error_name; ?></span> <?php } ?> </td>
                        <td><?php echo $entry_city; ?></td>
                        <td>
                        <input type="text" class="form-control" name="city" value="<?php echo $city; ?>">
                        </td>
                    </tr>

                    <tr>
                        <td><?php echo $entry_email; ?></td>
                        <td>
                        <input type="text" class="form-control" name="email" value="<?php echo $email; ?>">
                        </td>
                        <td><?php echo $entry_status; ?></td>
                        <td>
                        <select class="form-control" name="status">
                            <?php if ($status) { ?>
                            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                            <option value="0"><?php echo $text_disabled; ?></option>
                            <?php } else { ?>
                            <option value="1"><?php echo $text_enabled; ?></option>
                            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                            <?php } ?>
                        </select></td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_date_added; ?></td>
                        <td>
                        <input type="text" class="form-control" name="date_added" value="<?php echo $date_added; ?>">
                        </td>
                        <td><?php echo $entry_rating; ?></td>
                        <td><span><?php echo $entry_bad; ?></span>&nbsp;
                        <input type="radio" name="rating" value="1" style="margin: 0;" <?php if ( $rating == 1 ) echo 'checked="checked"';?> />
                        <input type="radio" name="rating" value="2" style="margin: 0;" <?php if ( $rating == 2 ) echo 'checked="checked"';?> />
                        <input type="radio" name="rating" value="3" style="margin: 0;" <?php if ( $rating == 3 ) echo 'checked="checked"';?> />
                        <input type="radio" name="rating" value="4" style="margin: 0;" <?php if ( $rating == 4 ) echo 'checked="checked"';?> />
                        <input type="radio" name="rating" value="5" style="margin: 0;" <?php if ( $rating == 5 ) echo 'checked="checked"';?> />
                        &nbsp; <span><?php echo $entry_good; ?></span></td>
                    </tr>

                </table>

            </form>
        </div>
    </div>
</div>

<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
<!--
<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('description<?php echo $language['language_id']; ?>', {
filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php } ?>
//-->
</script>

<script type="text/javascript">
<!--
$('#language a:first').tab('show');
//-->
</script>
<?php echo $footer; ?>