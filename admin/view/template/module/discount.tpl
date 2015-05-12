<?php echo $header;
function escape_string($string){
  return str_replace("'","\'",$string);
}
?>
<style type="text/css">
.multi-discount-pack input[type=text],
.multi-discount-pack select {
  border: 1px solid #b4b4b4;
  transition: border .40s ease-in-out;
  -moz-transition: border .40s ease-in-out;
  -webkit-transition: border .40s ease-in-out;
}


.multi-discount-pack input[type=text]:hover,
.multi-discount-pack input[type=text]:focus,
.multi-discount-pack select:hover,
.multi-discount-pack select:focus {
  border: 1Px solid #1481af;
  outline: #b7d2dd solid 2px;
}


.multi-discount-pack input[type=text] {
    /*height: 17px;*/
    width: 96px;
    padding: 0 4px;
}
.multi-discount-pack select {
  margin-top: -3px;
  border: 1px solid #b4b4b4;
  padding: 2px;
}
.multi-discount-pack .list tr:hover td {
  background: #f5f5f5;
}
.multi-discount-pack .list tr td span {
  min-width: 35px;
  text-align: left;
  padding-left: 2px;
  display: inline-block;
}
.multi-discount-pack .list tr td label {
  font-weight: bold;
}

.multi-discount-pack .error-field {
  border: 1px solid #db3d3d !important;
}
.multi-discount-pack  .error-field:hover {
  border: 1Px solid #b71d1d !important;
  outline: #ffa5a5 solid 2px !important;
}

.vtabs span.select-type {
  background: none !important;
  border: none !important;
  float: left;
  width: 190px;
  text-align: center;
  height: 40px;
  line-height: 40px;
  padding: 0px;
}

.vtabs a span {
  background: none;
  margin: 0px;
  padding: 0px;
  border: none;
  font-size: 10px;
}
.vtabs a span.active {
  color: #318926 !important;
}
.vtabs a span.inactive {
  color: #892626 !important;
}

.display-none {
  display: none;
}

.module-status {
  padding-right: 10px;
  display: inline-block;
}
.module-status label {
  font-weight: bold;
  padding-right: 5px;
}
.module-status select {
  border: 1px solid #b4b4b4;
  transition: border .40s ease-in-out;
  -moz-transition: border .40s ease-in-out;
  -webkit-transition: border .40s ease-in-out;
}
.module-status select:hover,
.module-status select:focus {
  border: 1Px solid #1481af;
  outline: #b7d2dd solid 2px;
}
.datetime {
width: 100px;
}

#tab-module-setting {
  background: #ffe8d8;
  border: 1px solid #ff8055;
  border-right: none;
}
.list {
	border-collapse: collapse;
	width: 100%;
	border-top: 1px solid #DDDDDD;
	border-left: 1px solid #DDDDDD;
	margin-bottom: 20px;
}
.list td {
	border-right: 1px solid #DDDDDD;
	border-bottom: 1px solid #DDDDDD;
}
.list thead td {
	background-color: #EFEFEF;
	padding: 0px 5px;
}
.list thead td a, .list thead td {
	text-decoration: none;
	color: #222222;
	font-weight: bold;
}
.list tbody td a {
	text-decoration: underline;
}
.list tbody td {
	vertical-align: middle;
	padding: 0px 5px;
	background: #FFFFFF;
}
.list tbody tr:hover td {
	background-color: #FFFFCB;
}
.list .left {
	text-align: left;
	padding: 7px;
}
.list .right {
	text-align: right;
	padding: 7px;
}
.list .center {
	text-align: center;
	padding: 7px;
}
.list .asc {
	padding-right: 15px;
	background: url('../image/asc.png') right center no-repeat;
}
.list .desc {
	padding-right: 15px;
	background: url('../image/desc.png') right center no-repeat;
}
.list tr.filter td, .list tr:hover.filter td {
	padding: 5px;
	background: #E7EFEF;
}
.pagination {
	border-top: 1px solid #DDDDDD;
	display: inline-block;
	width: 100%;
	padding-top: 6px;
}
.pagination .links {
	float: left;
	padding-top: 6px;
}
.pagination .links a {
	border: 1px solid #DDDDDD;
	padding: 4px 10px;
	font-size: 12px;
	text-decoration: none;
	color: #A3A3A3;
}
.pagination .links b {
	border: 1px solid #269BC6;
	padding: 4px 10px;
	font-size: 12px;
	font-weight: normal;
	text-decoration: none;
	color: #269BC6;
	background: #FFFFFF;
}
.pagination .results {
	float: right;
	padding-top: 6px;
	font-size: 12px;
}
table.form {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}
table.form > tbody > tr > td:first-child {
	width: 200px;
}
table.form > tbody > tr > td {
	padding: 10px;
	color: #000000;
	border-bottom: 1px dotted #CCCCCC;
}
.scrollbox {
	border: 1px solid #CCCCCC;
	width: 350px;
	height: 100px;
	background: #FFFFFF;
	overflow-y: scroll;
}
.scrollbox img {
	float: right;
	cursor: pointer;
}
.htabs {
	padding: 0px 0px 0px 10px;
	height: 30px;
	line-height: 16px;
	border-bottom: 1px solid #DDDDDD;
	margin-bottom: 15px;
}
.htabs a {
	border-top: 1px solid #DDDDDD;
	border-left: 1px solid #DDDDDD;
	border-right: 1px solid #DDDDDD;
	background: #FFFFFF url('../image/tab.png') repeat-x;
	padding: 7px 15px 6px 15px;
	float: left;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 13px;
	font-weight: bold;
	text-align: center;
	text-decoration: none;
	color: #000000;
	margin-right: 2px;
	display: none;
}
.htabs a.selected {
	padding-bottom: 7px;
	background: #FFFFFF;
}
.vtabs {
	width: 190px;
	padding: 10px 0px;
	min-height: 300px;
	float: left;
	display: block;
	border-right: 1px solid #DDDDDD;
}
.vtabs a {
	display: none;
}
.vtabs a, .vtabs span {
	display: block;
	float: left;
	width: 100%;
	margin-bottom: 5px;
	clear: both;
	border-top: 1px solid #DDDDDD;
	border-left: 1px solid #DDDDDD;
	border-bottom: 1px solid #DDDDDD;
	background: #F7F7F7;
	padding: 6px 14px 7px 15px;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 13px;
	font-weight: bold;
	text-align: right;
	text-decoration: none;
	color: #000000;
}
.vtabs a.selected {
	padding-right: 15px;
	background: #FFFFFF;
}
.vtabs a img, .vtabs span img {
	position: relative;
	top: 3px;
	cursor: pointer;
}
.vtabs-content {
	margin-left: 205px;
}
.accordion-heading {
	background: #EFEFEF;
	border: 1px solid #DDDDDD;
	padding: 8px;
	font-weight: bold;
	font-size: 13px;
	color: #555555;
	margin-bottom: 15px;
}
.accordion-heading a {
	float: right;
	margin-top: 1px;
	font-weight: normal;
	text-decoration: none;
}
.accordion-content {
	padding: 0px 0px 15px 0px;
	overflow: auto;
}
.scrollbox div {
	padding: 3px;
}
.scrollbox div input {
	margin: 0px;
	padding: 0px;
	margin-right: 3px;
}
.scrollbox div.even {
	background: #FFFFFF;
}
.scrollbox div.odd {
	background: #E4EEF7;
}
.overview {
	float: left;
	width: 49%;
	margin-bottom: 20px;
}
.overview table {
	width: 100%;
}
.overview td + td {
	text-align: right;
}
.statistic {
	float: right;
	width: 49%;
	margin-bottom: 20px;
}
.range {
	float: right;
	color: #FFF;
	vertical-align: middle;
}
.range {
	padding-top: 1px;
	padding-right: 1px;
}
.range, .range select {
	font-size: 11px;
}
.latest {
	clear: both;
}
.latest tbody td {
	background: #FFF;
}
.dashboard-heading {
	background: #547C96;
	color: #FFF;
	border-bottom: 1px solid #8EAEC3;
	padding: 5px;
	font-size: 14px;
	font-weight: bold;
}
.dashboard-content {
	background: #FCFCFC;
	border: 1px solid #8EAEC3;
	padding: 10px;
	min-height: 180px;
}
.refresh {
	cursor: pointer;
	position: relative;
	top: 3px;
}
.panel-default {
    padding: 10px;
    border-left: 1px solid #CCCCCC;
    border-right: 1px solid #CCCCCC;
    border-bottom: 1px solid #CCCCCC;
    min-height: 300px;
    overflow: auto;
}
.panel-default > .panel-heading {
    margin: -10px -10px 0;
}

