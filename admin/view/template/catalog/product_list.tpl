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
    <div class="panel-body">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-product">
        <div class="table-responsive">
          <table class="table table-striped table-bordered table-hover">
            <thead>
              <tr>
                <td class="text-center" style="width: 65px;"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                <td class="text-center" style="width: 100px"><?php echo $column_image; ?></td>
                <td class="text-left"><?php if ($sort == 'pd.name') { ?>
                  <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
                  <?php } ?></td>
                  <td class="text-left hidden-xs width-10"><?php if ($sort == 'p.model') { ?>
                    <a href="<?php echo $sort_model; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_model; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_model; ?>"><?php echo $column_model; ?></a>
                    <?php } ?>
                  </td>
                  <td class="text-left hidden-xs" style="width: 200px">
                    <span>Категории</span>
                  </td>
                  <td class="text-left hidden-xs width-10"><?php if ($sort == 'p.price') { ?>
                    <a href="<?php echo $sort_price; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_price; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_price; ?>"><?php echo $column_price; ?></a>
                    <?php } ?></td>
                    <td class="text-center hidden-xs width-10" style="width: 40px"><?php if ($sort == 'p.quantity') { ?>
                      <a href="<?php echo $sort_quantity; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_quantity; ?></a>
                      <?php } else { ?>
                      <a href="<?php echo $sort_quantity; ?>"><?php echo $column_quantity; ?></a>
                      <?php } ?></td>
                      <td class="text-center hidden-xs width-10" style="width: 100px"><?php if ($sort == 'p.status') { ?>
                        <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                        <?php } else { ?>
                        <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                        <?php } ?></td>
                        <td class="text-left" style="width: 105px"><?php if ($sort == 'p.date_added') { ?>
                          <a href="<?php echo $sort_date; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date; ?></a>
                          <?php } else { ?>
                          <a href="<?php echo $sort_date; ?>"><?php echo $column_date; ?></a>
                          <?php } ?></td>
                          <td class="text-right" style="width: 50px"><?php echo $column_action; ?></td>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>
                            <input class="form-control" name="filter_by_id" value="<?php if(isset($this->request->get['filter_by_id'])) { print (int)$this->request->get['filter_by_id']; } ?>">
                          </td>
                          <td></td>
                          <td><input type="text" name="filter_name" value="<?php echo $filter_name; ?>" class="form-control" /></td>
                          <td class=" hidden-xs"><input type="text" name="filter_model" value="<?php echo $filter_model; ?>" class="form-control" /></td>
                          <td class="text-left hidden-xs">
                            <select name="filter_category" id="filter_by_category" class="form-control">
                              <option value="<?php print $this->url->link('catalog/product', 'token=' . $this->session->data['token'], 'SSL'); ?>" <?php if(!isset($this->request->get['filter_category'])) { ?>selected="selected"<?php } ?>>---</option>
                              <?php if(isset($filter_categories)) { ?>
                              <?php foreach ($filter_categories as $category) { ?>
                              <option category-id="<?php print $category['category_id']; ?>" value="<?php print $category['href']; ?>" <?php if($category['active']) { ?>selected="selected"<?php } ?>><?php print $category['name']; ?></option>
                              <?php } ?>
                              <?php } ?>                  
                            </select>
                            <script type="text/javascript">
                              $(document).ready(function(){
                                $(document).on('change', '#filter_by_category', function(){
                                  window.location.href = $(this).val();
                                });
                              });
                            </script>
                          </td>
                          <td class=" hidden-xs" align="left"><input type="text" name="filter_price" value="<?php echo $filter_price; ?>" class="form-control" /></td>
                          <td class=" hidden-xs" align="right"><input type="text" name="filter_quantity" value="<?php echo $filter_quantity; ?>" class="form-control" /></td>
                          <td class=" hidden-xs"><select name="filter_status" class="form-control">
                            <option value="*"></option>
                            <?php if ($filter_status) { ?>
                            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                            <?php } else { ?>
                            <option value="1"><?php echo $text_enabled; ?></option>
                            <?php } ?>
                            <?php if (($filter_status !== null) && !$filter_status) { ?>
                            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                            <?php } else { ?>
                            <option value="0"><?php echo $text_disabled; ?></option>
                            <?php } ?>
                          </select></td>
                          <td><input class="form-control datepicker" type="text" name="filter_date_added" size="10" value="<?php echo $filter_date_added; ?>" style="text-align: center;" /></td>
                          <td><button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button></td>
                        </tr>
                        <?php if ($products) { ?>
                        <?php $p=0;foreach ($products as $product) { ?>
                        <tr>
                          <td class="text-center"><?php if ($product['selected']) { ?>
                            <input type="checkbox" name="selected[]" value="<?php echo $product['product_id']; ?>" checked="checked" data-toggle="tooltip" title="<?php echo $product['product_id']; ?>"/>
                            <?php } else { ?>
                            <input type="checkbox" name="selected[]" value="<?php echo $product['product_id']; ?>" data-toggle="tooltip" title="<?php echo $product['product_id']; ?>" />
                            <?php } ?>
                            <div></div>
                            <a class="viewProduct" onclick="window.open('/index.php?route=product/product&product_id=<?php print $product['product_id']; ?>','_blank');"><i class="fa fa-eye"></i></a>
                          </td>
                          <td class="text-center">
                            <img  id="thumb__<?php print $p; ?>" data-toggle="modal" onclick="image_upload('image__<?php print $p;?>', 'thumb__<?php print $p;?>', '<?php print $product['product_id']; ?>');" data-target="#dialog" src="<?php echo $product['image']; ?>" alt="<?php echo $product['name']; ?>" class="img-thumbnail uploadImg"  title="Кликните на изображение чтобы его изменить" />
                            <input type="hidden" name="img_product" id="image__<?php print $p; ?>" value="<?php print $product['original_image']; ?>">
                          </td>
                          <td class="text-center">
                            <span class="editable" data-name="product_name" data-pk="<?php print $product['product_id']; ?>" data-type="text"><?php echo $product['name']; ?></span>
                          </td>
                          <td class="text-left hidden-xs">
                            <span class="editable" data-name="product_model" data-pk="<?php print $product['product_id']; ?>" data-type="text"><?php echo $product['model']; ?></span>
                          </td>
                          <td class="text-left hidden-xs category-live product_id-<?php print $product['product_id']; ?>" product-id="<?php print $product['product_id']; ?>">
                            <span class="catList">
                              <?php if($product['categories']) { ?>
                              <?php foreach ($product['categories'] as $product_category) { ?>
                              <span product-category-id="<?php print $product_category['category_id']; ?>"><?php print $product_category['name']; ?> <i class="fa red fa-times product_category"></i></span>
                              <?php } ?>
                              <?php } ?>
                            </span>
                            <div class="pluscat green"><i class="fa fa-plus"></i></div>
                          </td>
                          <td class="text-center hidden-xs"><?php if ($product['special']) { ?>
                            <span style="text-decoration: line-through;" class="editable" data-name="product_price" data-pk="<?php print $product['product_id']; ?>" data-type="text"><?php echo $product['price']; ?></span><br/>
                            <div class="text-danger editable" data-name="product_special" data-pk="<?php print $product['product_id']; ?>" data-type="text"><?php echo $product['special']; ?></div>
                            <?php } else { ?>
                            <span class="editable" data-name="product_price" data-pk="<?php print $product['product_id']; ?>" data-type="text">
                              <?php echo $product['price']; ?>
                            </span>
                            <?php } ?>
                          </td>
                          <td class="text-right hidden-xs"><?php if ($product['quantity'] <= 0) { ?>
                            <span class="label label-warning editable" data-name="product_quantity" data-pk="<?php print $product['product_id']; ?>" data-type="text"><?php echo $product['quantity']; ?></span>
                            <?php } elseif ($product['quantity'] <= 5) { ?>
                            <span class="label label-danger editable" data-name="product_quantity" data-pk="<?php print $product['product_id']; ?>" data-type="text"><?php echo $product['quantity']; ?></span>
                            <?php } else { ?>
                            <span class="label label-success editable" data-name="product_quantity" data-pk="<?php print $product['product_id']; ?>" data-type="text"><?php echo $product['quantity']; ?></span>
                            <?php } ?></td>
                            <td class="text-left hidden-xs">
                            <!--
                              <span
                              class="
                              label status_field
                              <?php echo ($this->language->get('text_disabled') == $product['status'])?'label-warning':'label-primary'; ?> editable" 
                              data-name="product_status" 
                              data-pk="<?php print $product['product_id']; ?>"
                              data-type="select"
                              data-value="<?php if ( isset($text_disabled) && $text_disabled == $product['status'] ) { echo 0; } else { echo 1; } ?>"
                              data-source="{'1': 'Включено', '0': 'Отключено'}"
                              >
                              <?php echo $product['status']; ?>
                            </span> -->
                            <div class="btn-group toggle-product-status" data-toggle="buttons" product-id="<?php print $product['product_id']; ?>">
							  <label class="btn btn-success<?php if (!isset($text_disabled) || $text_disabled != $product['status']) { ?> active<?php } ?>">
							    <i class="fa fa-check"></i> <input type="radio" name="status" value="1" id="input-status" <?php if (!isset($text_disabled) || $text_disabled != $product['status']) { ?>checked<?php } ?>>
							  </label>
							  <label class="btn btn-danger<?php if (isset($text_disabled) && $text_disabled == $product['status']) { ?> active<?php } ?>">
							    <i class="fa fa-times"></i> <input type="radio" name="status" value="0" id="input-status" <?php if (isset($text_disabled) && $text_disabled == $product['status']) { ?>checked<?php } ?>>
							  </label>
							</div>
                          </td>
                          <td><?php echo date_format(new DateTime($product['date_added']), 'Y-m-d');?></td></td>
                          <td class="text-right"><?php foreach ($product['action'] as $action) { ?>
                            <a href="<?php echo $action['href']; ?>" data-toggle="tooltip" title="<?php echo $action['text']; ?>" class="btn btn-primary"><i class="fa fa-edit"></i> <?php echo $action['text']; ?></a>
                            <?php } ?></td>
                          </tr>
                          <?php $p++; } ?>
                          <?php } else { ?>
                          <tr>
                            <td class="text-center" colspan="9"><?php echo $text_no_results; ?></td>
                          </tr>
                          <?php } ?>
                        </tbody>
                      </table>
                    </div>
                  </form>
                  <div class="row">
                    <div class="col-xs-6 text-left"><?php 
                      if ($pagination){
                        $str = $pagination;

                        $str1 = str_replace('<div class="links">', '<ul class="pagination">', $str);
                        $str2 = str_replace('</div>', '</ul>', $str1);
                        $str3 = str_replace('<a', '<li><a', $str2);
                        $str4 = str_replace('</a>', '</a></li>', $str3);
                        $str5 = str_replace('<b>', '<li class="active"><a>', $str4);
                        $str6 = str_replace('</b>', '<span class="sr-only">(current)</span></a></li>', $str5);
                        $str7 = str_replace('&gt;|', '<i class="fa fa-angle-double-right"></i>', $str6);
                        $str8 = str_replace('&gt;', '<i class="fa fa-angle-right"></i>', $str7);
                        $str9 = str_replace('|&lt;', '<i class="fa fa-angle-double-left"></i>', $str8);
                        $str10 = str_replace('&lt;', '<i class="fa fa-angle-left"></i>', $str9);
                        $str11 = str_replace('....', '<li class="disabled"><span>....</span></li>', $str10);
                        echo $str11; 
                      }
                      ?></div>
                    </div>
                  </div>
                </div>
              </div>
              <script type="text/javascript"><!--
                $('#button-filter').on('click', function() {
                 var url = 'index.php?route=catalog/product&token=<?php echo $token; ?>';
                 
                 var filter_by_id = $('input[name=\'filter_by_id\']').val();
                 
                 if (filter_by_id) {
                  url += '&filter_by_id=' + encodeURIComponent(filter_by_id);
                }
                
                var filter_name = $('input[name=\'filter_name\']').val();
                
                if (filter_name) {
                  url += '&filter_name=' + encodeURIComponent(filter_name);
                }
                
                var filter_model = $('input[name=\'filter_model\']').val();
                
                if (filter_model) {
                  url += '&filter_model=' + encodeURIComponent(filter_model);
                }
                
                var filter_price = $('input[name=\'filter_price\']').val();
                
                if (filter_price) {
                  url += '&filter_price=' + encodeURIComponent(filter_price);
                }
                
                var filter_quantity = $('input[name=\'filter_quantity\']').val();
                
                if (filter_quantity) {
                  url += '&filter_quantity=' + encodeURIComponent(filter_quantity);
                }
                
                var filter_status = $('select[name=\'filter_status\']').val();
                
                if (filter_status != '*') {
                  url += '&filter_status=' + encodeURIComponent(filter_status);
                }	

                var filter_date_added = $('input[name=\'filter_date_added\']').val();
                
                if (filter_date_added) {
                  url += '&filter_date_added=' + encodeURIComponent(filter_date_added);
                }

                location = url;
              });
