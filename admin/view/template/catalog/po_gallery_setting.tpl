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
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="panel panel-default">
    <div class="panel-heading">
      <div class="pull-right">
         <a onclick="$('#form').submit();" class="btn btn-success"><i class="fa fa-check"></i> <?php echo $button_save; ?></a>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
          <table class="table table-striped table-bordered table-hover">
          	<tr>
              <td><span class="required">*</span> Заголовок галереи:</td>
              <td><input class="form-control" type="text" name="po_gallery_heading_title" value="<?php echo $po_gallery_heading_title; ?>" size="40" />
                <?php if ($error_heading_title) { ?>
                <span class="error"><?php echo $error_heading_title; ?></span>
                <?php } ?></td>
            </tr>
          	<tr>
              <td><span class="required">*</span> Колличество альбомов на строку:</td>
              <td><select class="form-control" name="po_gallery_album_per_row">
              <?php if ($po_gallery_album_per_row == 50) { ?>
              <option value="50" selected="selected">2 альбома</option>
              <?php } else { ?>
              <option value="50">2 Album</option>
              <?php } ?>
              <?php if ($po_gallery_album_per_row == 33) { ?>
              <option value="33" selected="selected">3 альбома</option>
              <?php } else { ?>
              <option value="33">3 Album</option>
              <?php } ?>
              <?php if ($po_gallery_album_per_row == 25) { ?>
              <option value="25" selected="selected">4 альбома</option>
              <?php } else { ?>
              <option value="25">4 Album</option>
              <?php } ?>
              <?php if ($po_gallery_album_per_row == 20) { ?>
              <option value="20" selected="selected">5 альбомов</option>
              <?php } else { ?>
              <option value="20">5 альбомов</option>
              <?php } ?>
              <?php if ($po_gallery_album_per_row == 16.6) { ?>
              <option value="16.6" selected="selected">6 альбомов</option>
              <?php } else { ?>
              <option value="16.6">6 альбомов</option>
              <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><span class="required">*</span> Тип альбома:</td>
              <td><select  class="form-control" name="po_gallery_type">
              <?php if ($po_gallery_type == 'square') { ?>
              <option value="square" selected="selected">Квадратный</option>
              <?php } else { ?>
              <option value="square">Квадратный</option>
              <?php } ?>
              <?php if ($po_gallery_type == 'rectangular') { ?>
              <option value="rectangular" selected="selected">Прямоугольный</option>
              <?php } else { ?>
              <option value="rectangular">Прямоугольный</option>
              <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td>Показывать рейтинг:</td>
              <td><?php if ($po_gallery_show_rating) { ?>
                <input type="radio" name="po_gallery_show_rating" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="po_gallery_show_rating" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="po_gallery_show_rating" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="po_gallery_show_rating" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td>Лимит альбомов:</td>
              <td><input class="form-control" type="text" name="po_gallery_limit" value="<?php echo $po_gallery_limit; ?>" size="3" /></td>
            </tr>
            <tr>
              <td><span class="required">*</span> Размер шрифта заголовка:</td>
              <td><select class="form-control" name="po_gallery_album_title_font">
              <?php if ($po_gallery_album_title_font == 16) { ?>
              <option value="16" selected="selected">Маленький</option>
              <?php } else { ?>
              <option value="16">Маленький</option>
              <?php } ?>
              <?php if ($po_gallery_album_title_font == 18) { ?>
              <option value="18" selected="selected">Средний</option>
              <?php } else { ?>
              <option value="18">Средний</option>
              <?php } ?>
              <?php if ($po_gallery_album_title_font == 20) { ?>
              <option value="20" selected="selected">Большой</option>
              <?php } else { ?>
              <option value="20">Большой</option>
              <?php } ?>
              </select></td>
            </tr>
            <tr>
              <td><span class="required">*</span> Ширина альбома:</td>
              <td><select class="form-control" name="po_gallery_album_width">
              <?php if ($po_gallery_album_width == 200) { ?>
              <option value="200" selected="selected">200px</option>
              <?php } else { ?>
              <option value="200">200px</option>
              <?php } ?>
              <?php if ($po_gallery_album_width == 160) { ?>
              <option value="160" selected="selected">160px</option>
              <?php } else { ?>
              <option value="160">160px</option>
              <?php } ?>
              <?php if ($po_gallery_album_width == 120) { ?>
              <option value="120" selected="selected">120px</option>
              <?php } else { ?>
              <option value="120">120px</option>
              <?php } ?>
              </select></td>
            </tr>
          </table>
       
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>