.ui-timepicker-div {
    display: none;
}

</style>
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
      <h1 class="panel-title"><img src="view/image/icon_discount.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons">
        
        <div class="module-status">
          <label for="module_status"><?php echo $text_module_status;?>:</label>
          <select name="discount[setting][status]" id="module_status" onChange="moduleStatus(this.value);">
            <option value="1"<?php if(isset($discount_data['setting']['status']) AND $discount_data['setting']['status'] == 1){echo ' selected="selected"';}?>><?php echo $text_enabled;?></option>
            <option value="0"<?php if(!isset($discount_data['setting']['status']) || $discount_data['setting']['status'] == 0){echo ' selected="selected"';}?>><?php echo $text_disabled;?></option>
          </select>
        </div>
        
        <a onclick="$('#form').submit();" class="btn btn-success"><span><?php echo $button_save; ?></span></a>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger"><span><?php echo $button_cancel; ?></span></a>
      </div>
    </div>
    
    
    
    <div class="content multi-discount-pack">
    
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        
        <div class="vtabs">
          
          <a href="#module-setting" id="tab-module-setting" class="tab" onClick="selectTab('module-setting');"><?php echo $text_module_setting;?></a>
          
          <span class="select-type"><?php echo $text_type_of_discount;?>:</span>
          
          <a href="#discount-total" id="tab-discount-total" class="tab" onClick="selectTab('discount-total');"><?php echo $text_discount_total;?><br><span class="inactive">( <?php echo $text_disabled;?> )</span></a>
          <a href="#discount-category" id="tab-discount-category" class="tab" onClick="selectTab('discount-category');"><?php echo $text_discount_category;?><br><span class="inactive">( <?php echo $text_disabled;?> )</span></a>
          <a href="#discount-manufacturer" id="tab-discount-manufacturer" class="tab" onClick="selectTab('discount-manufacturer');"><?php echo $text_discount_manufacturer;?><br><span class="inactive">( <?php echo $text_disabled;?> )</span></a>
          <a href="#discount-customer" id="tab-discount-customer" class="tab" onClick="selectTab('discount-customer');"><?php echo $text_discount_customer_group;?><br><span class="inactive">( <?php echo $text_disabled;?> )</span></a>
       </div>
        
        
        <div id="module-setting" class="vtabs-content">
          <table class="form">
            <tbody>
              <tr>
                <td><label for="discount_setting_special_1"><?php echo $text_include_special;?></label><br /><span class="help"><?php echo $text_include_special_i;?></span></td>
                <td>
                  <input type="radio" name="discount[setting][special]" id="discount_setting_special_1" value="1"<?php if(isset($discount_data['setting']['special']) AND $discount_data['setting']['special'] == 1){echo ' checked="checked"';} ?> /><?php echo $text_yes;?>&nbsp;
                  <input type="radio" name="discount[setting][special]" id="discount_setting_special_0" value="0"<?php if(!isset($discount_data['setting']['special']) || $discount_data['setting']['special'] == 0){echo ' checked="checked"';} ?> /><?php echo $text_no;?>
                </td>
              </tr>
              <tr>
                <td><label for="discount_setting_special_1"><?php echo $text_include_options;?></label><br /><span class="help"><?php echo $text_include_options_i;?></span></td>
                <td>
                  <input type="radio" name="discount[setting][options]" id="discount_setting_options_1" value="1"<?php if(isset($discount_data['setting']['options']) AND $discount_data['setting']['options'] == 1){echo ' checked="checked"';} ?> /><?php echo $text_yes;?>&nbsp;
                  <input type="radio" name="discount[setting][options]" id="discount_setting_options_0" value="0"<?php if(!isset($discount_data['setting']['options']) || $discount_data['setting']['options'] == 0){echo ' checked="checked"';} ?> /><?php echo $text_no;?>
                </td>
              </tr>
            </tbody>
          </table>
        
        <div class="display-none">
          <input type="text" name="discount[setting][status]" value="1" id="discount_setting_status" />
          
          <input type="radio" name="discount[setting][discount_type]" value="total" id="discount_type_total" />
          <input type="radio" name="discount[setting][discount_type]" value="manufacturer" id="discount_type_manufacturer" />
          <input type="radio" name="discount[setting][discount_type]" value="category" id="discount_type_category" />
          <input type="radio" name="discount[setting][discount_type]" value="customer_group" id="discount_type_customer_group" />
        </div>
        
        </div>
        
        
        
        
        
        
        
        
        
        <div id="discount-total" class="vtabs-content">
          <table class="form">
          <?php $discount_type = 'total';?>
            <tbody>
              <tr>
                <td><label for="discount_<?php echo $discount_type;?>_fulltime"><?php echo $text_fulltime_discount;?></label><br /><span class="help"><?php echo $text_fulltime_discount_i;?></span></td>
                <td>
                  <input type="checkbox" name="discount[<?php echo $discount_type;?>][fulltime]" id="discount_<?php echo $discount_type;?>_fulltime" value="1" onClick="setFullTimeDiscount('<?php echo $discount_type;?>');"<?php if(isset($discount_data[$discount_type]['fulltime']) AND $discount_data[$discount_type]['fulltime'] == 1){echo ' checked="checked"';} ?> />
                </td>
              </tr>
              <tr id="discount_<?php echo $discount_type;?>_date"<?php if(isset($discount_data[$discount_type]['fulltime']) AND $discount_data[$discount_type]['fulltime'] == 1){echo ' style="display: none;"';} ?>>
                <td><label for="discount_<?php echo $discount_type;?>_date_start"><?php echo $text_discount_date;?></label><br /><span class="help"><?php echo $text_discount_date_i;?></span></td>
                <td>
                   <input type="text" name="discount[<?php echo $discount_type;?>][discount_start]" value="<?php if(isset($discount_data[$discount_type]['discount_start'])){echo $discount_data[$discount_type]['discount_start'];} ?>" class="datetime<?php if(isset($error[$discount_type]['discount_start'])){echo ' error-field';}?>" id="discount_<?php echo $discount_type;?>_date_start" size="15" placeholder="<?php echo $text_discount_date_start;?>" /> - <input type="text" name="discount[<?php echo $discount_type;?>][discount_stop]" value="<?php if(isset($discount_data[$discount_type]['discount_stop'])){echo $discount_data[$discount_type]['discount_stop'];} ?>" class="datetime<?php if(isset($error[$discount_type]['discount_stop'])){echo ' error-field';}?>" id="discount_<?php echo $discount_type;?>_date_stop" size="15" placeholder="<?php echo $text_discount_date_end;?>" />
                </td>
              </tr>
              <tr>
                <td><label><?php echo $text_discount_type;?></label><br /><span class="help"><?php echo $text_discount_type_i;?></span></td>
                <td>
                  <input type="radio" name="discount[<?php echo $discount_type;?>][discount_type]" value="percentage" id="discount_<?php echo $discount_type;?>_type_percentage" onClick="setDiscountType('<?php echo $discount_type;?>',this.value);"<?php if(isset($discount_data[$discount_type]['discount_type']) AND $discount_data[$discount_type]['discount_type'] == 'percentage'){echo ' checked="checked"';} ?> />
                  <label for="discount_<?php echo $discount_type;?>_type_percentage"><?php echo $text_percentage;?></label>
                  <input type="radio" name="discount[<?php echo $discount_type;?>][discount_type]" value="fixed" id="discount_<?php echo $discount_type;?>_type_fixed" onClick="setDiscountType('<?php echo $discount_type;?>',this.value);"<?php if(isset($discount_data[$discount_type]['discount_type']) AND $discount_data[$discount_type]['discount_type'] == 'fixed'){echo ' checked="checked"';} ?> />
                  <label for="discount_<?php echo $discount_type;?>_type_fixed"><?php echo $text_fixed;?></label>
                </td>
              </tr>
              <tr>
                <td><label for="discount_<?php echo $discount_type;?>_type_value"><?php echo $text_discount_value;?></label><br /><span class="help"><?php echo $text_discount_value_i;?></span></td>
                <td>
                  - <input type="text" value="<?php if(isset($discount_data[$discount_type]['discount_value'])){echo $discount_data[$discount_type]['discount_value'];} ?>" name="discount[<?php echo $discount_type;?>][discount_value]" id="discount_<?php echo $discount_type;?>_type_value" size="10"<?php if(isset($error[$discount_type]['discount_value'])){echo ' class="error-field"';}?> />
                  <span id="discount_<?php echo $discount_type;?>_type_character"></span>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        
        
        
        
        
        
        
      <?php $discount_type = 'category';?>
        <div id="discount-category" class="vtabs-content">
           <table id="category_discount" class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $text_category;?>:</td>
                <td class="center" style="width: 225px;"><?php echo $text_discount_date;?>:</td>
                <td class="center" style="width: 160px;"><?php echo $text_discount_type;?>:</td>
                <td class="center" style="width: 135px;"><?php echo $text_discount_value;?>:</td>
                <td class="center" style="width: 80px;"><?php echo $text_action;?></td>
              </tr>
            </thead>
            <?php $category_number = 1;?>
            <tbody id="category-body">
            <?php if(isset($discount_data[$discount_type])){ ?>
              <?php foreach($discount_data[$discount_type] as $category){?>
                <tr id="category-discount-<?php echo $category_number;?>">
                  <td class="left">
                        
                    
                    <select name="discount[<?php echo $discount_type;?>][<?php echo $category_number;?>][category_id]" style="width: 100%;"<?php if(isset($error[$discount_type][$category_number]['category_id'])){echo ' class="error-field"';}?>>    
                    <?php foreach($categories as $cat){ ?>
                      <option value="<?php echo $cat['category_id'];?>"<?php if(isset($category['category_id']) AND $category['category_id'] == $cat['category_id']){echo ' selected="selected"';}?>><?php echo $cat['name'];?></option>
                    <?php } ?>
                    </select>
      
                          
                    <input type="checkbox" name="discount[<?php echo $discount_type;?>][<?php echo $category_number;?>][subcategories]" value="1" id="category_<?php echo $category_number;?>_subcategories"<?php if(isset($category['subcategories']) AND $category['subcategories'] == 1){echo ' checked="checked"';}?> />
                    <label for="category_<?php echo $category_number;?>_subcategories"><?php echo $text_include_subcategories;?></label>
                  </td>
                  <td class="right">
                    <input type="text" name="discount[<?php echo $discount_type;?>][<?php echo $category_number;?>][discount_start]" value="<?php if(isset($category['discount_start'])){echo $category['discount_start'];}?>" class="datetime<?php if(isset($error[$discount_type][$category_number]['discount_start'])){echo ' error-field';}?>" id="category_<?php echo $category_number;?>_date_start" size="15" placeholder="<?php echo $text_discount_date_start;?>"<?php if(isset($category['fulltime']) AND $category['fulltime'] == 1){echo ' disabled="disabled"';}?> /> - <input type="text" name="discount[<?php echo $discount_type;?>][<?php echo $category_number;?>][discount_stop]" value="<?php if(isset($category['discount_stop'])){echo $category['discount_stop'];}?>" class="datetime<?php if(isset($error[$discount_type][$category_number]['discount_stop'])){echo ' error-field';}?>" id="category_<?php echo $category_number;?>_date_stop" size="15" placeholder="<?php echo $text_discount_date_end;?>"<?php if(isset($category['fulltime']) AND $category['fulltime'] == 1){echo ' disabled="disabled"';}?> />
                    <br />
                    <input onClick="changeCategoryFulltime(<?php echo $category_number;?>)" type="checkbox" name="discount[<?php echo $discount_type;?>][<?php echo $category_number;?>][fulltime]" id="category_<?php echo $category_number;?>_fulltime" value="1"<?php if(isset($category['fulltime'])){echo ' checked="checked"';}?> />&nbsp;
                    <label for="category_<?php echo $category_number;?>_fulltime"><?php echo $text_fulltime;?></label>
                  </td>
                  <td class="center">
                    <input type="radio" name="discount[<?php echo $discount_type;?>][<?php echo $category_number;?>][discount_type]" value="percentage" id="category_<?php echo $category_number;?>_type_percentage" onClick="setDiscountCategoryType('<?php echo $discount_type;?>',this.value, <?php echo $category_number;?>);"<?php if(isset($category['discount_type']) AND $category['discount_type'] == "percentage"){echo ' checked="checked"';}?> />
                    <label for="category_<?php echo $category_number;?>_type_percentage"><?php echo $text_percentage;?></label>
                    <input type="radio" name="discount[<?php echo $discount_type;?>][<?php echo $category_number;?>][discount_type]" value="fixed" id="category_<?php echo $category_number;?>_type_fixed" onClick="setDiscountCategoryType('<?php echo $discount_type;?>',this.value, <?php echo $category_number;?>);"<?php if(isset($category['discount_type']) AND $category['discount_type'] == "fixed"){echo ' checked="checked"';}?> />
                    <label for="category_<?php echo $category_number;?>_type_fixed"><?php echo $text_fixed;?></label>
                  </td>
                  <td class="center">
                    - <input type="text" name="discount[<?php echo $discount_type;?>][<?php echo $category_number;?>][discount_value]" value="<?php if(isset($category['discount_value'])){echo $category['discount_value'];}?>" id="discount_<?php echo $discount_type;?>_category_<?php echo $category_number;?>_type_value" size="10"<?php if(isset($error[$discount_type][$category_number]['discount_value'])){echo ' class="error-field"';}?> />
                    <span id="discount_<?php echo $discount_type;?>_category_<?php echo $category_number;?>_type_character"></span>
                  </td>
                  <td align="center"><a class="btn btn-danger" onclick="$('#category-discount-<?php echo $category_number;?>').remove();"><span><?php echo $text_remove;?></span></a></td>
                </tr>
              <?php $category_number++;} ?>
            <?php } ?>
            </tbody>
            <tfoot>
              <tr>
                <td colspan="5" class="right"><a onclick="addCategory();" class="btn btn-success"><span><?php echo $text_add_category;?></span></a></td>
              </tr>
            </tfoot>
          </table>
        </div>
        
        
        
        
        
        
        
        
        
        
      <?php $discount_type = 'manufacturer';?>
        <div id="discount-manufacturer" class="vtabs-content">
           <table id="manufacturer_discount" class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $text_manufacturer;?>:</td>
                <td class="center" style="width: 225px;"><?php echo $text_discount_date;?>:</td>
                <td class="center" style="width: 160px;"><?php echo $text_discount_type;?>:</td>
                <td class="center" style="width: 135px;"><?php echo $text_discount_value;?>:</td>
                <td class="center" style="width: 80px;"><?php echo $text_action;?></td>
              </tr>
            </thead>
            <?php $manufacturer_number = 1;?>
            <tbody id="manufacturer-body">
            <?php if(isset($discount_data[$discount_type])){ ?>
              <?php foreach($discount_data[$discount_type] as $manufacturer_data){?>
                <tr id="manufacturer-discount-<?php echo $manufacturer_number;?>">
                  <td class="left">
                    <select name="discount[<?php echo $discount_type;?>][<?php echo $manufacturer_number;?>][manufacturer_id]" style="width: 100%;">
                      <?php foreach($manufacturers as $manufacturer){ ?>
                        <option value="<?php echo $manufacturer['manufacturer_id'];?>"<?php if(isset($manufacturer_data['manufacturer_id']) AND $manufacturer_data['manufacturer_id'] == $manufacturer['manufacturer_id']){echo ' selected="selected"';}?>><?php echo $manufacturer['name'];?></option>
                      <?php } ?>
                    </select><br /><small><?php echo $text_select_manufacturer;?></small>
                  </td>
                  <td class="right">
                    <input type="text" name="discount[<?php echo $discount_type;?>][<?php echo $manufacturer_number;?>][discount_start]" value="<?php if(isset($manufacturer_data['discount_start'])){echo $manufacturer_data['discount_start'];}?>" class="datetime<?php if(isset($error[$discount_type][$manufacturer_number]['discount_start'])){echo ' error-field';}?>" id="manufacturer_<?php echo $manufacturer_number;?>_date_start" size="15" placeholder="<?php echo $text_discount_date_start;?>"<?php if(isset($manufacturer_data['fulltime']) AND $manufacturer_data['fulltime'] == 1){echo ' disabled="disabled"';}?> /> - <input type="text" name="discount[<?php echo $discount_type;?>][<?php echo $manufacturer_number;?>][discount_stop]" value="<?php if(isset($manufacturer_data['discount_stop'])){echo $manufacturer_data['discount_stop'];}?>" class="datetime<?php if(isset($error[$discount_type][$manufacturer_number]['discount_stop'])){echo ' error-field';}?>" id="manufacturer_<?php echo $manufacturer_number;?>_date_stop" size="15" placeholder="<?php echo $text_discount_date_end;?>"<?php if(isset($manufacturer_data['fulltime']) AND $manufacturer_data['fulltime'] == 1){echo ' disabled="disabled"';}?> />
                     <input onClick="changeManufacturerFulltime(<?php echo $manufacturer_number;?>)" type="checkbox" name="discount[<?php echo $discount_type;?>][<?php echo $manufacturer_number;?>][fulltime]" id="manufacturer_<?php echo $manufacturer_number;?>_fulltime" value="1"<?php if(isset($manufacturer_data['fulltime']) AND $manufacturer_data['fulltime'] == 1){echo ' checked="checked"';}?> />&nbsp;
                    <label for="manufacturer_<?php echo $manufacturer_number;?>_fulltime"><?php echo $text_fulltime;?></label>
                 </td>
                  <td class="center">
                    <input type="radio" name="discount[<?php echo $discount_type;?>][<?php echo $manufacturer_number;?>][discount_type]" value="percentage" id="manufacturer_<?php echo $manufacturer_number;?>_type_percentage" onClick="setDiscountManufacturerType('<?php echo $discount_type;?>', this.value, <?php echo $manufacturer_number;?>);"<?php if(isset($manufacturer_data['discount_type']) AND $manufacturer_data['discount_type'] == 'percentage'){echo ' checked="chcecked"';}?> />
                    <label for="manufacturer_<?php echo $manufacturer_number;?>_type_percentage"><?php echo $text_percentage;?></label>
                    <input type="radio" name="discount[<?php echo $discount_type;?>][<?php echo $manufacturer_number;?>][discount_type]" value="fixed" id="manufacturer_<?php echo $manufacturer_number;?>_type_fixed" onClick="setDiscountManufacturerType('<?php echo $discount_type;?>',this.value, <?php echo $manufacturer_number;?>);"<?php if(isset($manufacturer_data['discount_type']) AND $manufacturer_data['discount_type'] == 'fixed'){echo ' checked="checked"';}?> />
                    <label for="manufacturer_<?php echo $manufacturer_number;?>_type_fixed"><?php echo $text_fixed;?></label>
                  </td>
                  <td class="center">
                    - <input type="text" name="discount[<?php echo $discount_type;?>][<?php echo $manufacturer_number;?>][discount_value]" value="<?php if(isset($manufacturer_data['discount_value'])){echo $manufacturer_data['discount_value'];}?>" id="discount_<?php echo $discount_type;?>_manufacturer_<?php echo $manufacturer_number;?>_type_value" size="10"<?php if(isset($error[$discount_type][$manufacturer_number]['discount_value'])){echo ' class="error-field"';}?> /><span id="discount_<?php echo $discount_type;?>_manufacturer_<?php echo $manufacturer_number;?>_type_character"></span>
                  </td>
                  <td align="center"><a onclick="$('#manufacturer-discount-<?php echo $manufacturer_number;?>').remove();" class="btn btn-danger"><span><?php echo $text_remove;?></span></a></td>
                </tr>
              <?php $manufacturer_number++;} ?>
            <?php } ?>
            </tbody>
            <tfoot>
              <tr>
                <td colspan="5" class="right"><a onclick="addManufacturer();" class="btn btn-success"><span><?php echo $text_add_manufacturer;?></span></a></td>
              </tr>
            </tfoot>
          </table>
        </div>
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
      <?php $discount_type = 'customer_group';?>
        <div id="discount-customer" class="vtabs-content">
           <table id="customer-group_discount" class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $text_customer_group;?>:</td>
                <td class="center" style="width: 225px;"><?php echo $text_discount_date;?>:</td>
                <td class="center" style="width: 160px;"><?php echo $text_discount_type;?>:</td>
                <td class="center" style="width: 135px;"><?php echo $text_discount_value;?>:</td>
                <td class="center" style="width: 80px;"><?php echo $text_action;?></td>
              </tr>
            </thead>
            <?php $customer_group_number = 1;?>
            <tbody id="customer-group-body">
            <?php if(isset($discount_data[$discount_type])){ ?>
              <?php foreach($discount_data[$discount_type] as $customer_group_data){?>
                <tr id="customer-discount-<?php echo $customer_group_number;?>">
                  <td class="left">
                    <select name="discount[<?php echo $discount_type;?>][<?php echo $customer_group_number;?>][customer_group_id]" style="width: 100%;">
                      <?php foreach($customer_groups as $customer_group){ ?>
                        <option value="<?php echo $customer_group['customer_group_id'];?>"<?php if(isset($customer_group_data['customer_group_id']) AND $customer_group_data['customer_group_id'] == $customer_group['customer_group_id']){echo ' selected="selected"';}?>><?php echo $customer_group['name'];?></option>
                      <?php } ?>
                    </select><br /><small>Select customer group</small>
                  </td>
                  <td class="right">
                    <input type="text" name="discount[<?php echo $discount_type;?>][<?php echo $customer_group_number;?>][discount_start]" value="<?php if(isset($customer_group_data['discount_start'])){echo $customer_group_data['discount_start'];}?>" class="datetime<?php if(isset($error[$discount_type][$customer_group_number]['discount_start'])){echo ' error-field';}?>" id="customer_group_<?php echo $customer_group_number;?>_date_start" size="15" placeholder="<?php echo $text_discount_date_start;?>"<?php if(isset($customer_group_data['fulltime']) AND $customer_group_data['fulltime'] == 1){echo ' disabled="disabled"';}?> /> - <input type="text" name="discount[<?php echo $discount_type;?>][<?php echo $customer_group_number;?>][discount_stop]" value="<?php if(isset($customer_group_data['discount_stop'])){echo $customer_group_data['discount_stop'];}?>" class="datetime<?php if(isset($error[$discount_type][$customer_group_number]['discount_stop'])){echo ' error-field';}?>" id="customer_group_<?php echo $customer_group_number;?>_date_stop" size="15" placeholder="<?php echo $text_discount_date_end;?>"<?php if(isset($customer_group_data['fulltime']) AND $customer_group_data['fulltime'] == 1){echo ' disabled="disabled"';}?> />
                    <input onClick="changeCustomerGroupFulltime(<?php echo $customer_group_number;?>)" type="checkbox" name="discount[<?php echo $discount_type;?>][<?php echo $customer_group_number;?>][fulltime]" id="customer_group_<?php echo $customer_group_number;?>_fulltime" value="1"<?php if(isset($customer_group_data['fulltime']) AND $customer_group_data['fulltime'] == 1){echo ' checked="checked"';}?> />&nbsp;
                    <label for="customer_group_<?php echo $customer_group_number;?>_fulltime"><?php echo $text_fulltime;?></label>
                  </td>
                  <td class="center">
                    <input type="radio" name="discount[<?php echo $discount_type;?>][<?php echo $customer_group_number;?>][discount_type]" value="percentage" id="customer_group_<?php echo $customer_group_number;?>_type_percentage" onClick="setDiscountCustomerGroupType('<?php echo $discount_type;?>', this.value, <?php echo $customer_group_number;?>);"<?php if(isset($customer_group_data['discount_type']) AND $customer_group_data['discount_type'] == 'percentage'){echo ' checked="checked"';}?> />
                    <label for="customer_group_<?php echo $customer_group_number;?>_type_percentage"><?php echo $text_percentage;?></label>
                    <input type="radio" name="discount[<?php echo $discount_type;?>][<?php echo $customer_group_number;?>][discount_type]" value="fixed" id="customer_group_<?php echo $customer_group_number;?>_type_fixed" onClick="setDiscountCustomerGroupType('<?php echo $discount_type;?>', this.value, <?php echo $customer_group_number;?>);"<?php if(isset($customer_group_data['discount_type']) AND $customer_group_data['discount_type'] == 'fixed'){echo ' checked="checked"';}?> />
                    <label for="customer_group_<?php echo $customer_group_number;?>_type_fixed"><?php echo $text_fixed;?></label>
                  </td>
                  <td class="center">
                    - <input type="text" name="discount[<?php echo $discount_type;?>][<?php echo $customer_group_number;?>][discount_value]" value="<?php if(isset($customer_group_data['discount_value'])){echo $customer_group_data['discount_value'];}?>" id="discount_<?php echo $discount_type;?>_customer_group_<?php echo $customer_group_number;?>_type_value" size="10"<?php if(isset($error[$discount_type][$customer_group_number]['discount_value'])){echo ' class="error-field"';}?> /><span id="discount_<?php echo $discount_type;?>_customer_group_<?php echo $customer_group_number;?>_type_character"></span>
                  </td>
                  <td align="center"><a onclick="$('#customer-discount-<?php echo $customer_group_number;?>').remove();" class="btn btn-danger"><span><?php echo $text_remove;?></span></a></td>
                </tr>
              <?php $customer_group_number++;} ?>
            <?php } ?>
            </tbody>
            <tfoot>
              <tr>
                <td colspan="5" class="right"><a onclick="addCustomerGroup();" class="btn btn-success"><span><?php echo $text_add_customer_group;?></span></a></td>
              </tr>
            </tfoot>
          </table>
        </div>
      </form>
    </div>
  </div>
