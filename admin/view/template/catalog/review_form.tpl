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
        <button type="submit" form="form-review" class="btn btn-primary "><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-danger "><i class="fa fa-times"></i> <?php echo $button_cancel; ?></a></div>
      <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-review" class="form-horizontal">
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="input-author"><?php echo $entry_author; ?></label>
          <div class="col-xs-10">
            <input type="text" name="author" value="<?php echo $author; ?>" id="input-author" class="form-control" />
            <?php if ($error_author) { ?>
            <div class="text-danger"><?php echo $error_author; ?></div>
            <?php } ?>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-product"><?php echo $entry_product; ?></label>
          <div class="col-xs-10">
            <input type="text" name="product" value="<?php echo $product; ?>" id="input-product" class="form-control" />
            <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />

            <?php if ($error_product) { ?>
            <div class="text-danger"><?php echo $error_product; ?></div>
            <?php } ?>
          </div>
        </div>
        
        
       <!-- New reviews -->
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-name"><?php echo $entry_rating; ?></label>
          <div class="col-xs-10">
            <div class="btn-group" data-toggle="buttons">
      			<label class="btn btn-warning<?php if ($rating == 1) { ?> active<?php } ?>">
    				<i class="fa fa-star"></i> <input type="radio" name="rating" id="input-rating" value="1" <?php if ($rating == 1) { ?>checked<?php } ?>>
      			</label>
      			<label class="btn btn-warning<?php if ($rating == 2) { ?> active<?php } ?>">
    				<i class="fa fa-star"></i> <input type="radio" name="rating" id="input-rating" value="2" <?php if ($rating == 2) { ?>checked<?php } ?>>
      			</label>
      			<label class="btn btn-warning<?php if ($rating == 3) { ?> active<?php } ?>">
    				<i class="fa fa-star"></i> <input type="radio" name="rating" id="input-rating" value="3" <?php if ($rating == 3) { ?>checked<?php } ?>>
      			</label>
      			<label class="btn btn-warning<?php if ($rating == 4) { ?> active<?php } ?>">
    				<i class="fa fa-star"></i> <input type="radio" name="rating" id="input-rating" value="4" <?php if ($rating == 4) { ?>checked<?php } ?>>
      			</label>
      			<label class="btn btn-warning<?php if ($rating == 5) { ?> active<?php } ?>">
    				<i class="fa fa-star"></i> <input type="radio" name="rating" id="input-rating" value="5" <?php if ($rating == 5) { ?>checked<?php } ?>>
      			</label>
                <?php if ($error_rating) { ?>
                <div class="text-danger"><?php echo $error_rating; ?></div>
                <?php } ?>
    		</div>
          </div>
        </div>
        
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-bads"><?php echo $entry_goods; ?></label>
          <div class="col-xs-10">
            <textarea name="good" cols="60" rows="8" id="input-bads" class="form-control"><?php echo $good; ?></textarea>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-bads"><?php echo $entry_bads; ?></label>
          <div class="col-xs-10">
            <textarea name="bads" cols="60" rows="8" id="input-bads" class="form-control"><?php echo $bads; ?></textarea>
          </div>
        </div>
        <div class="form-group required">
          <label class="col-xs-2 control-label" for="input-text"><?php echo $entry_text; ?></label>
          <div class="col-xs-10">
            <textarea name="text" cols="60" rows="8" id="input-text" class="form-control"><?php echo $text; ?></textarea>
            <?php if ($error_text) { ?>
            <div class="text-danger"><?php echo $error_text; ?></div>
            <?php } ?>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-answer"><?php echo $entry_answer; ?></label>
          <div class="col-xs-10">
            <textarea name="answer" cols="60" rows="8" id="input-answer" class="form-control"><?php echo $answer; ?></textarea>
          </div>
        </div>
        <div class="form-group">
          <label class="col-xs-2 control-label" for="input-addimage"><?php echo $entry_addimage; ?></label>
          <div class="col-xs-10">
            <input type="text" name="addimage" value="<?php echo $addimage; ?>" id="input-addimage" class="form-control" />
            <a href="<?php echo $addimage; ?>">
                <img src="<?php echo $addimage; ?>" style="max-width:70px;max-height:47px;" />
            </a>
          </div>
        </div>
        <div class="form-group">
            <label class="col-xs-2 control-label"><?php echo $entry_purchased; ?></label>
            <div class="col-xs-10">
                <div class="btn-group" data-toggle="buttons">
    		        <label class="btn btn-primary<?php if ($purchased) { ?> active<?php } ?>">
    				    <i class="fa fa-check"></i> 
    				    <input type="radio" name="status" value="1" <?php if ($purchased) { ?>checked<?php } ?>>On
    		        </label>
    		        <label class="btn btn-primary<?php if (!$purchased) { ?> active<?php } ?>">
    			        <i class="fa fa-times"></i> 
    			        <input type="radio" name="status" value="0" <?php if (!$purchased) { ?>checked<?php } ?>>Off
    		        </label>
    	        </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-2 control-label"><?php echo $entry_html_status; ?></label>
            <div class="col-xs-10">
                <div class="btn-group" data-toggle="buttons">
    		        <label class="btn btn-primary<?php if ($html_status) { ?> active<?php } ?>">
    				    <i class="fa fa-check"></i> 
    				    <input type="radio" name="html_status" value="1" <?php if ($html_status) { ?>checked<?php } ?>>On
    		        </label>
    		        <label class="btn btn-primary<?php if (!$html_status) { ?> active<?php } ?>">
    			        <i class="fa fa-times"></i> 
    			        <input type="radio" name="html_status" value="0" <?php if (!$html_status) { ?>checked<?php } ?>>Off
    		        </label>
    	        </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-2 control-label"><?php echo $entry_status; ?></label>
            <div class="col-xs-10">
                <div class="btn-group" data-toggle="buttons">
    		        <label class="btn btn-primary<?php if ($status) { ?> active<?php } ?>">
    				    <i class="fa fa-check"></i> 
    				    <input type="radio" name="status" value="1" <?php if ($status) { ?>checked<?php } ?>>On
    		        </label>
    		        <label class="btn btn-primary<?php if (!$status) { ?> active<?php } ?>">
    			        <i class="fa fa-times"></i> 
    			        <input type="radio" name="status" value="0" <?php if (!$status) { ?>checked<?php } ?>>Off
    		        </label>
    	        </div>
            </div>
        </div>
        <!--<div class="form-group">
          <label class="col-xs-2 control-label" for="input-date_added"><?php echo $entry_date_added; ?></label>
          <div class="col-xs-10">
            <input type="text" name="date_added" value="<?php echo $entry_date_added; ?>" id="input-date_added" class="form-control datetime" />
          </div>
        </div>-->
        
        <script src="view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
        <script>$('.datetime').datetimepicker({showSecond: true,dateFormat: 'yy-mm-dd',timeFormat: 'hh:mm:ss'});</script>
        <script>jQuery('.radio-star').hover(function(){var stars = jQuery(this).val();jQuery('.star-div').html('<span class="icstars-'+ stars +'"></span><i id="settext-'+ stars +'"></i>');},function(){var start = jQuery('input:radio[name=rating]:checked').val();if(typeof  start == 'undefined' ){start = 0;}jQuery('.star-div').html('<span class="icstars-'+ start +'"></span><i id="settext-'+ start +'"></i>');});jQuery('.radio-star').click(function(){jQuery('.radio-star').each(function(){jQuery(this).attr( 'checked', false );});jQuery(this).attr( 'checked', true );jQuery(this).each(function(){if(jQuery(this).attr("checked")=="checked"){var s = jQuery(this).val();jQuery('.star-div').stop().html('<span class="icstars-'+ s +'"></span><i id="settext-'+ s +'"></i>');}});});</script>
        <style>
        #settext-1:before{content: "Ужасно";margin-left: 7px;}
        #settext-2:before{content: "Плохо";margin-left: 7px;}
        #settext-3:before{content: "Средне";margin-left: 7px;}
        #settext-4:before{content: "Хорошо";margin-left: 7px;}
        #settext-5:before{content: "Отлично";margin-left: 7px;}
        input[type='text'], textarea{color: #333;border-radius:3px;border:1px solid #CCC;box-shadow: inset 0px 2px 8px rgba(32, 74, 96, 0.2), 0px 0px 3px white;-moz-box-shadow: inset 0px 2px 8px hsla(200, 50%, 25%, 0.2), 0px 0px 3px white;-webkit-box-shadow: inset 0px 2px 8px rgba(32, 74, 96, 0.2), 0px 0px 3px white;-webkit-transition: all 200ms;-moz-transition: all 200ms;-ms-transition: all 200ms;-o-transition: all 200ms;transition: all 200ms;padding:3px !important;margin-top:2px;margin-bottom:2px;}
        input:focus, textarea:focus {box-shadow: inset 0px 2px 8px rgba(255, 255, 255, 0), 0px 0px 5px #209FDF;-moz-box-shadow: inset 0px 2px 8px hsla(0, 100%, 100%, 0), 0px 0px 5px hsl(200, 75%, 50%);-webkit-box-shadow: inset 0px 2px 8px rgba(255, 255, 255, 0), 0px 0px 5px #209FDF;background-color: #FFF;outline: none;border-color: rgba(255, 255, 255, 0);}
        textarea:focus,input:focus{outline:none;}
        .radio-div{width:77px;float:left;margin-left:5px;}
        .radio-div input[type=radio]{position:relative;margin:0 0 0 -4px;padding:0;width:16px;height: 17px;opacity:0;z-index:2;cursor:pointer;-ms-filter:"progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";filter: alpha(opacity=0);}
        .star-div{height:17px;float:left;margin:1px 0 0 -84px;}
        .star-div span{width:77px;height:17px;display:inline-block;background:url(view/image/stars.png) no-repeat;}
        span.icstars-0{background-position:0 0}
        span.icstars-1{background-position:0 -16px}
        span.icstars-2{background-position:0 -32px}
        span.icstars-3{background-position:0 -48px}
        span.icstars-4{background-position:0 -64px}
        span.icstars-5{background-position:0 -80px}
        .switch input[type='radio']{display: none;}
        .cb-enable, .cb-disable, .cb-enable span, .cb-disable span {background: url(view/image/switch.gif) repeat-x; display: block; float: left; }
        .cb-enable span, .cb-disable span { line-height: 30px; display: block; background-repeat: no-repeat; font-weight: bold; }
        .cb-enable span { background-position: left -90px; padding: 0 10px; }
        .cb-disable span { background-position: right -180px;padding: 0 10px; }
        .cb-disable.selected { background-position: 0 -30px; }
        .cb-disable.selected span { background-position: right -210px; color: #fff; }
        .cb-enable.selected { background-position: 0 -60px; }
        .cb-enable.selected span { background-position: left -150px; color: #fff; }
        .switch label, h2 {cursor:pointer;-moz-user-select:-moz-none;-o-user-select:none;-khtml-user-select:none;-webkit-user-select:none;}
        </style>
       <!-- New reviews -->
       
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('input[name=\'product\']').autocomplete({
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
		$('input[name=\'product\']').val(item['label']);
		$('input[name=\'product_id\']').val(item['value']);		
	}	
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