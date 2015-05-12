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
        <div class="pull-right">
            <button type="submit" form="form-option" class="btn btn-primary "><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
            <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
        <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-option" class="form-horizontal">
        <div class="form-group required">
            <label class="col-xs-2 control-label"><?php echo $entry_name; ?></label>
            <div class="col-xs-10">
                <?php foreach ($languages as $language) { ?>
                    <div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                        <input type="text" name="option_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($option_description[$language['language_id']]) ? $option_description[$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_name; ?>" class="form-control" />
                    </div>
                    <?php if (isset($error_name[$language['language_id']])) { ?>
                        <div class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
                    <?php } ?>
                <?php } ?>
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-2 control-label" for="input-type"><?php echo $entry_type; ?></label>
            <div class="col-xs-10">
                <select name="type" id="input-type" class="form-control">
                    <optgroup label="<?php echo $text_choose; ?>">
                        <?php if ($type == 'select') { ?>
                            <option value="select" selected="selected"><?php echo $text_select; ?></option>
                        <?php } else { ?>
                            <option value="select"><?php echo $text_select; ?></option>
                        <?php } ?>
                        <?php if ($type == 'radio') { ?>
                            <option value="radio" selected="selected"><?php echo $text_radio; ?></option>
                        <?php } else { ?>
                            <option value="radio"><?php echo $text_radio; ?></option>
                        <?php } ?>
                        <?php if ($type == 'checkbox') { ?>
                            <option value="checkbox" selected="selected"><?php echo $text_checkbox; ?></option>
                        <?php } else { ?>
                            <option value="checkbox"><?php echo $text_checkbox; ?></option>
                        <?php } ?>
                        <?php if ($type == 'radiocolor') { ?>
                            <option value="radiocolor" selected="selected"><?php echo $text_radiocolor; ?></option>
                        <?php } else { ?>
                            <option value="radiocolor"><?php echo $text_radiocolor; ?></option>
                        <?php } ?>
                        <?php if ($type == 'radiolabel') { ?>
                            <option value="radiolabel" selected="selected"><?php echo $text_radiolabel; ?></option>
                        <?php } else { ?>
                            <option value="radiolabel"><?php echo $text_radiolabel; ?></option>
                        <?php } ?>
                        <?php if ($type == 'checkboxcolor') { ?>
                            <option value="checkboxcolor" selected="selected"><?php echo $text_checkboxcolor; ?></option>
                        <?php } else { ?>
                            <option value="checkboxcolor"><?php echo $text_checkboxcolor; ?></option>
                        <?php } ?>
                        <?php if ($type == 'checkboxlabel') { ?>
                            <option value="checkboxlabel" selected="selected"><?php echo $text_checkboxlabel; ?></option>
                        <?php } else { ?>
                            <option value="checkboxlabel"><?php echo $text_checkboxlabel; ?></option>
                        <?php } ?>
                        <?php if ($type == 'image') { ?>
                            <option value="image" selected="selected"><?php echo $text_image; ?></option>
                        <?php } else { ?>
                            <option value="image"><?php echo $text_image; ?></option>
                        <?php } ?>
                    </optgroup>
                    <optgroup label="<?php echo $text_input; ?>">
                        <?php if ($type == 'custom_text') { ?>
                            <option value="custom_text" selected="selected"><?php echo $text_text; ?></option>
                        <?php } else { ?>
                            <option value="custom_text"><?php echo $text_text; ?></option>
                        <?php } ?>
                        <?php /*<?php if ($type == 'textarea') { ?>
              <option value="textarea" selected="selected"><?php echo $text_textarea; ?></option>
              <?php } else { ?>
              <option value="textarea"><?php echo $text_textarea; ?></option>
              <?php } ?>
              </optgroup>
              <optgroup label="<?php echo $text_file; ?>">
              <?php if ($type == 'file') { ?>
              <option value="file" selected="selected"><?php echo $text_file; ?></option>
              <?php } else { ?>
              <option value="file"><?php echo $text_file; ?></option>
              <?php } ?>
              </optgroup>
              <optgroup label="<?php echo $text_date; ?>">
              <?php if ($type == 'date') { ?>
              <option value="date" selected="selected"><?php echo $text_date; ?></option>
              <?php } else { ?>
              <option value="date"><?php echo $text_date; ?></option>
              <?php } ?>
              <?php if ($type == 'time') { ?>
              <option value="time" selected="selected"><?php echo $text_time; ?></option>
              <?php } else { ?>
              <option value="time"><?php echo $text_time; ?></option>
              <?php } ?>
              <?php if ($type == 'datetime') { ?>
              <option value="datetime" selected="selected"><?php echo $text_datetime; ?></option>
              <?php } else { ?>
              <option value="datetime"><?php echo $text_datetime; ?></option>
              <?php } ?>*/?>
                    </optgroup>
                </select>
                <?php if ($error_dependent_option_type) { ?>
                    <span class="error"><?php echo $error_dependent_option_type; ?></span>
                <?php } ?>
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
            <div class="col-xs-10">
                <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-2 control-label">Отображать на странице продукта</label>
            <div class="col-xs-10">
                <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-primary<?php if ($product_page !== '0' ) { ?> active<?php } ?>">
                        <i class="fa fa-check"></i> <input type="radio" name="product_page" value="1" <?php if ($product_page !== '0') { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
                    </label>
                    <label class="btn btn-primary<?php if ($product_page === '0') { ?> active<?php } ?>">
                        <i class="fa fa-times"></i> <input type="radio" name="product_page" value="0" <?php if ($product_page === '0') { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
                    </label>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-2 control-label">Участие в фильтре</label>
            <div class="col-xs-10">
                <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-primary<?php if ($filter_option !== '0' ) { ?> active<?php } ?>">
                        <i class="fa fa-check"></i> <input type="radio" name="filter_option" value="1" <?php if ($filter_option !== '0') { ?>checked="checked"<?php } ?>> <?php echo $text_yes; ?>
                    </label>
                    <label class="btn btn-primary<?php if ($filter_option === '0') { ?> active<?php } ?>">
                        <i class="fa fa-times"></i> <input type="radio" name="filter_option" value="0" <?php if ($filter_option === '0') { ?>checked="checked"<?php } ?>> <?php echo $text_no; ?>
                    </label>
                </div>
            </div>
        </div>
        <?php foreach ($parent_option_values as $parent_option_value) { ?>
            <input type="hidden" name="parent_option_values[]" value="<?php echo $parent_option_value; ?>" />
        <?php } ?>
        <table id="option-value" class="table table-striped table-bordered table-hover">
            <thead>
            <tr>
                <td class="text-left required width-20"><?php echo $entry_option_value; ?></td>
                <td class="text-left"><?php echo $entry_image; ?></td>
                <?php if($type == 'checkboxcolor' || $type == 'radiocolor') { ?>
                    <td class="text-left color-cell" style="display: table-cell;">Цвет</td>
                <?php } else { ?>
                    <td class="text-left color-cell" style="display: none;">Цвет</td>
                <?php } ?>
                <td class="text-right width-10"><?php echo $entry_sort_order; ?></td>
                <td></td>
            </tr>
            </thead>
            <tbody>
            <?php $option_value_row = 0; ?>
            <?php foreach ($option_values as $option_value) { ?>
                <tr id="option-value-row<?php echo $option_value_row; ?>">
                    <td class="text-left"><input type="hidden" name="option_value[<?php echo $option_value_row; ?>][option_value_id]" value="<?php echo $option_value['option_value_id']; ?>" />
                        <?php foreach ($languages as $language) { ?>
                            <div class="input-group"> <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                                <input type="text" name="option_value[<?php echo $option_value_row; ?>][option_value_description][<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($option_value['option_value_description'][$language['language_id']]) ? $option_value['option_value_description'][$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_option_value; ?>" class="form-control" />
                            </div>
                            <?php if (isset($error_option_value[$option_value_row][$language['language_id']])) { ?>
                                <div class="text-danger"><?php echo $error_option_value[$option_value_row][$language['language_id']]; ?></div>
                            <?php } ?>
                        <?php } ?>
                        <?php if (isset($error_dependent_option_value[$option_value['option_value_id']])) { ?>
                            <div class="text-danger"><?php echo $error_dependent_option_value[$option_value['option_value_id']]; ?></div>
                        <?php } ?></td>
                    <td class="text-left">
                        <img src="<?php echo $option_value['thumb']; ?>" alt="" class="img-thumbnail" id="thumb<?php echo $option_value_row; ?>" />
                        <input type="hidden" name="option_value[<?php echo $option_value_row; ?>][image]" value="<?php echo $option_value['image']; ?>" id="image<?php echo $option_value_row; ?>"/>
                        <br />
                        <br />
                        <div class="btn-group">
                            <button type="button" data-toggle="modal" data-target="#dialog" class="btn btn-info" onclick="image_upload('image<?php echo $option_value_row; ?>', 'thumb<?php echo $option_value_row; ?>');"><span class="fa fa-pencil"></span> <?php echo $text_browse; ?></button>
                            <button type="button" onclick="$('#thumb<?php echo $option_value_row; ?>').attr('src', '<?php echo $no_image; ?>'); $('#image<?php echo $option_value_row; ?>').attr('value', '');return false;" class="btn btn-danger"><span class="fa fa-trash-o"></span> <?php echo $text_clear; ?></button>
                        </div></td>
                    <?php if($type == 'checkboxcolor' || $type == 'radiocolor') { ?>
                        <?php Debug::log($option_value['color']);?>
                        <td class="text-right color-cell" style="display: table-cell;"><div class="input-group color-field"><input type="text" name="option_value[<?php echo $option_value_row; ?>][color]" value="<?php echo $option_value['color']; ?>" class="form-control" /><span class="input-group-addon"><i></i></span></div></td>
                    <?php } else { ?>
                        <td class="text-right color-cell" style="display: none;"><div class="input-group color-field"><input type="text" name="option_value[<?php echo $option_value_row; ?>][color]" value="<?php echo $option_value['color']; ?>" class="form-control" /><span class="input-group-addon"><i></i></span></div></td>
                    <?php } ?>
                    <td class="text-right"><input type="text" name="option_value[<?php echo $option_value_row; ?>][sort_order]" value="<?php echo $option_value['sort_order']; ?>" class="form-control" /></td>
                    <td class="text-left"><button type="button" onclick="$('#option-value-row<?php echo $option_value_row; ?>').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i> <?php echo $button_remove; ?></button></td>
                </tr>
                <?php $option_value_row++; ?>
            <?php } ?>
            </tbody>
            <tfoot>
            <tr>
                <td colspan="3"></td>
                <?php if($type == 'radiocolor' || $type == 'checkboxcolor') { ?>
                    <td class="color-cell" style="display: table-cell;"></td>
                <?php } else {?>
                    <td class="color-cell" style="display: none;"></td>
                <?php } ?>
                <td class="text-left"><button type="button" onclick="addOptionValue();" class="btn btn-primary"><i class="fa fa-plus-circle"></i> <?php echo $button_add_option_value; ?></button></td>
            </tr>
            </tfoot>
        </table>
    </form>
    </div>
    </div>
    </div>
    <script type="text/javascript"><!--
        $('select[name=\'type\']').on('change', function() {
            if (this.value == 'select' || this.value == 'radio' || this.value == 'checkbox' || this.value == 'radiocolor' || this.value == 'radiolabel' || this.value == 'checkboxcolor' || this.value == 'checkboxlabel' || this.value == 'image' || this.value == 'custom_text') {
                $('#option-value').show();
                if(this.value == 'radiocolor' || this.value == 'checkboxcolor') {
                    $('.color-cell').css('display', 'table-cell');
                } else {
                    $('.color-cell').css('display', 'none');
                }
            } else {
                $('#option-value').hide();
            }
        });

        var option_value_row = <?php echo $option_value_row; ?>;

        function addOptionValue() {
            var selectedType = $('select[name=type] > optgroup > option:selected').val();
            html  = '<tr id="option-value-row' + option_value_row + '">';
            html += '  <td class="text-left"><input type="hidden" name="option_value[' + option_value_row + '][option_value_id]" value="" />';
            <?php foreach ($languages as $language) { ?>
            html += '    <div class="input-group">';
            html += '      <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span><input type="text" name="option_value[' + option_value_row + '][option_value_description][<?php echo $language['language_id']; ?>][name]" value="" placeholder="<?php echo $entry_option_value; ?>" class="form-control" />';
            html += '    </div>';
            <?php } ?>
            html += '  </td>';
            html += '  <td class="text-left"><img src="<?php echo $no_image; ?>" alt="" class="img-thumbnail" id="thumb' + option_value_row + '"/><input type="hidden" name="option_value[' + option_value_row + '][image]" value="" id="image' + option_value_row + '"/><div class="btn-group"><button type="button" data-toggle="modal" data-target="#dialog" class="btn btn-info" onclick="image_upload(\'image' + option_value_row + '\', \'thumb' + option_value_row + '\');"><span class="fa fa-pencil"></span> <?php echo $text_browse; ?></button><button type="button" onclick="$(\'#thumb' + option_value_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#image' + option_value_row + '\').attr(\'value\', \'\');return false;" class="btn btn-danger"><span class="fa fa-trash-o"></span> <?php echo $text_clear; ?></button></div></td>';
            if(selectedType == 'checkboxcolor' || selectedType == 'radiocolor') {
                html += '  <td class="text-right color-cell color-field" style="display: table-cell;"><div class="input-group color-field"><input type="text" name="option_value[' + option_value_row + '][color]" value="" placeholder="Цвет" class="form-control" /><span class="input-group-addon"><i></i></span></div></td>';
            } else {
                html += '  <td class="text-right color-cell color-field" style="display: none;"><div class="input-group color-field"><input type="text" name="option_value[' + option_value_row + '][color]" value="" placeholder="Цвет" class="form-control" /><span class="input-group-addon"><i></i></span></div></td>';
            }
            html += '  <td class="text-right"><input type="text" name="option_value[' + option_value_row + '][sort_order]" value="" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>';
            html += '  <td class="text-left"><button type="button" onclick="$(\'#option-value-row' + option_value_row + '\').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i> <?php echo $button_remove; ?></button></td>';
            html += '</tr>';

            $('#option-value tbody').append(html);

            option_value_row++;
            $('.color-field').colorpicker();
        }
        //--></script>
    <script>
        $(document).ready(function(){
            $('.color-field').colorpicker();
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
    <script type="text/javascript">
        function image_upload(field, thumb) {

            $('#dialog').attr('data-field', field);
            $('#dialog').attr('data-thumb', thumb);
            $('#dialog #fm-iframe').attr('src', 'index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field));
        };

        $(document.body).on('show.bs.modal', '#dialog', function () {
            $(this).find('#dialog-confirm').addClass('hide');
        });

        $(document.body).on('hidden.bs.modal', '#dialog', function () {
            var field = $(this).attr('data-field');
            var thumb = $(this).attr('data-thumb');

            if ($('#' + field).attr('value')) {
                $.ajax({
                    url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()),
                    dataType: 'text',
                    success: function(data) {
                        $('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '">');
                    }
                });
            }
            $('#dialog').attr('data-field', '');
            $('#dialog').attr('data-thumb', '');
            $('#dialog #fm-iframe').attr('src', '');
        });
    </script>
    <script>
        var isCtrl = false;
        $(document).keyup(function (e) {
            if(e.which == 17) isCtrl=false;
        }).keydown(function (e) {
            if(e.which == 17) isCtrl=true;
            if(e.which == 83 && isCtrl == true) {
                $('#content > div > div.panel-heading > div > button').trigger('click');
                return false;
            }
        });
    </script>
<?php echo $footer; ?>