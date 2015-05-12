<?php echo $header; ?>
<div id="content" class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="panel panel-default">
    <div class="panel-heading">
      <div class="pull-right">
        <div class="btn-group"> 
          <a onclick="$('#form').submit();"class="btn btn-success"><?php echo $button_save; ?></a>
          <a onclick="location = '<?php echo $cancel; ?>';" class="btn btn-danger"><?php echo $button_cancel; ?></a>
        </div>
      </div>
      <h1 class="panel-title"><i class="fa fa-list"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="table table-striped table-bordered table-hover">
          <tr>
            <td><span class="required">*</span> Автор</td>
            <td><input class="form-control" type="text" name="author" value="<?php echo $author; ?>" />
              <?php if ($error_author) { ?>
              <span class="error"><?php echo $error_author; ?></span>
              <?php } ?></td>
            </tr>
            <tr>
              <td>Альбом: (Автозаполнение)</td>
              <td><input class="form-control" type="text" name="album" value="<?php echo $album; ?>"/>
                <input type="hidden" name="album_id" value="<?php echo $album_id; ?>"/>
                <?php if ($error_album) { ?>
                <span class="error"><?php echo $error_album; ?></span>
                <?php } ?></td>
              </tr>
              <tr>
                <td><span class="required">*</span> Текст:</td>
                <td><textarea class="form-control" name="text" cols="60" rows="8"><?php echo $text; ?></textarea>
                  <?php if ($error_text) { ?>
                  <span class="error"><?php echo $error_text; ?></span>
                  <?php } ?></td>
                </tr>
                <tr>
                  <td>Рейтинг:</td>
                  <td><b class="rating">Плохо</b>&nbsp;
                    <?php if ($rating == 1) { ?>
                    <input type="radio" name="rating" value="1" checked />
                    <?php } else { ?>
                    <input type="radio" name="rating" value="1" />
                    <?php } ?>
                    &nbsp;
                    <?php if ($rating == 2) { ?>
                    <input type="radio" name="rating" value="2" checked />
                    <?php } else { ?>
                    <input type="radio" name="rating" value="2" />
                    <?php } ?>
                    &nbsp;
                    <?php if ($rating == 3) { ?>
                    <input type="radio" name="rating" value="3" checked />
                    <?php } else { ?>
                    <input type="radio" name="rating" value="3" />
                    <?php } ?>
                    &nbsp;
                    <?php if ($rating == 4) { ?>
                    <input type="radio" name="rating" value="4" checked />
                    <?php } else { ?>
                    <input type="radio" name="rating" value="4" />
                    <?php } ?>
                    &nbsp;
                    <?php if ($rating == 5) { ?>
                    <input type="radio" name="rating" value="5" checked />
                    <?php } else { ?>
                    <input type="radio" name="rating" value="5" />
                    <?php } ?>
                    &nbsp; <b class="rating">Отлично</b>
                    <?php if ($error_rating) { ?>
                    <span class="error"><?php echo $error_rating; ?></span>
                    <?php } ?></td>
                  </tr>
                  <tr>
                    <td>Статус:</td>
                    <td><select   name="status" class="form-control" style="width: 200px;">
                      <?php if ($status) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                    </select></td>
                  </tr>
                </table>
              </form>
            </div>
          </div>
        </div>
        <script type="text/javascript"><!--
          $('input[name=\'album\']').autocomplete({
           delay: 0,
           source: function(request, response) {
            $.ajax({
             url: 'index.php?route=catalog/po_gallery_album/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
             dataType: 'json',
             success: function(json) {		
              response($.map(json, function(item) {
               return {
                label: item.name,
                value: item.album_id
              }
            }));
            }
          });
          },
          select: function(event, ui) {
            $('input[name=\'album\']').val(ui.item.label);
            $('input[name=\'album_id\']').val(ui.item.value);

            return false;
          }
        });
          //--></script> 
          <?php echo $footer; ?>