</div>








<script type="text/javascript" src="view/javascript/discount.js"></script>
<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--

function getCategory(element_id){
$('#category_'+element_id+'_name').autocomplete({
	delay: 500,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/category/autocomplete&token=<?php if(isset($_GET['token'])){echo $_GET['token'];}?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {		
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.category_id
					}
				}));
			}
		});
	}, 
	select: function(event, ui) {
	
	 var cat_id = $(this).attr('aria-category-number');
	
    document.getElementById('category_'+cat_id+'_name').value = ui.item.label;
    document.getElementById('category_'+cat_id+'_value').value = ui.item.value;
 
		return false;
	},
	focus: function(event, ui) {
      return false;
   }
});
}

var category_number       = <?php echo $category_number;?>;
var manufacturer_number   = <?php echo $manufacturer_number;?>;
var customer_group_number = <?php echo $customer_group_number;?>;
          
function addCategory(){
  category_number++;
  var html = '';
      html    += '<tr id="category-discount-'+category_number+'">';
      html    += '  <td class="left">';
  
      html    += '  <select name="discount[category]['+category_number+'][category_id]" style="width: 100%;">';
      
      <?php foreach($categories as $category){ ?>
      html    += '  <option value="<?php echo $category['category_id'];?>"><?php echo escape_string($category['name']);?></option>';
      <?php } ?>
      html    += '  </select>';
      
  
      html    += '    <input type="checkbox" name="discount[category]['+category_number+'][subcategories]" value="1" id="category_'+category_number+'_subcategories" checked="checked" />';
      html    += '    <label for="category_'+category_number+'_subcategories"><?php echo $text_include_subcategories;?></label>';
      
      
      
      
      html    += '  </td>';
      html    += '  <td class="right">';
      html    += '    <input type="text" name="discount[category]['+category_number+'][discount_start]" value="" class="datetime" id="category_'+category_number+'_date_start" size="15" placeholder="<?php echo $text_discount_date_start;?>" /> - <input type="text" name="discount[category]['+category_number+'][discount_stop]" class="datetime" id="category_'+category_number+'_date_stop" size="15" placeholder="<?php echo $text_discount_date_end;?>" />';
      html    += '    <br />';
      html    += '    <input onClick="changeCategoryFulltime('+category_number+')" type="checkbox" name="discount[category]['+category_number+'][fulltime]" id="category_'+category_number+'_fulltime" value="1" />&nbsp;';
      html    += '    <label for="category_'+category_number+'_fulltime"><?php echo $text_fulltime;?></label>';
      html    += '  </td>';
      html    += '  <td class="center">';
      html    += '    <input type="radio" name="discount[category]['+category_number+'][discount_type]" value="percentage" id="category_'+category_number+'_type_percentage" onClick="setDiscountCategoryType(\'category\',this.value, '+category_number+');" checked="checked" />';
      html    += '    <label for="category_'+category_number+'_type_percentage"><?php echo $text_percentage;?></label>';
      html    += '    <input type="radio" name="discount[category]['+category_number+'][discount_type]" value="fixed" id="category_'+category_number+'_type_fixed" onClick="setDiscountCategoryType(\'category\',this.value, '+category_number+');" />';
      html    += '    <label for="category_'+category_number+'_type_fixed"><?php echo $text_fixed;?></label>';
      html    += '  </td>';
      html    += '  <td class="center">';
      html    += '    - <input type="text" name="discount[category]['+category_number+'][discount_value]" id="discount_category_category_'+category_number+'_type_value" size="10" /><span id="discount_category_category_'+category_number+'_type_character">%</span>';
      html    += '  </td>';
      html    += '  <td align="center"><a class="btn btn-danger" onclick="$(\'#category-discount-'+category_number+'\').remove();""><span><?php echo $text_remove;?></span></a></td>';
      html    += '</tr>';

  $('#category-body').append(html);

  $('#category-discount-'+category_number+' .datetime').datetimepicker({
  	dateFormat: 'yy-mm-dd',
  	timeFormat: 'hh:mm'
  });


  return false;
}
          
          
          
          
          
          
          
          
          
          
          
          
function addManufacturer(){
  manufacturer_number++;
  var html = '';
      html    += '<tr id="manufacturer-discount-'+manufacturer_number+'">';
      html    += '  <td class="left">';
      html    += '  <select name="discount[manufacturer]['+manufacturer_number+'][manufacturer_id]" style="width: 100%;">';
      <?php foreach($manufacturers as $manufacturer){ ?>
      html    += '    <option value="<?php echo $manufacturer['manufacturer_id'];?>"><?php echo escape_string($manufacturer['name']);?></option>';
      <?php } ?>
      html    += '  </select><br /><small><?php echo $text_select_manufacturer;?></small>';
      html    += '</td>';
      html    += '<td class="right">';
      html    += '  <input type="text" name="discount[manufacturer]['+manufacturer_number+'][discount_start]" value="" class="datetime" id="manufacturer_'+manufacturer_number+'_date_start" size="15" placeholder="<?php echo $text_discount_date_start;?>" /> - <input type="text" name="discount[manufacturer]['+manufacturer_number+'][discount_stop]" class="datetime" id="manufacturer_'+manufacturer_number+'_date_stop" size="15" placeholder="<?php echo $text_discount_date_end;?>" />';
      html    += '  <input onClick="changeManufacturerFulltime('+manufacturer_number+')" type="checkbox" name="discount[manufacturer]['+manufacturer_number+'][fulltime]" id="manufacturer_'+manufacturer_number+'_fulltime" value="1" />&nbsp;';
      html    += '  <label for="manufacturer_'+manufacturer_number+'_fulltime"><?php echo $text_fulltime;?></label>';
      html    += '</td>';
      html    += '<td class="center">';
      html    += '  <input type="radio" name="discount[manufacturer]['+manufacturer_number+'][discount_type]" value="percentage" id="manufacturer_'+manufacturer_number+'_type_percentage" onClick="setDiscountManufacturerType(\'manufacturer\',this.value, '+manufacturer_number+');" checked="checked" />';
      html    += '  <label for="manufacturer_'+manufacturer_number+'_type_percentage"><?php echo $text_percentage;?></label>';
      html    += '  <input type="radio" name="discount[manufacturer]['+manufacturer_number+'][discount_type]" value="fixed" id="manufacturer_'+manufacturer_number+'_type_fixed" onClick="setDiscountManufacturerType(\'manufacturer\',this.value, '+manufacturer_number+');" />';
      html    += '  <label for="manufacturer_'+manufacturer_number+'_type_fixed"><?php echo $text_fixed;?></label>';
      html    += '</td>';
      html    += '<td class="center">';
      html    += '  - <input type="text" name="discount[manufacturer]['+manufacturer_number+'][discount_value]" id="discount_<?php echo $discount_type;?>_manufacturer_'+manufacturer_number+'_type_value" size="10" /><span id="discount_manufacturer_manufacturer_'+manufacturer_number+'_type_character">%</span>';
      html    += '</td>';
      html    += '<td align="center"><a class="btn btn-danger" onclick="$(\'#manufacturer-discount-'+manufacturer_number+'\').remove();"><span><?php echo $text_remove;?></span></a></td>';
      html    += '</tr>';

  $('#manufacturer-body').append(html);

  $('#manufacturer-discount-'+manufacturer_number+' .datetime').datetimepicker({
  	dateFormat: 'yy-mm-dd',
  	timeFormat: 'hh:mm'
  });
  
  return false;
}
          
          
          
          
          
          
          
          
          
          
          