//--></script> 
<script type="text/javascript"><!--
  $('input[name=\'filter_name\']').autocomplete({
   'source': function(request, response) {
    $.ajax({
     url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
     dataType: 'json',			
     success: function(json) {
      response($.map(json, function(item) {
       return {
        label: item['name'],
        value: item['product_id']
      }
    }));
    }
  });
  },
  'select': function(item) {
    $('input[name=\'filter_name\']').val(item['label']);
  }	
});

  $('input[name=\'filter_model\']').autocomplete({
   'source': function(request, response) {
    $.ajax({
     url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_model=' +  encodeURIComponent(request),
     dataType: 'json',			
     success: function(json) {
      response($.map(json, function(item) {
       return {
        label: item['model'],
        value: item['product_id']
      }
    }));
    }
  });
  },
  'select': function(item) {
    $('input[name=\'filter_model\']').val(item['label']);
  }	
});
  //--></script> 
  <script>
    $(document).ready(function(){
      $.fn.editable.defaults.mode = 'popup';
      $.fn.editable.defaults.showbuttons = false;
      $.fn.editable.defaults.onblur = 'submit';
      $.fn.editable.defaults.success = function(response, value){
        console.log($(this).parent().children('span'));
        if($(this).parent().children('span').hasClass('status_field')) {
          if(response) {
            if(value == 1) {
              $(this).parent().children('span').removeClass('label-warning');
              $(this).parent().children('span').addClass('label-primary');
              $(this).parent().children('span').removeAttr('style');
            } else {
              $(this).parent().children('span').removeClass('label-primary');
              $(this).parent().children('span').addClass('label-warning');
              $(this).parent().children('span').removeAttr('style');
            }
          }
        }
      };
      $.fn.editable.defaults.url = '<?php print html_entity_decode($fastUpdateAction); ?>';
      $('.editable').editable();


    });
    $(document).on('click', '.toggle-product-status', function(){
		var data = {
			pk: parseInt($(this).attr('product-id')),
			value: parseInt($(this).find('input[type=radio]:checked').first().val()),
			name: 'product_status',
		};
		$.ajax({
			url: getLink('catalog/product/fastUpdate'),
			type: 'post',
			data: data,
			success: function(response) {
				// Pnotify here
			},
			error: function(e1, e2){
				console.log(e1);
				console.log(e2);
			}
		});
	});
