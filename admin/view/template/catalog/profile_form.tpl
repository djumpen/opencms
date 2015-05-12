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
        <button type="submit" onclick="$('#form').submit();"  class="btn btn-primary"><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger"><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <form id="form" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
        <div class="form-group required">
          <label class="col-xs-2 control-label"><?php echo $entry_name; ?></label>
          <div class="col-xs-10">
                      <?php foreach ($languages as $language): ?>
                        <div class="input-group"> <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span> <input name="profile_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($profile_description[$language['language_id']]) ? $profile_description[$language['language_id']]['name'] : ''; ?>" class="form-control" /></div>
                       <br />
                        <?php if (isset($error_name[$language['language_id']])): ?>
                            <span class="error"><?php echo $error_name[$language['language_id']]; ?></span><br />
                        <?php endif; ?>
                      <?php endforeach; ?>
                  </div>
				  </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
              <div class="col-xs-10">
                 <input name="sort_order" value="<?php echo $sort_order ?>" class="form-control" />
              </div>
            </div>
             <div class="col-xs-12">
                      <?php echo $text_recurring_help ?>
                </div>
                        <div class="form-group">
              <label class="col-xs-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
              <div class="col-xs-10">
				<div class="btn-group" data-toggle="buttons">
				  <label class="btn btn-primary<?php if ($status == 1) { ?> active<?php } ?>">
				    <i class="fa fa-check"></i> <input type="radio" name="status" value="1" id="input-status" <?php if ($status == 1) { ?>checked<?php } ?>> <?php echo $text_enabled; ?>
				  </label>
				  <label class="btn btn-primary<?php if ($status == 0) { ?> active<?php } ?>">
				    <i class="fa fa-times"></i> <input type="radio" name="status" value="0" id="input-status" <?php if ($status == 0) { ?>checked<?php } ?>> <?php echo $text_disabled; ?>
				  </label>
				</div>
              </div>
			  </div>
            <div class="form-group">
              <label class="col-xs-2 control-label" ><?php echo $entry_price; ?></label>
              <div class="col-xs-10">
                <input type="text" name="price" value="<?php echo $price; ?>"  class="form-control" />
              </div>
            </div>
           <div class="form-group">
              <label class="col-xs-2 control-label" ><?php echo $entry_duration; ?></label>
              <div class="col-xs-10">
                <input type="text" name="duration" value="<?php echo $duration; ?>"  class="form-control" />
              </div>
            </div>
           <div class="form-group">
              <label class="col-xs-2 control-label" ><?php echo $entry_cycle; ?></label>
              <div class="col-xs-10">
                <input type="text" name="cycle" value="<?php echo $cycle; ?>"  class="form-control" />
              </div>
            </div>
                            <div class="form-group">
              <label class="col-xs-2 control-label" ><?php echo $entry_frequency; ?></label>
              <div class="col-xs-10">
                      <select name="frequency" class="form-control">
                          <?php foreach ($frequencies as $key => $title): ?>
                              <?php if ($frequency == $key): ?>    
                                  <option value="<?php echo $key ?>" selected="selected"><?php echo $title ?></option>
                              <?php else: ?>
                                  <option value="<?php echo $key ?>"><?php echo $title ?></option>
                              <?php endif; ?>
                          <?php endforeach; ?>
                      </select>
                 </div>
				 </div>
                            <div class="form-group">
              <label class="col-xs-2 control-label" ><?php echo $entry_trial_status; ?></label>
              <div class="col-xs-10">
                      <select name="trial_status" class="form-control">
                          <?php if ($trial_status): ?>
                              <option value="0"><?php echo $text_disabled ?></option>
                              <option value="1" selected="selected"><?php echo $text_enabled ?></option>
                          <?php else: ?>
                              <option value="0" selected="selected"><?php echo $text_disabled ?></option>
                              <option value="1"><?php echo $text_enabled ?></option>
                          <?php endif; ?>
                    </select>
     </div>
	 </div>
	 
	                  <div class="form-group">
              <label class="col-xs-2 control-label" ><?php echo $entry_trial_price; ?></label>
              <div class="col-xs-10">
                 <input name="trial_price" value="<?php echo $trial_price ?>" class="form-control">
              </div>
			  </div>
                  <div class="form-group">
              <label class="col-xs-2 control-label" ><?php echo $entry_trial_duration; ?></label>
              <div class="col-xs-10">
                  <input name="trial_duration" value="<?php echo $trial_duration ?>" class="form-control">
				  </div>
				  </div>
             <div class="form-group">
              <label class="col-xs-2 control-label" ><?php echo $entry_trial_cycle; ?></label>
              <div class="col-xs-10">
                 <input name="trial_cycle" value="<?php echo $trial_cycle ?>" class="form-control">
             </div>
			 </div>
                  <div class="form-group">
              <label class="col-xs-2 control-label" ><?php echo $entry_trial_frequency ?></label>
              <div class="col-xs-10">
                      <select name="trial_frequency" class="form-control">
                          <?php foreach ($frequencies as $key => $title): ?>
                              <?php if ($trial_frequency == $key): ?>    
                                  <option value="<?php echo $key ?>" selected="selected"><?php echo $title ?></option>
                              <?php else: ?>
                                  <option value="<?php echo $key ?>"><?php echo $title ?></option>
                              <?php endif; ?>
                          <?php endforeach; ?>
                      </select>
                  </div>
				  </div>
      </form>
      
      </div>
    </div>
  </div>
