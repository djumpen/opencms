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
    <div class="pull-right"><a href="<?php echo $insert; ?>" class="btn btn-primary "><i class="fa fa-plus"></i> <?php echo $button_insert; ?></a>
      <button type="submit" form="form-product" formaction="<?php echo $copy; ?>" class="btn btn-success "><i class="fa fa-copy"></i> <?php echo $button_copy; ?></button>
      <div class="btn-group">
        <button type="button" class="btn btn-danger dropdown-toggle " data-toggle="dropdown"><i class="fa fa-trash-o"></i> <?php echo $button_delete; ?> <i class="fa fa-caret-down"></i></button>
        <ul class="dropdown-menu pull-right">
          <li><a onclick="$('#form-product').submit();"><?php echo $button_delete; ?></a></li>
        </ul>
      </div>
    </div>
    <h1 class="panel-title"><i class="fa fa-list"></i> <?php echo $heading_title; ?></h1>
  </div>
  <div class="content">
    <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
     <div class="table-responsive">
      <table class="table table-striped table-bordered table-hover">
        <thead>
          <tr>
            <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
            <td class="center">Изображения</td>
            <td class="left"><?php if ($sort == 'pd.name') { ?>
              <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>">Название изображения</a>
              <?php } else { ?>
              <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
              <?php } ?></td>
              <td class="left"><?php if ($sort == 'p.status') { ?>
                <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_status; ?>">Статус</a>
                <?php } ?></td>
                <td class="right">Действие</td>
              </tr>
            </thead>
            <tbody>
              <tr class="filter">
                <td></td>
                <td></td>
                <td><input class="form-control" type="text" name="filter_name" value="<?php echo $filter_name; ?>" /></td>
                <td><select class="form-control" name="filter_status">
                  <option value="*"></option>
                  <?php if ($filter_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <?php } ?>
                  <?php if (!is_null($filter_status) && !$filter_status) { ?>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
                <td align="right"><a onclick="filter();" class="btn btn-primary pull-right"><?php echo $button_filter; ?></a></td>
              </tr>
              <?php if ($photos) { ?>
              <?php foreach ($photos as $photo) { ?>
              <tr>
                <td style="text-align: center;"><?php if ($photo['selected']) { ?>
                  <input type="checkbox" name="selected[]" value="<?php echo $photo['photo_id']; ?>" checked="checked" />
                  <?php } else { ?>
                  <input type="checkbox" name="selected[]" value="<?php echo $photo['photo_id']; ?>" />
                  <?php } ?></td>
                  <td class="center"><img src="<?php echo $photo['image']; ?>" alt="<?php echo $photo['name']; ?>" style="padding: 1px; border: 1px solid #DDDDDD;" /></td>
                  <td class="left"><?php echo $photo['name']; ?></td>
                  <td class="left"><?php echo $photo['status']; ?></td>
                  <td class="right"><?php foreach ($photo['action'] as $action) { ?>
                    <a class="btn btn-primary" href="<?php echo $action['href']; ?>"><span class="fa fa-edit"> <?php echo $action['text']; ?></span></a>
                    <?php } ?></td>
                  </tr>
                  <?php } ?>
                  <?php } else { ?>
                  <tr>
                    <td class="center" colspan="8"><?php echo $text_no_results; ?></td>
                  </tr>
                  <?php } ?>
                </tbody>
              </table>
            </div>
          </form>
          <div class="pagination"><?php echo $pagination; ?></div>
        </div>
      </div>
    </div>
    <script type="text/javascript"><!--
      function filter() {
       url = 'index.php?route=catalog/po_photo&token=<?php echo $token; ?>';
       
       var filter_name = $('input[name=\'filter_name\']').attr('value');
       
       if (filter_name) {
        url += '&filter_name=' + encodeURIComponent(filter_name);
      }
      
      var filter_model = $('input[name=\'filter_model\']').attr('value');
      
      if (filter_model) {
        url += '&filter_model=' + encodeURIComponent(filter_model);
      }
      
      var filter_price = $('input[name=\'filter_price\']').attr('value');
      
      if (filter_price) {
        url += '&filter_price=' + encodeURIComponent(filter_price);
      }
      
      var filter_quantity = $('input[name=\'filter_quantity\']').attr('value');
      
      if (filter_quantity) {
        url += '&filter_quantity=' + encodeURIComponent(filter_quantity);
      }
      
      var filter_status = $('select[name=\'filter_status\']').attr('value');
      
      if (filter_status != '*') {
        url += '&filter_status=' + encodeURIComponent(filter_status);
      }	

      location = url;
    }
    //--></script> 
    <script type="text/javascript"><!--
      $('#form input').keydown(function(e) {
       if (e.keyCode == 13) {
        filter();
      }
    });
      //--></script> 
      <script type="text/javascript"><!--
        $('input[name=\'filter_name\']').autocomplete({
         delay: 0,
         source: function(request, response) {
          $.ajax({
           url: 'index.php?route=catalog/po_photo/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
           dataType: 'json',
           success: function(json) {		
            response($.map(json, function(item) {
             return {
              label: item.name,
              value: item.photo_id
            }
          }));
          }
        });
        }, 
        select: function(event, ui) {
          $('input[name=\'filter_name\']').val(ui.item.label);
          
          return false;
        }
      });

        $('input[name=\'filter_model\']').autocomplete({
         delay: 0,
         source: function(request, response) {
          $.ajax({
           url: 'index.php?route=catalog/po_photo/autocomplete&token=<?php echo $token; ?>&filter_model=' +  encodeURIComponent(request.term),
           dataType: 'json',
           success: function(json) {		
            response($.map(json, function(item) {
             return {
              label: item.model,
              value: item.photo_id
            }
          }));
          }
        });
        }, 
        select: function(event, ui) {
          $('input[name=\'filter_model\']').val(ui.item.label);
          
          return false;
        }
      });
        //--></script> 
        <?php echo $footer; ?>