function addCustomerGroup(){
  customer_group_number++;
  var html = '';
      html    += '<tr id="customer-discount-'+customer_group_number+'">';
      html    += '<td class="left">';
      html    += '  <select name="discount[customer_group]['+customer_group_number+'][customer_group_id]" style="width: 100%;">';
      <?php foreach($customer_groups as $customer_group){ ?>
      html    += '    <option value="<?php echo $customer_group['customer_group_id'];?>"><?php echo escape_string($customer_group['name']);?></option>';
      <?php } ?>
      html    += '</select><br /><small><?php echo $text_select_customer_group;?></small>';
      html    += '</td>';
      html    += '<td class="right">';
      html    += '  <input type="text" name="discount[customer_group]['+customer_group_number+'][discount_start]" value="" class="datetime" id="customer_group_'+customer_group_number+'_date_start" size="15" placeholder="<?php echo $text_discount_date_start;?>" /> - <input type="text" name="discount[customer_group]['+customer_group_number+'][discount_stop]" class="datetime" id="customer_group_'+customer_group_number+'_date_stop" size="15" placeholder="<?php echo $text_discount_date_end;?>" />';
      html    += '  <input onClick="changeCustomerGroupFulltime('+customer_group_number+')" type="checkbox" name="discount[customer_group]['+customer_group_number+'][fulltime]" id="customer_group_'+customer_group_number+'_fulltime" value="1" />&nbsp;';
      html    += '  <label for="customer_group_'+customer_group_number+'_fulltime"><?php echo $text_fulltime;?></label>';
      html    += '</td>';
      html    += '<td class="center">';
      html    += '  <input type="radio" name="discount[customer_group]['+customer_group_number+'][discount_type]" value="percentage" id="customer_group_'+customer_group_number+'_type_percentage" onClick="setDiscountCustomerGroupType(\'customer_group\', this.value, '+customer_group_number+');" checked="checked" />';
      html    += '  <label for="customer_group_'+customer_group_number+'_type_percentage"><?php echo $text_percentage;?></label>';
      html    += '  <input type="radio" name="discount[customer_group]['+customer_group_number+'][discount_type]" value="fixed" id="customer_group_'+customer_group_number+'_type_fixed" onClick="setDiscountCustomerGroupType(\'customer_group\', this.value, '+customer_group_number+');" />';
      html    += '  <label for="customer_group_'+customer_group_number+'_type_fixed"><?php echo $text_fixed;?></label>';
      html    += '</td>';
      html    += '<td class="center">';
      html    += '  - <input type="text" name="discount[customer_group]['+customer_group_number+'][discount_value]" id="discount_customer_group_customer_group_'+customer_group_number+'_type_value" size="10" /><span id="discount_customer_group_customer_group_'+customer_group_number+'_type_character">%</span>';
      html    += '</td>';
      html    += '<td align="center"><a class="btn btn-danger" onclick="$(\'#customer-discount-'+customer_group_number+'\').remove();"><span><?php echo $text_remove;?></span></a></td>';
      html    += '</tr>';
      
  $('#customer-group-body').append(html);

  $('#customer-discount-'+customer_group_number+' .datetime').datetimepicker({
  	dateFormat: 'yy-mm-dd',
  	timeFormat: 'hh:mm'
  });
  
  return false;
}