</div>
<script text="text/javascript"><!--
$('#button-add').click(function(){
    count++;
    var html = '';
    html += '<tr id="row' +  count + '">';
    html += ' <td class="right">';
    html += '   <select name="profile_prices[' + count + '][status]">';
    html += '     <option value="0"><?php echo $text_disabled ?></option>';
    html += '     <option value="1"><?php echo $text_enabled ?></option>';
    html += '   </select>';
    html += ' </td>';
    html += ' <td class="left">';
    html += '   <input style="width: 60px" name="profile_prices[' + count + '][price]" />';
    html += ' </td>';
    html += ' <td class="left">';
    html += '   <input style="width: 60px" name="profile_prices[' + count + '][duration]" />';
    html += ' </td>';
    html += ' <td class="left">';
    html += '   <input style="width: 60px" name="profile_prices[' + count + '][cycle]" />';
    html += ' </td>';
    html += ' <td class="left">';
    html += '   <select name="profile_prices[' + count + '][frequency]">';
    <?php foreach ($frequencies as $frequency => $frequencyName): ?>
        
        html += '<option value="<?php echo $frequency ?>"><?php echo $frequencyName ?></option>';
        
    <?php endforeach;?>
    html += '   </select>';
    html += ' </td>';
    html += ' <td class="left">';
    html += '   <select name="profile_prices[' + count + '][trial_status]">';
    html += '     <option value="0"><?php echo $text_disabled ?></option>';
    html += '     <option value="1"><?php echo $text_enabled ?></option>';
    html += '   </select>';
    html += ' </td>';
    html += ' <td class="right">';
    html += '   <input style="width: 60px" name="profile_prices[' + count + '][trial_price]" />';
    html += ' </td>';
    html += ' <td class="left">';
    html += '   <input style="width: 60px" name="profile_prices[' + count + '][trial_duration]" />';
    html += ' </td>';
    html += ' <td class="left">';
    html += '   <input style="width: 60px" name="profile_prices[' + count + '][trial_frequency]" />';
    html += ' </td>';
    html += ' <td class="left">';
    html += '   <select name="profile_prices[' + count + '][trial_frequency]">';
    <?php foreach ($frequencies as $frequency => $frequencyName): ?>
        
        html += '<option value="<?php echo $frequency ?>"><?php echo $frequencyName ?></option>';
        
    <?php endforeach;?>
    html += '   </select>';
    html += ' </td>';
    html += ' <td><a class="button" onclick="$(\'#row' + count + '\').remove()"><?php echo $button_remove ?></a></td>';
    html += '</tr>';
    
    $('table.list tbody').append(html);
});
//--></script>
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