</script>
<div class="modal fade" id="dialog" data-field="" data-thumb="">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title"><?php echo $text_image_manager; ?></h4>
      </div>
      <div class="modal-body">
       <iframe id="fm-iframe" style="display:block; border:0; padding:0; margin:0; width:100%; height:360px; overflow:auto;"></iframe>
     </div>
     <div class="modal-footer">
       <a href="#" id="dialog-confirm" class="btn btn-success hide"><i class="fa fa-thumbs-up"></i> Confirm</a>
       <a href="#" class="btn btn-success" data-dismiss="modal" aria-hidden="true">Close</a>
     </div>
   </div>
 </div>
</div>
<script>
  function image_upload(field, thumb, product_id) {

   $('#dialog').attr('data-field', field);
   $('#dialog').attr('data-thumb', thumb);
   $('#dialog').attr('data-product_id', product_id);
   
   
   $('#dialog #fm-iframe').attr('src', 'index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field));
 };

 $(document.body).on('show.bs.modal', '#dialog', function () {
   $(this).find('#dialog-confirm').addClass('hide');
 });

 $(document.body).on('hidden.bs.modal', '#dialog', function () {
   var field = $(this).attr('data-field');
   var thumb = $(this).attr('data-thumb');
   var product_id = $(this).attr('data-product_id');
   if ($('#' + field).attr('value')) {
    $.ajax({
     url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&product_id=' + product_id + '&fast-edit=1&image=' + encodeURIComponent($('#' + field).val()),
     dataType: 'json',
     success: function(data) {
       $('#' + thumb).attr('src', data.thumb);
       
     }
   });
  }
  $('#dialog').attr('data-field', '');
  $('#dialog').attr('data-thumb', '');
  $('#dialog #fm-iframe').attr('src', '');
});
// $(document).ready(function(){
//     $('input[name=filter_name]').keydown(function(event){    
//         if(event.keyCode==13){
//            $('#button-filter').trigger('click');
//         }
//     });
//     $('input[name=filter_model]').keydown(function(event){    
//         if(event.keyCode==13){
//            $('#button-filter').trigger('click');
//         }
//     });
//     $('input[name=filter_price]').keydown(function(event){    
//         if(event.keyCode==13){
//            $('#button-filter').trigger('click');
//         }
//     });
//     $('input[name=filter_by_id]').keydown(function(event){    
//         if(event.keyCode==13){
//            $('#button-filter').trigger('click');
//         }
//     });
//     $('input[name=filter_quantity]').keydown(function(event){    
//         if(event.keyCode==13){
//            $('#button-filter').trigger('click');
//         }
//     });
// });
</script>
<?php echo $footer; ?>