$('.vtabs a').tabs();
$('#form label').css("cursor","pointer");
$('#form label').css("font-weight","bold");


$('.vtabs a').click(function(){

  var id = $(this).attr("id");
  if(id != "tab-module-setting"){
    $('.vtabs a span').html('( <?php echo $text_disabled;?> )');
    $('.vtabs a span').removeClass(' inactive');
    $('.vtabs a span').removeClass(' active');
    $('.vtabs a span').addClass(' inactive');
    $(this).children().removeClass(" inactive");
    $(this).children().addClass(" active");
    $(this).children().html('( <?php echo $text_enabled;?> )');
  }
  
  
});

$('.datetime').datetimepicker({
	dateFormat: 'yy-mm-dd',
	timeFormat: 'hh:mm'
});
$('.time').timepicker({timeFormat: 'h:m'});






<?php
/******************************* DEFAULT VALUES *******************************/

//total
if(!isset($discount_data['total']['discount_type'])){
  echo '$("#discount_total_type_percentage").click();'."\n";
}else{
  echo '$("#discount_total_type_'.$discount_data['total']['discount_type'].'").click();'."\n";
}

//category
  $num = 1;
  if(isset($discount_data['category'])){
    foreach($discount_data['category'] as $category){
      if(isset($category['discount_type'])){ 
        echo '$("#category_'.$num.'_type_'.$category['discount_type'].'").click();'."\n";
      }
      $num++;
    }
  }

//manufacturer
  $num = 1;
  if(isset($discount_data['manufacturer'])){
    foreach($discount_data['manufacturer'] as $manufacturer){
      if(isset($manufacturer['discount_type'])){
        echo '$("#manufacturer_'.$num.'_type_'.$manufacturer['discount_type'].'").click();'."\n";
      }
      $num++;
    }
  }

//customer_group
  $num = 1;
  if(isset($discount_data['customer_group'])){
    foreach($discount_data['customer_group'] as $customer){
      if(isset($customer['discount_type'])){
        echo '$("#customer_group_'.$num.'_type_'.$customer['discount_type'].'").click();'."\n";
      }
      $num++;
    }
  }
?>


//selectTab('discount-total');




function setDiscountType(type,value){
  if(value == "fixed"){
    document.getElementById("discount_"+type+"_type_character").innerHTML = '<?php echo $primary_currency_code;?>';
  }else{
    document.getElementById("discount_"+type+"_type_character").innerHTML = '%';
  }
}

function setDiscountCategoryType(type, value, category_number){
  if(value == "fixed"){
    document.getElementById("discount_"+type+"_category_"+category_number+"_type_character").innerHTML = '<?php echo $primary_currency_code;?>';
  }else{
    document.getElementById("discount_"+type+"_category_"+category_number+"_type_character").innerHTML = '%';
  }
}
          

function setDiscountManufacturerType(type, value, manufacturer_number){
  if(value == "fixed"){
    document.getElementById("discount_"+type+"_manufacturer_"+manufacturer_number+"_type_character").innerHTML = '<?php echo $primary_currency_code;?>';
  }else{
    document.getElementById("discount_"+type+"_manufacturer_"+manufacturer_number+"_type_character").innerHTML = '%';
  }
}
          

function setDiscountCustomerGroupType(type, value, customer_group_number){
  if(value == "fixed"){
    document.getElementById("discount_"+type+"_customer_group_"+customer_group_number+"_type_character").innerHTML = '<?php echo $primary_currency_code;?>';
  }else{
    document.getElementById("discount_"+type+"_customer_group_"+customer_group_number+"_type_character").innerHTML = '%';
  }
}





//actual tab display
<?php if(isset($discount_data['setting']['discount_type'])){?>
  <?php if($discount_data['setting']['discount_type'] == "total"){ ?>
    $('#tab-discount-total').click();
    $('#discount_type_total').click();
  <?php } ?>
  
  <?php if($discount_data['setting']['discount_type'] == "manufacturer"){ ?>
    $('#tab-discount-manufacturer').click();
    $('#discount_type_manufacturer').click();
  <?php } ?>
  
  <?php if($discount_data['setting']['discount_type'] == "category"){ ?>
    $('#tab-discount-category').click();
    $('#discount_type_category').click();
  <?php } ?>
  
  <?php if($discount_data['setting']['discount_type'] == "customer_group"){ ?>
    $('#tab-discount-customer').click();
    $('#discount_type_customer_group').click();
  <?php } ?>
  
<?php }else{?>
  $('#tab-discount-total').click();
  $('#discount_type_total').click();
<?php } ?>
//--></script>
<?php echo $footer; ?>